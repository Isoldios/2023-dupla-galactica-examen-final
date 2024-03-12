Class {
	#name : #DiceAndShakersTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceAndShakersTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
DiceAndShakersTest >> testK001WhenADieIsCreatedThenValidItsNumberOfFaces [

	| aDie |
	aDie := Die with: 3.
	self assert: aDie numberOfFaces equals: 3
]

{ #category : #tests }
DiceAndShakersTest >> testK002WhenALoadedDieIsCreatedWithAnOrderedCollectionOfValuesThenCheckItsNumberOfFaces [

	| aLoadedDie |
	aLoadedDie := LoadedDie with: #( 1 2 3 ).
	self assert: aLoadedDie numberOfFaces equals: 3
]

{ #category : #tests }
DiceAndShakersTest >> testK003WhenALoadedDieWithAnOrderedCollectionOfValuesIsThrownThenValidItReturnsTheFirstValue [

	| aLoadedDie |
	aLoadedDie := LoadedDie with: #( 5 4 3 ).
	self assert: aLoadedDie throw equals: 5
]

{ #category : #tests }
DiceAndShakersTest >> testK004WhenADieIsThrownThenValidTheValueReturnesIsInTheDieRange [

	| aDie |
	aDie := Die with: 5.
	self assert: (aDie throw between: 1 and: aDie numberOfFaces)
]

{ #category : #tests }
DiceAndShakersTest >> testK005WhenALoadedDieWithAnOrderedCollectionOfValuesIsThrownTwiceThenValidItReturnsTheSecondValue [

	| aLoadedDie |
	aLoadedDie := LoadedDie with: #( 3 5 7 9 ).
	aLoadedDie throw.
	self assert: aLoadedDie throw equals: 5
]

{ #category : #tests }
DiceAndShakersTest >> testK006WhenALoadedDieWithAnOrderedCollectionOfValuesIsThrownAllPossibleValuesTimesThenValidItReturnsTheFirstValueAgain [

	| aLoadedDie |
	aLoadedDie := LoadedDie with: #( 3 5 7 9 ).
	aLoadedDie throw.
	aLoadedDie throw.
	aLoadedDie throw.
	aLoadedDie throw.
	self assert: aLoadedDie throw equals: 3
]

{ #category : #tests }
DiceAndShakersTest >> testK007WhenAShakerIsCreatedWithALoadedDieThenUseItToThrowAndCheckTheValueReturned [

	| aShaker |
	aShaker := DiceShaker with:
		           (OrderedCollection with: (LoadedDie with: #( 3 5 7 9 ))).
	self assert: aShaker throwDice equals: 3
]

{ #category : #tests }
DiceAndShakersTest >> testK008WhenAShakerIsCreatedWithTwoLoadedDieThenUseItToThrowAndCheckTheValueReturned [

	| aShaker |
	aShaker := DiceShaker with:
		           (OrderedCollection with: (LoadedDie with: #( 3 5 7 9 ))).
	aShaker addDie: (LoadedDie with: #( 3 5 7 9 )).
	self assert: aShaker throwDice equals: 6
]

{ #category : #tests }
DiceAndShakersTest >> testK009WhenAShakerIsCreatedWithADieThenUseItToThrowAndCheckTheValueReturnedIsInTheDieRange [

	| aShaker |
	aShaker := DiceShaker with: (OrderedCollection with: (Die with: 3)).
	self assert: (aShaker throwDice between: 1 and: 3)
]

{ #category : #tests }
DiceAndShakersTest >> testK010WhenAShakerIsCreatedWithTwoDiceThenUseItToThrowAndCheckTheValueReturnedIsInTheSumOfDiceFacesRange [

	| aShaker |
	aShaker := DiceShaker with: (OrderedCollection with: (Die with: 3)).
	aShaker addDie: (Die with: 3).
	self assert: (aShaker throwDice between: 1 and: 6)
]

{ #category : #tests }
DiceAndShakersTest >> testL001TryToCreateALoadedDieWithNegativeValuesAtFacesThenFails [

	self
		should: [ LoadedDie with: #( 3 5 -7 9 ) ]
		raise: Error
		withMessage: 'Cannot create with negative values at faces'
]

{ #category : #tests }
DiceAndShakersTest >> testL002TryToCreateALoadedDieWithLessThanThreeFacesThenFails [

	self
		should: [ LoadedDie with: #( 3 5 ) ]
		raise: Error
		withMessage: 'Cannot create with faces less than 3'
]

{ #category : #tests }
DiceAndShakersTest >> testL003TryToCreateADieWithNegativeNumberOfFacesThenFails [

	self
		should: [ Die with: -2 ]
		raise: Error
		withMessage:
		'Cannot create with negative values at faces or less than 2 faces'
]

{ #category : #tests }
DiceAndShakersTest >> testL004TryToCreateADieWithNumberOfFacesLessThanThreeThenFails [

	self
		should: [ Die with: 2 ]
		raise: Error
		withMessage:
		'Cannot create with negative values at faces or less than 2 faces'
]

{ #category : #tests }
DiceAndShakersTest >> testL005TryToCreateADiceShakerWithANoDiceCollectionThenFails [

	self
		should: [ DiceShaker with: 1 ]
		raise: Error
		withMessage: 'That is not a dice collection'.
	self
		should: [ DiceShaker with: 'P' ]
		raise: Error
		withMessage: 'That is not a dice collection'.
	self
		should: [ DiceShaker with: (Die with: 3) ]
		raise: Error
		withMessage: 'That is not a dice collection'
]

{ #category : #tests }
DiceAndShakersTest >> testL006TryToCreateADiceShakerWithADiceCollectionThatDoesNotHaveDiceThenFails [

	self
		should: [ 
			DiceShaker with:
				(OrderedCollection with: NoEffectBox initializeNew) ]
		raise: Error
		withMessage: 'Cannot create a dice shaker with that dice collection'.
	self
		should: [ DiceShaker with: (OrderedCollection with: 1) ]
		raise: Error
		withMessage: 'Cannot create a dice shaker with that dice collection'.
	self
		should: [ DiceShaker with: (OrderedCollection with: 'p') ]
		raise: Error
		withMessage: 'Cannot create a dice shaker with that dice collection'.
	self
		should: [ 
			DiceShaker with: (OrderedCollection
					 with: (Die with: 3)
					 with: (LoadedDie with: #( 1 2 3 ))
					 with: 'p') ]
		raise: Error
		withMessage: 'Cannot create a dice shaker with that dice collection'
]

{ #category : #tests }
DiceAndShakersTest >> testL007TryToCreateADiceShakerWithAnEmptyOrderedCollectionThenFails [

	self
		should: [ DiceShaker with: OrderedCollection new ]
		raise: Error
		withMessage:
		'Cannot create a dice shaker with an empty dice collection'
]
