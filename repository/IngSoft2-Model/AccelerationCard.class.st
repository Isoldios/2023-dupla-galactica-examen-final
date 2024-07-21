Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
AccelerationCard class >> initializeNew [

	^ self new initializeNew
]

{ #category : #Initialization }
AccelerationCard >> = aCard [

	^ aCard isKindOf: self class
]

{ #category : #Effect }
AccelerationCard >> applyCardUsing: aCardManager to: anObjectivePlayerColor at: aDuplaGalacticaGame [

	aCardManager activateToPlayer:
		(CardTargetPlayer of: anObjectivePlayerColor with: self)
]

{ #category : #Effect }
AccelerationCard >> applyEffect [

	^ 1
]

{ #category : #Information }
AccelerationCard >> haveEffect [

	^ true
]

{ #category : #Initialization }
AccelerationCard >> initializeNew [
]

{ #category : #Information }
AccelerationCard >> isPermanent [

	^ true
]
