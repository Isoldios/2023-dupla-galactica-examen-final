Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
SpeedCard class >> initializeNew [

	^ self new initializeNew
]

{ #category : #Initialization }
SpeedCard >> = aCard [

	^ aCard isKindOf: self class
]

{ #category : #Effect }
SpeedCard >> applyCardUsing: aCardManager to: anObjectivePlayerColor at: aDuplaGalacticaGame [

	aCardManager activateToPlayer:
		(CardTargetPlayer of: anObjectivePlayerColor with: self)
]

{ #category : #Effect }
SpeedCard >> applyEffect [

	^ 1
]

{ #category : #Information }
SpeedCard >> haveEffect [

	^ true
]

{ #category : #Initialization }
SpeedCard >> initializeNew [
]

{ #category : #Information }
SpeedCard >> isPermanent [

	^ true
]
