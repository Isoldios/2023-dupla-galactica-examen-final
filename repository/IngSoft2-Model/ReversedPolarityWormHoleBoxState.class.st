Class {
	#name : #ReversedPolarityWormHoleBoxState,
	#superclass : #WormHoleBox,
	#category : #'IngSoft2-Model'
}

{ #category : #Effect }
ReversedPolarityWormHoleBoxState >> affect: aDuplaGalacticaGame [

	aDuplaGalacticaGame moveOthers: -4
]

{ #category : #Effect }
ReversedPolarityWormHoleBoxState >> changeState: aWormHoleBox [

	aWormHoleBox changeStateTo: UnreversedPolarityWormHoleBoxState new
]
