Class {
	#name : #DiceShaker,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
DiceShaker class >> with: aDiceCollection [

	(aDiceCollection isKindOf: OrderedCollection) ifFalse: [ 
		Error signal: 'That is not a dice collection' ].
	aDiceCollection isEmpty ifTrue: [ Error signal: 'Cannot create a dice shaker with an empty dice collection' ].
	aDiceCollection do: [ :die | 
		[ die numberOfFaces ]
			on: MessageNotUnderstood
			do: [ 
				Error signal:
					'Cannot create a dice shaker with that dice collection' ] ].
	^ self new initializeWith: aDiceCollection
]

{ #category : #Dice }
DiceShaker >> addDie: aDie [

	dice addLast: aDie
]

{ #category : #Initialization }
DiceShaker >> initializeWith: aDiceCollection [

	dice := aDiceCollection
]

{ #category : #Dice }
DiceShaker >> throwDice [

	^ dice sumNumbers: [ :die | die throw ]
]
