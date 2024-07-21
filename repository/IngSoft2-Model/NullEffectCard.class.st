Class {
	#name : #NullEffectCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
NullEffectCard class >> initializeNew [

	^ self new initializeNew
]

{ #category : #Information }
NullEffectCard >> = aCard [

	^ aCard isKindOf: self class
]

{ #category : #Effect }
NullEffectCard >> applyCardUsing: aCardManager to: anObjectivePlayerColor at: aDuplaGalacticaGame [

	aCardManager activateToPlayer:
		(CardTargetPlayer of: anObjectivePlayerColor with: self)
]

{ #category : #Effect }
NullEffectCard >> applyEffect [

	^ 0
]

{ #category : #Information }
NullEffectCard >> haveEffect [

	^ true
]

{ #category : #Initialization }
NullEffectCard >> initializeNew [
]

{ #category : #Information }
NullEffectCard >> isPermanent [

	^ true
]
