Class {
	#name : #DuplaGalacticaGameFinalVersionTest,
	#superclass : #TestCase,
	#instVars : [
		'aLoadedDie',
		'aColorsCollection',
		'aBoard',
		'aCardsCollection'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #Games }
DuplaGalacticaGameFinalVersionTest >> createDuplaGalacticaGameFinalVersion [

	| anotherBoard aBoxesCollection boxesProbabilities anotherCardsCollection cardsProbabilities |
	cardsProbabilities := OrderedCollection
		                      with: (ObjectProbability
				                       using: AccelerationCard initializeNew
				                       withChanceOf: 12.5)
		                      with: (ObjectProbability
				                       using: OverloadCard initializeNew
				                       withChanceOf: 12.5)
		                      with: (ObjectProbability
				                       using: ReversePolarityCard initializeNew
				                       withChanceOf: 12.5)
		                      with: (ObjectProbability
				                       using: CancellationCard initializeNew
				                       withChanceOf: 12.5)
		                      with:
		                      (ObjectProbability
			                       using: RedoCard initializeNew
			                       withChanceOf: 12.5)
		                      with:
		                      (ObjectProbability
			                       using: RepeatCard initializeNew
			                       withChanceOf: 12.5).
	cardsProbabilities addLast: (ObjectProbability
			 using: SpeedBoostCard initializeNew
			 withChanceOf: 12.5).
	cardsProbabilities addLast:
		(ObjectProbability using: SpeedCard initializeNew withChanceOf: 12.5).
	anotherCardsCollection := (ObjectCreator use: cardsProbabilities) 
		                          create: 4.
	boxesProbabilities := OrderedCollection
		                      with:
		                      (ObjectProbability
			                       using: NullBox initializeNew
			                       withChanceOf: 30)
		                      with:
		                      (ObjectProbability
			                       using: WormHoleBox initializeNew
			                       withChanceOf: 20)
		                      with:
		                      (ObjectProbability
			                       using: SpeedUpBox initializeNew
			                       withChanceOf: 20)
		                      with:
		                      (ObjectProbability
			                       using: (MoonWalkBox with: -2)
			                       withChanceOf: 10)
		                      with:
		                      (ObjectProbability
			                       using: AtomicBombBox initializeNew
			                       withChanceOf: 2)
		                      with: (ObjectProbability
				                       using:
					                       (HyperJumpBox with: (OrderedCollection
							                         with: (ParsecMeasure worth: 40)
							                         with: (ParsecMeasure worth: 30)))
				                       withChanceOf: 8).
	boxesProbabilities addLast: (ObjectProbability
			 using:
				 (RandomCardBox with: (OrderedCollection with: (ObjectProbability
							    using: CancellationCard initializeNew
							    withChanceOf: 100)))
			 withChanceOf: 10).
	aBoxesCollection := (ObjectCreator use: boxesProbabilities) create:
		                    10.
	anotherBoard := Board
		                with: aBoxesCollection
		                measure: (ParsecMeasure worth: 200).
	^ DuplaGalacticaGameProxy
		  with: aColorsCollection
		  and: anotherBoard
		  usingToThrow:
		  (DiceShaker with: (OrderedCollection with: aLoadedDie))
		  winningWhenReach: 1
		  using: anotherCardsCollection
]

{ #category : #running }
DuplaGalacticaGameFinalVersionTest >> setUp [

	super setUp.

	aColorsCollection := OrderedCollection with: 'red' with: 'blue'.
	aLoadedDie := LoadedDie with: #( 1 2 3 4 ).
	aBoard := Board
		          with: (OrderedCollection
				           with: NullBox initializeNew
				           with: NullBox initializeNew
				           with: NullBox initializeNew
				           with: NullBox initializeNew)
		          measure: (ParsecMeasure worth: 200).
	aCardsCollection := OrderedCollection
		                    with: NullCard initializeNew
		                    with: NullCard initializeNew
		                    with: NullCard initializeNew
		                    with: NullCard initializeNew
]

{ #category : #tests }
DuplaGalacticaGameFinalVersionTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
DuplaGalacticaGameFinalVersionTest >> testI001WhenAGameIsCreatedWithABoardWhoseBoxesHaveRandomEffectsThenValidBoardBoxesSize [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self createDuplaGalacticaGameFinalVersion.
	self assert: aDuplaGalacticaGame boardLength identicalTo: 10
]

{ #category : #tests }
DuplaGalacticaGameFinalVersionTest >> testI002WhenAGameIsCreatedWithRandomCardsProbabilitiesThenValidPlayersCardsInPosetion [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self createDuplaGalacticaGameFinalVersion.
	self
		assert: aDuplaGalacticaGame playersCardsInPosetion
		equals: (OrderedCollection with: 2 with: 2)
]

{ #category : #tests }
DuplaGalacticaGameFinalVersionTest >> testI003WhenAGameIsCreatedThenValidGoalLaps [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self createDuplaGalacticaGameFinalVersion.
	self assert: aDuplaGalacticaGame goalLaps identicalTo: 1
]

{ #category : #tests }
DuplaGalacticaGameFinalVersionTest >> testI004WhenAGameIsCreatedThenValidShakerDiceAmount [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self createDuplaGalacticaGameFinalVersion.
	self assert: aDuplaGalacticaGame diceAmount identicalTo: 1
]

{ #category : #tests }
DuplaGalacticaGameFinalVersionTest >> testJ001TryToCreateAGameWithAnEmptyColorsCollectionThenFails [

	self
		should: [ 
			DuplaGalacticaGameProxy
				with: (OrderedCollection with: 'red')
				and: aBoard
				usingToThrow:
				(DiceShaker with: (OrderedCollection with: aLoadedDie))
				winningWhenReach: 1
				using: aCardsCollection ]
		raise: Error
		withMessage: 'A game can only be created with two or more players'
]

{ #category : #tests }
DuplaGalacticaGameFinalVersionTest >> testJ002TryToCreateAGameWithANegativeAmountOfGoalLapsThenFails [

	self
		should: [ 
			DuplaGalacticaGameProxy
				with: aColorsCollection
				and: aBoard
				usingToThrow:
				(DiceShaker with: (OrderedCollection with: aLoadedDie))
				winningWhenReach: -1
				using: aCardsCollection ]
		raise: Error
		withMessage:
		'Cannot create a game with a nagative value of goal laps'
]

{ #category : #tests }
DuplaGalacticaGameFinalVersionTest >> testJ003TryToCreateAGameWithALessOrEqualToZeroAmountOfParsecsMeasureThenFails [

	self
		should: [ 
			DuplaGalacticaGameProxy
				with: aColorsCollection
				and: (Board
						 with: (OrderedCollection
								  with: NullBox initializeNew
								  with: NullBox initializeNew
								  with: NullBox initializeNew
								  with: NullBox initializeNew)
						 measure: (ParsecMeasure worth: 0))
				usingToThrow:
				(DiceShaker with: (OrderedCollection with: aLoadedDie))
				winningWhenReach: 1
				using: aCardsCollection ]
		raise: Error
		withMessage:
		'Cannot create a game with that parsec or lightYear value'.
	self
		should: [ 
			DuplaGalacticaGameProxy
				with: aColorsCollection
				and: (Board
						 with: (OrderedCollection
								  with: NullBox initializeNew
								  with: NullBox initializeNew
								  with: NullBox initializeNew
								  with: NullBox initializeNew)
						 measure: (ParsecMeasure worth: -50))
				usingToThrow:
				(DiceShaker with: (OrderedCollection with: aLoadedDie))
				winningWhenReach: 1
				using: aCardsCollection ]
		raise: Error
		withMessage:
		'Cannot create a game with that parsec or lightYear value'
]

{ #category : #tests }
DuplaGalacticaGameFinalVersionTest >> testJ004TryToCreateAGameWithDuplicatedColorsThenFails [

	self
		should: [ 
			DuplaGalacticaGameProxy
				with: (OrderedCollection with: 'red' with: 'red')
				and: aBoard
				usingToThrow:
				(DiceShaker with: (OrderedCollection with: aLoadedDie))
				winningWhenReach: 1
				using: aCardsCollection ]
		raise: Error
		withMessage: 'Cannot create a game with duplicate colors'
]

{ #category : #tests }
DuplaGalacticaGameFinalVersionTest >> testJ005TryToCreateABoxesCollectionWithMoreThan100PercentProbabilityOfBoxAppearancesThenFails [

	self
		should: [ 
			ObjectCreator use: (OrderedCollection
					 with:
					 (ObjectProbability
						  using: AtomicBombBox initializeNew
						  withChanceOf: 60)
					 with:
					 (ObjectProbability
						  using: SpeedUpBox initializeNew
						  withChanceOf: 70)) ]
		raise: Error
		withMessage: 'The sum of probabilities must be 100'
]

{ #category : #tests }
DuplaGalacticaGameFinalVersionTest >> testJ006TryToCreateACardsCollectionWithMoreThan100PercentProbabilityOfCardAppearancesThenFails [

	self
		should: [ 
			ObjectCreator use: (OrderedCollection
					 with:
					 (ObjectProbability
						  using: OverloadCard initializeNew
						  withChanceOf: 80)
					 with:
					 (ObjectProbability
						  using: SpeedCard initializeNew
						  withChanceOf: 70)) ]
		raise: Error
		withMessage: 'The sum of probabilities must be 100'
]

{ #category : #tests }
DuplaGalacticaGameFinalVersionTest >> testJ014TryToCreateLessOrEqualToZeroObjectsThenFails [

	| anObjectCreator |
	anObjectCreator := ObjectCreator use: (OrderedCollection with:
			                    (ObjectProbability
				                     using: NullBox initializeNew
				                     withChanceOf: 100)).
	self
		should: [ anObjectCreator create: 0 ]
		raise: Error
		withMessage:
		'The amount of objects to create must be greater than zero'.
	self
		should: [ anObjectCreator create: -5 ]
		raise: Error
		withMessage:
		'The amount of objects to create must be greater than zero'
]

{ #category : #tests }
DuplaGalacticaGameFinalVersionTest >> testJ015TryToCreateANotANumberAmountOfObjectsThenFails [

	| anObjectCreator |
	anObjectCreator := ObjectCreator use: (OrderedCollection with:
			                    (ObjectProbability
				                     using: NullBox initializeNew
				                     withChanceOf: 100)).
	self
		should: [ anObjectCreator create: 'pepito' ]
		raise: Error
		withMessage: 'The amount of objects to create must be a number'
]
