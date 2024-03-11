Class {
	#name : #CreateAFunctionalDuplaGalacticaGameTest,
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
CreateAFunctionalDuplaGalacticaGameTest >> createGameWithBoxEffects [

	| aBoard1 aBoxCreator aBoxesCollection boxesProbabilities aCardsCollection1 |
	aCardsCollection1 := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NoEffectCard initializeNew
				                       withChanceOf: 100))) create: 4.
	boxesProbabilities := OrderedCollection
		                      with:
		                      (ObjectProbability
			                       using: NoEffectBox initializeNew
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
	aBoxCreator := ObjectCreator use: boxesProbabilities.
	aBoxesCollection := aBoxCreator create: 10.
	aBoard1 := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 200).
	^ DuplaGalacticaGameProxy
		  with: aColorsCollection
		  and: aBoard1
		  usingToThrow:
		  (DiceShaker with: (OrderedCollection with: aLoadedDie))
		  winningWhenReach: 1
		  using: aCardsCollection1
]

{ #category : #Games }
CreateAFunctionalDuplaGalacticaGameTest >> createGameWithRandomCards [

	| aBoard1 aBoxesCollection cardsProbabilities aCardsCollection1 |
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
	aCardsCollection1 := (ObjectCreator use: cardsProbabilities) create: 4.
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NoEffectBox initializeNew
				                       withChanceOf: 100))) create: 10.
	aBoard1 := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 200).
	^ DuplaGalacticaGameProxy
		  with: aColorsCollection
		  and: aBoard1
		  usingToThrow:
		  (DiceShaker with: (OrderedCollection with: aLoadedDie))
		  winningWhenReach: 1
		  using: aCardsCollection1
]

{ #category : #running }
CreateAFunctionalDuplaGalacticaGameTest >> setUp [

	super setUp.

	aColorsCollection := OrderedCollection with: 'red' with: 'blue'.
	aLoadedDie := LoadedDie with: #( 1 2 3 4 ).
	aBoard := Board
		          with: (OrderedCollection
				           with: NoEffectBox initializeNew
				           with: NoEffectBox initializeNew
				           with: NoEffectBox initializeNew
				           with: NoEffectBox initializeNew)
		          measure: (ParsecMeasure worth: 200).
	aCardsCollection := OrderedCollection
		                    with: NoEffectCard initializeNew
		                    with: NoEffectCard initializeNew
		                    with: NoEffectCard initializeNew
		                    with: NoEffectCard initializeNew
]

{ #category : #tests }
CreateAFunctionalDuplaGalacticaGameTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
CreateAFunctionalDuplaGalacticaGameTest >> testP001WhenAGameIsCreatedWithABoardWhoseBoxesHaveRandomEffectsThenValidBoardBoxesSize [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self createGameWithBoxEffects.
	self assert: aDuplaGalacticaGame boardLength identicalTo: 10
]

{ #category : #tests }
CreateAFunctionalDuplaGalacticaGameTest >> testP002WhenAGameIsCreatedWithRandomCardsProbabilitiesThenValidPlayersCardsInPosetion [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self createGameWithRandomCards.
	self
		assert: aDuplaGalacticaGame playersCardInPosetion
		equals: (OrderedCollection with: 2 with: 2)
]

{ #category : #tests }
CreateAFunctionalDuplaGalacticaGameTest >> testP003WhenAGameIsCreatedThenMovePlayersOneTimeAndValidPlayersTurn [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self createGameWithBoxEffects.
	aDuplaGalacticaGame movePlayer.
	self assert: aDuplaGalacticaGame currentPlayer equals: 'blue'
]

{ #category : #tests }
CreateAFunctionalDuplaGalacticaGameTest >> testP004WhenAGameIsCreatedThenValidGoalLaps [

	| aDuplaGalacticaGame |
	aDuplaGalacticaGame := self createGameWithBoxEffects.
	self assert: aDuplaGalacticaGame goalLaps identicalTo: 1
]

{ #category : #tests }
CreateAFunctionalDuplaGalacticaGameTest >> testP017TryToCreateAGameWithAnEmptyColorsCollectionThenFails [

	self
		should: [ 
			DuplaGalacticaGameProxy
				with: OrderedCollection new
				and: aBoard
				usingToThrow:
				(DiceShaker with: (OrderedCollection with: aLoadedDie))
				winningWhenReach: 1
				using: aCardsCollection ]
		raise: Error
		withMessage: 'Cannot create a game with no players'
]

{ #category : #tests }
CreateAFunctionalDuplaGalacticaGameTest >> testP018TryToCreateAGameWithANegativeAmountOfGoalLapsThenFails [

	self
		should: [ 
			DuplaGalacticaGame
				with: aColorsCollection
				and: aBoard
				usingToThrow:
				(DiceShaker with: (OrderedCollection with: aLoadedDie))
				winningWhenReach: -1
				using: aCardsCollection ]
		raise: Error
		withMessage: 'Cannot create a game with that goal laps'
]

{ #category : #tests }
CreateAFunctionalDuplaGalacticaGameTest >> testP019TryToCreateAGameWithALessOrEqualToZeroAmountOfParsecsMeasureThenFails [

	self
		should: [ 
			DuplaGalacticaGameProxy
				with: aColorsCollection
				and: (Board
						 with: (OrderedCollection
								  with: NoEffectBox initializeNew
								  with: NoEffectBox initializeNew
								  with: NoEffectBox initializeNew
								  with: NoEffectBox initializeNew)
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
								  with: NoEffectBox initializeNew
								  with: NoEffectBox initializeNew
								  with: NoEffectBox initializeNew
								  with: NoEffectBox initializeNew)
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
CreateAFunctionalDuplaGalacticaGameTest >> testP020TryToCreateAGameWithDuplicatedColorsThenFails [

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
CreateAFunctionalDuplaGalacticaGameTest >> testP021TryToCreateABoxesCollectionWithMoreThan100PercentProbabilityOfBoxAppearancesThenFails [

	self
		should: [ 
			ObjectCreator use: (OrderedCollection with:
					 (ObjectProbability
						  using: NoEffectBox initializeNew
						  withChanceOf: 130)) ]
		raise: Error
		withMessage: 'The sum of probabilities must be 100'
]

{ #category : #tests }
CreateAFunctionalDuplaGalacticaGameTest >> testP022TryToCreateACardsCollectionWithMoreThan100PercentProbabilityOfCardAppearancesThenFails [

	self
		should: [ 
			ObjectCreator use: (OrderedCollection with:
					 (ObjectProbability
						  using: NoEffectCard initializeNew
						  withChanceOf: 130)) ]
		raise: Error
		withMessage: 'The sum of probabilities must be 100'
]

{ #category : #tests }
CreateAFunctionalDuplaGalacticaGameTest >> testP023TryToCreateAnObjectWithANonObjectProbabilitiesCollectionThenFails [

	self
		should: [ ObjectCreator use: 1 ]
		raise: Error
		withMessage: 'That is not an object probabilities collection'.
	self
		should: [ ObjectCreator use: 'p' ]
		raise: Error
		withMessage: 'That is not an object probabilities collection'
]

{ #category : #tests }
CreateAFunctionalDuplaGalacticaGameTest >> testP024TryToCreateAnObjectWithoutObjectProbabilitiesThenFails [

	self
		should: [ ObjectCreator use: (OrderedCollection with: 1) ]
		raise: Error
		withMessage: 'That is not a valid object probability'.
	self
		should: [ ObjectCreator use: (OrderedCollection with: 'p') ]
		raise: Error
		withMessage: 'That is not a valid object probability'
]

{ #category : #tests }
CreateAFunctionalDuplaGalacticaGameTest >> testP025TryToCreateAnObjectProbabilityThatIsNeitherACardNorABoxThenFails [

	self
		should: [ ObjectProbability using: PlayerHand new withChanceOf: 100 ]
		raise: Error
		withMessage: 'That object is neither a card nor a box'
]
