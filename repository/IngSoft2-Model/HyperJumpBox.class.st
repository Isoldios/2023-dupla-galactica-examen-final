Class {
	#name : #HyperJumpBox,
	#superclass : #Object,
	#instVars : [
		'measureManager',
		'state'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
HyperJumpBox class >> with: aMeasuresCollection [

	^ self new initializeWith: aMeasuresCollection
]

{ #category : #Effect }
HyperJumpBox >> changeStateTo: aNewState [

	state := aNewState
]

{ #category : #Effect }
HyperJumpBox >> effect: aDuplaGalacticaGame [

	state affect: aDuplaGalacticaGame using: measureManager.
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
	measureManager := QueueManager with: aParsecsCollectionOrdered.
	state := UnreversedPolarityHyperJumpBoxState new
]

{ #category : #Effect }
HyperJumpBox >> reversePolarity [

	state changeState: self
]
