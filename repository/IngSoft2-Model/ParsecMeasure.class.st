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

	aNominalValue isNumber ifFalse: [ 
		Error signal: 'Cannot create a ligth year measure with that value' ].
	^ self new initializeWith: aNominalValue
]

{ #category : #Initialization }
ParsecMeasure >> initializeWith: aNominalValue [

	nominalValue := aNominalValue
]

{ #category : #Information }
ParsecMeasure >> lightYears [

	^ LigthYearMeasure worth: nominalValue * 3
]

{ #category : #Information }
ParsecMeasure >> nominalValue [

	^ nominalValue
]

{ #category : #Information }
ParsecMeasure >> parsecs [

	^ self
]
