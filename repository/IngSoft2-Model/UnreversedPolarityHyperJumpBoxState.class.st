Class {
	#name : #UnreversedPolarityHyperJumpBoxState,
	#superclass : #HyperJumpBox,
	#category : #'IngSoft2-Model'
}

{ #category : #Effect }
UnreversedPolarityHyperJumpBoxState >> affect: aDuplaGalacticaGame using: aMeasureManager [

	aDuplaGalacticaGame moveCurrent:
		aMeasureManager current parsecs nominalValue
		// aDuplaGalacticaGame boxesByParsecs
]

{ #category : #Effect }
UnreversedPolarityHyperJumpBoxState >> changeState: anHyperJumpBox [

	anHyperJumpBox changeStateTo: ReversedPolarityHyperJumpBoxState new
]
