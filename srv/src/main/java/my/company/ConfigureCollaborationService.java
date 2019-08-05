package my.company;
import java.util.*;
import com.sap.cloud.sdk.odatav2.connectivity.ODataException;
import com.sap.cloud.sdk.s4hana.datamodel.odata.services.DefaultEnterpriseProjectService;
import com.sap.cloud.sdk.service.prov.api.operations.Query;
import com.sap.cloud.sdk.service.prov.api.DataSourceHandler;
import com.sap.cloud.sdk.service.prov.api.EntityData;
import com.sap.cloud.sdk.service.prov.api.ExtensionHelper;
import com.sap.cloud.sdk.service.prov.api.response.QueryResponse;
import com.sap.cloud.sdk.service.prov.api.request.QueryRequest;
import com.sap.cloud.sdk.service.prov.api.exception.DatasourceException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sap.cloud.sdk.s4hana.datamodel.odata.namespaces.enterpriseproject.EnterpriseProject;

import com.sap.cloud.sdk.service.prov.api.response.ErrorResponse;

import com.sap.cloud.sdk.service.prov.api.annotations.Action;
import com.sap.cloud.sdk.service.prov.api.request.OperationRequest;
import com.sap.cloud.sdk.service.prov.api.response.OperationResponse;
import com.sap.cloud.sdk.s4hana.connectivity.*;

public class ConfigureCollaborationService {
	private Logger logger = LoggerFactory.getLogger(ConfigureCollaborationService.class);
	private static final String DESTINATION_NAME = "ErpQueryEndpoint"; //Refers to the destination created in Step 6
	private static final String apikey = "awXIDnqo2RaDSnAyUpYGQrciJzVQ2MNB"; //Replace with your API key
	private ErpConfigContext context = new ErpConfigContext(DESTINATION_NAME);
	
/*	
	@Query(serviceName="CollaborationConfigureService", entity = "EnterpriseProjectRemote")
	public QueryResponse querySupplier(QueryRequest qryRequest) {

    QueryResponse queryResponse;
    int top = qryRequest.getTopOptionValue();
    int skip = qryRequest.getSkipOptionValue();

    try {
    	// Create Map containing request header information
        	Map<String, String> requestHeaders = new HashMap<>();
        	requestHeaders.put("Content-Type","application/json");
        	requestHeaders.put("APIKey",apikey);

    	final List<EnterpriseProject> projects =
    	             new DefaultEnterpriseProjectService().getAllEnterpriseProject()
    	            .withCustomHttpHeaders(requestHeaders).onRequestAndImplicitRequests()
    	            .select(EnterpriseProject.PROJECT_UUID, EnterpriseProject.PROJECT, EnterpriseProject.PROJECT_DESCRIPTION, EnterpriseProject.PROFIT_CENTER)
    	            .top(top >= 0 ? top : 50)
    	            .skip(skip >= 0 ? skip : -1)
    	            .execute(context);
    	queryResponse = QueryResponse.setSuccess().setData(projects).response();

    } catch (final ODataException e) {
    	logger.error("Error occurred with the Query operation: " + e.getMessage(), e);
    	ErrorResponse er = ErrorResponse.getBuilder()
    	                            .setMessage("Error occurred with the Query operation: " + e.getMessage())
    	                            .setStatusCode(500).setCause(e).response();
    	queryResponse = QueryResponse.setError(er);
    }

	  return queryResponse;
	}	
	*/
	
	@Action(Name="SetInUse", serviceName="CollaborationConfigureService")
	public OperationResponse setInUse(OperationRequest actionRequest, ExtensionHelper extensionHelper )
	{
	  Map<String, Object> parameters = actionRequest.getParameters();
	  DataSourceHandler handler = extensionHelper.getHandler();
	
	  Map<String, Object> keys = new HashMap<String, Object>();
	  keys.put("ID", String.valueOf(parameters.get("ID")));

        List<String> flattenedElementNames = Arrays.asList(
                "ID",
                "state_state");
	
	  //fetching the product details for the id and fetching the amount
	  try {
	    EntityData entityData = handler.executeRead("CollaborationType", keys, flattenedElementNames);
	    String state;
	
	    //applying discount on the amount
	    state = "2";
	
	    //reconstructing the entityData with new amount value
	    entityData = EntityData.getBuilder(entityData).removeElement("state_state").addElement("state_state", state).buildEntityData("CollaborationType");
	    //updating the product
	    handler.executeUpdate(entityData, keys, false);
	
	    OperationResponse response = OperationResponse.setSuccess().setEntityData(Arrays.asList(entityData)).response();
	
	    return response;
	  } catch (DatasourceException e) {
	    // Return an instance of OperationResponse containing the error in
	    // case of failure
	    ErrorResponse errorResponse = ErrorResponse.getBuilder()
	        .setMessage(e.getMessage())
	        .setCause(e)
	        .response();
	
	    return OperationResponse.setError(errorResponse);
	  }
	} 
}
