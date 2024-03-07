Class {
	#name : #HyperJumpBox,
	#superclass : #Object,
	#instVars : [
		'parsecManager'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
HyperJumpBox class >> with: aParsecCollection [

	aParsecCollection isEmpty ifTrue: [ 
		Error signal: 'There are no values to use in the hyper jump box' ].
	^ self new initializeWith: aParsecCollection
]

{ #category : #Effect }
HyperJumpBox >> effect: aDuplaGalacticaGame with: aPolarityValue [

	aPolarityValue
		ifTrue: [ 
			aDuplaGalacticaGame moveCurrent:
				parsecManager current parsecs nominalValue
				// aDuplaGalacticaGame boxesByParsecs ]
		ifFalse: [ 
			aDuplaGalacticaGame moveOthers:
				parsecManager current parsecs nominalValue
				// aDuplaGalacticaGame boxesByParsecs ].
	parsecManager goNext
]

{ #category : #Initialization }
HyperJumpBox >> initializeWith: aParsecsCollection [

	| aParsecsCollectionOrdered |
	aParsecsCollectionOrdered := aParsecsCollection sort: [ :value1 :value2 | 
		                             value2 parsecs nominalValue
		                             < value1 parsecs nominalValue ].
	parsecManager := QueueManager with: aParsecsCollectionOrdered.
]
