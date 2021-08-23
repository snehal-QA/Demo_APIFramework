Feature: Validates swift_code in BankDetails

  Background: 
    Given I am authorized user

  @SchemaValidation
  Scenario: Validates error response is received when payment_methods=SWIFT and Payload field swift_code is missing
    And I create request payload with valid data for all keys without "swift_code"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "payment_schema_validation_failed"
    And Response "message" has value "This field is required"
    And Response "source" has value "beneficiary.bank_details.swift_code"

  @SchemaValidation
  Scenario: Validates error response is received when payment_methods=SWIFT and Payload feild swift_code is Empty
    And I create request payload with valid data for all keys with "swift_code" is "Empty"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "payment_schema_validation_failed"
    And Response "message" has value "This field is required"
    And Response "source" has value "beneficiary.bank_details.swift_code"

  @RequirementMismatch-ImproperResponseMessage
  Scenario Outline: Validate error message is returned for "bank_country_code" <Bank_country_code> when "swift_code" <swiftcode> lessthan 8 or greaterthan 11 charcters
    And I create request payload with valid data for all keys with "bank_country_code" is "<Bank_Country_Code>" "swift_code" is "<swiftcode>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "payment_schema_validation_failed"
    And Response "message" has value "Length of 'swift_code' should be either 8 or 11"
    And Response "source" has value "beneficiary.bank_details.swift_code"

    Examples: 
      | Bank_Country_Code | swiftcode    | no.of characters |
      | US                | ICBKUS       |                6 |
      | AU                | ICBKAUBJ123w |               12 |

  @RequirementMismatch-ImproperResponseMessage
  Scenario Outline: Validate error message is returned when "swift_code" <swiftcode> do not contain passed <Bank_country_code> at 5th and 6th character
    And I create request payload with valid data for all keys with "bank_country_code" is "<Bank_Country_Code>" "swift_code" is "<swiftcode>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "payment_schema_validation_failed"
    And Response "message" has value "The swift code is not valid for the given bank country code: <Bank_country_code>"
    And Response "source" has value "beneficiary.bank_details.swift_code"

    Examples: 
      | Bank_Country_Code | swiftcode | countrycodecharacters               |
      | US                | CHAS33US  | 8-9                                 |
      | US                | USAS33US  | presentdouble at different location |
      | CN                | CNAS33US  | 1-2                                 |

	@RequirementMismatch-ImproperResponseMessage
  Scenario Outline: Validate error message is returned when "swift_code" <swiftcode> do not match with "Bank_Country_Code" <Bank_country_code> at 5th and 6th character
    And I create request payload with valid data for all keys with "bank_country_code" is "<Bank_Country_Code>" "swift_code" is "<swiftcode>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "payment_schema_validation_failed"
    And Response "message" has value "The swift code is not valid for the given bank country code: <Bank_country_code>"
    And Response "source" has value "beneficiary.bank_details.swift_code"

    Examples: 
      | Bank_Country_Code | swiftcode | 
      | US                | CHASAU33  | 
      | AU                | CHASUS33  | 
      | CN                | CHASAU33  |

 @RequirementMismatch-ImproperResponseMessage   
 Scenario Outline: Validate error message is returned when "swift_code" <swiftcode> matches with "country_code" <country_code> but not with "bank_country_code" <Bank_country_code>
    And I create request payload with valid data for all keys with "country_code" is "<country_code>" "bank_country_code" is "<Bank_Country_Code>" "swift_code" is "<swiftcode>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "payment_schema_validation_failed"
    And Response "message" has value "The swift code is not valid for the given bank country code: <Bank_country_code>"
    And Response "source" has value "beneficiary.bank_details.swift_code"

    Examples: 
      | country_code | Bank_Country_Code | swiftcode |
      | US           | AU                | CHASUS33  |
      | AU           | US                | CTBAAU2S  |

@PositiveScenarios
 Scenario Outline: Validate correct message is returned when "swift_code" <swiftcode> matches with "country_code" <country_code> but not with "bank_country_code" <Bank_country_code>
    And I create request payload with valid data for all keys with "country_code" is "<country_code>" "bank_country_code" is "<Bank_Country_Code>" "swift_code" is "<swiftcode>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 201
    And Response status line is "Created"

    Examples: 
      | country_code | Bank_Country_Code | swiftcode |
      | US           | US                | CHASUS33  |
      | AU           | AU                | CTBAAU2S  |

