Class {
	#name : #UnreversedPolarityMoonWalkBoxState,
	#superclass : #MoonWalkBox,
	#category : #'IngSoft2-Model'
}

{ #category : #Effect }
UnreversedPolarityMoonWalkBoxState >> affect: aDuplaGalacticaGame using: anEffectValue [

	aDuplaGalacticaGame moveOthers: anEffectValue
]

{ #category : #Effect }
UnreversedPolarityMoonWalkBoxState >> changeState: aMoonWalkBox [

	aMoonWalkBox changeStateTo: ReversedPolarityMoonWalkBoxState new
]
