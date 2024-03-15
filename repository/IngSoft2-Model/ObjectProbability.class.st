Class {
	#name : #ObjectProbability,
	#superclass : #Object,
	#instVars : [
		'object',
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
ObjectProbability class >> using: anObject withChanceOf: aProbability [

	self validateObject: anObject.
	self validateProbability: aProbability.
	^ self new initializeUsing: anObject withChanceOf: aProbability
]

{ #category : #'Instance creation' }
ObjectProbability class >> validateObject: anObject [

	((anObject respondsTo: #isPermanent) or:
		 (anObject respondsTo: #effect:with:)) ifFalse: [ 
		Error signal: 'That object is neither a card nor a box' ]
]

{ #category : #'Instance creation' }
ObjectProbability class >> validateProbability: aProbability [

	aProbability isNumber
		ifTrue: [ 
			aProbability > 100 ifTrue: [ 
				Error signal: 'The probability cannot be greater than 100' ] ]
		ifFalse: [ 
			Error signal:
				'Cannot create an object probability with a not a number probability' ]
]

{ #category : #Initialization }
ObjectProbability >> initializeUsing: anObject withChanceOf: aProbability [

	object := anObject.
	probability := aProbability
]

{ #category : #Information }
ObjectProbability >> object [

	^ object
]

{ #category : #Information }
ObjectProbability >> probability [

	^ probability
]
