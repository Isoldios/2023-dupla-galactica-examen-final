Class {
	#name : #DuplaGalacticaGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'board',
		'goalLaps',
		'turnManager',
		'current',
		'cardManager',
		'shaker'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
DuplaGalacticaGame class >> with: aColorsCollection and: aBoard usingToThrow: aDiceShaker winningWhenReach: aNumberOfLaps using: aCardsCollection [

	aColorsCollection isEmpty ifTrue: [ 
		Error signal: 'Cannot create a game with no players' ].
	aColorsCollection do: [ :colorToTest | 
		(aColorsCollection select: [ :color | color = colorToTest ]) size
		> 1 ifTrue: [ 
			Error signal: 'Cannot create a game with duplicate colors' ] ].
	aNumberOfLaps <= 0 ifTrue: [ 
		Error signal: 'Cannot create a game with that goal laps' ].
	(aCardsCollection isKindOf: OrderedCollection) ifFalse: [ 
		Error signal: 'That is not a cards collection' ].
	aCardsCollection size // 2 < aColorsCollection size ifTrue: [ 
		Error signal: 'Cannot create a game with that amount of cards' ].
	aCardsCollection do: [ :card | 
		[ card isPermanent ]
			on: MessageNotUnderstood
			do: [ Error signal: 'That is not a valid card' ] ].
	^ self new
		  initializeWith: aColorsCollection
		  and: aBoard
		  usingToThrow: aDiceShaker
		  winningWhen: aNumberOfLaps
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
			cardManager add: (PlayerHand of: player color with: aCardInAPlayerHand) ]
]

{ #category : #Cards }
DuplaGalacticaGame >> apply: aCardInAPlayerHand to: anObjective [

	self isValidCardInAHand: aCardInAPlayerHand.
	self canBeUse: aCardInAPlayerHand.
	cardManager apply: aCardInAPlayerHand to: anObjective at: self
]

{ #category : #Information }
DuplaGalacticaGame >> boardLength [

	^ board length
]

{ #category : #Information }
DuplaGalacticaGame >> boxesByParsecs [

	^ self parsecs nominalValue // self boardLength
]

{ #category : #Validation }
DuplaGalacticaGame >> canBeUse: aCardInAPlayerHand [

	(((cardManager isValidCardObjective: aCardInAPlayerHand) isPermanent 
		  and: aCardInAPlayerHand holder = self currentPlayer) or:
		 aCardInAPlayerHand card isPermanent not) ifFalse: [ 
		Error signal:
			'A permanent card can only be use when it is your turn' ]
]

{ #category : #Boxes }
DuplaGalacticaGame >> changePolarityOf: aBoxNumber [

	board changePolarityOf: aBoxNumber
]

{ #category : #Boxes }
DuplaGalacticaGame >> checkPolarity [

	cardManager checkPolarityAt: self
]

{ #category : #Information }
DuplaGalacticaGame >> currentPlayer [

	^ current color
]

{ #category : #Information }
DuplaGalacticaGame >> goalLaps [

	^ goalLaps
]

{ #category : #Initialization }
DuplaGalacticaGame >> initializeWith: aColorsCollection and: aBoard usingToThrow: aDiceShaker winningWhen: reachAValue using: aCardsCollection [

	players := aColorsCollection collect: [ :color | Player with: color ].
	board := aBoard.
	shaker := aDiceShaker.
	turnManager := QueueManager with: players.
	current := turnManager current.
	goalLaps := reachAValue.
	cardManager := CardManager using: aCardsCollection with: aColorsCollection
]

{ #category : #Validation }
DuplaGalacticaGame >> isValidBox: aBoxNumber [

	aBoxNumber isNumber
		ifTrue: [ 
			(aBoxNumber <= self boardLength and: aBoxNumber > 0) ifFalse: [ 
				Error signal: 'That is not a valid box number' ] ]
		ifFalse: [ Error signal: 'That is not a box number' ]
]

{ #category : #Validation }
DuplaGalacticaGame >> isValidCardInAHand: aCardInAPlayerHand [

	self playersColors
		detect: [ :color | 
			[ color = aCardInAPlayerHand holder ]
				on: MessageNotUnderstood
				do: [ Error signal: 'That is not a valid card to apply' ] ]
		ifNone: [ Error signal: 'That player does not exist' ]
]

{ #category : #Validation }
DuplaGalacticaGame >> isValidPlayer: anObjectivePlayerColor [

	self playersColors
		detect: [ :color | color = anObjectivePlayerColor ]
		ifFound: [ ^ true ]
		ifNone: [ Error signal: 'That is not a valid player objective' ]
]

{ #category : #Information }
DuplaGalacticaGame >> lightYears [

	^ board lightYears
]

{ #category : #Boxes }
DuplaGalacticaGame >> moveAllToTheStart [

	players do: [ :player | player moveToTheBeginning]
]

{ #category : #Boxes }
DuplaGalacticaGame >> moveCurrent: aValue [

	current move: aValue andUpdateLap: self boardLength
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
	boxesToMove := shaker throwDice
	               + (cardManager calculateEffectOn: current color).
	current move: boxesToMove andUpdateLap: self boardLength.
	self checkPolarity.
	board effectAt: current box In: self.
	board resetPolarities.
	turnManager goNext.
	current := turnManager current
]

{ #category : #Information }
DuplaGalacticaGame >> parsecs [

	^ board parsecs
]

{ #category : #Information }
DuplaGalacticaGame >> playersBox [

	^ players collect: [ :player | player box ]
]

{ #category : #Information }
DuplaGalacticaGame >> playersCardInPosetion [

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

	current := players detect: [ :player | 
		           player color = anObjectivePlayerColor ].
	self checkPolarity.
	board effectAt: board lastBoxInvoked In: self.
	current := turnManager current
]

{ #category : #Finalization }
DuplaGalacticaGame >> winner [

	self winnerExists
		ifTrue: [ 
			^ (players detect: [ :player | self wins: player ])
				  color ]
		ifFalse: [ Error signal: 'There is no winner' ]
]

{ #category : #Finalization }
DuplaGalacticaGame >> winnerExists [

	^ players anySatisfy: [ :player | self wins: player ]
]

{ #category : #Finalization }
DuplaGalacticaGame >> wins: aPlayer [

	^ aPlayer lap >= self goalLaps
]
