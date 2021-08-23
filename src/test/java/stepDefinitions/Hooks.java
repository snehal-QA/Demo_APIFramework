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
	
	//Environment is taken from /src/test/resources/EnvConfig.json 
	//The required environment can be updated in this json file 
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
