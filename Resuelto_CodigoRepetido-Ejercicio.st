!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'tests' stamp: 'RP 10/12/2021 21:34:12'!
addAndSuspendCustomerNamed: aCustomer from: aCustomerBook

	aCustomerBook addCustomerNamed: aCustomer.
	aCustomerBook suspendCustomerNamed: aCustomer.

	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'RP 10/12/2021 21:20:51'!
assertThat: aCustomerBook hasATotalOfActiveCustomers: aNumberOfActiveCustomers andATotalOfSuspendedCustomers: aNumberOfSuspendedCustomers

	self assert: aNumberOfActiveCustomers equals: ( aCustomerBook numberOfActiveCustomers ).
	self assert: aNumberOfSuspendedCustomers equals: ( aCustomerBook numberOfSuspendedCustomers ).
	self assert: ( aNumberOfActiveCustomers + aNumberOfSuspendedCustomers ) equals: ( aCustomerBook numberOfCustomers ).
	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'RP 10/12/2021 21:34:16'!
assertThat: aCustomerBook hasOnlyThis: aCustomer

	self assert: (aCustomerBook numberOfCustomers = 1).
	self assert: (aCustomerBook includesCustomerNamed: aCustomer).
	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'Sebas 10/13/2021 13:04:22'!
assertThatFailingThis: aCodeToFail withError: anError proceedToRunThis: aCodeToRun
	[aCodeToFail value. self fail]
	on: anError
	do: aCodeToRun.
	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'RP 10/12/2021 21:34:20'!
assertThatRunning: anAction doesntTakeMoreThan: aTime

	| miliseconds |
	
	miliseconds := anAction timeToRun. 
	self assert: miliseconds < aTime.
	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'RP 10/12/2021 21:34:26'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	|customerJohnLennon customerBook|	
	
	customerBook := CustomerBook new.	
	customerJohnLennon := 'John Lennon'.
	
	self assertThatRunning: [customerBook addCustomerNamed: customerJohnLennon] doesntTakeMoreThan: 50 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'RP 10/12/2021 21:31:47'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	
	|customerPaulMcCartney customerBook|
	
	customerBook := CustomerBook new.
	customerPaulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: customerPaulMcCartney.
	
	self assertThatRunning: [customerBook removeCustomerNamed: customerPaulMcCartney] doesntTakeMoreThan: 100 * millisecond. 
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'Sebas 10/13/2021 13:03:34'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self assertThatFailingThis: [customerBook addCustomerNamed: ''.]
		withError: Error
		proceedToRunThis: [:anError | self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage. 
					self assert: customerBook isEmpty ]
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'Sebas 10/13/2021 13:03:34'!
test04CanNotRemoveAnInvalidCustomer
	
	|customerBook customerJohnLennon|
			
	customerBook := CustomerBook new.
	customerJohnLennon := 'John Lennon'.
	customerBook addCustomerNamed: customerJohnLennon.
	
	self assertThatFailingThis: [customerBook removeCustomerNamed: 'Paul McCartney' .]
	withError: NotFound
	proceedToRunThis: [:anError | self assertThat: customerBook hasOnlyThis: customerJohnLennon]! !

!CustomerBookTest methodsFor: 'tests' stamp: 'RP 10/12/2021 21:32:23'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook customerPaulMcCartney|
	
	customerBook := CustomerBook new.
	customerPaulMcCartney := 'Paul McCartney'.
	
	self addAndSuspendCustomerNamed: customerPaulMcCartney from: customerBook.
	
	self assertThat: customerBook hasATotalOfActiveCustomers: 0 andATotalOfSuspendedCustomers: 1. 
	self assert: (customerBook includesCustomerNamed: customerPaulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'RP 10/12/2021 21:33:44'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook customerPaulMcCartney|
	
	customerBook := CustomerBook new.
	customerPaulMcCartney := 'Paul McCartney'.
	
	self addAndSuspendCustomerNamed: customerPaulMcCartney from: customerBook.	 
	customerBook removeCustomerNamed: customerPaulMcCartney.
	
	self assertThat: customerBook hasATotalOfActiveCustomers: 0 andATotalOfSuspendedCustomers: 0.
	self deny: (customerBook includesCustomerNamed: customerPaulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'Sebas 10/13/2021 13:03:34'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook customerJohnLennon |
			
	customerBook := CustomerBook new.
	customerJohnLennon := 'John Lennon'.
	customerBook addCustomerNamed: customerJohnLennon.
	
	self assertThatFailingThis: [customerBook suspendCustomerNamed: 'Ringo Starr'] 
		withError: CantSuspend
		proceedToRunThis: [:anError | self assertThat: customerBook hasOnlyThis: customerJohnLennon].
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'Sebas 10/13/2021 13:03:34'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook customerJohnLennon |
			
	customerBook := CustomerBook new.
	customerJohnLennon := 'John Lennon'.
	
	self addAndSuspendCustomerNamed: customerJohnLennon from: customerBook.
	
	self assertThatFailingThis: [customerBook suspendCustomerNamed: customerJohnLennon]
		withError: CantSuspend
		proceedToRunThis: [:anError | self assertThat: customerBook hasOnlyThis: customerJohnLennon]
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'LL 10/30/2020 12:22:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'RP 10/12/2021 21:34:49'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	( self includesCustomerNamed: aName ) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'RP 10/12/2021 21:35:04'!
removeCustomerNamed: aName 

	^active remove: aName ifAbsent: [^suspended remove: aName ifAbsent: [^NotFound signal.]]! !

!CustomerBook methodsFor: 'customer management' stamp: 'RP 10/12/2021 21:35:11'!
suspendCustomerNamed: aName 

	active remove: aName ifAbsent: [^CantSuspend signal].
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'RP 10/12/2021 21:35:25'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
