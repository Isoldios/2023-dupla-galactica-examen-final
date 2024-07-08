Class {
	#name : #DuplaGalacticaGameTurnManagerTest,
	#superclass : #TestCase,
	#instVars : [
		'aColorsCollection'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #Games }
DuplaGalacticaGameTurnManagerTest >> gameWithLoadedDie [

	| aBoard aBoxesCollection aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NullCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NullBox initializeNew
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
DuplaGalacticaGameTurnManagerTest >> gameWithTwoLoadedDie [

	| aBoard aBoxesCollection aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NullCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NullBox initializeNew
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
DuplaGalacticaGameTurnManagerTest >> setUp [

	super setUp.

	aColorsCollection := OrderedCollection with: 'red' with: 'blue'
]

{ #category : #tests }
DuplaGalacticaGameTurnManagerTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
DuplaGalacticaGameTurnManagerTest >> testE001WhenAGameWithALoadedDieIsCreatedThenAskForCurrentPlayer [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self gameWithLoadedDie.
	self assert: aDuplaGalacticaGame currentPlayer equals: 'red'
]

{ #category : #tests }
DuplaGalacticaGameTurnManagerTest >> testE002WhenAGameIsCreatedWithALoadedDieThenMovePlayersAndAskForWinner [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self gameWithLoadedDie.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self assert: aDuplaGalacticaGame winner equals: 'red'
]

{ #category : #tests }
DuplaGalacticaGameTurnManagerTest >> testE003WhenAGameIsCreatedWithALoadedDieThenMovePlayersAndValidPlayersPositions [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self gameWithLoadedDie.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 10 with: 1)
]

{ #category : #tests }
DuplaGalacticaGameTurnManagerTest >> testE004WhenAGameIsCreatedWithTwoLoadedDiceThenMovePlayersAndValidPlayersPositions [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self gameWithTwoLoadedDie.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 3 with: 5)
]

{ #category : #tests }
DuplaGalacticaGameTurnManagerTest >> testE005WhenTheGameAskForRankingThenValidWhoIsAheadOfOtherPlayers [

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

{ #category : #tests }
DuplaGalacticaGameTurnManagerTest >> testE006WhenAGameWithALoadedDieIsCreatedThenMovePlayersAndAskForCurrentPlayer [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self gameWithLoadedDie.
	aDuplaGalacticaGame movePlayer.
	self assert: aDuplaGalacticaGame currentPlayer equals: 'blue'
]

{ #category : #tests }
DuplaGalacticaGameTurnManagerTest >> testF001TryToMovePlayersWhenSomeoneHasReachedTheGoalThenFails [

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
DuplaGalacticaGameTurnManagerTest >> testF002TryToAskForWinnerWhenNoOneReachesTheGoalThenFails [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self gameWithLoadedDie.
	aDuplaGalacticaGame movePlayer.
	self
		should: [ aDuplaGalacticaGame winner ]
		raise: Error
		withMessage: 'There is no winner'
]
