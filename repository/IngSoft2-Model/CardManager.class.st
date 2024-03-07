Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'lastCardPlay',
		'activeCardsDeck',
		'cardsInPosetionDeck'
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

	(self hasBeenGiven: aCardInAPlayerHand) ifFalse: [ 
		Error signal: 'The player does not have that card in posetion' ].
	aCardInAPlayerHand card haveEffect ifTrue: [ 
		lastCardPlay := aCardInAPlayerHand card ].
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
CardManager >> canBeUse: aCardInAPlayerHand whenPlay: aPlayerColor [

	^ ((self isValidCard: aCardInAPlayerHand) isPermanent and:
		   aCardInAPlayerHand holder = aPlayerColor) or:
		  aCardInAPlayerHand card isPermanent not
]

{ #category : #Information }
CardManager >> cardsInPosetionOf: aPlayersCollection [

	^ cardsInPosetionDeck cardsOf: aPlayersCollection
]

{ #category : #Managing }
CardManager >> checkPolarityAt: aDuplaGalacticaGame [

	activeCardsDeck checkPolarityAt: aDuplaGalacticaGame
]

{ #category : #Initialization }
CardManager >> deal: aCardsCollection to: aColorsCollection [

	| cardsPerColor |
	cardsPerColor := aCardsCollection size // aColorsCollection size.
	aColorsCollection do: [ :color | 
		cardsPerColor timesRepeat: [ 
			self add: (PlayerHand of: color with: aCardsCollection removeLast) ] ]
]

{ #category : #Managing }
CardManager >> desactivate: anObjectiveCardInAPlayerHand [

	activeCardsDeck desactivate: anObjectiveCardInAPlayerHand
]

{ #category : #Managing }
CardManager >> duplicateEffectOf: anObjectiveCardInAPlayerHand [

	activeCardsDeck duplicateEffectOf: anObjectiveCardInAPlayerHand
]

{ #category : #Information }
CardManager >> hasBeenGiven: aCardInAPlayerHand [

	^ cardsInPosetionDeck hasBeenGiven: aCardInAPlayerHand
]

{ #category : #Initialization }
CardManager >> initializeUsing: aCardsCollection with: aColorsCollection [

	lastCardPlay := NoEffectCard initializeNew.
	activeCardsDeck := ActiveCardsDeck createDeck.
	cardsInPosetionDeck := CardsInPosetionDeck createDeck.
	self deal: aCardsCollection to: aColorsCollection
]

{ #category : #Information }
CardManager >> isValidCard: anObjectiveCardInAPlayerHand [

	^ [ anObjectiveCardInAPlayerHand card ]
		  on: MessageNotUnderstood
		  do: [ Error signal: 'That is not a valid card objective' ]
]

{ #category : #Information }
CardManager >> lastCardPlay [

	^ lastCardPlay
]
