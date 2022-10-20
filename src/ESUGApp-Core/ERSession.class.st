"
Description
--------------------

I am a custom Session for ESUG page
"
Class {
	#name : #ERSession,
	#superclass : #WASession,
	#instVars : [
		'user',
		'account',
		'activeMenuId'
	],
	#category : #'ESUGApp-Core'
}

{ #category : #accessing }
ERSession >> activeMenu [
	"Get the id of current selected menu item in navbar"
	^ activeMenuId .
]

{ #category : #accessing }
ERSession >> activeMenu:id [
	"Set the id of current selected menu item in navbar"
	 activeMenuId :=id.
]

{ #category : #accessing }
ERSession >> defaultMenu [
	^ 'Home-option'.
]

{ #category : #intialization }
ERSession >> initialize [
	super initialize.
	self setDefaultMenu.
]

{ #category : #actions }
ERSession >> isLoggedIn [

 ^ self user notNil
]

{ #category : #actions }
ERSession >> login: aUser [
	self user: aUser.
]

{ #category : #actions }
ERSession >> logout [
	self user: nil.
	self activeMenu: nil.
	self unregister
]

{ #category : #actions }
ERSession >> setDefaultMenu [
	self activeMenu:self defaultMenu .
]

{ #category : #updating }
ERSession >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot title: ERLibrary applicationName
]

{ #category : #accessing }
ERSession >> user [
	^ user
]

{ #category : #accessing }
ERSession >> user: anObject [
	user := anObject
]
