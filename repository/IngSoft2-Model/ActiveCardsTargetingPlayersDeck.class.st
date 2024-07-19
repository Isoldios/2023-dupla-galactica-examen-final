Class {
	#name : #ActiveCardsTargetingPlayersDeck,
	#superclass : #Object,
	#instVars : [
		'activeCardsTargetingPlayers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
ActiveCardsTargetingPlayersDeck class >> createDeck [

	^ self new initializeDeck
]

{ #category : #Cards }
ActiveCardsTargetingPlayersDeck >> activateToPlayer: aCardTargetingPlayer [

	activeCardsTargetingPlayers addLast: aCardTargetingPlayer
]

{ #category : #Cards }
ActiveCardsTargetingPlayersDeck >> calculateEffectOn: aColorPlayer [

	^ (activeCardsTargetingPlayers select: [ :cardTargetPlayer | 
		   cardTargetPlayer targetPlayer = aColorPlayer or:
			   cardTargetPlayer targetPlayer = 'everyone' ]) sum: #effect
]

{ #category : #Cards }
ActiveCardsTargetingPlayersDeck >> cardToModify: anObjectiveCard playedAt: anObjectiveColorPlayer targetingPlayer: aPlayedCardOrder [

	^ (activeCardsTargetingPlayers select: [ :cardTargetPlayer | 
		   cardTargetPlayer card = anObjectiveCard and:
			   cardTargetPlayer targetPlayer = anObjectiveColorPlayer ]) at:
		  aPlayedCardOrder
]

{ #category : #Cards }
ActiveCardsTargetingPlayersDeck >> desactivate: anObjectiveCard targetingPlayer: anObjectiveColorPlayer atTemporalLocation: aPlayedCardOrder [

	| card |
	card := self
		        cardToModify: anObjectiveCard
		        playedAt: anObjectiveColorPlayer
		        targetingPlayer: aPlayedCardOrder.
	activeCardsTargetingPlayers remove: card
]

{ #category : #Cards }
ActiveCardsTargetingPlayersDeck >> duplicateEffectOf: anObjectiveCard targetingPlayer: anObjectiveColorPlayer atTemporalLocation: aPlayedCardOrder [

	| card |
	card := self
		        cardToModify: anObjectiveCard
		        playedAt: anObjectiveColorPlayer
		        targetingPlayer: aPlayedCardOrder.
	card boostEffect
]

{ #category : #Initialization }
ActiveCardsTargetingPlayersDeck >> initializeDeck [

	activeCardsTargetingPlayers := OrderedCollection new
]
