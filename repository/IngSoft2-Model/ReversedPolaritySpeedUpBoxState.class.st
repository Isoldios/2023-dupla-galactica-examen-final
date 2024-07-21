Class {
	#name : #ReversedPolaritySpeedUpBoxState,
	#superclass : #SpeedUpBox,
	#category : #'IngSoft2-Model'
}

{ #category : #Effect }
ReversedPolaritySpeedUpBoxState >> affect: aDuplaGalacticaGame [

	aDuplaGalacticaGame moveOthers: 4
]

{ #category : #Effect }
ReversedPolaritySpeedUpBoxState >> changeState: aSpeedUpBox [

	aSpeedUpBox changeStateTo: UnreversedPolaritySpeedUpBoxState new
]
