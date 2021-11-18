!classDefinition: #MarsRoverTests category: 'Ejercicio5_MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio5_MarsRover'!

!MarsRoverTests methodsFor: 'assertions' stamp: 'sm 11/17/2021 22:55:05'!
assertInvalidCommandErrorDescriptionRaisesIn: anInstruction
	
	self should: anInstruction 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: MarsRover invalidCommandErrorDescription equals: anError messageText.].! !


!MarsRoverTests methodsFor: 'running' stamp: 'sm 11/17/2021 23:01:06'!
changeMarsRoverDirectionTo: aDirection andExecuteAnInstruction: anInstruction.

	marsRover changeDirectionTo: aDirection.
	self executeAnInstructionForMarsRover: anInstruction .! !

!MarsRoverTests methodsFor: 'running' stamp: 'sm 11/17/2021 23:01:06'!
executeAnInstructionForMarsRover: anInstruction

	marsRover execute: anInstruction .! !


!MarsRoverTests methodsFor: 'setup' stamp: 'RP 11/16/2021 22:09:07'!
setUp

	| anInitialPoint |
	anInitialPoint := Point x: 0 y: 0.	
	marsRover := MarsRover withDirection: North new andInitialCoordinates: anInitialPoint.! !


!MarsRoverTests methodsFor: 'tests turning left' stamp: 'sm 11/17/2021 23:13:27'!
test01ElMarsRoverEstaApuntandoAlNorteYAlRotarALaIzquierdaApuntaAlOeste

	self executeAnInstructionForMarsRover: 'l'.
	
	self assert: (marsRover direction isWest ).! !

!MarsRoverTests methodsFor: 'tests turning left' stamp: 'sm 11/17/2021 23:01:31'!
test02ElMarsRoverEstaApuntandoAlOesteYAlRotarALaIzquierdaApuntaAlSur

	self changeMarsRoverDirectionTo: West new andExecuteAnInstruction: 'l'. 
	
	self assert: marsRover direction isSouth! !

!MarsRoverTests methodsFor: 'tests turning left' stamp: 'sm 11/17/2021 23:01:51'!
test03ElMarsRoverEstaApuntandoAlSurYAlRotarALaIzquierdaApuntaAlEste
	
	
	self changeMarsRoverDirectionTo: South new andExecuteAnInstruction: 'l'. 
	
	self assert: marsRover direction isEast ! !

!MarsRoverTests methodsFor: 'tests turning left' stamp: 'sm 11/17/2021 23:02:17'!
test04ElMarsRoverEstaApuntandoAlEsteYAlRotarALaIzquierdaApuntaAlNorte
	
	
	self changeMarsRoverDirectionTo: East new andExecuteAnInstruction: 'l'.
	
	self assert: marsRover direction isNorth ! !


!MarsRoverTests methodsFor: 'tests turning right' stamp: 'sm 11/17/2021 23:02:33'!
test05ElMarsRoverEstaApuntandoAlNorteYAlRotarALaDerechaApuntaAlEste
	
	self executeAnInstructionForMarsRover: 'r'.
	
	self assert: marsRover direction isEast 
! !

!MarsRoverTests methodsFor: 'tests turning right' stamp: 'sm 11/17/2021 23:02:54'!
test06ElMarsRoverEstaApuntandoAlEsteYAlRotarALaDerechaApuntaAlSur

	self changeMarsRoverDirectionTo: East new andExecuteAnInstruction: 'r'.
	
	self assert: marsRover direction isSouth 
! !

!MarsRoverTests methodsFor: 'tests turning right' stamp: 'sm 11/17/2021 23:03:10'!
test07ElMarsRoverEstaApuntandoAlSurYAlRotarALaDerechaApuntaAlOeste
	
	self changeMarsRoverDirectionTo: South new andExecuteAnInstruction: 'r'.
	
	self assert: marsRover direction isWest
! !

!MarsRoverTests methodsFor: 'tests turning right' stamp: 'sm 11/17/2021 23:03:49'!
test08ElMarsRoverEstaApuntandoAlOesteYAlRotarALaDerechaApuntaAlNorte
	
	self changeMarsRoverDirectionTo: West new  andExecuteAnInstruction: 'r'.
	
	self assert: marsRover direction isNorth! !


!MarsRoverTests methodsFor: 'tests moving forward' stamp: 'sm 11/17/2021 23:11:18'!
test09ElMarsRoverEstaApuntandoAlNorteYAlMoverseHaciaAdelanteSeMueveUnLugarEnDireccionNorte

	| finalCoordinates |
	finalCoordinates := Point x: 0 y: 1.
	self executeAnInstructionForMarsRover: 'f'.
	
	self assertThatMarsRoverPositionEqualsTo: finalCoordinates.	
	self assert: marsRover direction isNorth ! !

!MarsRoverTests methodsFor: 'tests moving forward' stamp: 'sm 11/17/2021 23:11:14'!
test10ElMarsRoverEstaApuntandoAlEsteYAlMoverseHaciaAdelanteSeMueveUnLugarEnDireccionEste

	|  finalCoordinates |
	finalCoordinates := Point x: 1 y: 0.
	self changeMarsRoverDirectionTo: East new  andExecuteAnInstruction: 'f'.
	
	self assertThatMarsRoverPositionEqualsTo: finalCoordinates.	
	self assert: marsRover direction isEast ! !

!MarsRoverTests methodsFor: 'tests moving forward' stamp: 'sm 11/17/2021 23:11:10'!
test11ElMarsRoverEstaApuntandoAlSurYAlMoverseHaciaAdelanteSeMueveUnLugarEnDireccionSur

	| finalCoordinates |
	finalCoordinates := Point x: 0 y: -1.
	self changeMarsRoverDirectionTo: South new  andExecuteAnInstruction: 'f'.
	
	self assertThatMarsRoverPositionEqualsTo: finalCoordinates.	
	self assert: marsRover direction isSouth ! !

!MarsRoverTests methodsFor: 'tests moving forward' stamp: 'sm 11/17/2021 23:11:06'!
test12ElMarsRoverEstaApuntandoAlOesteYAlMoverseHaciaAdelanteSeMueveUnLugarEnDireccionOeste

	| finalCoordinates |
	finalCoordinates := Point x: -1 y: 0.
	self changeMarsRoverDirectionTo: West new  andExecuteAnInstruction: 'f'.
	
	self assertThatMarsRoverPositionEqualsTo: finalCoordinates.	
	self assert: marsRover direction isWest ! !


!MarsRoverTests methodsFor: 'tests moving backward' stamp: 'sm 11/17/2021 23:11:01'!
test13ElMarsRoverEstaApuntandoAlNorteYAlMoverseHaciaAtrasSeMueveUnLugarEnDireccionSur

	| finalCoordinates |	
	finalCoordinates := Point x: 0 y: -1.
	self executeAnInstructionForMarsRover: 'b'.
	
	self assertThatMarsRoverPositionEqualsTo: finalCoordinates.	
	self assert: marsRover direction isNorth! !

!MarsRoverTests methodsFor: 'tests moving backward' stamp: 'sm 11/17/2021 23:10:57'!
test14ElMarsRoverEstaApuntandoAlEsteYAlMoverseHaciaAtrasSeMueveUnLugarEnDireccionOeste

	| finalCoordinates |	
	finalCoordinates := Point x: -1 y: 0.
	self changeMarsRoverDirectionTo: East new andExecuteAnInstruction: 'b'.
	
	self assertThatMarsRoverPositionEqualsTo: finalCoordinates.	
	self assert: marsRover direction isEast ! !

!MarsRoverTests methodsFor: 'tests moving backward' stamp: 'sm 11/17/2021 23:10:52'!
test15ElMarsRoverEstaApuntandoAlSurYAlMoverseHaciaAtrasSeMueveUnLugarEnDireccionNorte

	| finalCoordinates |
	finalCoordinates := Point x: 0 y: 1.
	self changeMarsRoverDirectionTo: South new andExecuteAnInstruction: 'b'.
	
	self assertThatMarsRoverPositionEqualsTo: finalCoordinates.	
	self assert: marsRover direction isSouth ! !

!MarsRoverTests methodsFor: 'tests moving backward' stamp: 'sm 11/17/2021 23:10:48'!
test16ElMarsRoverEstaApuntandoAlOesteYAlMoverseHaciaAtrasSeMueveUnLugarEnDireccionEste

	| finalCoordinates |
	finalCoordinates := Point x: 1 y: 0.
	self changeMarsRoverDirectionTo: West new andExecuteAnInstruction: 'b'.
	
	self assertThatMarsRoverPositionEqualsTo: finalCoordinates.	
	self assert: marsRover direction isWest ! !


!MarsRoverTests methodsFor: 'tests sets of instructions' stamp: 'sm 11/17/2021 23:15:02'!
assertThatMarsRoverPositionEqualsTo: finalCoordinates

	 self assert: finalCoordinates equals: marsRover position! !

!MarsRoverTests methodsFor: 'tests sets of instructions' stamp: 'sm 11/17/2021 23:10:43'!
test17ElMarsRoverRecibeUnaInstruccionErroneaYNoSeMueveNiCambiaLaDireccionYLanzaErrorDeInstruccionInvalida
	
	| finalCoordinates |
	finalCoordinates := Point x: 0 y: 0.
	
	self assertInvalidCommandErrorDescriptionRaisesIn: [marsRover execute: 'x'] .
						
	self assertThatMarsRoverPositionEqualsTo: finalCoordinates.	
	self assert: marsRover direction isNorth.
	
	! !

!MarsRoverTests methodsFor: 'tests sets of instructions' stamp: 'sm 11/17/2021 23:10:32'!
test18ElMarsRoverRecibeUnSetDeInstruccionesValidoYLasRealizaCorrectamente

	| finalCoordinates |
	finalCoordinates := Point x: -1 y: 2.
	self executeAnInstructionForMarsRover: 'frblf'.
	
	self assertThatMarsRoverPositionEqualsTo: finalCoordinates.	
	self assert: marsRover direction isNorth ! !

!MarsRoverTests methodsFor: 'tests sets of instructions' stamp: 'sm 11/17/2021 23:10:16'!
test19ElMarsRoverRecibeUnSetDeInstruccionesConUnComandoInvalidoYRealizaLasInstruccionesValidasHastaElComandoInvalidoYLanzaMensajeDeComandoInvalido

	| finalCoordinates |
	finalCoordinates := Point x: -1 y: 2.
	
	self assertInvalidCommandErrorDescriptionRaisesIn: [marsRover execute: 'frblfxfbb'].
						
	self assertThatMarsRoverPositionEqualsTo: finalCoordinates.	
	self assert: marsRover direction isNorth.! !


!classDefinition: #MarsRover category: 'Ejercicio5_MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'direction currentCoordinates'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio5_MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'RP 11/16/2021 19:06:11'!
pointingTo: aDirection atCoordinates: aPoint

	direction := 	aDirection.
	currentCoordinates := aPoint. ! !


!MarsRover methodsFor: 'commands' stamp: 'RP 11/18/2021 09:48:31'!
execute: anInstruction

	| aMarsRoverCommand |
	
	anInstruction do: [:aCommand | 
		( self isAValidCommand: aCommand ) ifFalse: [^ self error: MarsRover invalidCommandErrorDescription ].
		
		aMarsRoverCommand := MarsRoverCommand subclasses detect: [:subclass | subclass doesBelongToThisCommandSubclass: aCommand].
		aMarsRoverCommand new move: self.
		]
		! !

!MarsRover methodsFor: 'commands' stamp: 'RP 11/16/2021 22:17:10'!
isAValidCommand: aCommand

	^ (aCommand = $l) or: [aCommand = $r] or: [aCommand = $f] or: [aCommand = $b] 

	! !


!MarsRover methodsFor: 'moving' stamp: 'RP 11/17/2021 19:41:16'!
moveBackward

	direction keepByMovingBackward: self.	! !

!MarsRover methodsFor: 'moving' stamp: 'RP 11/17/2021 11:54:24'!
moveBackwardWhenPointingEast

	self translateWithVectorX: -1 andY: 0! !

!MarsRover methodsFor: 'moving' stamp: 'RP 11/17/2021 11:54:24'!
moveBackwardWhenPointingNorth

	self translateWithVectorX: 0 andY: -1! !

!MarsRover methodsFor: 'moving' stamp: 'RP 11/17/2021 11:54:24'!
moveBackwardWhenPointingSouth

	self translateWithVectorX: 0 andY: 1! !

!MarsRover methodsFor: 'moving' stamp: 'RP 11/17/2021 11:54:24'!
moveBackwardWhenPointingWest

	self translateWithVectorX: 1 andY: 0! !

!MarsRover methodsFor: 'moving' stamp: 'RP 11/17/2021 19:41:04'!
moveForward

	direction keepByMovingForward: self.	! !

!MarsRover methodsFor: 'moving' stamp: 'RP 11/17/2021 11:54:24'!
moveForwardWhenPointingEast

	self translateWithVectorX: 1 andY: 0! !

!MarsRover methodsFor: 'moving' stamp: 'RP 11/17/2021 11:54:24'!
moveForwardWhenPointingNorth

	self translateWithVectorX: 0 andY: 1! !

!MarsRover methodsFor: 'moving' stamp: 'RP 11/17/2021 11:54:24'!
moveForwardWhenPointingSouth

	self translateWithVectorX: 0 andY: -1! !

!MarsRover methodsFor: 'moving' stamp: 'RP 11/17/2021 11:54:24'!
moveForwardWhenPointingWest

	self translateWithVectorX: -1 andY: 0! !

!MarsRover methodsFor: 'moving' stamp: 'RP 11/17/2021 11:54:24'!
translateWithVectorX: xDisplacement andY: yDisplacement

	| translationVector |
	translationVector := Point x: xDisplacement y: yDisplacement . 
	currentCoordinates := currentCoordinates translatedBy: translationVector.! !


!MarsRover methodsFor: 'turning' stamp: 'RP 11/16/2021 21:36:15'!
changeDirectionTo: aDirection

	direction := aDirection ! !

!MarsRover methodsFor: 'turning' stamp: 'RP 11/17/2021 19:40:36'!
turnLeft

	direction changeByTurningLeft: self.	! !

!MarsRover methodsFor: 'turning' stamp: 'RP 11/16/2021 21:36:33'!
turnLeftWhenPointingEast

	self changeDirectionTo: North new.! !

!MarsRover methodsFor: 'turning' stamp: 'RP 11/16/2021 21:37:21'!
turnLeftWhenPointingNorth

	self changeDirectionTo: West new.! !

!MarsRover methodsFor: 'turning' stamp: 'RP 11/16/2021 21:37:31'!
turnLeftWhenPointingSouth
	
	self changeDirectionTo: East new! !

!MarsRover methodsFor: 'turning' stamp: 'RP 11/16/2021 21:37:46'!
turnLeftWhenPointingWest
	
	self changeDirectionTo: South new.! !

!MarsRover methodsFor: 'turning' stamp: 'RP 11/17/2021 19:40:45'!
turnRight

	direction changeByTurningRight: self.	! !

!MarsRover methodsFor: 'turning' stamp: 'RP 11/16/2021 21:38:00'!
turnRightWhenPointingEast
	
	self changeDirectionTo: South new.! !

!MarsRover methodsFor: 'turning' stamp: 'RP 11/16/2021 21:38:09'!
turnRightWhenPointingNorth
	
	self changeDirectionTo: East new.! !

!MarsRover methodsFor: 'turning' stamp: 'RP 11/16/2021 21:38:18'!
turnRightWhenPointingSouth
	
	self changeDirectionTo: West new.! !

!MarsRover methodsFor: 'turning' stamp: 'RP 11/16/2021 21:38:28'!
turnRightWhenPointingWest
	
	self changeDirectionTo: North new.! !


!MarsRover methodsFor: 'accessing' stamp: 'RP 11/17/2021 18:59:19'!
direction

	^direction.! !

!MarsRover methodsFor: 'accessing' stamp: 'RP 11/16/2021 19:06:50'!
position

	^currentCoordinates .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Ejercicio5_MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'RP 11/16/2021 20:13:37'!
invalidCommandErrorDescription

	^ 'Invalid Command!!' .! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'RP 11/16/2021 22:09:07'!
withDirection: aDirection andInitialCoordinates: aPairOfCoordinates

	^self new pointingTo: aDirection atCoordinates: aPairOfCoordinates .! !


!classDefinition: #MarsRoverCommand category: 'Ejercicio5_MarsRover'!
Object subclass: #MarsRoverCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio5_MarsRover'!

!MarsRoverCommand methodsFor: 'as yet unclassified' stamp: 'RP 11/17/2021 19:49:03'!
move: aMarsRover

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommand class' category: 'Ejercicio5_MarsRover'!
MarsRoverCommand class
	instanceVariableNames: ''!

!MarsRoverCommand class methodsFor: 'as yet unclassified' stamp: 'RP 11/17/2021 19:33:58'!
doesBelongToThisCommandSubclass: aCommand
	
	^self subclassResponsibility ! !


!classDefinition: #Backward category: 'Ejercicio5_MarsRover'!
MarsRoverCommand subclass: #Backward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio5_MarsRover'!

!Backward methodsFor: 'as yet unclassified' stamp: 'RP 11/17/2021 19:49:03'!
move: aMarsRover

	aMarsRover moveBackward ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Backward class' category: 'Ejercicio5_MarsRover'!
Backward class
	instanceVariableNames: ''!

!Backward class methodsFor: 'as yet unclassified' stamp: 'RP 11/17/2021 19:34:20'!
doesBelongToThisCommandSubclass: aCommand
	
	^aCommand = $b! !


!classDefinition: #Forward category: 'Ejercicio5_MarsRover'!
MarsRoverCommand subclass: #Forward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio5_MarsRover'!

!Forward methodsFor: 'as yet unclassified' stamp: 'RP 11/17/2021 19:49:03'!
move: aMarsRover

	aMarsRover moveForward ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Forward class' category: 'Ejercicio5_MarsRover'!
Forward class
	instanceVariableNames: ''!

!Forward class methodsFor: 'as yet unclassified' stamp: 'RP 11/17/2021 19:34:29'!
doesBelongToThisCommandSubclass: aCommand
	
	^aCommand = $f! !


!classDefinition: #Left category: 'Ejercicio5_MarsRover'!
MarsRoverCommand subclass: #Left
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio5_MarsRover'!

!Left methodsFor: 'as yet unclassified' stamp: 'RP 11/17/2021 19:49:03'!
move: aMarsRover

	aMarsRover turnLeft ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Left class' category: 'Ejercicio5_MarsRover'!
Left class
	instanceVariableNames: ''!

!Left class methodsFor: 'as yet unclassified' stamp: 'RP 11/17/2021 19:34:37'!
doesBelongToThisCommandSubclass: aCommand
	
	^aCommand = $l! !


!classDefinition: #Right category: 'Ejercicio5_MarsRover'!
MarsRoverCommand subclass: #Right
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio5_MarsRover'!

!Right methodsFor: 'as yet unclassified' stamp: 'RP 11/17/2021 19:49:03'!
move: aMarsRover

	aMarsRover turnRight ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Right class' category: 'Ejercicio5_MarsRover'!
Right class
	instanceVariableNames: ''!

!Right class methodsFor: 'as yet unclassified' stamp: 'RP 11/17/2021 19:34:46'!
doesBelongToThisCommandSubclass: aCommand
	
	^aCommand = $r! !


!classDefinition: #MarsRoverDirection category: 'Ejercicio5_MarsRover'!
Object subclass: #MarsRoverDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio5_MarsRover'!

!MarsRoverDirection methodsFor: 'actions' stamp: 'RP 11/16/2021 22:23:19'!
changeByTurningLeft: aMarsRover

	self subclassResponsibility .! !

!MarsRoverDirection methodsFor: 'actions' stamp: 'RP 11/16/2021 22:23:27'!
changeByTurningRight: aMarsRover

	self subclassResponsibility .! !

!MarsRoverDirection methodsFor: 'actions' stamp: 'RP 11/16/2021 22:23:54'!
keepByMovingBackward: aMarsRover

	self subclassResponsibility .! !

!MarsRoverDirection methodsFor: 'actions' stamp: 'RP 11/16/2021 22:24:09'!
keepByMovingForward: aMarsRover

	self subclassResponsibility .! !


!MarsRoverDirection methodsFor: 'testing' stamp: 'RP 11/16/2021 21:17:33'!
isEast

	^self subclassResponsibility ! !

!MarsRoverDirection methodsFor: 'testing' stamp: 'RP 11/16/2021 21:17:40'!
isNorth

	^self subclassResponsibility ! !

!MarsRoverDirection methodsFor: 'testing' stamp: 'RP 11/16/2021 21:17:44'!
isSouth

	^self subclassResponsibility ! !

!MarsRoverDirection methodsFor: 'testing' stamp: 'RP 11/16/2021 21:16:51'!
isWest

	^self subclassResponsibility ! !


!classDefinition: #East category: 'Ejercicio5_MarsRover'!
MarsRoverDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio5_MarsRover'!

!East methodsFor: 'actions' stamp: 'RP 11/16/2021 22:23:19'!
changeByTurningLeft: aMarsRover

	aMarsRover turnLeftWhenPointingEast .! !

!East methodsFor: 'actions' stamp: 'RP 11/16/2021 22:23:27'!
changeByTurningRight: aMarsRover

	aMarsRover turnRightWhenPointingEast ! !

!East methodsFor: 'actions' stamp: 'RP 11/16/2021 22:23:54'!
keepByMovingBackward: aMarsRover

	aMarsRover moveBackwardWhenPointingEast ! !

!East methodsFor: 'actions' stamp: 'RP 11/16/2021 22:24:09'!
keepByMovingForward: aMarsRover

	aMarsRover moveForwardWhenPointingEast ! !


!East methodsFor: 'testing' stamp: 'RP 11/16/2021 21:19:33'!
isEast

	^true! !

!East methodsFor: 'testing' stamp: 'RP 11/16/2021 21:19:22'!
isNorth

	^false! !

!East methodsFor: 'testing' stamp: 'RP 11/16/2021 21:19:26'!
isSouth

	^false! !

!East methodsFor: 'testing' stamp: 'RP 11/16/2021 21:19:19'!
isWest

	^false! !


!classDefinition: #North category: 'Ejercicio5_MarsRover'!
MarsRoverDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio5_MarsRover'!

!North methodsFor: 'actions' stamp: 'RP 11/16/2021 22:23:19'!
changeByTurningLeft: aMarsRover

	aMarsRover turnLeftWhenPointingNorth! !

!North methodsFor: 'actions' stamp: 'RP 11/16/2021 22:23:27'!
changeByTurningRight: aMarsRover

	aMarsRover turnRightWhenPointingNorth ! !

!North methodsFor: 'actions' stamp: 'RP 11/16/2021 22:23:54'!
keepByMovingBackward: aMarsRover

	aMarsRover moveBackwardWhenPointingNorth ! !

!North methodsFor: 'actions' stamp: 'RP 11/16/2021 22:24:09'!
keepByMovingForward: aMarsRover

	aMarsRover moveForwardWhenPointingNorth ! !


!North methodsFor: 'testing' stamp: 'RP 11/16/2021 21:18:53'!
isEast
	
	^false! !

!North methodsFor: 'testing' stamp: 'RP 11/16/2021 21:19:02'!
isNorth
	
	^true! !

!North methodsFor: 'testing' stamp: 'RP 11/16/2021 21:18:56'!
isSouth
	
	^false! !

!North methodsFor: 'testing' stamp: 'RP 11/16/2021 21:18:49'!
isWest
	
	^false! !


!classDefinition: #South category: 'Ejercicio5_MarsRover'!
MarsRoverDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio5_MarsRover'!

!South methodsFor: 'actions' stamp: 'RP 11/16/2021 22:23:19'!
changeByTurningLeft: aMarsRover

	aMarsRover turnLeftWhenPointingSouth ! !

!South methodsFor: 'actions' stamp: 'RP 11/16/2021 22:23:27'!
changeByTurningRight: aMarsRover

	aMarsRover turnRightWhenPointingSouth ! !

!South methodsFor: 'actions' stamp: 'RP 11/16/2021 22:23:54'!
keepByMovingBackward: aMarsRover

	aMarsRover moveBackwardWhenPointingSouth ! !

!South methodsFor: 'actions' stamp: 'RP 11/16/2021 22:24:09'!
keepByMovingForward: aMarsRover

	aMarsRover moveForwardWhenPointingSouth ! !


!South methodsFor: 'testing' stamp: 'RP 11/16/2021 21:18:28'!
isEast
	
	^false! !

!South methodsFor: 'testing' stamp: 'RP 11/16/2021 21:18:31'!
isNorth
	
	^false! !

!South methodsFor: 'testing' stamp: 'RP 11/16/2021 21:18:37'!
isSouth
	
	^true! !

!South methodsFor: 'testing' stamp: 'RP 11/16/2021 21:18:22'!
isWest
	
	^false! !


!classDefinition: #West category: 'Ejercicio5_MarsRover'!
MarsRoverDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio5_MarsRover'!

!West methodsFor: 'actions' stamp: 'RP 11/16/2021 22:23:19'!
changeByTurningLeft: aMarsRover

	aMarsRover turnLeftWhenPointingWest ! !

!West methodsFor: 'actions' stamp: 'RP 11/16/2021 22:23:27'!
changeByTurningRight: aMarsRover

	aMarsRover turnRightWhenPointingWest ! !

!West methodsFor: 'actions' stamp: 'RP 11/16/2021 22:23:54'!
keepByMovingBackward: aMarsRover

	aMarsRover moveBackwardWhenPointingWest ! !

!West methodsFor: 'actions' stamp: 'RP 11/16/2021 22:24:09'!
keepByMovingForward: aMarsRover

	aMarsRover moveForwardWhenPointingWest ! !


!West methodsFor: 'testing' stamp: 'RP 11/16/2021 21:18:12'!
isEast

	^false! !

!West methodsFor: 'testing' stamp: 'RP 11/16/2021 21:18:00'!
isNorth

	^false! !

!West methodsFor: 'testing' stamp: 'RP 11/16/2021 21:18:07'!
isSouth

	^false! !

!West methodsFor: 'testing' stamp: 'RP 11/16/2021 21:17:00'!
isWest

	^true! !
