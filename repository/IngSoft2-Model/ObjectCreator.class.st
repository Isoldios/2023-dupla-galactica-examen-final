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

	(anObjectsProbabilitiesCollection isKindOf: OrderedCollection) 
		ifFalse: [ 
		Error signal: 'That is not an object probabilities collection' ].
	([ anObjectsProbabilitiesCollection sum: #probability ]
		 on: MessageNotUnderstood
		 do: [ Error signal: 'That is not a valid object probability' ])
	= 100 ifFalse: [ 
		Error signal: 'The sum of probabilities must be 100' ]
]

{ #category : #Creation }
ObjectCreator >> create: aNumberOfObjects [

	| anObjectsCollection |
	aNumberOfObjects isNumber
		ifTrue: [ 
			aNumberOfObjects > 0
				ifTrue: [ 
					anObjectsCollection := OrderedCollection new.
					aNumberOfObjects timesRepeat: [ 
						anObjectsCollection addLast: self oneRandomObject ].
					^ anObjectsCollection ]
				ifFalse: [ 
					Error signal:
						'The amount of objects to create must be greater than zero' ] ]
		ifFalse: [ 
		Error signal: 'The amount of objects to create must be a number' ]
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
