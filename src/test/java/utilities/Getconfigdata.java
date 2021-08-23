package utilities;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import org.json.JSONException;
import org.json.JSONObject;

import io.restassured.RestAssured;
import io.restassured.internal.support.FileReader;

public class Getconfigdata {

	
//	//Read Config.properties from java resources
//	public static String getPropertyValue(String key) throws IOException
//	{
//		Properties prop =new Properties();
//		FileInputStream fis =new FileInputStream(System.getProperty("user.dir")+"/src/test/resources/config.properties");
//		prop.load(fis);
//		return prop.getProperty(key);		
//	}
	
	//Read JSON from test resources 
	public static String readJSONFile(String path) throws IOException
	{	
		String fileLoc = System.getProperty("user.dir")+ path;
		JSONObject jsonString = new JSONObject(FileReader.readToString(new File(fileLoc), "UTF-8"));
		return jsonString.toString();		
	}
	
}
