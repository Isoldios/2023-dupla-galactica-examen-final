Class {
	#name : #MoonWalkBox,
	#superclass : #Object,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
MoonWalkBox class >> with: aValue [

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
