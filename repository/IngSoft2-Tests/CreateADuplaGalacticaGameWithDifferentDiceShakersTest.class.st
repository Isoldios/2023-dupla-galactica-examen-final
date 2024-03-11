Class {
	#name : #CreateADuplaGalacticaGameWithDifferentDiceShakersTest,
	#superclass : #TestCase,
	#instVars : [
		'aColorsCollection'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #Games }
CreateADuplaGalacticaGameWithDifferentDiceShakersTest >> gameWithLoadedDie [

	| aBoard aBoxesCollection aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NoEffectCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NoEffectBox initializeNew
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	^ DuplaGalacticaGameProxy
		  with: aColorsCollection
		  and: aBoard
		  usingToThrow: (DiceShaker with:
				   (OrderedCollection with: (LoadedDie with: #( 9 7 8 9 ))))
		  winningWhenReach: 1
		  using: aCardsCollection
]

{ #category : #Games }
CreateADuplaGalacticaGameWithDifferentDiceShakersTest >> gameWithTwoLoadedDie [

	| aBoard aBoxesCollection aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NoEffectCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NoEffectBox initializeNew
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	^ DuplaGalacticaGameProxy
		  with: aColorsCollection
		  and: aBoard
		  usingToThrow: (DiceShaker with: (OrderedCollection
					    with: (LoadedDie with: #( 1 2 3 4 ))
					    with: (LoadedDie with: #( 1 2 3 4 ))))
		  winningWhenReach: 1
		  using: aCardsCollection
]

{ #category : #running }
CreateADuplaGalacticaGameWithDifferentDiceShakersTest >> setUp [

	super setUp.


	aColorsCollection := OrderedCollection with: 'red' with: 'blue'
]

{ #category : #tests }
CreateADuplaGalacticaGameWithDifferentDiceShakersTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
CreateADuplaGalacticaGameWithDifferentDiceShakersTest >> testD001WhenAGameWithALoadedDieIsCreatedThenAskForCurrentPlayer [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self gameWithLoadedDie.
	self assert: aDuplaGalacticaGame currentPlayer equals: 'red'
]

{ #category : #tests }
CreateADuplaGalacticaGameWithDifferentDiceShakersTest >> testD002WhenAGameIsCreatedWithALoadedDieThenMovePlayersAndAskForWinner [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self gameWithLoadedDie.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self assert: aDuplaGalacticaGame winner equals: 'red'
]

{ #category : #tests }
CreateADuplaGalacticaGameWithDifferentDiceShakersTest >> testF001WhenAGameIsCreatedWithALoadedDieThenMovePlayersAndValidPlayersPositions [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self gameWithLoadedDie.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 10 with: 1)
]

{ #category : #tests }
CreateADuplaGalacticaGameWithDifferentDiceShakersTest >> testG002WhenAGameIsCreatedWithTwoLoadedDiceThenMovePlayersAndValidPlayersPositions [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self gameWithTwoLoadedDie.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 3 with: 5)
]

{ #category : #tests }
CreateADuplaGalacticaGameWithDifferentDiceShakersTest >> testH001TryToMovePlayersWhenSomeoneHasReachedTheGoalThenFails [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self gameWithTwoLoadedDie.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		should: [ aDuplaGalacticaGame movePlayer ]
		raise: Error
		withMessage: 'The game has finished because someone won'
]

{ #category : #tests }
CreateADuplaGalacticaGameWithDifferentDiceShakersTest >> testL002TryToAskForWinnerWhenNoOneReachesTheGoalThenFails [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self gameWithLoadedDie.
	aDuplaGalacticaGame movePlayer.
	self
		should: [ aDuplaGalacticaGame winner ]
		raise: Error
		withMessage: 'There is no winner'
]

{ #category : #tests }
CreateADuplaGalacticaGameWithDifferentDiceShakersTest >> testL003WhenTheGameAskForRankingThenValidWhoIsAheadOfOtherPlayers [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self gameWithTwoLoadedDie.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame ranking
		equals: (OrderedCollection with: 'blue' with: 'red')
]
