Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'activeCardsDeck',
		'cardsInPosetionDeck',
		'lastCardPlayed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
CardManager class >> using: aCardsCollection with: aColorsCollection [

	^ self new initializeUsing: aCardsCollection with: aColorsCollection
]

{ #category : #Managing }
CardManager >> activate: aCardInAPlayerHand [

	activeCardsDeck activate: aCardInAPlayerHand
]

{ #category : #Managing }
CardManager >> add: aCardInAPlayerHand [

	cardsInPosetionDeck add: aCardInAPlayerHand
]

{ #category : #Managing }
CardManager >> apply: aCardInAPlayerHand to: anObjective at: aDuplaGalacticaGame [

	cardsInPosetionDeck hasBeenGiven: aCardInAPlayerHand.
	aCardInAPlayerHand card haveEffect ifTrue: [ 
		lastCardPlayed := aCardInAPlayerHand card ].
	aCardInAPlayerHand card
		applyCardUsing: self
		to: anObjective
		at: aDuplaGalacticaGame.
	cardsInPosetionDeck takeOut: aCardInAPlayerHand
]

{ #category : #Managing }
CardManager >> calculateEffectOn: aColorPlayer [

	^ activeCardsDeck calculateEffectOn: aColorPlayer
]

{ #category : #Information }
CardManager >> cardsInPosetionOf: aPlayersCollection [

	^ cardsInPosetionDeck cardsOf: aPlayersCollection
]

{ #category : #Managing }
CardManager >> checkPolarityAt: aDuplaGalacticaGame of: aBoxesCollection [

	activeCardsDeck checkPolarityAt: aDuplaGalacticaGame of: aBoxesCollection
]

{ #category : #Initialization }
CardManager >> deal: aCardsCollection to: aColorsCollection [

	| cardsPerColor |
	cardsPerColor := aCardsCollection size // aColorsCollection size.
	aColorsCollection do: [ :color | 
		cardsPerColor timesRepeat: [ 
			self add: (PlayerHand of: color with: aCardsCollection removeFirst) ] ]
]

{ #category : #Managing }
CardManager >> desactivate: anObjectiveCardInAPlayerHand [

	self isValidCardObjective: anObjectiveCardInAPlayerHand.
	activeCardsDeck desactivate: anObjectiveCardInAPlayerHand
]

{ #category : #Managing }
CardManager >> duplicateEffectOf: anObjectiveCardInAPlayerHand [

	self isValidCardObjective: anObjectiveCardInAPlayerHand.
	activeCardsDeck duplicateEffectOf: anObjectiveCardInAPlayerHand
]

{ #category : #Initialization }
CardManager >> initializeUsing: aCardsCollection with: aColorsCollection [

	lastCardPlayed := NullCard initializeNew.
	activeCardsDeck := ActiveCardsInPlayersHandsDeck createDeck.
	cardsInPosetionDeck := CardsInPlayersHandsDeck createDeck.
	self deal: aCardsCollection to: aColorsCollection
]

{ #category : #Validation }
CardManager >> isValidCardObjective: anObjectiveCardInAPlayerHand [

	^ [ anObjectiveCardInAPlayerHand card ]
		  on: MessageNotUnderstood
		  do: [ Error signal: 'That is not a valid card objective' ]
]

{ #category : #Information }
CardManager >> lastCardPlay [

	^ lastCardPlayed
]
