Class {
	#name : #EveryPlayer,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
EveryPlayer class >> initializeNew [

	^ self new initializeNew
]

{ #category : #Initialization }
EveryPlayer >> initializeNew [

	^ 'everyone'
]
