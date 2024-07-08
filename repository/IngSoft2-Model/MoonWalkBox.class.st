Class {
	#name : #MoonWalkBox,
	#superclass : #Object,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #Validation }
MoonWalkBox class >> validateNumber: aValue [

	aValue isNumber ifFalse: [ 
		Error signal:
			'Cannot create a Moon Walk Box with a not a number effect value' ]
]

{ #category : #'Instance creation' }
MoonWalkBox class >> with: aValue [

	self validateNumber: aValue.
	^ self new initializeWith: aValue
]

{ #category : #Effect }
MoonWalkBox >> effect: aDuplaGalacticaGame with: aPolarityValue [

	aPolarityValue
		ifTrue: [ aDuplaGalacticaGame moveOthers: effect ]
		ifFalse: [ aDuplaGalacticaGame moveCurrent: effect ]
]

{ #category : #Initialization }
MoonWalkBox >> initializeWith: aValue [

	effect := aValue
]
