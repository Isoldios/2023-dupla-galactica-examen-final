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

{ #category : #Information }
Board >> boxesByParsecs [

	^ self parsecs // self length
]

{ #category : #BoxManager }
Board >> changePolarityOf: aBox [

	(boxes select: [ :box | aBox = box type ]) do: [ :box | 
		box changePolarity ]
]

{ #category : #BoxManager }
Board >> checkPolarityAt: aDuplaGalacticaGame of: aCardManager [

	aCardManager checkPolarityAt: aDuplaGalacticaGame of: boxes
]

{ #category : #BoxManager }
Board >> effectAt: aBoxNumber In: aDuplaGalacticaGame [

	(boxes at: aBoxNumber) effect: aDuplaGalacticaGame.
	lastBoxInvoked := aBoxNumber.
	self resetPolarities
]

{ #category : #Initialization }
Board >> initializeWith: aBoxesCollection measure: aLengthMeasure [

	lengthMeasure := aLengthMeasure.
	boxes := aBoxesCollection collect: [ :box | Box type: box ].
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

{ #category : #BoxManager }
Board >> resetPolarities [

	boxes do: [ :box | box resetPolarity ]
]
