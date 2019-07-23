package my.company;
import java.util.*;



import com.sap.cloud.sdk.service.prov.api.DataSourceHandler;
import com.sap.cloud.sdk.service.prov.api.EntityData;
import com.sap.cloud.sdk.service.prov.api.ExtensionHelper;


import com.sap.cloud.sdk.service.prov.api.exception.DatasourceException;


import com.sap.cloud.sdk.service.prov.api.response.ErrorResponse;

import com.sap.cloud.sdk.service.prov.api.annotations.Action;
import com.sap.cloud.sdk.service.prov.api.request.OperationRequest;
import com.sap.cloud.sdk.service.prov.api.response.OperationResponse;


public class ConfigureCollaborationService {
	@Action(Name="SetInUse", serviceName="CollaborationConfigureService")
	public OperationResponse setInUse(OperationRequest actionRequest, ExtensionHelper extensionHelper )
	{
	  Map<String, Object> parameters = actionRequest.getParameters();
	  DataSourceHandler handler = extensionHelper.getHandler();
	
	  Map<String, Object> keys = new HashMap<String, Object>();
	  keys.put("collaboration_type", String.valueOf(parameters.get("collaboration_type")));

        List<String> flattenedElementNames = Arrays.asList(
                "collaboration_type",
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
