Class {
	#name : #UnreversedPolaritySpeedUpBoxState,
	#superclass : #SpeedUpBox,
	#category : #'IngSoft2-Model'
}

{ #category : #Effect }
UnreversedPolaritySpeedUpBoxState >> affect: aDuplaGalacticaGame [

	aDuplaGalacticaGame moveCurrent: 4
]

{ #category : #Effect }
UnreversedPolaritySpeedUpBoxState >> changeState: aSpeedUpBox [

	aSpeedUpBox changeStateTo: ReversedPolaritySpeedUpBoxState new
]
