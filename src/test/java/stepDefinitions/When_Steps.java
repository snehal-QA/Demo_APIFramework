package stepDefinitions;


import org.testng.asserts.SoftAssert;
import Generic.APIEndpoints;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import utilities.Log;

public class When_Steps {
	
	private ScenarioContext scenarioCtx;
	Scenario scenario;
	SoftAssert softAssert = new SoftAssert();
	
	public When_Steps (ScenarioContext scenarioCtx) {
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
	
	// Posting the Payload created in Given Step
	@When("I perform post on CreateBeneficiary endpoint")
	public void i_perform_post_on_create_beneficiary_endpoint() {
		Response response=APIEndpoints.createBeneficiary((String) this.scenarioCtx.getScenarioCtx("RequestPayload"),(String) this.scenarioCtx.getScenarioCtx("Token"));
		this.scenarioCtx.setScenarioCtx("Response", response);
		Log.info("Request PayLoad is posted");
		Log.info("\nResponse : " + response.asPrettyString());
		this.scenario.log("Response : " + response.asPrettyString());
	}
	

}
