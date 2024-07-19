Class {
	#name : #AtomicBombBox,
	#superclass : #Object,
	#instVars : [
		'state'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
AtomicBombBox class >> initializeNew [

	^ self new initializeNew
]

{ #category : #Effect }
AtomicBombBox >> changeStateTo: aNewState [

	state := aNewState
]

{ #category : #Effect }
AtomicBombBox >> effect: aDuplaGalacticaGame [

	state affect: aDuplaGalacticaGame
]

{ #category : #Initialization }
AtomicBombBox >> initializeNew [

	state := UnreversedPolarityAtomicBombBoxState new
]

{ #category : #Effect }
AtomicBombBox >> reversePolarity [

	state changeState: self
]
