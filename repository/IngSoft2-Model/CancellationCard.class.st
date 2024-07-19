Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
CancellationCard class >> initializeNew [

	^ self new initializeNew
]

{ #category : #Information }
CancellationCard >> = aCard [

	^ aCard isKindOf: self class
]

{ #category : #cambiar }
CancellationCard >> affect: anObjectiveCard targetingBox: anObjectiveBox atTemporalLocation: aPlayedCardOrder at: aCardManager [

	aCardManager
		desactivate: anObjectiveCard
		targetingBox: anObjectiveBox
		atTemporalLocation: aPlayedCardOrder
]

{ #category : #Effect }
CancellationCard >> affect: anObjectiveCard targetingPlayer: anObjectiveColorPlayer atTemporalLocation: aPlayedCardOrder at: aCardManager [

	aCardManager
		desactivate: anObjectiveCard
		targetingPlayer: anObjectiveColorPlayer
		atTemporalLocation: aPlayedCardOrder
]

{ #category : #Information }
CancellationCard >> haveEffect [

	^ true
]

{ #category : #Initialization }
CancellationCard >> initializeNew [

	
]

{ #category : #Information }
CancellationCard >> isPermanent [

	^ false
]
