Class {
	#name : #RedoCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
RedoCard class >> initializeNew [

	^ self new initializeNew
]

{ #category : #Initialization }
RedoCard >> = aCard [

	^ aCard isKindOf: self class
]

{ #category : #Effect }
RedoCard >> affect: anObjectiveCard targetingPlayer: anObjectiveColorPlayer atTemporalLocation: aPlayedCardOrder at: aCardManager [

	aCardManager checkLastCardPlayed.
	aCardManager lastCardPlay
		affect: anObjectiveCard
		targetingPlayer: anObjectiveColorPlayer
		atTemporalLocation: aPlayedCardOrder
		at: aCardManager
]

{ #category : #Effect }
RedoCard >> applyCardUsing: aCardManager to: anObjectiveBox [

	aCardManager lastCardPlay
		applyCardUsing: aCardManager
		to: anObjectiveBox
]

{ #category : #Effect }
RedoCard >> applyCardUsing: aCardManager to: anObjectivePlayerColor at: aDuplaGalacticaGame [

	aCardManager checkLastCardPlayed.
	aCardManager lastCardPlay
		applyCardUsing: aCardManager
		to: anObjectivePlayerColor
		at: aDuplaGalacticaGame
]

{ #category : #Information }
RedoCard >> haveEffect [

	^ false
]

{ #category : #Initialization }
RedoCard >> initializeNew [
]

{ #category : #Information }
RedoCard >> isPermanent [

	^ false
]
