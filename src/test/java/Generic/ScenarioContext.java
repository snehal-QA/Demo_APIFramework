package Generic;

import java.io.IOException;
import java.util.HashMap;
import utilities.Getconfigdata;


//Scenario Context to pass the values between Steps files via Dependency Injection
public class ScenarioContext {
	
	//Stores key and values to pass through out the different steps
	private HashMap<String, Object>	scenarioCtx = new HashMap<String, Object>();
	
	public ScenarioContext(HashMap<String, Object> scenarioCtx) throws IOException {
		this.scenarioCtx = scenarioCtx;
//		expectedValues();
		CreateTestData();
	}

	public Object getScenarioCtx(String key) {
		return scenarioCtx.get(key);
	}

	public void setScenarioCtx(String key, Object obj) {
		this.scenarioCtx.put(key, obj);
	}	
	
//	public void expectedValues() throws IOException {
//		String path="/src/test/resources/requirement_spec/expected_values.json";
//		this.scenarioCtx.put("expectedVal", Getconfigdata.readJSONFile(path));
//	}
	
	public void CreateTestData( ) throws IOException {
		String path="/src/test/resources/RequestPayload/createbeneficiarypayload.json";
		this.scenarioCtx.put("testData", Getconfigdata.readJSONFile(path));
		
	}	
}
