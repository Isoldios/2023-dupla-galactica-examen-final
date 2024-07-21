Class {
	#name : #ParsecMeasure,
	#superclass : #Object,
	#instVars : [
		'nominalValue'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
ParsecMeasure class >> worth: aNominalValue [

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
