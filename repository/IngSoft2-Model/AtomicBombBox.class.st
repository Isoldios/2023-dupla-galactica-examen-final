Class {
	#name : #AtomicBombBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
AtomicBombBox class >> initializeNew [

	^ self new initializeNew
]

{ #category : #Effect }
AtomicBombBox >> effect: aDuplaGalacticaGame with: aPolarityValue [

	aPolarityValue ifTrue: [ aDuplaGalacticaGame moveAllToTheStart ]
]

{ #category : #Initialization }
AtomicBombBox >> initializeNew [
]
