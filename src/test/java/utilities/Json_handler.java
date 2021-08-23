package utilities;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.json.JSONArray;
import org.json.JSONObject;

import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;

public class Json_handler {
		
	public static String getJsonPath(Response response,String key)
	{
		  String resp=response.asString();
		  JsonPath   js = new JsonPath(resp);
		  return js.get(key).toString();
	}
	
}