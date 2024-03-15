Class {
	#name : #Box,
	#superclass : #Object,
	#instVars : [
		'box',
		'polarity'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
Box class >> type: aBox [

	^ self new initializeType: aBox
]

{ #category : #Effect }
Box >> changePolarity [

	polarity := polarity not
]

{ #category : #Effect }
Box >> effect: aDuplaGalacticaGame [

	box effect: aDuplaGalacticaGame with: polarity
]

{ #category : #Initialization }
Box >> initializeType: aBox [

	box := aBox.
	polarity := true
]

{ #category : #Effect }
Box >> resetPolarity [

	polarity := true
]

{ #category : #Information }
Box >> type [

	^ box
]
