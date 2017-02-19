module CertificateAuthoritiesHelper

  def shorten_certificate_display(certificate)
    "#{certificate.slice(0, 50)} ..." unless certificate.nil?
  end

end
