Class {
	#name : #ReversedPolarityHyperJumpBoxState,
	#superclass : #HyperJumpBox,
	#category : #'IngSoft2-Model'
}

{ #category : #Effect }
ReversedPolarityHyperJumpBoxState >> affect: aDuplaGalacticaGame using: aMeasureManager [

	aDuplaGalacticaGame moveOthers:
		aMeasureManager current parsecs nominalValue
		// aDuplaGalacticaGame boxesByParsecs
]

{ #category : #Effect }
ReversedPolarityHyperJumpBoxState >> changeState: anHyperJumpBox [

	anHyperJumpBox changeStateTo: UnreversedPolarityHyperJumpBoxState new
]
