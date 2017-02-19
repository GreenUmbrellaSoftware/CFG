require 'openssl'

class CertificateAuthority < ApplicationRecord

  validate do |record|
    intermediate = validate_ca_certificate record, :intermediate
    root = validate_ca_certificate record, :root

    record.errors[:base] << 'Intermediate CA was not signed by the Root CA!' unless
        intermediate.issuer.to_s == root.subject.to_s and intermediate.verify root.public_key
  end

  private
    def validate_ca_certificate(record, symbol)
      name = symbol.to_s.capitalize

      begin
        certificate = OpenSSL::X509::Certificate.new record[symbol]
      rescue OpenSSL::X509::CertificateError
        record.errors[symbol] << "#{name} certificate invalid!"
      end

      unless certificate.extensions.any?(&method(:is_ca_extension))
        record.errors[symbol] << "#{name} certificate is not a CA certificate."
      end

      certificate
    end

  def is_ca_extension(extension)
    extension.oid == 'basicConstraints' and extension.value == 'CA:TRUE'
  end

end
