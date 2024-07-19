Class {
	#name : #CardTargetBox,
	#superclass : #Object,
	#instVars : [
		'box',
		'card',
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardTargetBox class >> of: anObjectiveBox with: aCard [

	^ self new initializeOf: anObjectiveBox with: aCard
]

{ #category : #card }
CardTargetBox >> boostEffect [

	effect := effect + 1
]

{ #category : #information }
CardTargetBox >> box [

	^ box
]

{ #category : #information }
CardTargetBox >> card [

	^ card
]

{ #category : #information }
CardTargetBox >> effect [

	^ effect
]

{ #category : #initialization }
CardTargetBox >> initializeOf: anObjectiveBox with: aCard [

	box := anObjectiveBox.
	card := aCard.
	effect := 1
]
