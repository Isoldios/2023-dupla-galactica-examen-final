Class {
	#name : #WormHoleBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
WormHoleBox class >> initializeNew [

	^ self new initializeNew
]

{ #category : #Effect }
WormHoleBox >> effect: aDuplaGalacticaGame with: aPolarityValue [

	aPolarityValue
		ifTrue: [ aDuplaGalacticaGame moveCurrent: -4 ]
		ifFalse: [ aDuplaGalacticaGame moveOthers: -4 ]
]

{ #category : #Initialization }
WormHoleBox >> initializeNew [
]
