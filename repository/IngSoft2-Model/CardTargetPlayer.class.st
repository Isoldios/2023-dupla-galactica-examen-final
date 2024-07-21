Class {
	#name : #CardTargetPlayer,
	#superclass : #Object,
	#instVars : [
		'card',
		'effect',
		'targetPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardTargetPlayer class >> of: anObjectivePlayer with: aCard [

	^ self new initializeOf: anObjectivePlayer with: aCard
]

{ #category : #card }
CardTargetPlayer >> boostEffect [

	effect := effect * 2
]

{ #category : #information }
CardTargetPlayer >> card [

	^ card
]

{ #category : #information }
CardTargetPlayer >> effect [

	^ effect
]

{ #category : #initialization }
CardTargetPlayer >> initializeOf: anObjectivePlayer with: aCard [

	targetPlayer := anObjectivePlayer.
	card := aCard.
	effect := card applyEffect
]

{ #category : #information }
CardTargetPlayer >> targetPlayer [

	^ targetPlayer
]
