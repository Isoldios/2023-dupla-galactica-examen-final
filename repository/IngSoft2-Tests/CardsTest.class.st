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
		play: OverloadCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
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
		play: OverloadCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
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
		play: OverloadCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
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
		play: OverloadCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
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
		play: SpeedCard initializeNew
		from: 'red'
		toPlayer: 'red'.
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
		play: SpeedCard initializeNew
		from: 'red'
		toPlayer: 'red'.
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
		play: SpeedCard initializeNew
		from: 'red'
		toPlayer: 'red'.
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
		play: OverloadCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
	aDuplaGalacticaGame
		play: OverloadCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
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
		playToEveryone: AccelerationCard initializeNew
		from: 'red'.
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
		playToEveryone: AccelerationCard initializeNew
		from: 'red'.
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
		playToEveryone: AccelerationCard initializeNew
		from: 'red'.
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
		play: OverloadCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		affect: OverloadCard initializeNew
		targetingPlayer: 'blue'
		atTemporalLocation: 1
		with: CancellationCard initializeNew
		from: 'blue'.
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
		play: SpeedCard initializeNew
		from: 'red'
		toPlayer: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		affect: SpeedCard initializeNew
		targetingPlayer: 'red'
		atTemporalLocation: 1
		with: CancellationCard initializeNew
		from: 'blue'.
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
		playToEveryone: AccelerationCard initializeNew
		from: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		affect: AccelerationCard initializeNew
		targetingPlayer: 'everyone'
		atTemporalLocation: 1
		with: CancellationCard initializeNew
		from: 'blue'.
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
		play: SpeedCard initializeNew
		from: 'red'
		toPlayer: 'red'.
	aDuplaGalacticaGame
		play: SpeedCard initializeNew
		from: 'red'
		toPlayer: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		affect: SpeedCard initializeNew
		targetingPlayer: 'red'
		atTemporalLocation: 1
		with: CancellationCard initializeNew
		from: 'blue'.
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
		play: SpeedCard initializeNew
		from: 'red'
		toPlayer: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		play: SpeedCard initializeNew
		from: 'blue'
		toPlayer: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		affect: SpeedCard initializeNew
		targetingPlayer: 'red'
		atTemporalLocation: 1
		with: CancellationCard initializeNew
		from: 'blue'.
	aDuplaGalacticaGame
		affect: SpeedCard initializeNew
		targetingPlayer: 'blue'
		atTemporalLocation: 1
		with: CancellationCard initializeNew
		from: 'red'.
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
		play: OverloadCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		play: RedoCard initializeNew
		from: 'blue'
		toPlayer: 'red'.
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
		play: SpeedCard initializeNew
		from: 'red'
		toPlayer: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		play: RedoCard initializeNew
		from: 'red'
		toPlayer: 'red'.
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
		playToEveryone: AccelerationCard initializeNew
		from: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		playToEveryone: RedoCard initializeNew
		from: 'red'.
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
		play: OverloadCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		play: OverloadCard initializeNew
		from: 'blue'
		toPlayer: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		affect: OverloadCard initializeNew
		targetingPlayer: 'blue'
		atTemporalLocation: 1
		with: CancellationCard initializeNew
		from: 'blue'.
	aDuplaGalacticaGame
		affect: OverloadCard initializeNew
		targetingPlayer: 'red'
		atTemporalLocation: 1
		with: RedoCard initializeNew
		from: 'red'.
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
		playToEveryone: AccelerationCard initializeNew
		from: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		playToEveryone: RedoCard initializeNew
		from: 'red'.
	aDuplaGalacticaGame
		playToEveryone: RedoCard initializeNew
		from: 'blue'.
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
		play: RepeatCard initializeNew
		from: 'red'
		toPlayer: 'red'.
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
		play: RepeatCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
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
		play: RepeatCard initializeNew
		from: 'red'
		toPlayer: 'red'.
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
		play: RepeatCard initializeNew
		from: 'red'
		toPlayer: 'red'.
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
		play: RepeatCard initializeNew
		from: 'red'
		toPlayer: 'red'.
	aDuplaGalacticaGame
		play: RedoCard initializeNew
		from: 'blue'
		toPlayer: 'blue'.
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
		play: OverloadCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		affect: OverloadCard initializeNew
		targetingPlayer: 'blue'
		atTemporalLocation: 1
		with: SpeedBoostCard initializeNew
		from: 'red'.
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
		play: SpeedCard initializeNew
		from: 'red'
		toPlayer: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		affect: SpeedCard initializeNew
		targetingPlayer: 'red'
		atTemporalLocation: 1
		with: SpeedBoostCard initializeNew
		from: 'red'.
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
		playToEveryone: AccelerationCard initializeNew
		from: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		affect: AccelerationCard initializeNew
		targetingPlayer: 'everyone'
		atTemporalLocation: 1
		with: SpeedBoostCard initializeNew
		from: 'red'.
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
		play: OverloadCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
	aDuplaGalacticaGame
		affect: OverloadCard initializeNew
		targetingPlayer: 'blue'
		atTemporalLocation: 1
		with: SpeedBoostCard initializeNew
		from: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		affect: OverloadCard initializeNew
		targetingPlayer: 'blue'
		atTemporalLocation: 1
		with: CancellationCard initializeNew
		from: 'blue'.
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
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 2.
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
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 9.
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
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 5.
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
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 5.
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
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
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
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
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
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
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
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		affect: ReversePolarityCard initializeNew
		targetingBox: 3
		atTemporalLocation: 1
		with: SpeedBoostCard initializeNew
		from: 'red'.
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
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		affect: ReversePolarityCard initializeNew
		targetingBox: 3
		atTemporalLocation: 1
		with: CancellationCard initializeNew
		from: 'blue'.
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
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame play: RedoCard initializeNew from: 'red' toBox: 6.
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
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		play: RepeatCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 7 with: 5)
]

{ #category : #tests }
CardsTest >> testC042WhenPlayerPlaysTwoReversePolarityCardsOnTheSameSpeedUpBoxThenCheckThatTheEffectWasNotReversedAndValidPlayersPositions [

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
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
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
				                       using: NullEffectCard initializeNew
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
		play: NullEffectCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
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
		play: SpeedCard initializeNew
		from: 'red'
		toPlayer: 'red'.
	aDuplaGalacticaGame
		play: SpeedCard initializeNew
		from: 'red'
		toPlayer: 'red'.
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
		playToEveryone: AccelerationCard initializeNew
		from: 'red'.
	aDuplaGalacticaGame
		playToEveryone: AccelerationCard initializeNew
		from: 'red'.
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
		play: OverloadCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		play: RedoCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
	aDuplaGalacticaGame
		play: RedoCard initializeNew
		from: 'blue'
		toPlayer: 'red'.
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
		play: SpeedCard initializeNew
		from: 'red'
		toPlayer: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		play: RedoCard initializeNew
		from: 'red'
		toPlayer: 'red'.
	aDuplaGalacticaGame
		play: RedoCard initializeNew
		from: 'blue'
		toPlayer: 'blue'.
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
		play: RepeatCard initializeNew
		from: 'red'
		toPlayer: 'red'.
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
		play: RepeatCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
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
		play: RepeatCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testC051WhenPlayerPlaysTwoReversePolarityCardsOnTheSameAtomicBombBoxThenCheckThatTheEffectWasNotReversedAndValidPlayersPositions [

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
					                         (LoadedDie with: #( 2 1 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 1 with: 1)
]

{ #category : #tests }
CardsTest >> testC052WhenPlayerPlaysTwoReversePolarityCardsOnTheSameHyperJumpBoxThenCheckThatTheEffectWasNotReversedAndValidPlayersPositions [

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
					                         (LoadedDie with: #( 2 1 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 7 with: 1)
]

{ #category : #tests }
CardsTest >> testC053WhenPlayerPlaysTwoReversePolarityCardsOnTheSameMoonWalkBoxThenCheckThatTheEffectWasNotReversedAndValidPlayersPositions [

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
					                         (LoadedDie with: #( 2 1 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 3 with: 1)
]

{ #category : #tests }
CardsTest >> testC054WhenPlayerPlaysTwoReversePolarityCardsOnTheSameRandomCardBoxThenCheckThatTheEffectWasNotReversedAndValidPlayersPositions [

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
					                         (LoadedDie with: #( 2 1 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersCardsInPosetion
		equals: (OrderedCollection with: 1 with: 2)
]

{ #category : #tests }
CardsTest >> testC055WhenPlayerPlaysTwoReversePolarityCardsOnTheSameWormHoleBoxThenCheckThatTheEffectWasNotReversedAndValidPlayersPositions [

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
					                         (LoadedDie with: #( 2 1 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 1 with: 1)
]

{ #category : #tests }
CardsTest >> testC056WhenPlayerPlaysTwoReversePolarityCardsOnTheSameSpeedUpBoxThenPlaysACancellationCardToOneReversePolarityCardThenCheckThatTheEffectWasNotReversedAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := OrderedCollection
		                    with: ReversePolarityCard initializeNew
		                    with: ReversePolarityCard initializeNew
		                    with: CancellationCard initializeNew
		                    with: ReversePolarityCard initializeNew
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
					                         (LoadedDie with: #( 2 1 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	aDuplaGalacticaGame
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame
		affect: ReversePolarityCard initializeNew
		targetingBox: 3
		atTemporalLocation: 1
		with: CancellationCard initializeNew
		from: 'blue'.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 3 with: 5)
]

{ #category : #tests }
CardsTest >> testC057WhenPlayerPlaysAReversePolarityCardThenPlaysASpeedBoostCardOnItThenACancellationCardOnItThenCheckThereAreNoBoxesReversedPolarityAndValidPlayersPositions [

	| aDuplaGalacticaGame aCardsCollection aBoxesCollection aBoard |
	aCardsCollection := OrderedCollection
		                    with: ReversePolarityCard initializeNew
		                    with: SpeedBoostCard initializeNew
		                    with: CancellationCard initializeNew
		                    with: ReversePolarityCard initializeNew
		                    with: SpeedBoostCard initializeNew
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
		play: ReversePolarityCard initializeNew
		from: 'red'
		toBox: 3.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		affect: ReversePolarityCard initializeNew
		targetingBox: 3
		atTemporalLocation: 1
		with: SpeedBoostCard initializeNew
		from: 'red'.
	aDuplaGalacticaGame
		affect: ReversePolarityCard initializeNew
		targetingBox: 3
		atTemporalLocation: 1
		with: CancellationCard initializeNew
		from: 'blue'.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 3 with: 7)
]

{ #category : #tests }
CardsTest >> testC058WhenPlayerPlaysACancellationCardOnABoostedPermanentCardWhenThereAreTwoActivePermanentCardsThenCheckThatTheEffectIsNoMoreAppliedAndValidPlayersPositions [

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
		play: OverloadCard initializeNew
		from: 'red'
		toPlayer: 'blue'.
	aDuplaGalacticaGame
		affect: OverloadCard initializeNew
		targetingPlayer: 'blue'
		atTemporalLocation: 1
		with: SpeedBoostCard initializeNew
		from: 'red'.
	aDuplaGalacticaGame movePlayer.
	aDuplaGalacticaGame
		play: OverloadCard initializeNew
		from: 'blue'
		toPlayer: 'blue'.
	aDuplaGalacticaGame
		affect: OverloadCard initializeNew
		targetingPlayer: 'blue'
		atTemporalLocation: 1
		with: SpeedBoostCard initializeNew
		from: 'blue'.
	aDuplaGalacticaGame
		affect: OverloadCard initializeNew
		targetingPlayer: 'blue'
		atTemporalLocation: 1
		with: CancellationCard initializeNew
		from: 'blue'.
	aDuplaGalacticaGame movePlayer.
	self
		assert: aDuplaGalacticaGame playersBox
		equals: (OrderedCollection with: 3 with: 4)
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
				play: OverloadCard initializeNew
				from: 'blue'
				toPlayer: 'red' ]
		raise: Error
		withMessage: 'A permanent card can only be use when it is your turn'
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
				play: RedoCard initializeNew
				from: 'blue'
				toPlayer: 'red' ]
		raise: Error
		withMessage:
		'Redo card cannot be played because there are no cards that have been played before'
]
