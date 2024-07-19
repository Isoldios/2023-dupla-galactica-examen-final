Class {
	#name : #ReversedPolarityAtomicBombBoxState,
	#superclass : #AtomicBombBox,
	#category : #'IngSoft2-Model'
}

{ #category : #Effect }
ReversedPolarityAtomicBombBoxState >> affect: aDuplaGalacticaGame [

	
]

{ #category : #Effect }
ReversedPolarityAtomicBombBoxState >> changeState: anAtomicBombBox [

	anAtomicBombBox changeStateTo:
		UnreversedPolarityAtomicBombBoxState new
]
