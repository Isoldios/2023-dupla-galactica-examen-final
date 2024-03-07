Class {
	#name : #SpeedUpBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
SpeedUpBox class >> initializeNew [

	^ self new initializeNew
]

{ #category : #Effect }
SpeedUpBox >> effect: aDuplaGalacticaGame with: aPolarityValue [

	aPolarityValue
		ifTrue: [ aDuplaGalacticaGame moveCurrent: 4 ]
		ifFalse: [ aDuplaGalacticaGame moveOthers: 4 ]
]

{ #category : #Initialization }
SpeedUpBox >> initializeNew [
]
