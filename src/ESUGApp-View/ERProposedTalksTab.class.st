"
Description
--------------------

Tab to render all proposal talks in the database of an especific attendee (attendee of session).

I can edit and delete talks
"
Class {
	#name : #ERProposedTalksTab,
	#superclass : #ERMyRegistrationTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #adding }
ERProposedTalksTab >> addTalk [
	self initializeFormAddTalk.
	content state: formTalk.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERProposedTalksTab >> createTalk: aTalk [
	controller addTalk: aTalk.
	self cancel
]

{ #category : #accessing }
ERProposedTalksTab >> headers [ 	
	^ {'Title' .	'Submitted By'	. PSTableSortableHeaderOptions new cell:  'Presentation Download URL' . PSTableSortableHeaderOptions new cell:  '' }
]

{ #category : #initialization }
ERProposedTalksTab >> initializeFormAddTalk [
	| talk |
	talk := ERTalk submitter: attendee.
	formTalk := (ERTittledFormView 
							on: talk 
							withContent: content) title: 'Talk'; 
							callback: [ :aTalk | self createTalk: aTalk ];
							cancelCallback: [ self cancel ]; 
							initializeForm
]

{ #category : #tableBlock }
ERProposedTalksTab >> listDataToRenderButton [
	| list attributesTab|
	list := OrderedCollection new.
	attributesTab := Array new: 7.
	
	self proposalsAreAllowed ifTrue: [
			attributesTab
				at:1 put: 'edit';
				at:2 put: [ :talk | self modifyTalk: talk.
					self updateStateTab: self tabName. ];
				at:3 put: [ :talk | talk id , '-modify' ];
				at:4 put: 'Modify';
				at:5 put: '';
				at:6 put: false;
			   at:7 put: [ :talk | talk displayStatusClass ] .
				list add: attributesTab.
				
		 		attributesTab := Array new: 7.
				
			 	attributesTab
				at:1 put: 'delete';
				at:2 put: [ :talk | self deleteTalk: talk.
					self updateStateTab: self tabName. ];
				at:3 put: [ :talk | talk id , '-delete' ] ;
				at:4 put: 'Delete';
				at:5 put: 'return confirm(''Are you sure you want to delete this item?'');';
				at:6 put: false;
				at:7 put: [ :talk | talk displayStatusClass ] .
				
				list add:attributesTab. 
				attributesTab := Array new: 7.
				
			   attributesTab 
				at:1 put:  'info';
				at:2 put: [ :talk | ];
				at:3 put: [ :talk | talk id , '-info' ];
				at:4 put: [ :talk | talk acceptanceDetails ];
				at:5 put: '';
				at:6 put: false;
				at:7 put: [ :talk | talk displayStatusClassInfoBtn ] .
				list add:attributesTab.
		] .
	  ^list.
]

{ #category : #updating }
ERProposedTalksTab >> modifyTalk: aTalk [
	self initializeFormEditTalk: aTalk.
	content state: formTalk.
	self updateStateTab: self tabName.
]

{ #category : #rendering }
ERProposedTalksTab >> renderButtonAddOn: html [
	html mdlAnchorButton
		colored;
		id: 'addTalk';
		callback: [ self addTalk ];
		with: 'Add'
]

{ #category : #rendering }
ERProposedTalksTab >> renderContainerOn: html [ 	
	html horizontalRule .
	self proposalsAreAllowed ifTrue: [ self renderButtonAddOn: html ].
	self renderTableOn: html.
]

{ #category : #rendering }
ERProposedTalksTab >> renderMessageEmptyOn: html [
	html horizontalRule.
	html heading level5; with: 'You do not have any proposed talk yet.'
]

{ #category : #rendering }
ERProposedTalksTab >> renderTableOn: html [
	self submittedTalks isEmpty 
		ifTrue: [ self renderMessageEmptyOn: html ]
		ifFalse: [ self renderTalksTableOn: html ]
]

{ #category : #rendering }
ERProposedTalksTab >> renderTalksTableOn: html [
	table := ERTable new
		tableId: 'proposedTalks-table';
		validation: self filterTalksInformation;
		limitPageShowed: 3;
		header: self headers;
		levelTotal: 6;
		rows: self submittedTalks;
		blockToExecute: self blockTableTalksToExecute;
		listToRenderButton: self listDataToRenderButton;
		sortingMethod: self sortingMethodTalks.
	html render: table
]

{ #category : #accessing }
ERProposedTalksTab >> sortingMethodTalks [
	
	^ { [ :att | att title ] 
		. [ :att | att submitter userAccount email ]
		. [ :att | ] }
]

{ #category : #accessing }
ERProposedTalksTab >> submittedTalks [ 
	^ controller conference submittedTalksFor: attendee
]

{ #category : #accessing }
ERProposedTalksTab >> tabId [
	^ 'proposedTalks'

]

{ #category : #accessing }
ERProposedTalksTab >> tabName [
	^ 'Proposed Talks'
]

{ #category : #accessing }
ERProposedTalksTab >> title [
	^ 'Submitted Talks'
]
