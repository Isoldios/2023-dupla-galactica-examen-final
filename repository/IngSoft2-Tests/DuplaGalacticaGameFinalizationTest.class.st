Class {
	#name : #DuplaGalacticaGameFinalizationTest,
	#superclass : #TestCase,
	#instVars : [
		'aColorsCollection'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #Games }
DuplaGalacticaGameFinalizationTest >> gameWithOneLap: aLoadedDie [

	| aDuplaGalacticaGame aBoard aCardsCollection aBoxesCollection |
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
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow:
		                       (DiceShaker with:
			                        (OrderedCollection with: aLoadedDie))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	^ aDuplaGalacticaGame
]

{ #category : #Games }
DuplaGalacticaGameFinalizationTest >> gameWithTwoLaps: aLoadedDie [

	| aBoard aDuplaGalacticaGame aCardsCollection aBoxesCollection |
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
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow:
		                       (DiceShaker with:
			                        (OrderedCollection with: aLoadedDie))
		                       winningWhenReach: 2
		                       using: aCardsCollection.
	^ aDuplaGalacticaGame
]

{ #category : #running }
DuplaGalacticaGameFinalizationTest >> setUp [

	super setUp.

	aColorsCollection := OrderedCollection with: 'red' with: 'blue'
]

{ #category : #tests }
DuplaGalacticaGameFinalizationTest >> testM001WhenAGameIsCreatedWithTwoGoalLapsThenMoveAPlayerOneEntireLapAndValidPlayersLaps [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self gameWithTwoLaps:
		                       (LoadedDie with: #( 11 5 3 4 )).
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersLaps
		equals: (OrderedCollection with: 1 with: 0)
]

{ #category : #tests }
DuplaGalacticaGameFinalizationTest >> testM002WhenAGameIsCreatedWithTwoGoalLapsThenMovePlayersOneEntireLapAndValidPlayersLaps [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self gameWithTwoLaps:
		                       (LoadedDie with: #( 11 16 3 4 )).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersLaps
		equals: (OrderedCollection with: 1 with: 1)
]

{ #category : #tests }
DuplaGalacticaGameFinalizationTest >> testM003WhenAGameIsCreatedWithTwoGoalLapsThenMoveAPlayerTwoEntireLapsInOneThrowAndValidItWinsAndPlayersLaps [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self gameWithTwoLaps:
		                       (LoadedDie with: #( 23 9 3 4 )).
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersLaps
		equals: (OrderedCollection with: 2 with: 0).
	self assert: aDuplaGalacticaGame winner equals: 'red'
]

{ #category : #tests }
DuplaGalacticaGameFinalizationTest >> testM004WhenAGameIsCreatedWithOneGoalLapThenMoveOnePlayerToTheGoalAndValidItWins [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self gameWithOneLap:
		                       (LoadedDie with: #( 9 11 3 4 )).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self assert: aDuplaGalacticaGame winner equals: 'blue'
]
