package Generic;

import java.io.IOException;

import org.json.JSONObject;

import io.restassured.RestAssured;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import stepDefinitions.Hooks;
import utilities.Getconfigdata;

public class APIEndpoints {
	
//		private static String base_url;
//		private static String x_client_id;
//		private static String x_api_key;
//	
	
		//Authentication Endpoint
		public static Response Authentication() throws IOException {
			APIResources resource=APIResources.valueOf("AuthEndpoint");
	        RequestSpecification request = RestAssured.given();
	        request.header("Content-Type", "application/json");
	        String path="/src/test/resources/EnvConfig.json";
	        request.header("x-client-id",Hooks.x_client_id);
	        request.header("x-api-key",Hooks.x_api_key);	        
	        Response response = request.when().post(resource.getResource());
	        return response;      
		}
		
		
		//Create Beneficiary Endpoint
		public static Response createBeneficiary(String body, String token) {
			APIResources resource=APIResources.valueOf("CreateBeneficiaryEndpoint");
	        RequestSpecification request = RestAssured.given();
	        request.contentType("application/json")
	        .header("Authorization","Bearer "+ token)
	        .body(body);
	        Response response = request.when().post(resource.getResource());
	        
	        return response;
	    }
}
