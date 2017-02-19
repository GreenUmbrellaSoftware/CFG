class CertificateAuthoritiesController < ApplicationController
  before_action :set_certificate_authority, only: :show

  # GET /certificate_authorities
  # GET /certificate_authorities.json
  def index
    @certificate_authorities = CertificateAuthority.all
  end

  # GET /certificate_authorities/1
  # GET /certificate_authorities/1.json
  def show
  end

  # GET /certificate_authorities/new
  def new
    @certificate_authority = CertificateAuthority.new
  end

  # POST /certificate_authorities
  # POST /certificate_authorities.json
  def create
    @certificate_authority = CertificateAuthority.new(certificate_authority_params)

    respond_to do |format|
      if @certificate_authority.save
        format.html { redirect_to @certificate_authority, notice: 'Certificate authority was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_certificate_authority
      @certificate_authority = CertificateAuthority.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def certificate_authority_params
      params.require(:certificate_authority).permit(:title, :intermediate, :root)
    end
end
