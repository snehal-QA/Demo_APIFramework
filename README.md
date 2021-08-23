# Demo_APIFramework

	This project implements rest api testing to create beneficiary using the below libraries.

## Tools/Framework/Libraries/Plugin
	-JDK 8
	-Maven - build tool
	-TestNG - test runner
	-Cucumber - BDD/Gherkin style feature files
	-Rest assured - Rest api Java library
	-org.json - Json handling
	-Log4j - Logging
	-maven-cucumber-reporting - Enhanced Reporting

## Environment Configuration: 

EnvConfig.json: (src/test/resources/)
	
	-Required environment can be configured by providing correct value to "env" key. Eg: "env":"test" (runs on test env)
	-Additional environment can be added in this json in respective json object format
	-Baseurl,x-client-id, x-api-key are the required fields.

## Run the tests using maven on CLI or via Jenkins

```shell script
mvn clean verify

```

## Reports: 

	- Enhance HTML Report:
		target/Reports/cucumber-html-reports/overview-features.html
		
	- Basic HTML Report:
		target/Reports/cucumber-report.html
		
## Logs:
	- Log4j: Logs location: target/logs/DemoCreateBeneficiaries.log
		
## BDD Cucumber(Feature file / Step definition)
	- BDD has a feature file to invoke the step definitions:
	- Scenarios are created in feature file as per the requirements,underlying code is present in Stepdefinitions;
	- Following the BDD practices for better communication on scenarios and coverage;

### Structure

##src/test/java

- Cucumber.Options: 

     This is heart of Cucumber; used cucumber-testng: All tests run through TestRunner code.

- Generic:
	
	-APIEndpoints. java: This contains code for api connection, making http request and collecting response. Response is further used in required stepdefinition files by calling appropriate functions within.
	-APIResources.java: Enum is used to store endpoints information and uses from here.

- StepDefinitions: 

	-Hooks:
		-@Before: This is first function for executing all scenarios; it reads and stores Environment values from EnvConfig.json to decide environment details.
		
	- ScenarioContext:
		Used for dependency injection where data is stored in a Hashmap and is assigned and retrieved in any steps/files.
		
	- Given_Steps.java 
		These contains programming logic for all given steps across all feature files.
		
	- When_Steps.java
		This contains programming logic for all when steps across all feature files.
		
	- Then_Steps.java
		This contains programming logic for all when steps across all feature files.
	
- utilities:

	-Getconfigdata:
		To read any .json files in a project
	
	-Json_handler.java
		To navigate through json and get required value
		
	-Log.java:
		To handle logs		

####src/test/resources

- features: Contains all functional scenarios for respective feilds in Bank_details

	-Account_Name.feature
	-Account_Number.feature
	-Bank_country_code.feature
	-Payment_method.feature
	-Routing_Type.feature
	-Swift_code.feature
	
- RequestPayload: 

	- createbeneficiarypayload.json (request_payload)
	


	
	
	
	
	
	