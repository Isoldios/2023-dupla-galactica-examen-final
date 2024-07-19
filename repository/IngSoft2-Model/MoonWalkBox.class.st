Class {
	#name : #MoonWalkBox,
	#superclass : #Object,
	#instVars : [
		'effect',
		'state'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
MoonWalkBox class >> with: aValue [

	^ self new initializeWith: aValue
]

{ #category : #Effect }
MoonWalkBox >> changeStateTo: aNewState [

	state := aNewState
]

{ #category : #Effect }
MoonWalkBox >> effect: aDuplaGalacticaGame [

	state affect: aDuplaGalacticaGame using: effect
]

{ #category : #Initialization }
MoonWalkBox >> initializeWith: aValue [

	effect := aValue.
	state := UnreversedPolarityMoonWalkBoxState new
]

{ #category : #Effect }
MoonWalkBox >> reversePolarity [

	state changeState: self
]
