using collaboration.configure as configure from '../db/ConfigureCollaborationEntity';

using API_ENTERPRISE_PROJECT_SRV as ep from '../srv/external/csn/EnterpriseProjectCreateReadUpdateDelete';
service CollaborationConfigureService {
    entity CollaborationType as projection on configure.CollaborationType;
    entity StatusProfile as projection on configure.StatusProfile;
    entity CollaborationTypeState as projection on configure.CollaborationTypeState;
    action SetInUse ( ID:UUID );
      entity EnterpriseProject as projection on ep.A_EnterpriseProjectType
	 excluding {to_SupplierCompany, to_SupplierPurchasingOrg};
}
