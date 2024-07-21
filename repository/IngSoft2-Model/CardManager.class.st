Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'cardsInPosetionDeck',
		'lastCardPlayed',
		'activeCardsTargetingPlayersDeck',
		'activeCardsTargetingBoxesDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
CardManager class >> using: aCardsCollection with: aColorsCollection [

	^ self new initializeUsing: aCardsCollection with: aColorsCollection
]

{ #category : #Cards }
CardManager >> activateToBox: aCardTargetingBox [

	activeCardsTargetingBoxesDeck activateToBox: aCardTargetingBox
]

{ #category : #Cards }
CardManager >> activateToPlayer: aCardTargetingPlayer [

	activeCardsTargetingPlayersDeck activateToPlayer:
		aCardTargetingPlayer
]

{ #category : #Cards }
CardManager >> add: aCardWithAHolderPlayerColor [

	cardsInPosetionDeck add: aCardWithAHolderPlayerColor
]

{ #category : #Cards }
CardManager >> affect: anObjectiveCard targetingBox: anObjectiveBox atTemporalLocation: aPlayedCardOrder with: aCard from: aCardHolderPlayerColor [

	aCard haveEffect ifTrue: [ lastCardPlayed := aCard ].
	aCard
		affect: anObjectiveCard
		targetingBox: anObjectiveBox
		atTemporalLocation: aPlayedCardOrder
		at: self.
	cardsInPosetionDeck takeOut: aCard from: aCardHolderPlayerColor
]

{ #category : #Cards }
CardManager >> affect: anObjectiveCard targetingPlayer: anObjectiveColorPlayer atTemporalLocation: aPlayedCardOrder with: aCard from: aCardHolderPlayerColor [

	aCard haveEffect ifTrue: [ lastCardPlayed := aCard ].
	aCard
		affect: anObjectiveCard
		targetingPlayer: anObjectiveColorPlayer
		atTemporalLocation: aPlayedCardOrder
		at: self.
	cardsInPosetionDeck takeOut: aCard from: aCardHolderPlayerColor
]

{ #category : #Cards }
CardManager >> calculateEffectOn: aColorPlayer [

	^ activeCardsTargetingPlayersDeck calculateEffectOn: aColorPlayer
]

{ #category : #Information }
CardManager >> cardsInPosetionOf: aPlayersCollection [

	^ cardsInPosetionDeck cardsOf: aPlayersCollection
]

{ #category : #Cards }
CardManager >> checkLastCardPlayed [

	lastCardPlayed = NullEffectCard initializeNew ifTrue: [ 
		Error signal:
			'Redo card cannot be played because there are no cards that have been played before' ]
]

{ #category : #Initialization }
CardManager >> deal: aCardsCollection to: aColorsCollection [

	| cardsPerColor |
	cardsPerColor := aCardsCollection size // aColorsCollection size.
	aColorsCollection do: [ :color | 
		cardsPerColor timesRepeat: [ 
			self add: (CardHolder of: color with: aCardsCollection removeFirst) ] ]
]

{ #category : #Cards }
CardManager >> desactivate: anObjectiveCard targetingBox: anObjectiveBox atTemporalLocation: aPlayedCardOrder [

	activeCardsTargetingBoxesDeck
		desactivate: anObjectiveCard
		targetingBox: anObjectiveBox
		atTemporalLocation: aPlayedCardOrder
]

{ #category : #Cards }
CardManager >> desactivate: anObjectiveCard targetingPlayer: anObjectiveColorPlayer atTemporalLocation: aPlayedCardOrder [

	activeCardsTargetingPlayersDeck
		desactivate: anObjectiveCard
		targetingPlayer: anObjectiveColorPlayer
		atTemporalLocation: aPlayedCardOrder
]

{ #category : #Cards }
CardManager >> duplicateEffectOf: anObjectiveCard targetingBox: anObjectiveBox atTemporalLocation: aPlayedCardOrder [

	activeCardsTargetingBoxesDeck
		duplicateEffectOf: anObjectiveCard
		targetingBox: anObjectiveBox
		atTemporalLocation: aPlayedCardOrder
]

{ #category : #Cards }
CardManager >> duplicateEffectOf: anObjectiveCard targetingPlayer: anObjectiveColorPlayer atTemporalLocation: aPlayedCardOrder [

	activeCardsTargetingPlayersDeck
		duplicateEffectOf: anObjectiveCard
		targetingPlayer: anObjectiveColorPlayer
		atTemporalLocation: aPlayedCardOrder
]

{ #category : #Initialization }
CardManager >> initializeUsing: aCardsCollection with: aColorsCollection [

	lastCardPlayed := NullEffectCard initializeNew.
	activeCardsTargetingPlayersDeck := ActiveCardsTargetingPlayersDeck
		                                   createDeck.
	activeCardsTargetingBoxesDeck := ActiveCardsTargetingBoxesDeck
		                                 createDeck.
	cardsInPosetionDeck := CardsInPlayersHandsDeck createDeck.
	self deal: aCardsCollection to: aColorsCollection
]

{ #category : #Information }
CardManager >> lastCardPlay [

	^ lastCardPlayed
]

{ #category : #Cards }
CardManager >> play: aCard from: aCardHolderPlayerColor toBox: anObjectiveBox [

	aCard haveEffect ifTrue: [ lastCardPlayed := aCard ].
	aCard applyCardUsing: self to: anObjectiveBox.
	cardsInPosetionDeck takeOut: aCard from: aCardHolderPlayerColor
]

{ #category : #Cards }
CardManager >> play: aCard from: aCardHolderPlayerColor toPlayer: anObjectiveColorPlayer at: aDuplaGalacticaGame [

	aCard haveEffect ifTrue: [ lastCardPlayed := aCard ].
	aCard
		applyCardUsing: self
		to: anObjectiveColorPlayer
		at: aDuplaGalacticaGame.
	cardsInPosetionDeck takeOut: aCard from: aCardHolderPlayerColor
]
