namespace collaboration.configure;
using managed from '@sap/cds/common';

entity CollaborationType: managed {
  key ID: UUID;
  collaboration_type: String(4) not null;
  version: Integer;
  description: String;
  profile : Association to StatusProfile;
  state  : Association to CollaborationTypeState;
}

entity StatusProfile {
  key ID : String;
  description: String;
}


entity CollaborationTypeState {
  key state: String;
  description: String;
}