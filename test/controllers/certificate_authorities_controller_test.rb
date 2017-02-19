require 'test_helper'

class CertificateAuthoritiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @certificate_authority = certificate_authorities(:one)
  end

  test "should get index" do
    get certificate_authorities_url
    assert_response :success
  end

  test "should get new" do
    get new_certificate_authority_url
    assert_response :success
  end

  test "should create certificate_authority" do
    assert_difference('CertificateAuthority.count') do
      post certificate_authorities_url, params: { certificate_authority: { intermediate: @certificate_authority.intermediate, root: @certificate_authority.root, title: @certificate_authority.title } }
    end

    assert_redirected_to certificate_authority_url(CertificateAuthority.last)
  end

  test "should show certificate_authority" do
    get certificate_authority_url(@certificate_authority)
    assert_response :success
  end

  test "should get edit" do
    get edit_certificate_authority_url(@certificate_authority)
    assert_response :success
  end

  test "should update certificate_authority" do
    patch certificate_authority_url(@certificate_authority), params: { certificate_authority: { intermediate: @certificate_authority.intermediate, root: @certificate_authority.root, title: @certificate_authority.title } }
    assert_redirected_to certificate_authority_url(@certificate_authority)
  end

  test "should destroy certificate_authority" do
    assert_difference('CertificateAuthority.count', -1) do
      delete certificate_authority_url(@certificate_authority)
    end

    assert_redirected_to certificate_authorities_url
  end
end
