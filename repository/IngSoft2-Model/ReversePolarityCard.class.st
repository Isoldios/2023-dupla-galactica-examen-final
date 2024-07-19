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

{ #category : #cambiar }
ReversePolarityCard >> applyCardUsing: aCardManager to: anObjectiveBox [

	aCardManager activateToBox:
		(CardTargetBox of: anObjectiveBox with: self)
]

{ #category : #cambiar }
ReversePolarityCard >> applyEffect: anObjectiveBox [

	anObjectiveBox reversePolarity
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
