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
		    hand holder = aColorPlayer or: hand holder = 'everyone' ]) 
		   collect: [ :hand | hand ]) sum: #effect
]

{ #category : #Cards }
ActiveCardsTargetingPlayersDeck >> checkPolarityAt: aDuplaGalacticaGame of: aBoxesCollection [

	activeCardsTargetingPlayers do: [ :hand | 
		(aBoxesCollection anySatisfy: [ :box | hand holder = box type ]) 
			ifTrue: [ 
			hand card changePolarityOf: hand holder at: aDuplaGalacticaGame ] ]
]

{ #category : #cambiar }
ActiveCardsTargetingPlayersDeck >> desactivate: anObjectiveCard targetingPlayer: anObjectiveColorPlayer atTemporalLocation: aPlayedCardOrder [

	activeCardsTargetingPlayers remove:
		((activeCardsTargetingPlayers select: [ :hand | 
			  hand card = anObjectiveCard and:
				  hand holder = anObjectiveColorPlayer ]) at: aPlayedCardOrder)
]

{ #category : #cambiar }
ActiveCardsTargetingPlayersDeck >> duplicateEffectOf: anObjectiveCard targetingPlayer: anObjectiveColorPlayer atTemporalLocation: aPlayedCardOrder [

	((activeCardsTargetingPlayers select: [ :hand | 
		  hand card = anObjectiveCard and:
			  hand holder = anObjectiveColorPlayer ]) at: aPlayedCardOrder)
		boostEffect
]

{ #category : #Initialization }
ActiveCardsTargetingPlayersDeck >> initializeDeck [

	activeCardsTargetingPlayers := OrderedCollection new
]
