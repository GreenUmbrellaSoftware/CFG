require 'openssl'

class CertificateAuthority < ApplicationRecord

  validate do |record|
    record.errors[:title] << 'cannot be empty!' if record.title.empty?

    intermediate = validate_ca_certificate record, :intermediate
    root = validate_ca_certificate record, :root

    if [ intermediate, root ].all? { |c| c.is_a?(OpenSSL::X509::Certificate) }
      record.errors[:base] << 'Intermediate CA was not signed by the Root CA!' unless
          intermediate.issuer.to_s == root.subject.to_s and intermediate.verify root.public_key
    end
  end

  def collect_certificates
    @certs = Hash.new
    @certs[:intermediate] = OpenSSL::X509::Certificate.new self.intermediate
    @certs[:root] = OpenSSL::X509::Certificate.new self.root
  end

  def certs
    @certs
  end

  private

  def validate_ca_certificate(record, symbol)
    if record[symbol].nil? or record[symbol].empty?
      record.errors[symbol] << 'certificate cannot be empty!'
    else
      begin
        certificate = OpenSSL::X509::Certificate.new record[symbol]
      rescue OpenSSL::X509::CertificateError
        record.errors[symbol] << 'certificate invalid!'
      end

      unless certificate.extensions.any?(&method(:is_ca_extension))
        record.errors[symbol] << 'certificate is not a CA certificate.'
      end

      certificate
    end
  end

  def is_ca_extension(extension)
    extension.oid == 'basicConstraints' and extension.value == 'CA:TRUE'
  end

end
