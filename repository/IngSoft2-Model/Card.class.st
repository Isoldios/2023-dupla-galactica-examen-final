Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'card',
		'effect',
		'flag'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
Card class >> type: aCard [

	^ self new initializeType: aCard
]

{ #category : #Effect }
Card >> applyCardUsing: aCardManager to: anObjective at: aDuplaGalacticaGame [

	card
		applyCardUsing: aCardManager
		to: anObjective
		at: aDuplaGalacticaGame
]

{ #category : #Effect }
Card >> applyEffect [

	^ effect
]

{ #category : #Effect }
Card >> boostEffect [

	effect := effect * 2.
	flag := flag + 1
]

{ #category : #Effect }
Card >> changePolarityOf: aBoxNumber at: aDuplaGalacticaGame [

	card changePolarityOf: aBoxNumber at: aDuplaGalacticaGame with: flag
]

{ #category : #Information }
Card >> haveEffect [

	^ card haveEffect
]

{ #category : #Initialization }
Card >> initializeType: aCard [

	card := aCard.
	card isPermanent ifFalse: [ ^ self ].
	effect := card applyEffect.
	flag := 1
]

{ #category : #Information }
Card >> isPermanent [

	^ card isPermanent
]

{ #category : #Information }
Card >> type [

	^ card 
]
