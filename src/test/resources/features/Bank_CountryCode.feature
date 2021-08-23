Feature: Validates bank_country_code in BankDetails

  This feature consists of scenarios that perform various functional validations on bank_country_code,
  ####  Prerequisite: All other values dependant & independent of bank_country_code are valid  #################
  Background: 
    Given I am authorized user
  
  @SchemaValidation
  Scenario: Validates beneficiary is not added when Bank_Country_Code key is missing
    And I create request payload with valid data for all keys without "bank_country_code"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "field_required"
    And Response "message" has value "must not be null"
    And Response "source" has value "beneficiary.bank_details.bank_country_code"

  @SchemaValidation
  Scenario: Validates beneficiary is not added when Bank_Country_Code value is Empty
    And I create request payload with valid data for all keys with "bank_country_code" is "Empty"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "invalid_argument"
    And Response "message" has value " is not a valid type"
    And Response "source" has value "beneficiary.bank_details.bank_country_code"

  Scenario Outline: Validates beneficiary is added when Bank_Country_Code is valid but in small case <Bank_Country_Code>
    And I create request payload with valid data for all keys with "bank_country_code" is "<Bank_Country_Code>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "invalid_argument"
    And Response "message" has value "<Bank_Country_Code> is not a valid type"
    And Response "source" has value "beneficiary.bank_details.bank_country_code"

    Examples: 
      | Bank_Country_Code |
      | us                |
      | cn                |

   Scenario Outline: Validates beneficiary is not added when Bank_Country_Code does not follow 'ISO 3166-2' standard
    And I create request payload with valid data for all keys with "bank_country_code" is "<Bank_Country_Code>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "invalid_argument"
    And Response "message" has value "<Bank_Country_Code> is not a valid type"
    And Response "source" has value "beneficiary.bank_details.bank_country_code"

    Examples: 
      | Bank_Country_Code |
      | UP                |
      | XT                |

  Scenario Outline: Validates beneficiary is not added when Bank_Country_Code as per 'ISO 3166-2' standard but invalid for Airwallex
    And I create request payload with valid data for all keys with "bank_country_code" is "<Bank_Country_Code>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 400
    And Response status line is "Bad Request"
    And Response "code" has value "payment_schema_validation_failed"
    And Response "message" has value "Should be one of the following: [AD, AE, AG, AI, AL, AM, AN, AO, AR, AT, AU, AW, AZ, BA, BD, BE, BG, BH, BO, BR, BZ, CA, CH, CL, CN, CO, CR, CW, CY, CZ, DE, DK, DM, DO, DZ, EC, EE, EG, ES, FI, FJ, FR, GB, GD, GE, GG, GI, GQ, GR, GT, GY, HK, HN, HR, HU, ID, IE, IL, IM, IN, IS, IT, JE, JM, JO, JP, KE, KG, KH, KR, KZ, KW, LI, LK, LT, LU, LV, MA, MC, MD, ME, MK, MO, MQ, MT, MU, MV, MX, MY, NA, NG, NL, NO, NP, NZ, OM, PA, PE, PF, PH, PK, PL, PM, PR, PT, PY, QA, RO, RS, RU, SA, SC, SE, SG, SI, SK, SM, SV, TH, TJ, TN, TR, TZ, TW, UA, UG, US, UY, UZ, VN, VU, YT, ZA, ZM]"
    And Response "source" has value "beneficiary.bank_details.bank_country_code"

    Examples: 
      | Bank_Country_Code |
      | AX                |
      | CC                |
      
   @PositiveScenarios
   Scenario Outline: Validates beneficiary is added when Bank_Country_Code is valid but in small case <Bank_Country_Code>
    And I create request payload with valid data for all keys with "country code" is "<Bank_Country_Code>" "bank_country_code" is "<Bank_Country_Code>"
    When I perform post on CreateBeneficiary endpoint
    Then Response status code is 201
    And Response status line is "Created"

    Examples: 
      | Bank_Country_Code |
      | US                |
      | AU                |