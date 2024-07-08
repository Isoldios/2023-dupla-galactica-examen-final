Class {
	#name : #ParsecMeasure,
	#superclass : #Object,
	#instVars : [
		'nominalValue'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #Validation }
ParsecMeasure class >> validateValue: aNominalValue [

	aNominalValue isNumber ifFalse: [ 
		Error signal:
			'Cannot create a parsec measure with a not a number value' ]
]

{ #category : #'Instance creation' }
ParsecMeasure class >> worth: aNominalValue [

	self validateValue: aNominalValue.
	^ self new initializeWorth: aNominalValue
]

{ #category : #Initialization }
ParsecMeasure >> initializeWorth: aNominalValue [

	nominalValue := aNominalValue
]

{ #category : #Information }
ParsecMeasure >> nominalValue [

	^ nominalValue
]

{ #category : #Information }
ParsecMeasure >> parsecs [

	^ self
]
