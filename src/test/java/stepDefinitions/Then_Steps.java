package stepDefinitions;
import org.testng.asserts.SoftAssert;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;
import io.cucumber.java.en.Then;

import io.restassured.response.Response;
import utilities.Json_handler;
import utilities.Log;

public class Then_Steps {
	
	private ScenarioContext scenarioCtx;      //Dependency Injection to pass data across files and use where required
	Scenario scenario;                        //Logging data in Reports
	SoftAssert softAssert = new SoftAssert(); //Soft Asserts are used to make sure all assertions are executed so as to capture exact reason of failure
	
	public Then_Steps (ScenarioContext scenarioCtx) {
		this.scenarioCtx = scenarioCtx;
	}
	
	@Before
	public void before(Scenario scenario) {
	    this.scenario = scenario;
	}
	
	@After
	public void after(Scenario scenario) {
	    this.scenario = scenario;
	    softAssert.assertAll();
	}
	
	
	// Check response status code for actual to expected
	// It is used for all the features
	@Then("Response status code is {int}")
	public void response_status_code_is(Integer status_code) {
		Response response=(Response) this.scenarioCtx.getScenarioCtx("Response");
		Log.info("Response status code is "+ response.getStatusCode());
		softAssert.assertEquals((Integer) response.getStatusCode(), status_code); 
	}

	// Check response status code for actual to expected
	// It is used for all the features
	@Then("Response status line is {string}")
	public void response_status_line_is(String status_line) {
		Response response=(Response) this.scenarioCtx.getScenarioCtx("Response");
		Log.info("Response status line is "+ response.getStatusLine());
		softAssert.assertTrue(response.getStatusLine().contains(status_line));
	}

	// Check response status code for actual to expected
	// It is used for all the features
	@Then("Response {string} has value {string}")
	public void response_contains_value(String resp_key, String resp_val) {	
		Response response=(Response) this.scenarioCtx.getScenarioCtx("Response");
		Log.info("Response " + resp_key + " contains value " + Json_handler.getJsonPath(response, resp_key));
		softAssert.assertEquals(Json_handler.getJsonPath(response, resp_key), resp_val); 
	}
}
