Class {
	#name : #QueueManager,
	#superclass : #Object,
	#instVars : [
		'current',
		'values'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
QueueManager class >> with: aValuesCollection [

	^ self new initializeWith: aValuesCollection
]

{ #category : #ManageTurns }
QueueManager >> current [

	^ values at: current 
]

{ #category : #ManageTurns }
QueueManager >> goNext [

	current := current == values size
		           ifTrue: [ 1 ]
		           ifFalse: [ current + 1 ]
]

{ #category : #Initialization }
QueueManager >> initializeWith: aValuesCollection [

	values	:= aValuesCollection.
	current := 1
]

{ #category : #Information }
QueueManager >> valuesOnQueue [

	^ values size
]
