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
