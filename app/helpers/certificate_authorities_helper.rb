require 'openssl'

module CertificateAuthoritiesHelper

  def display_common_name(hash)
    certificate = OpenSSL::X509::Certificate.new hash
    matches = certificate.subject.to_s.match(/\/CN=(.+)/).to_a

    if matches.empty?
      'Invalid certificate!'
    else
      matches[1]
    end
  end

end
