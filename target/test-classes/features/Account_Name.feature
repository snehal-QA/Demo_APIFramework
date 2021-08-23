Feature: Validates Account_Name in Bank_details

  Background: 
    Given I am authorized user
	
  @SchemaValidation
  Scenario: Validates beneficiary is not added when account_name key is missing from bankdetails jsonobject
    And I create request payload with valid data for all keys without "account_name"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "payment_schema_validation_failed"
    And Response "message" has value "This field is required"
    And Response "source" has value "beneficiary.bank_details.account_name"

  @SchemaValidation
  Scenario: Validates beneficiary is not added when account_name value is Empty
    And I create request payload with valid data for all keys with "account_name" is "Empty"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "payment_schema_validation_failed"
    And Response "message" has value "This field is required"
    And Response "source" has value "beneficiary.bank_details.account_name"

  @RequirementMismatch-AcctNameLength @RequirementMismatch-ImproperResponseMessage 
  Scenario Outline: Validate error response is returned for "bank_country_code" <Bank_Country_Code> when "account_name" <account_name> has invalid no. of characters <number_of_characters>
    And I create request payload with valid data for all keys with "bank_country_code" is "<Bank_Country_Code>" "account_name" is "<account_name>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "payment_schema_validation_failed"
    And Response "message" has value "Length of account_name should be between {Min} and {Max} when bank_country_code is <Bank_Country_Code>"
    And Response "source" has value "beneficiary.bank_details.account_name"

    Examples: 
      | Bank_Country_Code | account_name | number_of_characters | Min | Max |
      | US                | U            |                    1 |   2 |  10 |
      | AU                | a            |                    1 |   2 |  10 |
      | CN                | G            |                    1 |   2 |  10 |
      | CN                | asfsf4567w3  |                   11 |   2 |  10 |

   @PositiveScenarios @AcctName_allSpecialCharAllowed
  Scenario Outline: Validate correct response is returned for "bank_country_code" <Bank_Country_Code> when "account_name" <account_name> has valid no. of characters <number_of_characters>
    And I create request payload with valid data for all keys with "bank_country_code" is "<Bank_Country_Code>" "account_name" is "<account_name>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 201
    And Response status line is "Created"

    Examples: 
      | Bank_Country_Code | account_name | number_of_characters | Min | Max |
      | US                | UA           |                    2 |   2 |  10 |
      | AU                | @@           |                    1 |   2 |  10 |
      | AU                | ()[aE1<:!    |                    1 |   2 |  10 |
      | US                | asfsf4567w   |                   10 |   2 |  10 |