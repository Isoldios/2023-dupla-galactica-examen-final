Class {
	#name : #CardTargetPlayer,
	#superclass : #Object,
	#instVars : [
		'target',
		'card',
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardTargetPlayer class >> of: anObjective with: aCard [

	^ self new initilizeOf: anObjective with: aCard
]

{ #category : #card }
CardTargetPlayer >> boostEffect [

	effect := effect * 2
]

{ #category : #information }
CardTargetPlayer >> card [

	^ card
]

{ #category : #card }
CardTargetPlayer >> effect [

	^ effect
]

{ #category : #information }
CardTargetPlayer >> holder [

	^ target
]

{ #category : #initialization }
CardTargetPlayer >> initilizeOf: anObjective with: aCard [

	target := anObjective.
	card := aCard.
	effect := card applyEffect
]
