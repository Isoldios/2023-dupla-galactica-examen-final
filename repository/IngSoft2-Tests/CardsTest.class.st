Class {
	#name : #CardsTest,
	#superclass : #TestCase,
	#instVars : [
		'aColorsCollection'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #Board }
CardsTest >> createBoard [

	| aBoxesCollection |
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			           (ObjectProbability
				            using: NullBox initializeNew
				            withChanceOf: 100))) create: 10.
	^ Board with: aBoxesCollection measure: (ParsecMeasure worth: 100)
]

{ #category : #running }
CardsTest >> setUp [

	super setUp.

	aColorsCollection := OrderedCollection with: 'red' with: 'blue'.
]

{ #category : #tests }
CardsTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
CardsTest >> testC001WhenPlayerPlaysAnOverloadCardThenCheckTheNegativeEffectAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: OverloadCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
		to: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 2 with: 1)
]

{ #category : #tests }
CardsTest >> testC002WhenPlayerPlaysAnOverloadCardThenCheckThatTheNegativeEffectIsPermanentAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: OverloadCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
		to: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 5 with: 3)
]

{ #category : #tests }
CardsTest >> testC003WhenPlayerPlaysAnOverloadCardThenCheckTheNegativeEffectMakesPlayerGoBackwardLapsAndValidPlayersPositionsAndLaps [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: OverloadCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 10 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
		to: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 2 with: 9).
	self
		assert: aDuplaGalacticaGame playersLaps
		equals: (OrderedCollection with: 0 with: 0)
]

{ #category : #tests }
CardsTest >> testC004WhenPlayerPlaysAnOverloadCardThenCheckTheNegativeEffectCannotSendPlayerToAnOutOfRangeBoardPositionAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: OverloadCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 0 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
		to: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 2 with: 1)
]

{ #category : #tests }
CardsTest >> testC005WhenPlayerPlaysASpeedCardThenCheckThePositiveEffectAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: SpeedCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: SpeedCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 3 with: 3)
]

{ #category : #tests }
CardsTest >> testC006WhenPlayerPlaysASpeedCardThenCheckThatThePositiveEffectIsPermanentAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: SpeedCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: SpeedCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 7 with: 3)
]

{ #category : #tests }
CardsTest >> testC007WhenPlayerPlaysASpeedCardThenCheckThePositiveEffectMakesPlayerGoForwardLapsAndValidPlayersPositionsAndLaps [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: SpeedCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 9 2 3 4 ))))
		                       winningWhenReach: 2
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: SpeedCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 1 with: 3).
	self
		assert: aDuplaGalacticaGame playersLaps
		equals: (OrderedCollection with: 1 with: 0)
]

{ #category : #tests }
CardsTest >> testC008WhenPlayerPlaysTwoOverloadCardsThenCheckThatBothEffectsWereAppliedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: OverloadCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
		to: 'blue'.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
		to: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 2 with: 1)
]

{ #category : #tests }
CardsTest >> testC009WhenPlayerPlaysAnAccelerationCardThenCheckThatItHasAPositiveEffectOnAllPlayersAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: AccelerationCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: AccelerationCard initializeNew)
		to: EveryPlayer initializeNew.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 3 with: 4)
]

{ #category : #tests }
CardsTest >> testC010WhenPlayerPlaysAnAccelerationCardThenCheckThatThePositiveEffectIsPermanentOnAllPlayersAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: AccelerationCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: AccelerationCard initializeNew)
		to: EveryPlayer initializeNew.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 7 with: 9)
]

{ #category : #tests }
CardsTest >> testC011WhenPlayerPlaysAnAccelerationCardThenCheckThePositiveEffectMakesPlayerGoForwardLapsAndValidPlayersPositionsAndLaps [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: AccelerationCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 8 9 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: AccelerationCard initializeNew)
		to: EveryPlayer initializeNew.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 10 with: 1).
	self
		assert: aDuplaGalacticaGame playersLaps
		equals: (OrderedCollection with: 0 with: 1)
]

{ #category : #tests }
CardsTest >> testC012WhenPlayerPlaysACancellationCardOnAnOverloadCardThenTheOverloadCardEffectIsCancelledAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: OverloadCard initializeNew
		                    with: CancellationCard initializeNew
		                    with: OverloadCard initializeNew
		                    with: CancellationCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
		to: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'blue' with: CancellationCard initializeNew)
		to: (PlayerHand of: 'blue' with: OverloadCard initializeNew).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 5 with: 5)
]

{ #category : #tests }
CardsTest >> testC013WhenPlayerPlaysACancellationCardOnASpeedCardThenTheSpeedCardEffectIsCancelledAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: SpeedCard initializeNew
		                    with: CancellationCard initializeNew
		                    with: SpeedCard initializeNew
		                    with: CancellationCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: SpeedCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'blue' with: CancellationCard initializeNew)
		to: (PlayerHand of: 'red' with: SpeedCard initializeNew).
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 6 with: 3)
]

{ #category : #tests }
CardsTest >> testC014WhenPlayerPlaysACancellationCardOnAnAccelerationCardThenTheAccelerationCardEffectIsCancelledAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: AccelerationCard initializeNew
		                    with: CancellationCard initializeNew
		                    with: AccelerationCard initializeNew
		                    with: CancellationCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: AccelerationCard initializeNew)
		to: EveryPlayer initializeNew.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'blue' with: CancellationCard initializeNew)
		to: (PlayerHand
				 of: EveryPlayer initializeNew
				 with: AccelerationCard initializeNew).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 6 with: 8)
]

{ #category : #tests }
CardsTest >> testC015WhenPlayerPlaysACancellationCardOnASpeedCardAndThereAreTwoActiveSpeedCardsThenOneSpeedCardEffectIsCancelledAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: SpeedCard initializeNew
		                    with: SpeedCard initializeNew
		                    with: CancellationCard initializeNew
		                    with: SpeedCard initializeNew
		                    with: SpeedCard initializeNew
		                    with: CancellationCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: SpeedCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: SpeedCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'blue' with: CancellationCard initializeNew)
		to: (PlayerHand of: 'red' with: SpeedCard initializeNew).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 8 with: 7)
]

{ #category : #tests }
CardsTest >> testC016WhenPlayerPlaysTwoCancellationCardsOnTwoActiveSpeedCardsThenTheTwoSpeedCardsEffectsAreCancelledAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: SpeedCard initializeNew
		                    with: CancellationCard initializeNew
		                    with: SpeedCard initializeNew
		                    with: CancellationCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: SpeedCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'blue' with: SpeedCard initializeNew)
		to: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'blue' with: CancellationCard initializeNew)
		to: (PlayerHand of: 'red' with: SpeedCard initializeNew).
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: CancellationCard initializeNew)
		to: (PlayerHand of: 'blue' with: SpeedCard initializeNew).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 6 with: 8)
]

{ #category : #tests }
CardsTest >> testC017WhenPlayerPlaysARedoCardAndTheLastCardPlayedWasAnOverloadCardThenCheckThatTheEffectWasRepeatedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: OverloadCard initializeNew
		                    with: RedoCard initializeNew
		                    with: OverloadCard initializeNew
		                    with: RedoCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
		to: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'blue' with: RedoCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 3 with: 3)
]

{ #category : #tests }
CardsTest >> testC018WhenPlayerPlaysARedoCardAndTheLastCardPlayedWasASpeedCardThenCheckThatTheEffectWasRepeatedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: SpeedCard initializeNew
		                    with: RedoCard initializeNew
		                    with: SpeedCard initializeNew
		                    with: RedoCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: SpeedCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: RedoCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 8 with: 3)
]

{ #category : #tests }
CardsTest >> testC019WhenPlayerPlaysARedoCardAndTheLastCardPlayedWasAnAccelerationCardThenCheckThatTheEffectWasRepeatedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: AccelerationCard initializeNew
		                    with: RedoCard initializeNew
		                    with: AccelerationCard initializeNew
		                    with: RedoCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: AccelerationCard initializeNew)
		to: EveryPlayer initializeNew.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: RedoCard initializeNew)
		to: EveryPlayer initializeNew.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 8 with: 10)
]

{ #category : #tests }
CardsTest >> testC020WhenPlayerPlaysARedoCardAndTheLastCardPlayedWasACancellationCardThenCheckThatTheEffectWasRepeatedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: OverloadCard initializeNew
		                    with: RedoCard initializeNew
		                    with: CancellationCard initializeNew
		                    with: OverloadCard initializeNew
		                    with: RedoCard initializeNew
		                    with: CancellationCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
		to: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'blue' with: OverloadCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'blue' with: CancellationCard initializeNew)
		to: (PlayerHand of: 'blue' with: OverloadCard initializeNew).
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: RedoCard initializeNew)
		to: (PlayerHand of: 'red' with: OverloadCard initializeNew).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 5 with: 5)
]

{ #category : #tests }
CardsTest >> testC021WhenPlayerPlaysARedoCardAndLastCardPlayedWasARedoCardThatRepeatedTheEffectOfAnAccelerationCardThenRepeatAgainThatEffectAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: AccelerationCard initializeNew
		                    with: RedoCard initializeNew
		                    with: AccelerationCard initializeNew
		                    with: RedoCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 1 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: AccelerationCard initializeNew)
		to: EveryPlayer initializeNew.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: RedoCard initializeNew)
		to: EveryPlayer initializeNew.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'blue' with: RedoCard initializeNew)
		to: EveryPlayer initializeNew.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 9 with: 10)
]

{ #category : #tests }
CardsTest >> testC022WhenPlayerPlaysARepeatCardAndLastBoxInvokedWasASpeedUpBoxThenCheckThatThisEffectWasRepeatedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: RepeatCard initializeNew
				                       withChanceOf: 100))) create: 4.
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
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: RepeatCard initializeNew)
		to: 'red'.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 10 with: 7)
]

{ #category : #tests }
CardsTest >> testC023WhenPlayerPlaysARepeatCardAndLastBoxInvokedWasAWormHoleBoxThenCheckThatThisEffectWasRepeatedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: RepeatCard initializeNew
				                       withChanceOf: 100))) create: 4.
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
					                         (LoadedDie with: #( 8 9 7 6 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: RepeatCard initializeNew)
		to: 'blue'.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 5 with: 2)
]

{ #category : #tests }
CardsTest >> testC024WhenPlayerPlaysARepeatCardAndLastBoxInvokedWasAMoonWalkBoxThenCheckThatThisEffectWasRepeatedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: RepeatCard initializeNew
				                       withChanceOf: 100))) create: 4.
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
					                         (LoadedDie with: #( 4 5 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: RepeatCard initializeNew)
		to: 'red'.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 3 with: 4)
]

{ #category : #tests }
CardsTest >> testC025WhenPlayerPlaysARepeatCardAndLastBoxInvokedWasAHyperJumpBoxThenCheckThatThisEffectWasRepeatedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: RepeatCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aBoxesCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using:
					                       (HyperJumpBox with: (OrderedCollection
							                         with: (ParsecMeasure worth: 40)
							                         with: (ParsecMeasure worth: 20)))
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: RepeatCard initializeNew)
		to: 'red'.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 8 with: 7)
]

{ #category : #tests }
CardsTest >> testC026WhenPlayerPlaysARedoCardAndTheLastCardPlayedWasARepeatCardThenCheckThatTheEffectOfASpeedUpBoxWasRepeatedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := OrderedCollection
		                    with: RepeatCard initializeNew
		                    with: RedoCard initializeNew
		                    with: RepeatCard initializeNew
		                    with: RedoCard initializeNew.
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
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: RepeatCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'blue' with: RedoCard initializeNew)
		to: 'blue'.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 10 with: 5)
]

{ #category : #tests }
CardsTest >> testC027WhenPlayerPlaysASpeedBoostCardOnAnOverloadCardThenCheckThatTheOverloadCardEffectWasDuplicatedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: OverloadCard initializeNew
		                    with: SpeedBoostCard initializeNew
		                    with: OverloadCard initializeNew
		                    with: SpeedBoostCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 2 3 4 5 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
		to: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: SpeedBoostCard initializeNew)
		to: (PlayerHand of: 'blue' with: OverloadCard initializeNew).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 7 with: 3)
]

{ #category : #tests }
CardsTest >> testC028WhenPlayerPlaysASpeedBoostCardOnASpeedCardThenCheckThatTheSpeedCardEffectWasDuplicatedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: SpeedCard initializeNew
		                    with: SpeedBoostCard initializeNew
		                    with: SpeedCard initializeNew
		                    with: SpeedBoostCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: SpeedCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: SpeedBoostCard initializeNew)
		to: (PlayerHand of: 'red' with: SpeedCard initializeNew).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 8 with: 7)
]

{ #category : #tests }
CardsTest >> testC029WhenPlayerPlaysASpeedBoostCardOnAnAccelerationCardThenCheckThatTheAccelerationCardEffectWasDuplicatedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: AccelerationCard initializeNew
		                    with: SpeedBoostCard initializeNew
		                    with: AccelerationCard initializeNew
		                    with: SpeedBoostCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: AccelerationCard initializeNew)
		to: EveryPlayer initializeNew.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: SpeedBoostCard initializeNew)
		to: (PlayerHand
				 of: EveryPlayer initializeNew
				 with: AccelerationCard initializeNew).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 8 with: 10)
]

{ #category : #tests }
CardsTest >> testC030WhenPlayerPlaysACancellationCardOnABoostedPermanentCardThenCheckThatTheEffectIsNoMoreAppliedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: OverloadCard initializeNew
		                    with: SpeedBoostCard initializeNew
		                    with: CancellationCard initializeNew
		                    with: OverloadCard initializeNew
		                    with: SpeedBoostCard initializeNew
		                    with: CancellationCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 2 5 1 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
		to: 'blue'.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: SpeedBoostCard initializeNew)
		to: (PlayerHand of: 'blue' with: OverloadCard initializeNew).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'blue' with: CancellationCard initializeNew)
		to: (PlayerHand of: 'blue' with: OverloadCard initializeNew).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 4 with: 6)
]

{ #category : #tests }
CardsTest >> testC031WhenPlayerPlaysAReversePolarityCardOnASpeedUpBoxThenCheckThatTheBoxAffectOtherPlayersAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: ReversePolarityCard initializeNew
				                       withChanceOf: 100))) create: 4.
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
					                         (LoadedDie with: #( 1 1 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply:
		(PlayerHand of: 'red' with: ReversePolarityCard initializeNew)
		to: (aBoxesCollection at: 2).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 2 with: 10)
]

{ #category : #tests }
CardsTest >> testC032WhenPlayerPlaysAReversePolarityCardOnAWormHoleBoxThenCheckThatTheBoxAffectOtherPlayersAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: ReversePolarityCard initializeNew
				                       withChanceOf: 100))) create: 4.
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
					                         (LoadedDie with: #( 7 8 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply:
		(PlayerHand of: 'red' with: ReversePolarityCard initializeNew)
		to: (aBoxesCollection at: 9).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 1 with: 9)
]

{ #category : #tests }
CardsTest >> testC033WhenPlayerPlaysAReversePolarityCardOnAMoonWalkBoxThenCheckThatTheBoxAffectTheCurrentPlayersAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: ReversePolarityCard initializeNew
				                       withChanceOf: 100))) create: 4.
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
					                         (LoadedDie with: #( 5 4 3 2 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply:
		(PlayerHand of: 'red' with: ReversePolarityCard initializeNew)
		to: (aBoxesCollection at: 5).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 6 with: 3)
]

{ #category : #tests }
CardsTest >> testC034WhenPlayerPlaysAReversePolarityCardOnAnAtomicBombBoxThenCheckThatTheBoxDoesNotAffectAnyoneAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: ReversePolarityCard initializeNew
				                       withChanceOf: 100))) create: 4.
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
					                         (LoadedDie with: #( 5 4 3 2 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply:
		(PlayerHand of: 'red' with: ReversePolarityCard initializeNew)
		to: (aBoxesCollection at: 5).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 1 with: 5)
]

{ #category : #tests }
CardsTest >> testC035WhenPlayerPlaysAReversePolarityCardOnAHyperJumpBoxThenCheckThatTheBoxAffectOtherPlayersAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: ReversePolarityCard initializeNew
				                       withChanceOf: 100))) create: 4.
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
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply:
		(PlayerHand of: 'red' with: ReversePolarityCard initializeNew)
		to: (aBoxesCollection at: 3).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 10 with: 3)
]

{ #category : #tests }
CardsTest >> testC036WhenPlayerPlaysAReversePolarityCardOnARandomCardBoxThenCheckThatTheBoxAffectOtherPlayersAndValidPlayersCardsInPosition [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: ReversePolarityCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aBoxesCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using:
					                       (RandomCardBox with:
						                        (OrderedCollection with:
							                         (ObjectProbability
								                          using: OverloadCard initializeNew
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
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply:
		(PlayerHand of: 'red' with: ReversePolarityCard initializeNew)
		to: (aBoxesCollection at: 3).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersCardsInPosetion
		equals: (OrderedCollection with: 3 with: 2)
]

{ #category : #tests }
CardsTest >> testC037WhenPlayerPlaysAReversePolarityCardOnANoEffectBoxThenCheckThatNoEffectsWereAppliedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: ReversePolarityCard initializeNew
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
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply:
		(PlayerHand of: 'red' with: ReversePolarityCard initializeNew)
		to: (aBoxesCollection at: 3).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testC038WhenPlayerPlaysASpeedBoostCardOnAReversePolarityCardThenCheckThatTheBoxPolarityHasChangedAgainThenValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := OrderedCollection
		                    with: ReversePolarityCard initializeNew
		                    with: SpeedBoostCard initializeNew
		                    with: ReversePolarityCard initializeNew
		                    with: SpeedBoostCard initializeNew.
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
					                         (LoadedDie with: #( 2 8 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply:
		(PlayerHand of: 'red' with: ReversePolarityCard initializeNew)
		to: (aBoxesCollection at: 3).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: SpeedBoostCard initializeNew)
		to: (PlayerHand of: (aBoxesCollection at: 3) with: ReversePolarityCard initializeNew).
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 3 with: 7)
]

{ #category : #tests }
CardsTest >> testC039WhenPlayerPlaysACancellationCardOnAReversePolarityCardThenCheckThatTheBoxPolarityHasChangedAgainAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := OrderedCollection
		                    with: ReversePolarityCard initializeNew
		                    with: CancellationCard initializeNew
		                    with: ReversePolarityCard initializeNew
		                    with: CancellationCard initializeNew.
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
					                         (LoadedDie with: #( 2 8 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply:
		(PlayerHand of: 'red' with: ReversePolarityCard initializeNew)
		to: (aBoxesCollection at: 3).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: CancellationCard initializeNew)
		to: (PlayerHand of: (aBoxesCollection at: 3) with: ReversePolarityCard initializeNew).
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 3 with: 7)
]

{ #category : #tests }
CardsTest >> testC040WhenPlayerPlaysARedoCardAndTheLastCardPlayedWasAReversePolarityCardThenCheckThatTheBoxPolarityHasChangedDueToTheRedoCardAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := OrderedCollection
		                    with: ReversePolarityCard initializeNew
		                    with: RedoCard initializeNew
		                    with: ReversePolarityCard initializeNew
		                    with: RedoCard initializeNew.
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
					                         (LoadedDie with: #( 2 1 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply:
		(PlayerHand of: 'red' with: ReversePolarityCard initializeNew)
		to: (aBoxesCollection at: 3).
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: RedoCard initializeNew)
		to: (aBoxesCollection at: 6).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 7 with: 6)
]

{ #category : #tests }
CardsTest >> testC041WhenPlayerPlaysARepeatCardAndTheLastBoxInvokedHasBeenAffectedByAReversePolarityCardThenCheckThatTheEffectReversedWasRepeatedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := OrderedCollection
		                    with: ReversePolarityCard initializeNew
		                    with: RepeatCard initializeNew
		                    with: ReversePolarityCard initializeNew
		                    with: RepeatCard initializeNew.
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
					                         (LoadedDie with: #( 2 1 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply:
		(PlayerHand of: 'red' with: ReversePolarityCard initializeNew)
		to: (aBoxesCollection at: 3).
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: RepeatCard initializeNew)
		to: 'blue'.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 7 with: 5)
]

{ #category : #tests }
CardsTest >> testC042WhenPlayerPlaysTwoReversePolarityCardsOnTheSameBoxThenCheckThatTheEffectWasNotReversedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: ReversePolarityCard initializeNew
				                       withChanceOf: 100))) create: 4.
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
					                         (LoadedDie with: #( 2 1 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply:
		(PlayerHand of: 'red' with: ReversePolarityCard initializeNew)
		to: (aBoxesCollection at: 3).
	aDuplaGalacticaGame
		apply:
		(PlayerHand of: 'red' with: ReversePolarityCard initializeNew)
		to: (aBoxesCollection at: 3).
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 7 with: 1)
]

{ #category : #tests }
CardsTest >> testC043WhenPlayerPlaysANoEffectCardThenCheckThatNoEffectsWereAppliedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
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
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: NullCard initializeNew)
		to: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testC044WhenPlayerPlaysTwoSpeedCardsThenCheckThatBothEffectsWereAppliedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: SpeedCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: SpeedCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: SpeedCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 4 with: 1)
]

{ #category : #tests }
CardsTest >> testC045WhenPlayerPlaysTwoAccelerationCardsThenCheckThatBothEffectsWereAppliedToAllPlayersAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: AccelerationCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: AccelerationCard initializeNew)
		to: EveryPlayer initializeNew.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: AccelerationCard initializeNew)
		to: EveryPlayer initializeNew.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 4 with: 5)
]

{ #category : #tests }
CardsTest >> testC046WhenPlayerPlaysARedoCardAndLastCardPlayedWasARedoCardThatRepeatedTheEffectOfAnOverloadCardThenRepeatAgainThatEffectAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: OverloadCard initializeNew
		                    with: RedoCard initializeNew
		                    with: OverloadCard initializeNew
		                    with: RedoCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 2 3 4 5 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
		to: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: RedoCard initializeNew)
		to: 'blue'.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'blue' with: RedoCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 5 with: 3)
]

{ #category : #tests }
CardsTest >> testC047WhenPlayerPlaysARedoCardAndLastCardPlayedWasARedoCardThatRepeatedTheEffectOfASpeedCardThenRepeatAgainThatEffectAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: SpeedCard initializeNew
		                    with: RedoCard initializeNew
		                    with: SpeedCard initializeNew
		                    with: RedoCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: SpeedCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: RedoCard initializeNew)
		to: 'red'.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'blue' with: RedoCard initializeNew)
		to: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 8 with: 8)
]

{ #category : #tests }
CardsTest >> testC048WhenPlayerPlaysARepeatCardAndLastBoxInvokedWasAnAtomicBombBoxThenCheckThatThisEffectWasRepeatedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: RepeatCard initializeNew
				                       withChanceOf: 100))) create: 4.
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
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: RepeatCard initializeNew)
		to: 'red'.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 1 with: 1)
]

{ #category : #tests }
CardsTest >> testC049WhenPlayerPlaysARepeatCardAndLastBoxInvokedWasARandomCardBoxThenCheckThatThisEffectWasRepeatedAndValidPlayersCardsInPosetion [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: RepeatCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aBoxesCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using:
					                       (RandomCardBox with:
						                        (OrderedCollection with:
							                         (ObjectProbability
								                          using: OverloadCard initializeNew
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
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: RepeatCard initializeNew)
		to: 'blue'.
	self
		assert: aDuplaGalacticaGame playersCardsInPosetion
		equals: (OrderedCollection with: 2 with: 4)
]

{ #category : #tests }
CardsTest >> testC050WhenPlayerPlaysARepeatCardAndLastBoxInvokedWasANoEffectBoxThenCheckThatNoEffectsWereRepeatedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: RepeatCard initializeNew
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
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: RepeatCard initializeNew)
		to: 'blue'.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testD001TryToPlayACancellationCardOnAnOverloadCardWhenThePlayerDoesNotHaveAnyActiveCardsThenFails [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: CancellationCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self
		should: [ 
			aDuplaGalacticaGame
				apply: (PlayerHand of: 'red' with: CancellationCard initializeNew)
				to: (PlayerHand of: 'red' with: OverloadCard initializeNew) ]
		raise: Error
		withMessage: 'There are no active permanent cards'
]

{ #category : #tests }
CardsTest >> testD002TryToPlayACancellationCardOnASpeedCardWhenThePlayerHasOnlyAnActiveOverloadCardThenFails [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: OverloadCard initializeNew
		                    with: CancellationCard initializeNew
		                    with: OverloadCard initializeNew
		                    with: CancellationCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
		to: 'blue'.
	self
		should: [ 
			aDuplaGalacticaGame
				apply:
				(PlayerHand of: 'blue' with: CancellationCard initializeNew)
				to: (PlayerHand of: 'blue' with: SpeedCard initializeNew) ]
		raise: Error
		withMessage: 'There are no cards of that type active in this player'
]

{ #category : #tests }
CardsTest >> testD004TryToPlayAPermanentCardWhenItIsNotThePlayerTurnThenFails [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: OverloadCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self
		should: [ 
			aDuplaGalacticaGame
				apply: (PlayerHand of: 'blue' with: OverloadCard initializeNew)
				to: 'red' ]
		raise: Error
		withMessage: 'A permanent card can only be use when it is your turn'
]

{ #category : #tests }
CardsTest >> testD005TryToPlayASpeedCardWhenPlayerDoesNotHaveThatTypeOfCardInPosetionThenFails [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: OverloadCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self
		should: [ 
			aDuplaGalacticaGame
				apply: (PlayerHand of: 'red' with: SpeedCard initializeNew)
				to: 'red' ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testD006TryToPlayAnOverloadCardOnANonPlayerObjectiveThenFails [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: OverloadCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self
		should: [ 
			aDuplaGalacticaGame
				apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
				to: (PlayerHand of: 'blue' with: OverloadCard initializeNew) ]
		raise: Error
		withMessage: 'That is not a valid player objective'
]

{ #category : #tests }
CardsTest >> testD007TryToCreateAGameWithCardsThatAreNotCardsThenFails [

	| aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NullBox initializeNew
				                       withChanceOf: 100))) create: 4.
	self
		should: [ 
			DuplaGalacticaGameProxy
				with: aColorsCollection
				and: self createBoard
				usingToThrow: (DiceShaker with:
						 (OrderedCollection with: (LoadedDie with: #( 1 2 3 4 ))))
				winningWhenReach: 1
				using: aCardsCollection ]
		raise: Error
		withMessage: 'That is not a valid card'
]

{ #category : #tests }
CardsTest >> testD008TryToPlayAnOverloadCardOnANonExistentPlayerThenFails [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: OverloadCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self
		should: [ 
			aDuplaGalacticaGame
				apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
				to: 'orange' ]
		raise: Error
		withMessage: 'That is not a valid player objective'
]

{ #category : #tests }
CardsTest >> testD009TryToCreateAGameWithNoCardsThenFails [

	| aCardsCollection |
	aCardsCollection := OrderedCollection new.
	self
		should: [ 
			DuplaGalacticaGameProxy
				with: aColorsCollection
				and: self createBoard
				usingToThrow: (DiceShaker with:
						 (OrderedCollection with: (LoadedDie with: #( 1 2 3 4 ))))
				winningWhenReach: 1
				using: aCardsCollection ]
		raise: Error
		withMessage: 'Cannot create a game with that amount of cards'
]

{ #category : #tests }
CardsTest >> testD010TryToPlayASpeedCardOnANonPlayerObjectiveThenFails [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: SpeedCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self
		should: [ 
			aDuplaGalacticaGame
				apply: (PlayerHand of: 'red' with: SpeedCard initializeNew)
				to: (PlayerHand of: 'blue' with: SpeedCard initializeNew) ]
		raise: Error
		withMessage: 'That is not a valid player objective'
]

{ #category : #tests }
CardsTest >> testD011TryToPlayACardWhenPlayerDoesNotHaveAnyMoreCardsAfterPlayingItsTwoCardsInPosetionThenFails [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: OverloadCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
		to: 'blue'.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
		to: 'blue'.
	self
		should: [ 
			aDuplaGalacticaGame
				apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
				to: 'blue' ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testD012TryToPlayARepeatCardOnANonPlayerObjectiveThenFails [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: RepeatCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self
		should: [ 
			aDuplaGalacticaGame
				apply: (PlayerHand of: 'red' with: RepeatCard initializeNew)
				to: (PlayerHand of: 'blue' with: RepeatCard initializeNew) ]
		raise: Error
		withMessage: 'That is not a valid player objective'
]

{ #category : #tests }
CardsTest >> testD013TryToCreateAGameWithLessThanTwoCardsPerPlayerThenFails [

	| aCardsCollection |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: AccelerationCard initializeNew
				                       withChanceOf: 100))) create: 3.
	self
		should: [ 
			DuplaGalacticaGameProxy
				with: aColorsCollection
				and: self createBoard
				usingToThrow: (DiceShaker with:
						 (OrderedCollection with: (LoadedDie with: #( 1 2 3 4 ))))
				winningWhenReach: 1
				using: aCardsCollection ]
		raise: Error
		withMessage: 'Cannot create a game with that amount of cards'
]

{ #category : #tests }
CardsTest >> testD014TryToPlayARedoCardWhenNoOtherCardsWerePlayedBeforeThenFails [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: RedoCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self
		should: [ 
			aDuplaGalacticaGame
				apply: (PlayerHand of: 'blue' with: RedoCard initializeNew)
				to: 'red' ]
		raise: Error
		withMessage:
		'Redo card cannot be played because there are no cards that have been played before'
]

{ #category : #tests }
CardsTest >> testD015TryToCreateAGameWithNoCardsOrderedCollectionThenFails [

	| aCardsCollection |
	aCardsCollection := 'blue'.
	self
		should: [ 
			DuplaGalacticaGameProxy
				with: aColorsCollection
				and: self createBoard
				usingToThrow: (DiceShaker with:
						 (OrderedCollection with: (LoadedDie with: #( 1 2 3 4 ))))
				winningWhenReach: 1
				using: aCardsCollection ]
		raise: Error
		withMessage: 'That is not a cards collection'
]

{ #category : #tests }
CardsTest >> testD017TryToPlayAnAccelerationCardOnANonEveryPlayerObjectiveThenFails [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: AccelerationCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 2 5 1 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self
		should: [ 
			aDuplaGalacticaGame
				apply: (PlayerHand of: 'red' with: AccelerationCard initializeNew)
				to: 'blue' ]
		raise: Error
		withMessage:
		'Cannot play an acceleration card on a non every player objective'
]

{ #category : #tests }
CardsTest >> testD018TryToPlayASpeedBoostCardOnASpeedCardWhenTheOnlyActivePermanetCardIsAnOverloadCardThenFails [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := OrderedCollection
		                    with: OverloadCard initializeNew
		                    with: SpeedBoostCard initializeNew
		                    with: OverloadCard initializeNew
		                    with: SpeedBoostCard initializeNew.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		apply: (PlayerHand of: 'red' with: OverloadCard initializeNew)
		to: 'blue'.
	self
		should: [ 
			aDuplaGalacticaGame
				apply: (PlayerHand of: 'red' with: SpeedBoostCard initializeNew)
				to: (PlayerHand of: 'blue' with: SpeedCard initializeNew) ]
		raise: Error
		withMessage: 'There are no cards of that type active in this player'
]

{ #category : #tests }
CardsTest >> testD019TryToPlayASpeedBoostCardWhenThereAreNoActivePermanentCardsThenFails [

	| aDuplaGalacticaGame aCardsCollection |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: SpeedBoostCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: self createBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self
		should: [ 
			aDuplaGalacticaGame
				apply: (PlayerHand of: 'red' with: SpeedBoostCard initializeNew)
				to: (PlayerHand of: 'red' with: SpeedCard initializeNew) ]
		raise: Error
		withMessage: 'There are no active permanent cards'
]

{ #category : #tests }
CardsTest >> testD020TryToPlayAReversePolarityCardOnANoCreatedBoxAtTheGameBoxThenFails [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: ReversePolarityCard initializeNew
				                       withChanceOf: 100))) create: 4.
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
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self
		should: [ 
			aDuplaGalacticaGame
				apply:
				(PlayerHand of: 'red' with: ReversePolarityCard initializeNew)
				to: SpeedUpBox initializeNew ]
		raise: Error
		withMessage: 'That is not a box created at the dupla galactica game'
]

{ #category : #tests }
CardsTest >> testD021TryToPlayAReversePolarityCardOnAPlayerObjectiveThenFails [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: ReversePolarityCard initializeNew
				                       withChanceOf: 100))) create: 4.
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
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self
		should: [ 
			aDuplaGalacticaGame
				apply:
				(PlayerHand of: 'red' with: ReversePolarityCard initializeNew)
				to: 'blue' ]
		raise: Error
		withMessage: 'That is not a box created at the dupla galactica game'
]

{ #category : #tests }
CardsTest >> testD022TryToPlayAReversePolarityCardOnACardObjectiveThenFails [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := (ObjectCreator use:
		                     (OrderedCollection with: (ObjectProbability
				                       using: ReversePolarityCard initializeNew
				                       withChanceOf: 100))) create: 4.
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
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self
		should: [ 
			aDuplaGalacticaGame
				apply:
				(PlayerHand of: 'red' with: ReversePolarityCard initializeNew)
				to: (PlayerHand of: 'red' with: SpeedCard initializeNew) ]
		raise: Error
		withMessage: 'That is not a box created at the dupla galactica game'
]
