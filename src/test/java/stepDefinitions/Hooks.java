package stepDefinitions;

import java.io.IOException;

import org.json.JSONObject;
import io.cucumber.java.Before;
import io.restassured.RestAssured;
import utilities.Getconfigdata;

public class Hooks {

	public static String base_url;
	public static String x_client_id;
	public static String x_api_key;
	
	//Think of logic to create a baseurl based upon the environment.
	//As per me best way is to keep it under config.json and have baseurl's and x-api &x-client-id keys as that
	//can be different per env
	@Before
	public static void envConfig() throws IOException {
		String path="/src/test/resources/EnvConfig.json";
		JSONObject env_config =  new JSONObject(Getconfigdata.readJSONFile(path));
		base_url=(String) env_config.getJSONObject(env_config.getString("env")).get("BaseUrl");
		x_client_id=(String) env_config.getJSONObject(env_config.getString("env")).get("x-client-id");
		x_api_key=(String) env_config.getJSONObject(env_config.getString("env")).get("x-api-key");
		RestAssured.baseURI=base_url;		
	}
}
