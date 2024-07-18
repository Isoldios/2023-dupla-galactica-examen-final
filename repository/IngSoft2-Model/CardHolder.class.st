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
CardHolder class >> of: aColor with: aCard [

	^ self new initializeOf: aColor with: aCard
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
CardHolder >> initializeOf: aColor with: aCard [

	holder := aColor.
	card := aCard
]
