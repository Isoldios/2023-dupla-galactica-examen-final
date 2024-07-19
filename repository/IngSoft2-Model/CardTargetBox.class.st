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

{ #category : #information }
CardTargetBox >> box [

	^ box
]

{ #category : #information }
CardTargetBox >> card [

	^ card
]

{ #category : #initialization }
CardTargetBox >> initializeOf: anObjectiveBox with: aCard [

	box := anObjectiveBox.
	card := aCard
]
