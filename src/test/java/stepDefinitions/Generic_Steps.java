package stepDefinitions;

import java.io.IOException;

import org.json.JSONObject;
import org.testng.asserts.SoftAssert;

import Generic.APIEndpoints;
import Generic.ScenarioContext;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import utilities.Json_handler;
import utilities.Log;

public class Generic_Steps {
	
	private ScenarioContext scenarioCtx;
	Scenario scenario;
	SoftAssert softAssert = new SoftAssert();
	
	public Generic_Steps(ScenarioContext scenarioCtx) {
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

	@Given("I am authorized user")
	public void i_am_authorized_user() throws IOException {
		Log.startTestCase(scenario.getName());
	    Response response=APIEndpoints.Authentication();
	    String token= Json_handler.getJsonPath(response, "token");
	    Log.info("Token Created");
	    this.scenarioCtx.setScenarioCtx("Token", token);
	 }
	
	@Given("I create request payload with valid data for all keys without {string}")
	public void i_create_request_payload_with_valid_data_for_all_keys_without_bank_country_code(String req_field) {
		JSONObject json_obj =  new JSONObject((String) this.scenarioCtx.getScenarioCtx("testData")).getJSONObject("US");
		if(req_field.contains("payment_methods")) {
			json_obj.remove(req_field);
			this.scenarioCtx.setScenarioCtx("RequestPayload", json_obj.toString());
			Log.info("Request PayLoad Created with all keys, except without " + req_field + " Code key");
			this.scenario.log("Request Payload : " + json_obj.toString(4));			
		}
		else {
			json_obj.getJSONObject("beneficiary").getJSONObject("bank_details").remove(req_field);
			this.scenarioCtx.setScenarioCtx("RequestPayload", json_obj.toString());
			Log.info("Request PayLoad Created with all keys, except without  " + req_field + " Code key");
			this.scenario.log("Request Payload : " + json_obj.toString(4));	
		}
	}

	@Given("I create request payload with valid data for all keys with {string} is {string}")
	public void i_create_request_payload_with_valid_data_for_all_keys_with_bank_country_code_is(String req_field,String req_val) {
		JSONObject json_obj =  new JSONObject((String) this.scenarioCtx.getScenarioCtx("testData")).getJSONObject("US");
		
		if(req_field.equals("payment_methods") && req_val.equals("Empty")) {  	
	    	json_obj.getJSONArray(req_field).put(0, "");
	    	this.scenarioCtx.setScenarioCtx("RequestPayload", json_obj.toString());
	    	Log.info("Request PayLoad Created with all keys, with " + req_field + " value is Empty");
	    } else if(req_field.equals("payment_methods") && !req_val.equals("Empty")) {  	
	    	json_obj.getJSONArray(req_field).put(0, req_val);
	    	this.scenarioCtx.setScenarioCtx("RequestPayload", json_obj.toString());
	    	Log.info("Request PayLoad Created with all keys, with " + req_field + " value is Empty");
	    } 
		else if(req_val.equals("Empty")) 
		{  	
	    	json_obj.getJSONObject("beneficiary").getJSONObject("bank_details").put(req_field, "");	    	
	    	this.scenarioCtx.setScenarioCtx("RequestPayload", json_obj.toString());
	    	Log.info("Request PayLoad Created with all keys, with " + req_field + " value is " + req_val);
	    }
	    else {
	    	json_obj.getJSONObject("beneficiary").getJSONObject("bank_details").put(req_field, req_val);
	    	this.scenarioCtx.setScenarioCtx("RequestPayload", json_obj.toString());	 
	    	Log.info("Request PayLoad Created with all keys, with " + req_field + " value is " + req_val);
	    }
	    this.scenario.log("Request Payload : " + json_obj.toString(4));
	}
	
	@Given("I create request payload with valid data for all keys with {string} is {string} {string} is {string}")
	public void i_create_request_payload_with_valid_data_for_all_keys_with_is_is(String req_field1, String req_val1, String req_field2, String req_val2) {
		JSONObject json_obj =  new JSONObject((String) this.scenarioCtx.getScenarioCtx("testData")).getJSONObject(req_val1);
		json_obj.getJSONObject("beneficiary").getJSONObject("bank_details").put(req_field2,req_val2);
		this.scenarioCtx.setScenarioCtx("RequestPayload", json_obj.toString());
		Log.info("Request PayLoad Created");
		this.scenario.log("Request Payload : " + json_obj.toString(4));

	}
	
	@Given("I create request payload with valid data for all keys with {string} is {string} {string} is {string} {string} is {string}")
	public void i_create_request_payload_with_valid_data_for_all_keys_with_is_is_is(String req_field1, String req_val1, String req_field2, String req_val2,String req_field3, String req_val3) {
		JSONObject json_obj =  new JSONObject((String) this.scenarioCtx.getScenarioCtx("testData")).getJSONObject(req_val1);
		json_obj.getJSONObject("beneficiary").getJSONObject("bank_details").put(req_field2,req_val2);
		json_obj.getJSONObject("beneficiary").getJSONObject("bank_details").put(req_field3,req_val3);
		this.scenarioCtx.setScenarioCtx("RequestPayload", json_obj.toString());
		Log.info("Request PayLoad Created");
		this.scenario.log("Request Payload : " + json_obj.toString(4));	    // Write code here that turns the phrase above into concrete actions
	}
	
	@When("I perform post on CreateBeneficiary endpoint")
	public void i_perform_post_on_create_beneficiary_endpoint() {
		Response response=APIEndpoints.createBeneficiary((String) this.scenarioCtx.getScenarioCtx("RequestPayload"),(String) this.scenarioCtx.getScenarioCtx("Token"));
		this.scenarioCtx.setScenarioCtx("Response", response);
		Log.info("Request PayLoad is posted");
		this.scenario.log("Response : " + response.asPrettyString());
	}

	@Then("Response status code is {int}")
	public void response_status_code_is(Integer status_code) {
		Response response=(Response) this.scenarioCtx.getScenarioCtx("Response");
		Log.info("Response status code is "+ response.getStatusCode());
		softAssert.assertEquals((Integer) response.getStatusCode(), status_code); 
	}

	@Then("Response status line is {string}")
	public void response_status_line_is(String status_line) {
		Response response=(Response) this.scenarioCtx.getScenarioCtx("Response");
		Log.info("Response status line is "+ response.getStatusLine());
		softAssert.assertTrue(response.getStatusLine().contains(status_line));
	}

	@Then("Response {string} has value {string}")
	public void response_contains_value(String resp_key, String resp_val) {
		Response response=(Response) this.scenarioCtx.getScenarioCtx("Response");
		Log.info("Response " + resp_key + " contains value " + Json_handler.getJsonPath(response, resp_key));
		softAssert.assertEquals(Json_handler.getJsonPath(response, resp_key), resp_val); 
	}
}
