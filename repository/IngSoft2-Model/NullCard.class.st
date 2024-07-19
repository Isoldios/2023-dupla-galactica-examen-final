Class {
	#name : #NullCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
NullCard class >> initializeNew [

	^ self new initializeNew
]

{ #category : #Information }
NullCard >> = aCard [

	^ aCard isKindOf: self class
]

{ #category : #Effect }
NullCard >> applyCardUsing: aCardManager to: anObjective at: aDuplaGalacticaGame [

	aCardManager activateToPlayer:
		(CardTargetPlayer of: anObjective with: self initializeNew)
]

{ #category : #Effect }
NullCard >> applyEffect [

	^ 0
]

{ #category : #Information }
NullCard >> haveEffect [

	^ true
]

{ #category : #Initialization }
NullCard >> initializeNew [
]

{ #category : #Information }
NullCard >> isPermanent [

	^ true
]
