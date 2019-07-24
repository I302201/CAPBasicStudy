using collaboration.configure as configure from '../db/ConfigureCollaborationEntity';

service CollaborationConfigureService {
    entity CollaborationType as projection on configure.CollaborationType;
    entity StatusProfile as projection on configure.StatusProfile;
    entity CollaborationTypeState as projection on configure.CollaborationTypeState;
    action SetInUse ( ID:UUID );
}
