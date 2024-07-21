Class {
	#name : #UnreversedPolarityRandomCardBoxState,
	#superclass : #RandomCardBox,
	#category : #'IngSoft2-Model'
}

{ #category : #Effect }
UnreversedPolarityRandomCardBoxState >> affect: aDuplaGalacticaGame using: aCardsProbabilitiesCollection [

	aDuplaGalacticaGame add: (CardHolder
			 of: aDuplaGalacticaGame currentPlayer
			 with:
				 ((ObjectCreator use: aCardsProbabilitiesCollection) create: 1)
					 removeFirst)
]

{ #category : #Effect }
UnreversedPolarityRandomCardBoxState >> changeState: aRandomCardBox [

	aRandomCardBox changeStateTo: ReversedPolarityRandomCardBoxState new
]
