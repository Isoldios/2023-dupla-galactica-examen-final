Class {
	#name : #DuplaGalacticaGameProxy,
	#superclass : #Object,
	#instVars : [
		'game'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
DuplaGalacticaGameProxy class >> with: aColorsCollection and: aBoard usingToThrow: aDiceShaker winningWhenReach: aNumberOfLaps using: aCardsCollection [

	^ self new
		  initializeWith: aColorsCollection
		  and: aBoard
		  usingToThrow: aDiceShaker
		  winningWhenReach: aNumberOfLaps
		  using: aCardsCollection
]

{ #category : #Cards }
DuplaGalacticaGameProxy >> apply: aCardInAPlayerHand to: anObjective [

	game apply: aCardInAPlayerHand to: anObjective
]

{ #category : #Information }
DuplaGalacticaGameProxy >> boardLength [

	^ game boardLength
]

{ #category : #Information }
DuplaGalacticaGameProxy >> currentPlayer [

	^ game currentPlayer
]

{ #category : #Information }
DuplaGalacticaGameProxy >> diceAmount [

	^ game diceAmount
]

{ #category : #Information }
DuplaGalacticaGameProxy >> goalLaps [

	^ game goalLaps
]

{ #category : #Initialization }
DuplaGalacticaGameProxy >> initializeWith: aColorsCollection and: aBoard usingToThrow: aDiceShaker winningWhenReach: aNumberOfLaps using: aCardsCollection [

	game := DuplaGalacticaGame
		        with: aColorsCollection
		        and: aBoard
		        usingToThrow: aDiceShaker
		        winningWhenReach: aNumberOfLaps
		        using: aCardsCollection
]

{ #category : #Information }
DuplaGalacticaGameProxy >> lightYears [

	^ game lightYears
]

{ #category : #Movement }
DuplaGalacticaGameProxy >> movePlayer [

	^ game movePlayer
]

{ #category : #Information }
DuplaGalacticaGameProxy >> parsecs [

	^ game parsecs
]

{ #category : #Information }
DuplaGalacticaGameProxy >> playersBox [

	^ game playersBox
]

{ #category : #Information }
DuplaGalacticaGameProxy >> playersCardInPosetion [

	^ game playersCardInPosetion
]

{ #category : #Information }
DuplaGalacticaGameProxy >> playersColors [

	^ game playersColors
]

{ #category : #Information }
DuplaGalacticaGameProxy >> playersLaps [

	^ game playersLaps
]

{ #category : #Information }
DuplaGalacticaGameProxy >> ranking [

	^ game ranking
]

{ #category : #Finalization }
DuplaGalacticaGameProxy >> winner [

	^ game winner
]
