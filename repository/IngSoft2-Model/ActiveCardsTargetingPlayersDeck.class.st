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

	^ ((activeCardsTargetingPlayers select: [ :hand | 
		    hand target = aColorPlayer or: hand target = 'everyone' ]) 
		   collect: [ :hand | hand ]) sum: #effect
]

{ #category : #Cards }
ActiveCardsTargetingPlayersDeck >> desactivate: anObjectiveCard targetingPlayer: anObjectiveColorPlayer atTemporalLocation: aPlayedCardOrder [

	activeCardsTargetingPlayers remove:
		((activeCardsTargetingPlayers select: [ :hand | 
			  hand card = anObjectiveCard and:
				  hand target = anObjectiveColorPlayer ]) at: aPlayedCardOrder)
]

{ #category : #Cards }
ActiveCardsTargetingPlayersDeck >> duplicateEffectOf: anObjectiveCard targetingPlayer: anObjectiveColorPlayer atTemporalLocation: aPlayedCardOrder [

	((activeCardsTargetingPlayers select: [ :hand | 
		  hand card = anObjectiveCard and:
			  hand target = anObjectiveColorPlayer ]) at: aPlayedCardOrder)
		boostEffect
]

{ #category : #Initialization }
ActiveCardsTargetingPlayersDeck >> initializeDeck [

	activeCardsTargetingPlayers := OrderedCollection new
]
