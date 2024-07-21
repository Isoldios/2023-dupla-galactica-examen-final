Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
RepeatCard class >> initializeNew [

	^ self new initializeNew
]

{ #category : #Initialization }
RepeatCard >> = aCard [

	^ aCard isKindOf: self class
]

{ #category : #Effect }
RepeatCard >> applyCardUsing: aCardManager to: anObjectivePlayerColor at: aDuplaGalacticaGame [

	aDuplaGalacticaGame repeatEffectTo: anObjectivePlayerColor
]

{ #category : #Information }
RepeatCard >> haveEffect [

	^ true
]

{ #category : #Initialization }
RepeatCard >> initializeNew [

	
]

{ #category : #Information }
RepeatCard >> isPermanent [

	^ false
]
