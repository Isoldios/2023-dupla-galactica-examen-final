Class {
	#name : #SpeedUpBox,
	#superclass : #Object,
	#instVars : [
		'state'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
SpeedUpBox class >> initializeNew [

	^ self new initializeNew
]

{ #category : #Effect }
SpeedUpBox >> changeStateTo: aNewState [

	state := aNewState
]

{ #category : #Effect }
SpeedUpBox >> effect: aDuplaGalacticaGame [

	state affect: aDuplaGalacticaGame
]

{ #category : #Initialization }
SpeedUpBox >> initializeNew [

	state := UnreversedPolaritySpeedUpBoxState new
]

{ #category : #Effect }
SpeedUpBox >> reversePolarity [

	state changeState: self
]
