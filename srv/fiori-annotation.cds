using CollaborationConfigureService as srv from './cat-service';

annotate srv.CollaborationType with {
  collaboration_type
	@title: 'Collaboration Type title'
	@Common.FieldControl: #Mandatory;
  description
    @title: 'Collaboration Type Description3';
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
      ],
      Label:'Collaboration Type',
    }
    ],
    
  UI.FieldGroup#HeaderInfo: {
    Label: 'Header Info',
    Data: [
      {$Type: 'UI.DataField', Value: state_state, Label : 'State1'}
    ]
  },
  
  UI.FieldGroup#GeneralInfo: {
    Label: 'Gerneral Info',
    Data: [
      {$Type: 'UI.DataField', Value: collaboration_type},
      {$Type: 'UI.DataField', Value: description},
      {$Type: 'UI.DataField', Value: state_state, label: 'State in facet'},
    ]
  },
  
  UI.FieldGroup#StatusProfile: {
    Label: 'Status Profile',
    Data: [
      {$Type: 'UI.DataField', Value: profile_ID, Label: 'Profile in facet'}
    ]
  }  
);