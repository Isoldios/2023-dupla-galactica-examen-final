Class {
	#name : #CardHolder,
	#superclass : #Object,
	#instVars : [
		'card',
		'holder'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
CardHolder class >> of: aPlayerColor with: aCard [

	^ self new initializeOf: aPlayerColor with: aCard
]

{ #category : #Information }
CardHolder >> card [

	^ card
]

{ #category : #Information }
CardHolder >> holder [

	^ holder
]

{ #category : #Initialization }
CardHolder >> initializeOf: aPlayerColor with: aCard [

	holder := aPlayerColor.
	card := aCard
]
