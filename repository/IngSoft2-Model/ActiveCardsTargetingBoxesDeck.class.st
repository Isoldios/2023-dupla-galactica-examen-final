Class {
	#name : #ActiveCardsTargetingBoxesDeck,
	#superclass : #Object,
	#instVars : [
		'activeCardsTargetingBoxes',
		'actionPendingCardsTargetingBoxes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ActiveCardsTargetingBoxesDeck class >> createDeck [

	^ self new initializeDeck
]

{ #category : #cambiar }
ActiveCardsTargetingBoxesDeck >> activateToBox: aCardTargetingBox [

	actionPendingCardsTargetingBoxes addLast: aCardTargetingBox
]

{ #category : #cambiar }
ActiveCardsTargetingBoxesDeck >> checkEffects [

	actionPendingCardsTargetingBoxes do: [ :cardTargetBox | 
		cardTargetBox card applyEffect: cardTargetBox box.
		activeCardsTargetingBoxes addLast: cardTargetBox ].
	actionPendingCardsTargetingBoxes removeAll
]

{ #category : #cambiar }
ActiveCardsTargetingBoxesDeck >> desactivate: anObjectiveCard targetingBox: anObjectiveBox atTemporalLocation: aPlayedCardOrder [

	| cardToCancell |
	cardToCancell := (activeCardsTargetingBoxes select: [ :cardTargetBox | 
		                  cardTargetBox card = anObjectiveCard and:
			                  cardTargetBox box = anObjectiveBox ]) at:
		                 aPlayedCardOrder.
	activeCardsTargetingBoxes remove: cardToCancell.
	actionPendingCardsTargetingBoxes addLast: cardToCancell
]

{ #category : #cambiar }
ActiveCardsTargetingBoxesDeck >> duplicateEffectOf: anObjectiveCard targetingBox: anObjectiveBox atTemporalLocation: aPlayedCardOrder [

	| cardToBoost |
	cardToBoost := (activeCardsTargetingBoxes select: [ :cardTargetBox | 
		                cardTargetBox card = anObjectiveCard and:
			                cardTargetBox box = anObjectiveBox ]) at:
		               aPlayedCardOrder.
	activeCardsTargetingBoxes remove: cardToBoost.
	actionPendingCardsTargetingBoxes addLast: cardToBoost
]

{ #category : #Initialization }
ActiveCardsTargetingBoxesDeck >> initializeDeck [

	actionPendingCardsTargetingBoxes := OrderedCollection new.
	activeCardsTargetingBoxes := OrderedCollection new
]
