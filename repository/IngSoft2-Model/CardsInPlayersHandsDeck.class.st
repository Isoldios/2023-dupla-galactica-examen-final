Class {
	#name : #CardsInPlayersHandsDeck,
	#superclass : #Object,
	#instVars : [
		'cardsWithHolderPlayerColor'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
CardsInPlayersHandsDeck class >> createDeck [

	^ self new initializeDeck
]

{ #category : #Cards }
CardsInPlayersHandsDeck >> add: aCardAHolderPlayerColor [

	cardsWithHolderPlayerColor addLast: aCardAHolderPlayerColor
]

{ #category : #Information }
CardsInPlayersHandsDeck >> cardsOf: aPlayersCollection [

	^ aPlayersCollection collect: [ :player | 
		  (cardsWithHolderPlayerColor select: [ :aCardHolder | 
			   aCardHolder holder = player color ]) size ]
]

{ #category : #Initialization }
CardsInPlayersHandsDeck >> initializeDeck [

	cardsWithHolderPlayerColor := OrderedCollection new
]

{ #category : #Cards }
CardsInPlayersHandsDeck >> takeOut: aCard from: aCardHolderPlayerColor [

	cardsWithHolderPlayerColor remove:
		(cardsWithHolderPlayerColor detect: [ :cardHolder | 
			 cardHolder card = aCard and:
				 cardHolder holder = aCardHolderPlayerColor ])
]
