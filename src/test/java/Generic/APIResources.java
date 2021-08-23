package Generic;

public enum APIResources {
	
	//Resources
	AuthEndpoint("/api/v1/authentication/login"),
	CreateBeneficiaryEndpoint("/api/v1/beneficiaries/create");
	
private String resource;
	
	APIResources(String resource)
	{
		this.resource=resource;
	}
	
	public String getResource()
	{
		return resource;
	}
}
