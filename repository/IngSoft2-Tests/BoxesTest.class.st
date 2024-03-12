Class {
	#name : #BoxesTest,
	#superclass : #TestCase,
	#instVars : [
		'aCardsCollection',
		'aColorsCollection'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
BoxesTest >> setUp [

	super setUp.

	aColorsCollection := OrderedCollection with: 'red' with: 'blue'.
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NoEffectCard initializeNew
				                       withChanceOf: 100))) create: 4
]

{ #category : #tests }
BoxesTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
BoxesTest >> testA001WhenPlayerReachesANoEffectBoxThenCheckThatNoEffectsWereAppliedAndValidPlayersPositions [

	| aDuplaGalacticaGame aBoxesCollection aBoard |
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NoEffectBox initializeNew
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 6 8 5 8 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 7 with: 9)
]

{ #category : #tests }
BoxesTest >> testA002WhenPlayerReachesAWormHoleBoxThenCheckThatANegativeEffectWasAppliedAndValidPlayersPositions [

	| aDuplaGalacticaGame aBoxesCollection aBoard |
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: WormHoleBox initializeNew
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 5 8 5 8 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 2 with: 5)
]

{ #category : #tests }
BoxesTest >> testA003WhenPlayerReachesASpeedUpBoxThenCheckThatAPositiveEffectWasAppliedAndValidPlayersPositions [

	| aDuplaGalacticaGame aBoxesCollection aBoard |
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: SpeedUpBox initializeNew
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 8 5 8 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 6 with: 3)
]

{ #category : #tests }
BoxesTest >> testA004WhenPlayerReachesAMoonWalkBoxThenCheckThatTheEffectWasAppliedOnOtherPlayersAndValidPlayersPositions [

	| aDuplaGalacticaGame aBoxesCollection aBoard |
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: (MoonWalkBox with: -2)
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 8 3 5 8 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 7 with: 4)
]

{ #category : #tests }
BoxesTest >> testA005WhenPlayerReachesAnAtomicBombBoxThenCheckThatAllPlayersWereMovedToTheBeginningOfTheLapAndValidPlayersPositions [

	| aDuplaGalacticaGame aBoxesCollection aBoard |
	aBoxesCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: AtomicBombBox initializeNew
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 8 5 8 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 1 with: 1)
]

{ #category : #tests }
BoxesTest >> testA006WhenPlayerReachesAHyperJumpBoxThenCheckThatTheEffectDependingOnAParsecNominalValueWasAppliedAndValidPlayersPositions [

	| aDuplaGalacticaGame aBoxesCollection aBoard |
	aBoxesCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using:
					                       (HyperJumpBox with: (OrderedCollection
							                         with: (ParsecMeasure worth: 40)
							                         with: (ParsecMeasure worth: 30)))
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 3 4 5 8 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 8 with: 9)
]

{ #category : #tests }
BoxesTest >> testA007WhenPlayerReachesAWormHoleBoxInTheFirstLapThenCheckThatTheNegativeEffectCannotSendPlayerToAnOutOfRangeBoardPositionAndValidPlayersPositions [

	| aDuplaGalacticaGame aBoxesCollection aBoard |
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: WormHoleBox initializeNew
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 8 5 8 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 1 with: 5)
]

{ #category : #tests }
BoxesTest >> testA008WhenPlayerReachesAMoonWalkBoxThenCheckThatTheEffectCannotSendOtherPlayersToAnOutOfRangeBoardPositionInTheFirstLapAndValidPlayersPositions [

	| aDuplaGalacticaGame aBoxesCollection aBoard |
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: (MoonWalkBox with: -4)
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 3 4 5 8 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 1 with: 5)
]

{ #category : #tests }
BoxesTest >> testA009WhenPlayerReachesAHyperJumpBoxInTheFirstLapThenCheckThatANegativeEffectCannotSendPlayerToAnOutOfRangeBoardPositionAndValidPlayersPositions [

	| aDuplaGalacticaGame aBoxesCollection aBoard |
	aBoxesCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using:
					                       (HyperJumpBox with: (OrderedCollection
							                         with: (ParsecMeasure worth: -40)
							                         with: (ParsecMeasure worth: -10)))
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 3 3 5 8 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 3 with: 1)
]

{ #category : #tests }
BoxesTest >> testA010WhenPlayerReachesTheGoalButAlsoLandsOnAWormHoleBoxThenVerifyThatTheEffectPreventsWinningAndThatCheckingTheWinnerFails [

	| aDuplaGalacticaGame aBoxesCollection aBoard |
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: WormHoleBox initializeNew
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 13 8 5 8 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	self
		should: [ aDuplaGalacticaGame winner ]
		raise: Error
		withMessage: 'There is no winner'
]

{ #category : #tests }
BoxesTest >> testA011WhenPlayerReachesAHyperJumpBoxWithNoEntireValueMeasuresThenCheckThatTheEffectMovesPlayerAnEntireValueAndValidPlayersPositions [

	| aDuplaGalacticaGame aBoxesCollection aBoard |
	aBoxesCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using:
					                       (HyperJumpBox with: (OrderedCollection
							                         with: (ParsecMeasure worth: 45.5)
							                         with: (ParsecMeasure worth: 39.4)))
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 3 3 5 8 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 8 with: 7)
]

{ #category : #tests }
BoxesTest >> testA012WhenPlayersReachTheSameHyperJumpBoxThenCheckThatTheEffectDependingOnAParsecNominalValueWasAppliedAndValidPlayersPositions [

	| aDuplaGalacticaGame aBoxesCollection aBoard |
	aBoxesCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using:
					                       (HyperJumpBox with: (OrderedCollection
							                         with: (ParsecMeasure worth: 30)
							                         with: (ParsecMeasure worth: 40)))
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 3 3 5 8 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 8 with: 7)
]

{ #category : #tests }
BoxesTest >> testA013WhenPlayerReachesARandomCardBoxThenCheckThatPlayerHasOneMoreCardInPosetion [

	| aDuplaGalacticaGame aBoxesCollection aBoard |
	aBoxesCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using:
					                       (RandomCardBox with:
						                        (OrderedCollection with:
							                         (ObjectProbability
								                          using: NoEffectCard initializeNew
								                          withChanceOf: 100)))
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 6 8 5 8 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersCardInPosetion
		equals: (OrderedCollection with: 3 with: 2)
]

{ #category : #tests }
BoxesTest >> testA014WhenPlayerReachesAHyperJumpBoxThenCheckThatTheEffectDependingOnALigthYearNominalValueWasAppliedAndValidPlayersPositions [

	| aDuplaGalacticaGame aBoxesCollection aBoard |
	aBoxesCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using:
					                       (HyperJumpBox with: (OrderedCollection
							                         with: (LigthYearMeasure worth: 120)
							                         with: (LigthYearMeasure worth: 90)))
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 3 3 5 8 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 8 with: 7)
]

{ #category : #tests }
BoxesTest >> testA015WhenPlayerReachesAHyperJumpBoxThenCheckThatTheEffectDependingOnALigthYearAndAParsecNominalValueWasAppliedAndValidPlayersPositions [

	| aDuplaGalacticaGame aBoxesCollection aBoard |
	aBoxesCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using:
					                       (HyperJumpBox with: (OrderedCollection
							                         with: (LigthYearMeasure worth: 120)
							                         with: (ParsecMeasure worth: 30)))
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 3 3 5 8 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 8 with: 7)
]

{ #category : #tests }
BoxesTest >> testA016WhenPlayerReachesAHyperJumpBoxThenCheckThatTheEffectDependingOnALigthYearAndAParsecNegativeNominalValueWasAppliedAndValidPlayersPositions [

	| aDuplaGalacticaGame aBoxesCollection aBoard |
	aBoxesCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using:
					                       (HyperJumpBox with: (OrderedCollection
							                         with: (LigthYearMeasure worth: -60)
							                         with: (ParsecMeasure worth: -30)))
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 3 3 5 8 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 2 with: 1)
]

{ #category : #tests }
BoxesTest >> testA017WhenPlayerReachesAHyperJumpBoxThenCheckIfItHasANegativeEffectThatMakesPlayerMoveBackwardMoreThanOneLapAndValidPlayersPositions [

	| aDuplaGalacticaGame aBoxesCollection aBoard |
	aBoxesCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: (HyperJumpBox with:
						                        (OrderedCollection with:
							                         (ParsecMeasure worth: -220)))
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 30 31 5 8 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 9 with: 10)
]

{ #category : #tests }
BoxesTest >> testB001TryToCreateARandomCardBoxWithCardsProbabilitiesNotEqualsTo100ThenFails [

	self
		should: [ 
			RandomCardBox with: (OrderedCollection with:
					 (ObjectProbability
						  using: OverloadCard initializeNew
						  withChanceOf: 10)) ]
		raise: Error
		withMessage: 'The sum of probabilities must be 100'.
	self
		should: [ 
			RandomCardBox with: (OrderedCollection with:
					 (ObjectProbability
						  using: OverloadCard initializeNew
						  withChanceOf: 150)) ]
		raise: Error
		withMessage: 'The sum of probabilities must be 100'
]

{ #category : #tests }
BoxesTest >> testB002TryToCreateAHyperJumpBoxWithNoValuesToUseThenFails [

	self
		should: [ 
			(ObjectCreator use: (OrderedCollection with: (ObjectProbability
						   using: (HyperJumpBox with: OrderedCollection new)
						   withChanceOf: 100))) create: 10 ]
		raise: Error
		withMessage: 'There are no values to use in the hyper jump box'
]

{ #category : #tests }
BoxesTest >> testB003TryToCreateABoardWithLessThanFourBoxesThenFails [

	| aBoxesCollection |
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NoEffectBox initializeNew
				                       withChanceOf: 100))) create: 3.
	self
		should: [ 
		Board with: aBoxesCollection measure: (ParsecMeasure worth: 100) ]
		raise: Error
		withMessage: 'Cannot create a board with that amount of boxes'
]

{ #category : #tests }
BoxesTest >> testB004TryToCreateABoardWithBoxesThatAreNotBoxesThenFails [

	| aBoxesCollection |
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NoEffectCard initializeNew
				                       withChanceOf: 100))) create: 10.
	self
		should: [ 
		Board with: aBoxesCollection measure: (ParsecMeasure worth: 100) ]
		raise: Error
		withMessage: 'That is not a valid box'
]

{ #category : #tests }
BoxesTest >> testB005TryToCreateABoardWithNoBoxesOrderedCollectionThenFails [

	self
		should: [ Board with: 'blue' measure: (ParsecMeasure worth: 100) ]
		raise: Error
		withMessage: 'That is not a boxes collection'.
	self
		should: [ Board with: 100 measure: (ParsecMeasure worth: 100) ]
		raise: Error
		withMessage: 'That is not a boxes collection'
]

{ #category : #tests }
BoxesTest >> testB006TryToCreateAHyperJumpBoxWithNoMeasuresOrderedCollectionThenFails [

	self
		should: [ 
			(ObjectCreator use: (OrderedCollection with:
					  (ObjectProbability
						   using: (HyperJumpBox with: 'p')
						   withChanceOf: 100))) create: 10 ]
		raise: Error
		withMessage: 'That is not a measures collection'.
	self
		should: [ 
			(ObjectCreator use: (OrderedCollection with:
					  (ObjectProbability
						   using: (HyperJumpBox with: 100)
						   withChanceOf: 100))) create: 10 ]
		raise: Error
		withMessage: 'That is not a measures collection'
]

{ #category : #tests }
BoxesTest >> testB007TryToCreateAHyperJumpBoxWithMeasuresThatAreNotMeasuresThenFails [

	self
		should: [ 
			(ObjectCreator use: (OrderedCollection with: (ObjectProbability
						   using: (HyperJumpBox with: (OrderedCollection
									     with: (ParsecMeasure worth: 45)
									     with: 'p'
									     with: (LigthYearMeasure worth: 60)))
						   withChanceOf: 100))) create: 10 ]
		raise: Error
		withMessage: 'Cannot create a hyper jump box with that values'
]

{ #category : #tests }
BoxesTest >> testB008TryToCreateABoardWithAMeasureThatIsNotAMeasureThenFails [

	| aBoxesCollection |
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NoEffectBox initializeNew
				                       withChanceOf: 100))) create: 10.
	self
		should: [ Board with: aBoxesCollection measure: 'p' ]
		raise: Error
		withMessage: 'That is not a measure'.
	self
		should: [ Board with: aBoxesCollection measure: 100 ]
		raise: Error
		withMessage: 'That is not a measure'.
	self
		should: [ 
		Board with: aBoxesCollection measure: (OrderedCollection with: 100) ]
		raise: Error
		withMessage: 'That is not a measure'
]
