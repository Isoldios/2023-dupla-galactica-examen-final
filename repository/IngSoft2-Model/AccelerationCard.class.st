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
AccelerationCard >> applyCardUsing: aCardManager to: anObjective at: aDuplaGalacticaGame [

	anObjective = 'everyone' ifFalse: [ 
		Error signal: 'Cannot play an acceleration card on a non every player objective' ].
	aCardManager activate:
		(PlayerHand of: anObjective with: self initializeNew)
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
