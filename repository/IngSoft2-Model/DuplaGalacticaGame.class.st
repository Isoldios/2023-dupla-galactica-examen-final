Class {
	#name : #DuplaGalacticaGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'board',
		'goalLaps',
		'cardManager',
		'playersTurnManager',
		'diceShaker',
		'currentPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #Validation }
DuplaGalacticaGame class >> validateCards: aCardsCollection using: aColorsCollection [

	aCardsCollection size // 2 < aColorsCollection size ifTrue: [ 
		Error signal: 'Cannot create a game with that amount of cards' ]
]

{ #category : #Validation }
DuplaGalacticaGame class >> validateColors: aColorsCollection [

	aColorsCollection size < 2 ifTrue: [ 
		Error signal: 'A game can only be created with two or more players' ].
	aColorsCollection do: [ :colorToTest | 
		(aColorsCollection select: [ :color | color = colorToTest ]) size
		> 1 ifTrue: [ 
			Error signal: 'Cannot create a game with duplicate colors' ] ]
]

{ #category : #Validation }
DuplaGalacticaGame class >> validateLaps: aNumberOfLaps [

	aNumberOfLaps > 0 ifFalse: [ 
		Error signal:
			'Cannot create a game with a nagative value of goal laps' ]
]

{ #category : #'Instance creation' }
DuplaGalacticaGame class >> with: aColorsCollection and: aBoard usingToThrow: aDiceShaker winningWhenReach: aNumberOfLaps using: aCardsCollection [

	self validateColors: aColorsCollection.
	self validateLaps: aNumberOfLaps.
	self validateCards: aCardsCollection using: aColorsCollection.
	^ self new
		  initializeWith: aColorsCollection
		  and: aBoard
		  usingToThrow: aDiceShaker
		  winningWhenReach: aNumberOfLaps
		  using: aCardsCollection
]

{ #category : #Cards }
DuplaGalacticaGame >> add: aCardInAPlayerHand [

	cardManager add: aCardInAPlayerHand
]

{ #category : #Cards }
DuplaGalacticaGame >> addToOthers: aCardInAPlayerHand [

	(players reject: [ :player | player color == self currentPlayer ]) 
		do: [ :player | 
			cardManager add: (CardHolder of: player color with: aCardInAPlayerHand) ]
]

{ #category : #Cards }
DuplaGalacticaGame >> apply: aCardInAPlayerHand to: anObjective [

	self canBeUse: aCardInAPlayerHand.
	cardManager apply: aCardInAPlayerHand to: anObjective at: self
]

{ #category : #Information }
DuplaGalacticaGame >> boardLength [

	^ board length
]

{ #category : #Information }
DuplaGalacticaGame >> boxesByParsecs [

	^ board boxesByParsecs
]

{ #category : #Validation }
DuplaGalacticaGame >> canBeUse: aCardInAPlayerHand [

	((aCardInAPlayerHand card isPermanent and:
		  aCardInAPlayerHand holder = self currentPlayer) or:
		 aCardInAPlayerHand card isPermanent not) ifFalse: [ 
		Error signal:
			'A permanent card can only be use when it is your turn' ]
]

{ #category : #Boxes }
DuplaGalacticaGame >> changePolarityOf: aBox [

	board changePolarityOf: aBox
]

{ #category : #Validation }
DuplaGalacticaGame >> check: aCardHolderPlayerColor canPlay: aCard [

	((aCard isPermanent and: aCardHolderPlayerColor = self currentPlayer) 
		 or: aCard isPermanent not) ifFalse: [ 
		Error signal:
			'A permanent card can only be use when it is your turn' ]
]

{ #category : #Boxes }
DuplaGalacticaGame >> checkPolarity [

	board checkPolarityAt: self of: cardManager
]

{ #category : #Information }
DuplaGalacticaGame >> currentPlayer [

	^ currentPlayer color
]

{ #category : #Information }
DuplaGalacticaGame >> diceAmount [

	^ diceShaker diceAmount
]

{ #category : #Information }
DuplaGalacticaGame >> goalLaps [

	^ goalLaps
]

{ #category : #Initialization }
DuplaGalacticaGame >> initializeWith: aColorsCollection and: aBoard usingToThrow: aDiceShaker winningWhenReach: aNumberOfLaps using: aCardsCollection [

	players := aColorsCollection collect: [ :color | Player with: color ].
	board := aBoard.
	diceShaker := aDiceShaker.
	playersTurnManager := QueueManager with: players.
	currentPlayer := playersTurnManager current.
	goalLaps := aNumberOfLaps.
	cardManager := CardManager
		               using: aCardsCollection
		               with: aColorsCollection
]

{ #category : #Boxes }
DuplaGalacticaGame >> moveAllToTheStart [

	players do: [ :player | player moveToTheBeginning]
]

{ #category : #Boxes }
DuplaGalacticaGame >> moveCurrent: aValue [

	currentPlayer move: aValue andUpdateLap: self boardLength
]

{ #category : #Boxes }
DuplaGalacticaGame >> moveOthers: aValue [

	(players reject: [ :player | player color == self currentPlayer ]) 
		do: [ :player | player move: aValue andUpdateLap: self boardLength ]
]

{ #category : #Player }
DuplaGalacticaGame >> movePlayer [

	| boxesToMove |
	self winnerExists ifTrue: [ 
		Error signal: 'The game has finished because someone won' ].
	boxesToMove := diceShaker throwDice
	               + (cardManager calculateEffectOn: currentPlayer color).
	currentPlayer move: boxesToMove andUpdateLap: self boardLength.
	self checkPolarity.
	board effectAt: currentPlayer box In: self.
	currentPlayer := playersTurnManager goNext current
]

{ #category : #Information }
DuplaGalacticaGame >> parsecsMeasure [

	^ board parsecs
]

{ #category : #Cards }
DuplaGalacticaGame >> play: aCard from: aCardHolderPlayerColor toPlayer: anObjectiveColorPlayer [

	self check: aCardHolderPlayerColor canPlay: aCard.
	cardManager
		play: aCard
		from: aCardHolderPlayerColor
		toPlayer: anObjectiveColorPlayer
		at: self
]

{ #category : #Information }
DuplaGalacticaGame >> playersBox [

	^ players collect: [ :player | player box ]
]

{ #category : #Information }
DuplaGalacticaGame >> playersCardsInPosetion [

	^ cardManager cardsInPosetionOf: players
]

{ #category : #Information }
DuplaGalacticaGame >> playersColors [

	^ players collect: [ :player | player color ]
]

{ #category : #Information }
DuplaGalacticaGame >> playersLaps [

	^ players collect: [ :player | player lap ]
]

{ #category : #Information }
DuplaGalacticaGame >> ranking [

	| ranking |
	ranking := players collect: [ :player | player ].
	ranking sort: [ :player1 :player2 | 
		player1 aheadOf: player2 ].
	^ ranking collect: [ :player | player color ]
]

{ #category : #Cards }
DuplaGalacticaGame >> repeatEffectTo: anObjectivePlayerColor [

	currentPlayer := players detect: [ :player | 
		           player color = anObjectivePlayerColor ].
	self checkPolarity.
	board effectAt: board lastBoxInvoked In: self.
	currentPlayer := playersTurnManager current
]

{ #category : #Finalization }
DuplaGalacticaGame >> winner [

	self winnerExists
		ifTrue: [ 
		^ (players detect: [ :player | player lap >= self goalLaps ]) color ]
		ifFalse: [ Error signal: 'There is no winner' ]
]

{ #category : #Finalization }
DuplaGalacticaGame >> winnerExists [

	^ players anySatisfy: [ :player | player lap >= self goalLaps ]
]
