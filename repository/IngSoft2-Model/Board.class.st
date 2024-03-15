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

	(aBoxesCollection isKindOf: OrderedCollection) ifFalse: [ 
		Error signal: 'That is not a boxes collection' ].
	aBoxesCollection size < 4 ifTrue: [ 
		Error signal: 'Cannot create a board with that amount of boxes' ].
	aBoxesCollection do: [ :box | 
		(box respondsTo: #effect:with:) ifFalse: [ 
			Error signal: 'That is not a valid box' ] ]
]

{ #category : #Validation }
Board class >> validateMeasure: aLengthMeasure [

	([ aLengthMeasure nominalValue ]
		 on: MessageNotUnderstood
		 do: [ Error signal: 'That is not a measure' ]) <= 0 ifTrue: [ 
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
Board >> changePolarityOf: aBoxNumber [

	(boxes at: aBoxNumber) changePolarity
]

{ #category : #BoxManager }
Board >> effectAt: aBoxNumber In: aDuplaGalacticaGame [

	(boxes at: aBoxNumber) effect: aDuplaGalacticaGame.
	lastBoxInvoked := aBoxNumber
]

{ #category : #Initialization }
Board >> initializeWith: aBoxesCollection measure: aLengthMeasure [

	lengthMeasure := aLengthMeasure.
	boxes := aBoxesCollection collect: [ :box | Box type: box ].
	lastBoxInvoked := 0
]

{ #category : #Validation }
Board >> isValidBox: aBoxNumber [

	(aBoxNumber <= self length and: aBoxNumber > 0) ifFalse: [ 
		Error signal: 'That is not a valid box number' ]
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
Board >> lightYears [

	^ lengthMeasure lightYears
]

{ #category : #Information }
Board >> parsecs [

	^ lengthMeasure parsecs
]

{ #category : #BoxManager }
Board >> resetPolarities [

	boxes do: [ :box | box resetPolarity ]
]
