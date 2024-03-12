Class {
	#name : #PlayersTest,
	#superclass : #TestCase,
	#instVars : [
		'aDuplaGalacticaGame'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
PlayersTest >> setUp [

	| aColorsCollection aCardsCollection aBoxesCollection |
	super setUp.

	aColorsCollection := OrderedCollection with: 'red' with: 'blue'.
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NoEffectCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NoEffectBox initializeNew
				                       withChanceOf: 100))) create: 10.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and:
		                       (Board
			                        with: aBoxesCollection
			                        measure: (ParsecMeasure worth: 100))
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection
]

{ #category : #tests }
PlayersTest >> testN001WhenAGameIsCreatedWithAColorsCollectionThenValidPlayersColors [

	self
		assert: aDuplaGalacticaGame playersColors
		equals: (OrderedCollection with: 'red' with: 'blue')
]

{ #category : #tests }
PlayersTest >> testN002WhenAGameIsCreatedWithTwoColorsPlayersThenValidPlayersTurn [

	self assert: aDuplaGalacticaGame currentPlayer equals: 'red'
]

{ #category : #tests }
PlayersTest >> testN003WhenAGameIsCreatedWithTwoColorsPlayersThenMoveBothPlayersOnceAndValidPlayersTurn [

	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self assert: aDuplaGalacticaGame currentPlayer equals: 'red'
]
