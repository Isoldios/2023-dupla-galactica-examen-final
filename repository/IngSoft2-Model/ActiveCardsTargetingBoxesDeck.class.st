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

{ #category : #Cards }
ActiveCardsTargetingBoxesDeck >> activateToBox: aCardTargetingBox [

	actionPendingCardsTargetingBoxes addLast: aCardTargetingBox.
	self checkEffects
]

{ #category : #Cards }
ActiveCardsTargetingBoxesDeck >> cardToModify: anObjectiveCard playedAt: aPlayedCardOrder targetingBox: anObjectiveBox [

	| card |
	card := (activeCardsTargetingBoxes select: [ :cardTargetBox | 
		         cardTargetBox card = anObjectiveCard and:
			         cardTargetBox targetBox = anObjectiveBox ]) at:
		        aPlayedCardOrder.
	activeCardsTargetingBoxes remove: card.
	card effect timesRepeat: [ card card applyEffect: card targetBox ].
	^ card
]

{ #category : #Cards }
ActiveCardsTargetingBoxesDeck >> checkEffects [

	actionPendingCardsTargetingBoxes do: [ :cardTargetBox | 
		cardTargetBox effect timesRepeat: [ 
			cardTargetBox card applyEffect: cardTargetBox targetBox ].
		activeCardsTargetingBoxes addLast: cardTargetBox ].
	actionPendingCardsTargetingBoxes removeAll
]

{ #category : #Cards }
ActiveCardsTargetingBoxesDeck >> desactivate: anObjectiveCard targetingBox: anObjectiveBox atTemporalLocation: aPlayedCardOrder [

	self
		cardToModify: anObjectiveCard
		playedAt: aPlayedCardOrder
		targetingBox: anObjectiveBox.
	self checkEffects
]

{ #category : #Cards }
ActiveCardsTargetingBoxesDeck >> duplicateEffectOf: anObjectiveCard targetingBox: anObjectiveBox atTemporalLocation: aPlayedCardOrder [

	| cardToBoost |
	cardToBoost := self
		               cardToModify: anObjectiveCard
		               playedAt: aPlayedCardOrder
		               targetingBox: anObjectiveBox.
	cardToBoost boostEffect.
	self activateToBox: cardToBoost
]

{ #category : #Initialization }
ActiveCardsTargetingBoxesDeck >> initializeDeck [

	actionPendingCardsTargetingBoxes := OrderedCollection new.
	activeCardsTargetingBoxes := OrderedCollection new
]
