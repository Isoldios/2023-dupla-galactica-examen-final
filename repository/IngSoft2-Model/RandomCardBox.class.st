Class {
	#name : #RandomCardBox,
	#superclass : #Object,
	#instVars : [
		'cardsProbabilities',
		'state'
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
RandomCardBox >> changeStateTo: aNewState [

	state := aNewState
]

{ #category : #Effect }
RandomCardBox >> effect: aDuplaGalacticaGame [

	state affect: aDuplaGalacticaGame using: cardsProbabilities
]

{ #category : #Initialization }
RandomCardBox >> initializeWith: aCardsProbabilitiesCollection [

	cardsProbabilities := aCardsProbabilitiesCollection.
	state := UnreversedPolarityRandomCardBoxState new
]

{ #category : #Effect }
RandomCardBox >> reversePolarity [

	state changeState: self
]
