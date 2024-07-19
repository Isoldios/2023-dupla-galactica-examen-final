Class {
	#name : #SpeedBoostCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
SpeedBoostCard class >> initializeNew [

	^ self new initializeNew
]

{ #category : #Initialization }
SpeedBoostCard >> = aCard [

	^ aCard isKindOf: self class
]

{ #category : #Effect }
SpeedBoostCard >> affect: anObjectiveCard targetingBox: anObjectiveBox atTemporalLocation: aPlayedCardOrder at: aCardManager [

	aCardManager
		duplicateEffectOf: anObjectiveCard
		targetingBox: anObjectiveBox
		atTemporalLocation: aPlayedCardOrder
]

{ #category : #Effect }
SpeedBoostCard >> affect: anObjectiveCard targetingPlayer: anObjectiveColorPlayer atTemporalLocation: aPlayedCardOrder at: aCardManager [

	aCardManager
		duplicateEffectOf: anObjectiveCard
		targetingPlayer: anObjectiveColorPlayer
		atTemporalLocation: aPlayedCardOrder
]

{ #category : #Information }
SpeedBoostCard >> haveEffect [

	^ true
]

{ #category : #Initialization }
SpeedBoostCard >> initializeNew [
]

{ #category : #Information }
SpeedBoostCard >> isPermanent [

	^ false
]
