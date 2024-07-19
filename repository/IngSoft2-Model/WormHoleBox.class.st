Class {
	#name : #WormHoleBox,
	#superclass : #Object,
	#instVars : [
		'state'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
WormHoleBox class >> initializeNew [

	^ self new initializeNew
]

{ #category : #Effect }
WormHoleBox >> changeStateTo: aNewState [

	state := aNewState
]

{ #category : #Effect }
WormHoleBox >> effect: aDuplaGalacticaGame [

	state affect: aDuplaGalacticaGame
]

{ #category : #Initialization }
WormHoleBox >> initializeNew [

	state := UnreversedPolarityWormHoleBoxState new
]

{ #category : #Effect }
WormHoleBox >> reversePolarity [

	state changeState: self
]
