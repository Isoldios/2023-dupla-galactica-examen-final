Class {
	#name : #CardTargetBox,
	#superclass : #Object,
	#instVars : [
		'box',
		'card'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardTargetBox class >> of: anObjectiveBox with: aCard [

	^ self new initializeOf: anObjectiveBox with: aCard
]

{ #category : #card }
CardTargetBox >> card [

	^ card
]

{ #category : #card }
CardTargetBox >> holder [

	^ box
]

{ #category : #initialization }
CardTargetBox >> initializeOf: anObjectiveBox with: aCard [

	box := anObjectiveBox.
	card := aCard
]
