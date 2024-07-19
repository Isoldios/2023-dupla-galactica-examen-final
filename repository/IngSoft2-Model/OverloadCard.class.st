Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
OverloadCard class >> initializeNew [

	^ self new initializeNew
]

{ #category : #Initialization }
OverloadCard >> = aCard [

	^ aCard isKindOf: self class
]

{ #category : #Effect }
OverloadCard >> applyCardUsing: aCardManager to: anObjective at: aDuplaGalacticaGame [

	aCardManager activateToPlayer:
		(CardTargetPlayer of: anObjective with: self)
]

{ #category : #Effect }
OverloadCard >> applyEffect [

	^ -2
]

{ #category : #Information }
OverloadCard >> haveEffect [

	^ true
]

{ #category : #Initialization }
OverloadCard >> initializeNew [
]

{ #category : #Information }
OverloadCard >> isPermanent [

	^ true
]
