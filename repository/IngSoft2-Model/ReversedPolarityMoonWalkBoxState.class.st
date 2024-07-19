Class {
	#name : #ReversedPolarityMoonWalkBoxState,
	#superclass : #MoonWalkBox,
	#category : #'IngSoft2-Model'
}

{ #category : #Effect }
ReversedPolarityMoonWalkBoxState >> affect: aDuplaGalacticaGame using: anEffectValue [

	aDuplaGalacticaGame moveCurrent: anEffectValue
]

{ #category : #Effect }
ReversedPolarityMoonWalkBoxState >> changeState: aMoonWalkBox [

	aMoonWalkBox changeStateTo: UnreversedPolarityMoonWalkBoxState new
]
