require "application_system_test_case"
require_relative "../test_helpers/corrective_action_test_helper"


class CreateTsInvestigationTest < ApplicationSystemTestCase
  include CorrectiveActionTestHelper

  setup do
    sign_in_as_non_opss_user

    @product = products(:one)
    @investigation = investigations(:one)
    @business_one = businesses :one
    @business_two = businesses :two
    @corrective_action_one = corrective_actions :one
    @corrective_action_two = corrective_actions :two
    @test = tests :two

    visit new_ts_investigation_path
  end

  teardown do
    logout
  end

  test "can complete the ts flow" do
    corrective_filename_one = "old_risk_assessment.txt"
    corrective_description_one = "Test attachment description"
    corrective_filename_two = "another_risk_assessment.txt"
    corrective_description_two = "Another test attachment description"
    test_result_filename = "test_result.txt"
    test_result_description = "Test attachment description"
    risk_assessment_title = "new_risk_assessment.txt"
    risk_assessment_description = "Risk assessment description"

    assert_selector "h1", text: "What product are you reporting?"
    fill_in_product_page

    assert_text "Why are you reporting this product?"
    fill_in_why_reporting

    assert_selector "h1", text: "Supply chain information"
    choose_two_businesses

    assert_selector "h1", text: "Retailer details"
    fill_in_business_form @business_one

    assert_selector "h1", text: "Advertiser details"
    fill_in_business_form @business_two

    choose_corrective_action

    assert_selector "h1", text: "Record corrective action"
    fill_in_corrective_action_details @corrective_action_one, with_business: false, with_product: false
    add_corrective_action_attachment(
      filename: corrective_filename_one,
      description: corrective_description_one
    )
    click_button "Continue"

    choose_corrective_action

    assert_selector "h1", text: "Record corrective action"
    fill_in_corrective_action_details @corrective_action_two, with_business: false, with_product: false
    add_corrective_action_attachment(
      filename: corrective_filename_two,
      description: corrective_description_two
    )
    choose "further_corrective_action_no", visible: false
    click_button "Continue"

    assert_selector "h1", text: "Other information and files"
    choose_test_results_and_risk_assessments

    assert_selector "h1", text: "Test result details"
    fill_in_test_results @test
    add_attachment test_result_filename
    fill_in "Attachment description", with: test_result_description
    click_button "Continue"

    assert_selector "h1", text: "Risk assessment details"
    fill_in "Title", with: risk_assessment_title
    fill_in "Description", with: risk_assessment_description
    add_attachment risk_assessment_title
    choose "further_risk_assessments_yes", visible: false
    click_button "Continue"

    assert_selector "h1", text: "Risk assessment details"
    fill_in "Title", with: risk_assessment_title
    fill_in "Description", with: risk_assessment_description
    add_attachment risk_assessment_title
    choose "further_risk_assessments_no", visible: false
    click_button "Continue"

    assert_selector "h1", text: "Find this in your system"
    fill_in_complainant_reference

    # assert that corrective actions saved
    click_link "tab_activity"
    assert_text @corrective_action_one.summary
    assert_text @corrective_action_two.summary

    # assert that product saved
    click_link "tab_products"
    assert_text @product.name
    assert_text @product.product_code
    assert_text @product.product_type
    assert_text @product.category
    assert_text @product.webpage
    assert_text @product.description
    assert_text @product.country_of_origin

    # assert that business has saved
    click_link "tab_businesses"
    assert_text "Advertiser"
    assert_text "Retailer"
    assert_text @business_one.trading_name
    assert_text @business_two.trading_name
    # assert business location saved
    assert_text @business_one.locations.first.address_line_1

    # assert attachments saved
    click_link "tab_attachments"
    assert_text "Passed test: #{@product.name}"
    assert_text test_result_description
    assert_text risk_assessment_title
    assert_text risk_assessment_description


    #TODO assert about contact when MSPSDS-869 is finished
  end

  def fill_in_product_page
    fill_autocomplete "product-category-picker", with: @product.category
    fill_in "Product type", with: @product.product_type
    fill_in "Product name", with: @product.name
    fill_in "product_product_code", with: @product.product_code
    fill_in "Webpage", with: @product.webpage
    fill_autocomplete "location-autocomplete", with: @product.country_of_origin
    fill_in "Description", with: @product.description
    click_button "Continue"
  end

  def fill_in_why_reporting
    page.check :investigation_unsafe, visible: false
    fill_autocomplete "hazard-type-picker", with: @investigation.hazard_type, visible: false
    fill_in "allegation-hazard–detail", with: @investigation.hazard_description, visible: false
    page.check :investigation_non_compliant, visible: false
    fill_in "allegation-compliance-detail", with: @investigation.non_compliant_reason, visible: false
    click_button "Continue"
  end

  def choose_two_businesses
    page.check "businesses_retailer", visible: false
    page.check "businesses_other", visible: false
    fill_in "new-business-type-other", with: "advertiser"
    click_button "Continue"
  end

  def fill_in_business_form business
    fill_in "business_trading_name", with: business.trading_name
    fill_in "business_legal_name", with: business.legal_name
    fill_in "business_company_number", with: business.company_number + "unique company number"
    fill_in "business_contacts_attributes_0_name", with: business.contacts.first.name
    fill_in "business_locations_attributes_0_address_line_1", with: business.locations.first.address_line_1
    click_button "Continue"
  end

  def fill_in_test_results test_record
    fill_in "legislation-picker", with: test_record.legislation
    fill_in "Day", with: test_record.date.day
    fill_in "Month", with: test_record.date.month
    fill_in "Year", with: test_record.date.year
    choose :test_result_passed, visible: false
    fill_in "test_details", with: test_record.details
    choose "further_test_results_no", visible: false
  end

  def choose_corrective_action
    choose "further_corrective_action_yes", visible: false
    click_button "Continue"
  end

  def choose_test_results_and_risk_assessments
    page.check "test_results", visible: false
    page.check "risk_assessments", visible: false
    click_button "Continue"
  end

  def fill_in_complainant_reference
    fill_in "investigation_complainant_reference", with: @investigation.complainant_reference
    click_button "Save"
  end

  def add_attachment filename
    attach_file "attachment-file-input", file_fixture(filename)
  end
end