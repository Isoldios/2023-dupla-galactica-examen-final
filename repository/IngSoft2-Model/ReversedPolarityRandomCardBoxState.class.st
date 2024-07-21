Class {
	#name : #ReversedPolarityRandomCardBoxState,
	#superclass : #RandomCardBox,
	#category : #'IngSoft2-Model'
}

{ #category : #Effect }
ReversedPolarityRandomCardBoxState >> affect: aDuplaGalacticaGame using: aCardsProbabilitiesCollection [

	aDuplaGalacticaGame addToOthers:
		((ObjectCreator use: aCardsProbabilitiesCollection) create: 1)
			removeFirst
]

{ #category : #Effect }
ReversedPolarityRandomCardBoxState >> changeState: aRandomCardBox [

	aRandomCardBox changeStateTo: UnreversedPolarityRandomCardBoxState new
]
