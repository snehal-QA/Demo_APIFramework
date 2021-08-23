package cucumber.Options;


import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;

//Cucumber Test runner to report setup. It will be available at target/Reports/cucumber-html-reports 
@CucumberOptions(features="src/test/resources/features",
plugin ={"pretty", "html:target/Reports/cucumber-report.html",
		 "json:target/Reports/cucumber.json","junit:target/Reports/cucumber.xml"}
,glue= {"stepDefinitions"}
,dryRun=false)
public class RunCucumberTests extends AbstractTestNGCucumberTests {	
	
}
