using CollaborationConfigureService as srv from './cat-service';

annotate srv.CollaborationType with {
  collaboration_type
	@title: 'Collaboration Type title'
	@Common.FieldControl: #Mandatory;
  description
    @title: 'Collaboration Type Description3';
  ProfitCenter
    @title: 'Profit Center';
  profile
    @Common: {
      Label : 'Status Profile',
      Text: {$value: profile.description, "@UI.TextArrangement": #TextOnly},
      ValueList: { entity: 'StatusProfile' }
    };    
  state
    @Common: {
      Label : 'State',
      Text: {$value: state.description, "@UI.TextArrangement": #TextOnly},
      ValueList: { entity: 'CollaborationTypeState' }
    };    
};

annotate srv.CollaborationTypeState with {
  state
    @title: 'State';
  description
	@title: 'StateDesc';
};

annotate srv.EnterpriseProjectRemote with {
  ProfitCenter
    @title: 'Profit Center';
  Project
	@title: 'Project Number';
  ProjectDescription
	@title: 'Project Desc';	
};

annotate srv.CollaborationType with @(
  UI.LineItem: [
    {$Type: 'UI.DataField', Value: collaboration_type, Label: 'Collaboration Type label'},
    {$Type: 'UI.DataField', Value: description, Label : 'Collaboration Type Description'},
    {$Type: 'UI.DataField', Value: profile_ID, Label : 'Status Profile'},
    {$Type: 'UI.DataField', Value: state_state, Label : 'State'},
  ],
  UI.HeaderInfo: {
    Title: { Value: collaboration_type },
    Description: { Value: description },
    TypeName: 'Type',
    TypeNamePlural: 'Types'
  },

  UI.Identification: [
	{ $Type: 'UI.DataFieldForAction', Label: 'Set in Use1', Action: 'CollaborationConfigureService.CollaborationType/SetInUse' },
  ],

  UI.HeaderFacets: [
    { $Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#HeaderInfo' }
  ],  
  
  UI.Facets: [
    {
      $Type:'UI.CollectionFacet',
      Facets: [
        { $Type: 'UI.ReferenceFacet', Label: 'General Info', Target: '@UI.FieldGroup#GeneralInfo' },
        { $Type: 'UI.ReferenceFacet', Label: 'Profile Info', Target: '@UI.FieldGroup#StatusProfile' },
//        { $Type: 'UI.ReferenceFacet', Label: 'Projects', Target: '@UI.LineItem#Projects' },
      ],
      Label:'Collaboration Type',
    },
    
    {
        $Type: 'UI.ReferenceFacet', Label: 'Projects', Target: 'projects/@UI.LineItem#Project',
    },
    {
        $Type: 'UI.ReferenceFacet', Label: 'Descriptions', Target: 'descriptions/@UI.LineItem#Description',
    },    
/*    
    {
      $Type:'UI.CollectionFacet',
      Facets: [
        { $Type: 'UI.ReferenceFacet', Label: 'Desc', Target: 'descriptions/@UI.LineItem#Desc' },
      ],      
      Label:'Desc',
    }
*/    
    ],
    
  UI.FieldGroup#HeaderInfo: {
    Label: 'Header Info',
    Data: [
      {$Type: 'UI.DataField', Value: state_state, Label : 'State1'},
      {$Type: 'UI.DataField', Value: version, Label : 'Version'}
    ]
  },
  
  UI.FieldGroup#GeneralInfo: {
    Label: 'Gerneral Info',
    Data: [
      {$Type: 'UI.DataField', Value: collaboration_type},
      {$Type: 'UI.DataField', Value: description},
      {$Type: 'UI.DataField', Value: state_state, Label: 'State'},
      {$Type: 'UI.DataField', Value: ProfitCenter, Label: 'EPPM Profit Center'},
    ]
  },
  
  UI.FieldGroup#StatusProfile: {
    Label: 'Status Profile',
    Data: [
      {$Type: 'UI.DataField', Value: profile_ID, Label: 'Profile in facet'}
    ]
  },
 /*
  UI.LineItem#Projects: [
      {$Type: 'UI.DataField', Value: projects.Project, Label: 'Project ID'},
      {$Type: 'UI.DataField', Value: projects.ProjectDescription, Label: 'Project Description'}, 
    ],
  UI.LineItem#Desc: [
      {$Type: 'UI.DataField', Value: descriptions.lan, Label: 'Language'},
      {$Type: 'UI.DataField', Value: descriptions.desc, Label: 'Description'}, 
    ]    
    */
);


annotate srv.EnterpriseProjectRemote with @(
  UI.LineItem#Project: [ 
      {$Type: 'UI.DataField', Value: Project},
      {$Type: 'UI.DataField', Value: ProjectDescription}, 
      {$Type: 'UI.DataField', Value: ProfitCenter}, 
  ],
);  

annotate srv.CollaborationTypeDesc with @(
  UI.LineItem#Description: [ 
      {$Type: 'UI.DataField', Value: lan},
      {$Type: 'UI.DataField', Value: desc}, 
  ],
);  