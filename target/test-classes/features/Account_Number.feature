Feature: Validates Account_Number in Bank_details

  Background: 
    Given I am authorized user

  @SchemaValidation
  Scenario: Validates beneficiary is not added when account_number key is missing from bankdetails jsonobject
  And I create request payload with valid data for all keys without "account_number"
  When I perform post on CreateBeneficiary endpoint
  Then Response status code is 400
  And Response status line is "Bad Request"
  And Response "code" has value "payment_schema_validation_failed"
  And Response "message" has value "This field is required"
  And Response "source" has value "beneficiary.bank_details.account_number"
  
  @SchemaValidation
  Scenario: Validates beneficiary is not added when account_number value is Empty
  And I create request payload with valid data for all keys with "account_number" is "Empty"
  When I perform post on CreateBeneficiary endpoint
  Then Response status code is 400
  And Response status line is "Bad Request"
  And Response "code" has value "payment_schema_validation_failed"
  And Response "message" has value "This field is required"
  And Response "source" has value "beneficiary.bank_details.account_number"
  
  @RequirementMismatch-AcctNumber
  Scenario Outline: Validate beneficiary is sucessfully added for "bank_country_code" <bank_country_code> when "account_number" <account_number> contains special characters
  And I create request payload with valid data for all keys with "bank_country_code" is "<Bank_Country_Code>" "account_number" is "<account_number>"
  When I perform post on CreateBeneficiary endpoint
  Then Response status code is 201
  And Response status line is "Created"
  
  Examples:
  | Bank_Country_Code | account_number   | number_of_characters |
  | US                | AGT-789IJY-T2345 |                   14 |
  | AU                | AGT:789          |                    6 |
  | CN                | AGT 789IJY T2345 |                   16 |
  
  @RequirementMismatch-AcctNumber @RequirementMismatch-ImproperResponseMessage
  Scenario Outline: Validate error response is returned for "bank_country_code" <Bank_Country_Code> when "account_number" <account_number> has invalid no. of characters <number_of_characters>
    And I create request payload with valid data for all keys with "bank_country_code" is "<Bank_Country_Code>" "account_number" is "<account_number>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "payment_schema_validation_failed"
    And Response "message" has value "Length of account_number should be between <Min> and <Max> when bank_country_code is <Bank_Country_Code>"
    And Response "source" has value "beneficiary.bank_details.account_number"

    Examples: 
      | Bank_Country_Code | account_number                      | number_of_characters | Min | Max |
      | US                | asedr5432GHUYJIO2345                |                   20 |   1 |  17 |
      | US                | asedr5432GHUYJIO23451321432         |                   26 |   1 |  17 |
      | AU                | MJIKH                               |                    5 |   6 |   9 |
      | AU                | er456tbg                            |                    8 |   6 |   9 |
      | AU                | de444556677833224                   |                   17 |   6 |   9 |
      | AU                | de44455667783322412345              |                   22 |   6 |   9 |
      | CN                | G                                   |                    1 |   8 |  20 |
      | CN                |                              123456 |                    6 |   8 |  20 |
      | CN                | 123456789qwertyui                   |                   17 |   8 |  20 |
      | CN                | ASEDRFTGYHUJIKOL1234123456789012345 |                   35 |   8 |  20 |
     
     
  @PositiveScenarios 
  Scenario Outline: Validate beneficiary is sucessfully added when for "bank_country_code" <Bank_country_code> when "account_number" <account_number> has valid <number_of_characters> characters
    And I create request payload with valid data for all keys with "bank_country_code" is "<Bank_Country_Code>" "account_number" is "<account_number>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 201
    And Response status line is "Created"

    Examples: 
      | Bank_Country_Code | account_number       | number_of_characters |
      | US                | A                    |                    1 |
      | US                |                    0 |                    1 |
      | US                |            123456789 |                    9 |
      | AU                | MJIKHI               |                    6 |
      | AU                |            987654321 |                    9 |
      | AU                | GFhyi345             |                    8 |
      | CN                | GFh44445             |                    8 |
      | CN                | 123456789DERftguhijo |                   20 |