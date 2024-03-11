Class {
	#name : #CreatePlayersFromTheGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CreatePlayersFromTheGameTest >> testI001WhenAGameIsCreatedWithAColorsCollectionThenValidPlayersColors [

	| aBoard aColorsCollection aBoxesCollection aCardsCollection aDuplaGalacticaGame |
	aCardsCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NoEffectCard initializeNew
				                       withChanceOf: 100))) create: 4.
	aColorsCollection := OrderedCollection with: 'red' with: 'blue'.
	aBoxesCollection := (ObjectCreator use: (OrderedCollection with:
			                      (ObjectProbability
				                       using: NoEffectBox initializeNew
				                       withChanceOf: 100))) create: 10.
	aBoard := Board
		          with: aBoxesCollection
		          measure: (ParsecMeasure worth: 100).
	aDuplaGalacticaGame := DuplaGalacticaGameProxy
		                       with: aColorsCollection
		                       and: aBoard
		                       usingToThrow: (DiceShaker with:
				                        (OrderedCollection with:
					                         (LoadedDie with: #( 1 2 3 4 ))))
		                       winningWhenReach: 1
		                       using: aCardsCollection.
	self
		assert: aDuplaGalacticaGame playersColors
		equals: (OrderedCollection with: 'red' with: 'blue')
]
