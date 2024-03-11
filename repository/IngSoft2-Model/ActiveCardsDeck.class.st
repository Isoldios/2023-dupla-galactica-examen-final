Class {
	#name : #ActiveCardsDeck,
	#superclass : #Object,
	#instVars : [
		'playersHands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
ActiveCardsDeck class >> createDeck [

	^ self new initializeDeck
]

{ #category : #Cards }
ActiveCardsDeck >> activate: aCardInAPlayerHand [

	playersHands addLast: aCardInAPlayerHand
]

{ #category : #Cards }
ActiveCardsDeck >> calculateEffectOn: aColorPlayer [

	^ ((playersHands select: [ :hand | 
		    hand holder = aColorPlayer or:
			    hand holder = EveryPlayer initializeNew players ]) collect: [ 
		   :hand | hand card ]) sum: #applyEffect
]

{ #category : #Cards }
ActiveCardsDeck >> checkPolarityAt: aDuplaGalacticaGame [

	(playersHands select: [ :hand | hand holder isNumber ]) do: [ :hand | 
		hand card changePolarityOf: hand holder at: aDuplaGalacticaGame ]
]

{ #category : #Cards }
ActiveCardsDeck >> desactivate: anObjectiveCardInAPlayerHand [

	playersHands remove: (self searching: anObjectiveCardInAPlayerHand)
]

{ #category : #Cards }
ActiveCardsDeck >> duplicateEffectOf: anObjectiveCardInAPlayerHand [

	(self searching: anObjectiveCardInAPlayerHand) card boostEffect
]

{ #category : #Initialization }
ActiveCardsDeck >> initializeDeck [

	playersHands := OrderedCollection new
]

{ #category : #Information }
ActiveCardsDeck >> isEmpty [

	playersHands isEmpty ifTrue: [ Error signal: 'There are no active permanent cards' ]
]

{ #category : #Information }
ActiveCardsDeck >> isValidCard: anObjectiveCardInAPlayerHand [

	^ [ anObjectiveCardInAPlayerHand card ]
		  on: MessageNotUnderstood
		  do: [ Error signal: 'That is not a valid card objective' ]
]

{ #category : #Information }
ActiveCardsDeck >> searching: anObjectiveCardInAPlayerHand [

	self isEmpty.
	playersHands
		detect: [ :hand | 
			((self isValidCard: anObjectiveCardInAPlayerHand) type = hand card type 
				 and: anObjectiveCardInAPlayerHand holder = hand holder) or:
				hand holder = 'everyone' ]
		ifFound: [ :hand | ^ hand ]
		ifNone: [ 
			Error signal:
				'There are no cards of that type active in this player' ]
]
