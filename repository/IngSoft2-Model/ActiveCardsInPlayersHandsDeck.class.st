Class {
	#name : #ActiveCardsInPlayersHandsDeck,
	#superclass : #Object,
	#instVars : [
		'activeCardsInPlayersHands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
ActiveCardsInPlayersHandsDeck class >> createDeck [

	^ self new initializeDeck
]

{ #category : #Cards }
ActiveCardsInPlayersHandsDeck >> activate: aCardInAPlayerHand [

	activeCardsInPlayersHands addLast: aCardInAPlayerHand
]

{ #category : #Cards }
ActiveCardsInPlayersHandsDeck >> calculateEffectOn: aColorPlayer [

	^ ((activeCardsInPlayersHands select: [ :hand | 
		    hand holder = aColorPlayer or: hand holder = 'everyone' ]) 
		   collect: [ :hand | hand card ]) sum: #applyEffect
]

{ #category : #Cards }
ActiveCardsInPlayersHandsDeck >> checkPolarityAt: aDuplaGalacticaGame of: aBoxesCollection [

	activeCardsInPlayersHands do: [ :hand | 
		(aBoxesCollection anySatisfy: [ :box | hand holder = box type ]) 
			ifTrue: [ 
			hand card changePolarityOf: hand holder at: aDuplaGalacticaGame ] ]
]

{ #category : #Cards }
ActiveCardsInPlayersHandsDeck >> desactivate: anObjectiveCardInAPlayerHand [

	activeCardsInPlayersHands remove: (self searching: anObjectiveCardInAPlayerHand)
]

{ #category : #Cards }
ActiveCardsInPlayersHandsDeck >> duplicateEffectOf: anObjectiveCardInAPlayerHand [

	(self searching: anObjectiveCardInAPlayerHand) card boostEffect
]

{ #category : #Initialization }
ActiveCardsInPlayersHandsDeck >> initializeDeck [

	activeCardsInPlayersHands := OrderedCollection new
]

{ #category : #Information }
ActiveCardsInPlayersHandsDeck >> searching: anObjectiveCardInAPlayerHand [

	activeCardsInPlayersHands isEmpty ifTrue: [ 
		Error signal: 'There are no active permanent cards' ].
	activeCardsInPlayersHands
		detect: [ :hand | 
			(anObjectiveCardInAPlayerHand card type = hand card type and:
				 anObjectiveCardInAPlayerHand holder = hand holder) or:
				hand holder = 'everyone' ]
		ifFound: [ :hand | ^ hand ]
		ifNone: [ 
			Error signal:
				'There are no cards of that type active in this player' ]
]
