Class {
	#name : #RandomCardBox,
	#superclass : #Object,
	#instVars : [
		'cardsProbabilities'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #Validation }
RandomCardBox class >> validateCardsProbabilities: aCardsProbabilitiesCollection [

	(aCardsProbabilitiesCollection sum: #probability) = 100 ifFalse: [ 
		Error signal: 'The sum of probabilities must be 100' ]
]

{ #category : #'Instance creation' }
RandomCardBox class >> with: aCardsProbabilitiesCollection [

	self validateCardsProbabilities: aCardsProbabilitiesCollection.
	^ self new initializeWith: aCardsProbabilitiesCollection
]

{ #category : #Effect }
RandomCardBox >> effect: aDuplaGalacticaGame with: aPolarityValue [

	aPolarityValue
		ifTrue: [ 
			aDuplaGalacticaGame add: (PlayerHand
					 of: aDuplaGalacticaGame currentPlayer
					 with:
					 ((ObjectCreator use: cardsProbabilities) create: 1) removeFirst) ]
		ifFalse: [ 
			aDuplaGalacticaGame addToOthers:
				((ObjectCreator use: cardsProbabilities) create: 1) removeFirst ]
]

{ #category : #Initialization }
RandomCardBox >> initializeWith: aCardsProbabilitiesCollection [

	cardsProbabilities := aCardsProbabilitiesCollection
]
