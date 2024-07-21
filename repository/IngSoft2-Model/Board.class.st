Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'lengthMeasure',
		'lastBoxInvoked'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #Validation }
Board class >> validateBoxes: aBoxesCollection [

	aBoxesCollection size < 4 ifTrue: [ 
		Error signal: 'Cannot create a board with that amount of boxes' ]
]

{ #category : #Validation }
Board class >> validateMeasure: aLengthMeasure [

	aLengthMeasure nominalValue <= 0 ifTrue: [ 
		Error signal:
			'Cannot create a game with that parsec or lightYear value' ]
]

{ #category : #'Instance creation' }
Board class >> with: aBoxesCollection measure: aLengthMeasure [

	self validateMeasure: aLengthMeasure.
	self validateBoxes: aBoxesCollection.
	^ self new initializeWith: aBoxesCollection measure: aLengthMeasure
]

{ #category : #BoxManager }
Board >> apllyEffectsIn: aBoxNumber using: aCardManager at: aDuplaGalacticaGame [

	(boxes at: aBoxNumber) effect: aDuplaGalacticaGame.
	lastBoxInvoked := aBoxNumber
]

{ #category : #Information }
Board >> boxes [

	^ boxes
]

{ #category : #Information }
Board >> boxesByParsecs [

	^ self parsecs // self length
]

{ #category : #Initialization }
Board >> initializeWith: aBoxesCollection measure: aLengthMeasure [

	lengthMeasure := aLengthMeasure.
	boxes := aBoxesCollection.
	lastBoxInvoked := 0
]

{ #category : #Information }
Board >> lastBoxInvoked [

	^ lastBoxInvoked
]

{ #category : #Information }
Board >> length [

	^ boxes size
]

{ #category : #Information }
Board >> parsecs [

	^ lengthMeasure parsecs nominalValue
]
