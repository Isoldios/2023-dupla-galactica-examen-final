Class {
	#name : #UnreversedPolarityAtomicBombBoxState,
	#superclass : #AtomicBombBox,
	#category : #'IngSoft2-Model'
}

{ #category : #Effect }
UnreversedPolarityAtomicBombBoxState >> affect: aDuplaGalacticaGame [

	aDuplaGalacticaGame moveAllToTheStart
]

{ #category : #Effect }
UnreversedPolarityAtomicBombBoxState >> changeState: anAtomicBombBox [

	anAtomicBombBox changeStateTo: ReversedPolarityAtomicBombBoxState new
]
