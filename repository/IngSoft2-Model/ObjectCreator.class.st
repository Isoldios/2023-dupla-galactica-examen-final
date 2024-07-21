Class {
	#name : #ObjectCreator,
	#superclass : #Object,
	#instVars : [
		'objectsProbabilities'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
ObjectCreator class >> use: anObjectsProbabilitiesCollection [

	self validateObjectsProbabilities: anObjectsProbabilitiesCollection.
	^ self new initializeUse: anObjectsProbabilitiesCollection
]

{ #category : #Validation }
ObjectCreator class >> validateObjectsProbabilities: anObjectsProbabilitiesCollection [

	(anObjectsProbabilitiesCollection sum: #probability) = 100 ifFalse: [ 
		Error signal: 'The sum of probabilities must be 100' ]
]

{ #category : #Creation }
ObjectCreator >> create: aNumberOfObjects [

	| anObjectsCollection |
	anObjectsCollection := OrderedCollection new.
	aNumberOfObjects timesRepeat: [ 
		anObjectsCollection addLast: self oneRandomObject ].
	^ anObjectsCollection
]

{ #category : #Initialization }
ObjectCreator >> initializeUse: anObjectsProbabilitiesCollection [

	objectsProbabilities := anObjectsProbabilitiesCollection
]

{ #category : #Creation }
ObjectCreator >> oneRandomObject [

	| sum |
	sum := 0.
	^ (objectsProbabilities detect: [ :object | 
		   sum := sum + object probability.
		   100 atRandom <= sum ]) object deepCopy
]
