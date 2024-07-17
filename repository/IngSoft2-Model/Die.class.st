Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #Validation }
Die class >> validateFaces: aNumberOfFaces [

	aNumberOfFaces < 3 ifTrue: [ 
		Error signal:
			'Cannot create with negative values at faces or less than 2 faces' ]
]

{ #category : #'Instance creation' }
Die class >> with: aNumberOfFaces [

	self validateFaces: aNumberOfFaces.
	^ self new initializeWith: aNumberOfFaces
]

{ #category : #Initialization }
Die >> initializeWith: aNumberOfFaces [

	faces := aNumberOfFaces
]

{ #category : #Information }
Die >> numberOfFaces [

	^ faces
]

{ #category : #Throw }
Die >> throw [

	^ faces atRandom
]
