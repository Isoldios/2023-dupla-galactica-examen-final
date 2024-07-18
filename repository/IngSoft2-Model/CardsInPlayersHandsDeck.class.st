Class {
	#name : #CardsInPlayersHandsDeck,
	#superclass : #Object,
	#instVars : [
		'cardsInPlayersHands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
CardsInPlayersHandsDeck class >> createDeck [

	^ self new initializeDeck
]

{ #category : #Cards }
CardsInPlayersHandsDeck >> add: aCardInAPlayerHand [

	cardsInPlayersHands addLast: aCardInAPlayerHand
]

{ #category : #Information }
CardsInPlayersHandsDeck >> cardsOf: aPlayersCollection [

	^ aPlayersCollection collect: [ :player | 
		  (cardsInPlayersHands select: [ :hand | hand holder = player color ]) size ]
]

{ #category : #Validation }
CardsInPlayersHandsDeck >> hasBeenGiven: aCardInAPlayerHand [

	cardsInPlayersHands
		detect: [ :hand | 
			hand card type = aCardInAPlayerHand card type and:
				hand holder = aCardInAPlayerHand holder ]
		ifNone: [ 
		Error signal: 'The player does not have that card in posetion' ]
]

{ #category : #Initialization }
CardsInPlayersHandsDeck >> initializeDeck [

	cardsInPlayersHands := OrderedCollection new
]

{ #category : #Cards }
CardsInPlayersHandsDeck >> takeOut: aCardInAPlayerHand [

	cardsInPlayersHands remove: (cardsInPlayersHands detect: [ :hand | 
			 hand card = aCardInAPlayerHand card and:
				 hand holder = aCardInAPlayerHand holder ])
]

{ #category : #Cards }
CardsInPlayersHandsDeck >> takeOut: aCard from: aCardHolderPlayerColor [

	cardsInPlayersHands remove:
		(cardsInPlayersHands detect: [ :cardHolder | 
			 cardHolder card = aCard and:
				 cardHolder holder = aCardHolderPlayerColor ])
]
