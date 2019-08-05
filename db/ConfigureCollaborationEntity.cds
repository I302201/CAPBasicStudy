namespace collaboration.configure;
using managed from '@sap/cds/common';

/*
using API_ENTERPRISE_PROJECT_SRV as ep from '../srv/external/csn/EnterpriseProjectCreateReadUpdateDelete';
@cds.persistence.skip
entity EnterpriseProjectRemote as SELECT from ep.A_EnterpriseProjectType {
  key ProjectUUID            as ProjectUUID,
  key ProfitCenter	as ProfitCenter,
  Project                                                               as Project,
  ProjectDescription	as ProjectDescription,
};



@cds.persistence: { skip: false, table: true }  // make the entity a table on DB
entity EnterpriseProject as projection on EnterpriseProjectRemote;


entity EnterpriseProject{
  key ID: UUID;
  key ProfitCenter: String(10);
  Project : String;
  ProjectDescription: String;
};
*/


entity EnterpriseProjectRemote {
  key ProjectUUID: String(10);
  ProfitCenter: String(10);
  Project : String;
  ProjectDescription: String;
};

entity CollaborationTypeDesc{
  key lan: String(2);
  key collaboration_type: String(4) not null;	
  desc: String;
};

entity CollaborationType: managed {
  key ID: UUID;
  collaboration_type: String(4) not null;
  ProfitCenter: String(10);
  projects: Association to many EnterpriseProjectRemote on projects.ProfitCenter = ProfitCenter;
  descriptions: Composition of many CollaborationTypeDesc on descriptions.collaboration_type = collaboration_type;
  version: Integer;
  description: String;
  profile : Association to StatusProfile;
  state  : Association to CollaborationTypeState;
};

entity StatusProfile {
  key ID : String;
  description: String;
};


entity CollaborationTypeState {
  key state: String;
  description: String;
};



