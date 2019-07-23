namespace collaboration.configure;


entity CollaborationType {
  key collaboration_type: String;
  description: String;
  profile : Association to StatusProfile;
  state  : Association to CollaborationTypeState;
  create_date: Date;
  create_time: Time;
}

entity StatusProfile {
  key ID : String;
  description: String;
}


entity CollaborationTypeState {
  key state: String;
  description: String;
}