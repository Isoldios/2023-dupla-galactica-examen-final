Class {
	#name : #UnreversedPolarityWormHoleBoxState,
	#superclass : #WormHoleBox,
	#category : #'IngSoft2-Model'
}

{ #category : #Effect }
UnreversedPolarityWormHoleBoxState >> affect: aDuplaGalacticaGame [

	aDuplaGalacticaGame moveCurrent: -4
]

{ #category : #Effect }
UnreversedPolarityWormHoleBoxState >> changeState: aWormHoleBox [

	aWormHoleBox changeStateTo: ReversedPolarityWormHoleBoxState new
]
