"
Description
--------------------

I am a custom mdlNavigationLink, I have an icon, a label and callback
"
Class {
	#name : #ERItemNav,
	#superclass : #ERComponent,
	#instVars : [
		'callback',
		'icon',
		'label'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #'instance creation' }
ERItemNav class >> label: aString icon: anIcon callback: aBlock [
	|instance|
	instance := self new.
	instance label: aString .
	instance icon: anIcon .
	instance callback: aBlock .
	^ instance 
]

{ #category : #accessing }
ERItemNav >> callback: anObject [
	callback := anObject
]

{ #category : #action }
ERItemNav >> evaluateCallBackBlock [
	callback value value.
]

{ #category : #action }
ERItemNav >> getCallback [ 
	self iAmClicked.
	self evaluateCallBackBlock.
	 
	
]

{ #category : #action }
ERItemNav >> iAmClicked [
	self session activeMenu:  label,'-option'.
]

{ #category : #accessing }
ERItemNav >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
ERItemNav >> isCurrentlyActive [ 
	^ self session activeMenu =  (label,'-option').
]

{ #category : #accessing }
ERItemNav >> label: anObject [
	label := anObject
]

{ #category : #rendering }
ERItemNav >> renderContentOn: html [
	html mdlNavigationLink
		id: label,'-option';
		callback: [self getCallback ];
		class: 'active-menu-option' if: (self isCurrentlyActive );
		with: [ 
			html mdlIcon
				class: 'mdl-color-text--white';
				with: [ html text: icon ].
				html text:  label . ]
]
