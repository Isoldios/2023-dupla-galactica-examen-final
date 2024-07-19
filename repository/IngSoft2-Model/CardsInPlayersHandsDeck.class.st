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

{ #category : #Initialization }
CardsInPlayersHandsDeck >> initializeDeck [

	cardsInPlayersHands := OrderedCollection new
]

{ #category : #Cards }
CardsInPlayersHandsDeck >> takeOut: aCard from: aCardHolderPlayerColor [

	cardsInPlayersHands remove:
		(cardsInPlayersHands detect: [ :cardHolder | 
			 cardHolder card = aCard and:
				 cardHolder holder = aCardHolderPlayerColor ])
]
