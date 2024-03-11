Class {
	#name : #CreateADuplaGalacticaGameWithDifferentLengthMeasuresTest,
	#superclass : #TestCase,
	#instVars : [
		'aLoadedDie',
		'aBoxesCollection',
		'aCardsCollection',
		'aColorsCollection'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
CreateADuplaGalacticaGameWithDifferentLengthMeasuresTest >> setUp [

	super setUp.

	aColorsCollection := OrderedCollection with: 'red' with: 'blue'.
	aLoadedDie := LoadedDie with: #( 1 2 3 ).
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NoEffectCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NoEffectBox initializeNew
				                       withChanceOf: 100))) create: 10
]

{ #category : #running }
CreateADuplaGalacticaGameWithDifferentLengthMeasuresTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
CreateADuplaGalacticaGameWithDifferentLengthMeasuresTest >> testS001WhenAGameIsCreaterWithAParsecMeasureThenAskForParsecsNominalValue [

	| aBoard aDuplaGalacticaGame |
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow:
		                       (DiceShaker with:
			                        (OrderedCollection with: aLoadedDie))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self assert: aDuplaGalacticaGame parsecs nominalValue equals: 100
]

{ #category : #tests }
CreateADuplaGalacticaGameWithDifferentLengthMeasuresTest >> testS002WhenAGameIsCreatedWithALightYearMeasureThenAskForLightYearsNominalValue [

	| aBoard aDuplaGalacticaGame |
	aBoard := Board
		          with: aBoxesCollection
		          measure: (LigthYearMeasure worth: 300).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow:
		                       (DiceShaker with:
			                        (OrderedCollection with: aLoadedDie))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self assert: aDuplaGalacticaGame lightYears nominalValue equals: 300
]

{ #category : #tests }
CreateADuplaGalacticaGameWithDifferentLengthMeasuresTest >> testS003WhenAGameIsCreatedWithAParsecMeasureThenAskForLightYearsNominalValue [

	| aBoard aDuplaGalacticaGame |
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow:
		                       (DiceShaker with:
			                        (OrderedCollection with: aLoadedDie))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self assert: aDuplaGalacticaGame lightYears nominalValue equals: 300
]

{ #category : #tests }
CreateADuplaGalacticaGameWithDifferentLengthMeasuresTest >> testS004WhenAGameIsCreatedWithALightYearMeasureThenAskForParsecsNominalValue [

	| aBoard aDuplaGalacticaGame |
	aBoard := Board
		          with: aBoxesCollection
		          measure: (LigthYearMeasure worth: 300).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow:
		                       (DiceShaker with:
			                        (OrderedCollection with: aLoadedDie))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self assert: aDuplaGalacticaGame parsecs nominalValue equals: 100
]

{ #category : #tests }
CreateADuplaGalacticaGameWithDifferentLengthMeasuresTest >> testS005TryToCreateALigthYearMeasureWithANonNumericNominalValueThenFails [

	self
		should: [ LigthYearMeasure worth: 'a' ]
		raise: Error
		withMessage: 'Cannot create a ligth year measure with that value'.
	self
		should: [ LigthYearMeasure worth: (OrderedCollection with: 1) ]
		raise: Error
		withMessage: 'Cannot create a ligth year measure with that value'
]

{ #category : #tests }
CreateADuplaGalacticaGameWithDifferentLengthMeasuresTest >> testS006TryToCreateAParsecMeasureWithANonNumericNominalValueThenFails [

	self
		should: [ ParsecMeasure worth: 'a' ]
		raise: Error
		withMessage: 'Cannot create a ligth year measure with that value'.
	self
		should: [ ParsecMeasure worth: (OrderedCollection with: 1) ]
		raise: Error
		withMessage: 'Cannot create a ligth year measure with that value'
]
