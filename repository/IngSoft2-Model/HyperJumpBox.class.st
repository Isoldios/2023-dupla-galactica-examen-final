Class {
	#name : #HyperJumpBox,
	#superclass : #Object,
	#instVars : [
		'measureManager'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
HyperJumpBox class >> with: aMeasuresCollection [

	(aMeasuresCollection isKindOf: OrderedCollection) ifFalse: [ 
		Error signal: 'That is not a measures collection' ].
	aMeasuresCollection isEmpty ifTrue: [ 
		Error signal: 'There are no values to use in the hyper jump box' ].
	aMeasuresCollection do: [ :measure | 
		[ measure nominalValue ]
			on: MessageNotUnderstood
			do: [ 
			Error signal: 'Cannot create a hyper jump box with that values' ] ].
	^ self new initializeWith: aMeasuresCollection
]

{ #category : #Effect }
HyperJumpBox >> effect: aDuplaGalacticaGame with: aPolarityValue [

	aPolarityValue
		ifTrue: [ 
			aDuplaGalacticaGame moveCurrent:
				measureManager current parsecs nominalValue
				// aDuplaGalacticaGame boxesByParsecs ]
		ifFalse: [ 
			aDuplaGalacticaGame moveOthers:
				measureManager current parsecs nominalValue
				// aDuplaGalacticaGame boxesByParsecs ].
	measureManager goNext
]

{ #category : #Initialization }
HyperJumpBox >> initializeWith: aMeasuresCollection [

	| aParsecsCollectionOrdered |
	aParsecsCollectionOrdered := aMeasuresCollection sort: [ 
		                             :value1 
		                             :value2 | 
		                             value2 parsecs nominalValue
		                             < value1 parsecs nominalValue ].
	measureManager := QueueManager with: aParsecsCollectionOrdered
]
