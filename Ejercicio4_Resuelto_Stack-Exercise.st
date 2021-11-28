!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'sentencesStack sentencesWithWin sentencesWithPrefixThe foundSentences sentenceFinder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'asserts' stamp: 'sebas 11/2/2021 19:05:18'!
assertThat: aListOfFoundSentences hasEqualElementsWith: aListToCompare

	aListOfFoundSentences reverseDo: [ :sentence | foundSentences add: sentence ].
	
	self assert: (foundSentences hasEqualElements: aListToCompare).! !

!SentenceFinderByPrefixTest methodsFor: 'asserts' stamp: 'sebas 11/2/2021 18:58:01'!
assertThatStackIsUnchagedAfterSearchIn: aCollection

	aCollection reverseDo: [:sentence| self assert: sentence = sentencesStack top. sentencesStack pop].! !

!SentenceFinderByPrefixTest methodsFor: 'asserts' stamp: 'sebas 11/2/2021 19:15:58'!
assertThatThis: aPrefix raisesInvalidPrefixErrorIn: aSentenceFinder

	self should: [aSentenceFinder find: aPrefix ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |self assert: anError messageText=
			SentenceFinderByPrefix invalidPrefixErrorDescription ].

	! !


!SentenceFinderByPrefixTest methodsFor: 'initialization' stamp: 'RP 11/2/2021 17:15:04'!
fillStackWithSentencesFrom: aListOfSentences

	aListOfSentences do: [ :sentence | sentencesStack push: sentence].! !

!SentenceFinderByPrefixTest methodsFor: 'initialization' stamp: 'RP 11/2/2021 22:49:43'!
setUp

	sentencesWithWin := #( 'winter is coming' 'winning is everything' 'Winter is here' 'The winds of Winter' ).
	
	sentencesWithPrefixThe := #( 'The Lord of the Rings' 'The Shinning' 'The Chronicles of Narnia' 'The Hunger Games' ).	
	
	sentencesStack := OOStack new.
	
	sentenceFinder := SentenceFinderByPrefix with: sentencesStack .
	
	foundSentences := OrderedCollection new.
	! !


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'RP 11/2/2021 22:51:26'!
test01AllSentencesInStackHaveTheSamePrefixThe	

	| auxSentences |
	self fillStackWithSentencesFrom: sentencesWithPrefixThe.	
	
	auxSentences := sentenceFinder find: 'The'.		
	
	self assertThat: auxSentences hasEqualElementsWith: sentencesWithPrefixThe.
	self assertThatStackIsUnchagedAfterSearchIn: sentencesWithPrefixThe 
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'RP 11/2/2021 22:51:00'!
test02TwoSentencesInStackHaveTheSamePrefixwin

	| auxSentences |
	
	self fillStackWithSentencesFrom: sentencesWithWin .	
	
	auxSentences := sentenceFinder find: 'win'.		
	
	self assertThat: auxSentences hasEqualElementsWith: #( 'winter is coming' 'winning is everything' ).
	self assertThatStackIsUnchagedAfterSearchIn: sentencesWithWin.
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'RP 11/2/2021 22:50:32'!
test03OneSentenceFoundInStackWithPrefixWin

	| auxSentences |
	
	self fillStackWithSentencesFrom: sentencesWithWin .	
	
	auxSentences := sentenceFinder find: 'Win'.		
	
	self assertThat: auxSentences hasEqualElementsWith: #( 'Winter is here' ).
	self assertThatStackIsUnchagedAfterSearchIn: sentencesWithWin.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'sebas 11/2/2021 19:18:48'!
test04NoSentenceFoundInStackWithPrefixholis

	
	
	self fillStackWithSentencesFrom: sentencesWithWin .	

	foundSentences := sentenceFinder find: 'holis'.		
	
	self assert: ( foundSentences isEmpty ).
	self assertThatStackIsUnchagedAfterSearchIn: sentencesWithWin.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'sebas 11/2/2021 19:09:42'!
test05SearchCaseSensitive
	
	| resultLowerCasePrefix resultUpperCasePrefix |
	
	sentences :=  sentencesWithWin.
	resultLowerCasePrefix := OrderedCollection new.
	resultUpperCasePrefix := OrderedCollection new.
	
	self fillStackWithSentencesFrom: sentences.	
	
	resultUpperCasePrefix := sentenceFinder find: 'Win'.		
	resultLowerCasePrefix := sentenceFinder find: 'the'.
	
	self assertThat: resultUpperCasePrefix hasEqualElementsWith:#('Winter is here').
	self assert: resultLowerCasePrefix isEmpty.
	self assertThatStackIsUnchagedAfterSearchIn: sentencesWithWin 
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'sebas 11/2/2021 19:10:00'!
test06EmptyStackWithValidPrefix

	foundSentences := sentenceFinder find: 'The'.		
	
	self assert: foundSentences isEmpty.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'sebas 11/2/2021 19:15:12'!
test07EmptyStackWithInvalidPrefix

	self assertThatThis: 'The ' raisesInvalidPrefixErrorIn: sentenceFinder.
	self assert: sentencesStack isEmpty
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'sebas 11/2/2021 19:15:11'!
test08StackWithInvalidPrefix

	self fillStackWithSentencesFrom: sentencesWithPrefixThe.
	
	self assertThatThis: 'The ' raisesInvalidPrefixErrorIn: sentenceFinder.
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topNode'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'sebas 10/29/2021 20:03:45'!
initialize

	topNode := OOStackBaseNode new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'sebas 10/29/2021 19:59:02'!
isEmpty

	^topNode isEmpty.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'RP 11/2/2021 22:47:09'!
pop 

	| topNodeValue |
	
	topNodeValue := self top.
	topNode := topNode nextNode.
	
	^topNodeValue! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'sebas 10/29/2021 20:20:11'!
push: anElement

	| newTopNode |
	
	newTopNode  := OOStackRegularNode withValue: anElement beforeNode: topNode.
	
	topNode := newTopNode.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'RP 11/2/2021 22:46:58'!
size 

	^topNode size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'sebas 10/29/2021 20:14:00'!
top
	
	^topNode top.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackNode category: 'Stack-Exercise'!
Object subclass: #OOStackNode
	instanceVariableNames: 'nextNode content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNode methodsFor: 'as yet unclassified' stamp: 'sebas 10/29/2021 20:07:11'!
isEmpty
 	
	self subclassResponsibility ! !

!OOStackNode methodsFor: 'as yet unclassified' stamp: 'RP 11/2/2021 22:47:22'!
nextNode

 	self subclassResponsibility ! !

!OOStackNode methodsFor: 'as yet unclassified' stamp: 'sebas 10/29/2021 20:07:29'!
size
 	
	self subclassResponsibility ! !

!OOStackNode methodsFor: 'as yet unclassified' stamp: 'sebas 10/29/2021 20:07:32'!
top
 	
	self subclassResponsibility ! !


!classDefinition: #OOStackBaseNode category: 'Stack-Exercise'!
OOStackNode subclass: #OOStackBaseNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBaseNode methodsFor: 'as yet unclassified' stamp: 'sebas 10/29/2021 20:07:43'!
isEmpty

	^true! !

!OOStackBaseNode methodsFor: 'as yet unclassified' stamp: 'sebas 10/29/2021 20:08:20'!
nextNode

	OOStack error: OOStack stackEmptyErrorDescription.! !

!OOStackBaseNode methodsFor: 'as yet unclassified' stamp: 'sebas 10/29/2021 20:08:28'!
size 

	^0! !

!OOStackBaseNode methodsFor: 'as yet unclassified' stamp: 'sebas 10/29/2021 20:08:47'!
top

	OOStack error: OOStack stackEmptyErrorDescription ! !


!classDefinition: #OOStackRegularNode category: 'Stack-Exercise'!
OOStackNode subclass: #OOStackRegularNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackRegularNode methodsFor: 'as yet unclassified' stamp: 'RP 11/2/2021 15:37:32'!
initializeWithValue: nodeValue beforeNode: aNode

	nextNode := aNode.
	content := nodeValue.! !

!OOStackRegularNode methodsFor: 'as yet unclassified' stamp: 'sebas 10/29/2021 20:11:15'!
isEmpty

	^false.! !

!OOStackRegularNode methodsFor: 'as yet unclassified' stamp: 'sebas 10/29/2021 20:11:26'!
nextNode

	^nextNode.! !

!OOStackRegularNode methodsFor: 'as yet unclassified' stamp: 'sebas 10/29/2021 20:11:40'!
size

	^1 + (nextNode size).! !

!OOStackRegularNode methodsFor: 'as yet unclassified' stamp: 'RP 11/2/2021 15:37:32'!
top 
	^content.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackRegularNode class' category: 'Stack-Exercise'!
OOStackRegularNode class
	instanceVariableNames: ''!

!OOStackRegularNode class methodsFor: 'as yet unclassified' stamp: 'sebas 10/29/2021 20:13:31'!
withValue: nodeValue beforeNode: aNode

	^self new initializeWithValue: nodeValue beforeNode: aNode.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'sentenceStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'find' stamp: 'RP 11/2/2021 16:01:05'!
find: aPrefix

	| foundSentences |
	
	foundSentences := OrderedCollection new.
	
	self isValidPrefix: aPrefix.
	
	self findRecursively: aPrefix andStoreIn: foundSentences.
	
	^foundSentences .
	! !

!SentenceFinderByPrefix methodsFor: 'find' stamp: 'RP 11/2/2021 15:47:20'!
findRecursively: aPrefix andStoreIn: foundSentences

	| currentNodeValue |
	
	sentenceStack isEmpty ifTrue: [ ^self ].	
	
	currentNodeValue := sentenceStack pop.	
	( ( currentNodeValue findString: aPrefix ) = 1 ) ifTrue: [ foundSentences add: currentNodeValue ].
	
	self findRecursively: aPrefix andStoreIn: foundSentences .
	
	sentenceStack push: currentNodeValue .! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'RP 11/2/2021 15:14:30'!
initializeSentenceStackWith: aStack

	sentenceStack := aStack .! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'RP 11/2/2021 22:34:46'!
isValidPrefix: aPrefix
	
	( aPrefix isEmpty or: [ ( aPrefix findString: ' ' ) > 0 ] ) ifTrue: [ self error: SentenceFinderByPrefix invalidPrefixErrorDescription ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'RP 11/2/2021 15:17:22'!
invalidPrefixErrorDescription

	^'Invalid prefix!!'.! !


!SentenceFinderByPrefix class methodsFor: 'initialization' stamp: 'RP 11/2/2021 15:18:56'!
with: aStack

	^self new initializeSentenceStackWith: aStack.! !
