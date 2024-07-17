Class {
	#name : #ReversePolarityCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
ReversePolarityCard class >> initializeNew [

	^ self new initializeNew
]

{ #category : #Initialization }
ReversePolarityCard >> = aCard [

	^ aCard isKindOf: self class
]

{ #category : #Effect }
ReversePolarityCard >> applyCardUsing: aCardManager to: anObjective at: aDuplaGalacticaGame [

	aCardManager activate: (PlayerHand of: anObjective with: self)
]

{ #category : #Effect }
ReversePolarityCard >> applyEffect [

	^ 0
]

{ #category : #Information }
ReversePolarityCard >> haveEffect [

	^ true
]

{ #category : #Initialization }
ReversePolarityCard >> initializeNew [
]

{ #category : #Information }
ReversePolarityCard >> isPermanent [

	^ true
]
