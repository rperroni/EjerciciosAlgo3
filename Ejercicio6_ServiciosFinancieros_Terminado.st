!classDefinition: #PortfolioTests category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTests
	instanceVariableNames: 'account1 account2 portfolioA portfolioB'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTests methodsFor: 'assertions' stamp: 'RP 11/28/2021 11:40:12'!
assertThat: aPortfolio finds: aListOfTransactions

	self assert: aListOfTransactions equals: aPortfolio transactions! !

!PortfolioTests methodsFor: 'assertions' stamp: 'RP 11/27/2021 23:29:22'!
assertThat: aPortfolio hasBalance: anExpectedBalance

	self assert: anExpectedBalance equals: aPortfolio balance! !

!PortfolioTests methodsFor: 'assertions' stamp: 'RP 11/27/2021 23:34:29'!
assertThat: anAction shouldRaise: anError

	self should: anAction 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :error | self assert: error messageText equals: anError]! !

!PortfolioTests methodsFor: 'assertions' stamp: 'RP 11/27/2021 23:50:10'!
assertThatANewPortfolioHasZeroBalance

	self assert: 0*peso equals: Portfolio new balance! !

!PortfolioTests methodsFor: 'assertions' stamp: 'RP 11/27/2021 23:38:21'!
assertThatAnyAccountIn: aPortfolio hasRegistered: aTransaction

	self assert: ( aPortfolio anyAccountHasRegistered: aTransaction )! !

!PortfolioTests methodsFor: 'assertions' stamp: 'RP 11/28/2021 11:40:12'!
assertThatTheAmountOfTransactionsOf: aPortfolio is: anAmountOfTransactions

	self assert: anAmountOfTransactions equals: ( aPortfolio transactions size )! !


!PortfolioTests methodsFor: 'tests - balance' stamp: 'RP 11/27/2021 23:27:47'!
test01APortfolioWithNoAccountsHasZeroBalance
	
	self assertThatANewPortfolioHasZeroBalance.! !

!PortfolioTests methodsFor: 'tests - balance' stamp: 'RP 11/27/2021 23:55:02'!
test02APortfolioWithOneAccountHasTheBalanceOfThatAccount

	self register: Deposit for: 100*peso  on: account1 andAddTo: portfolioA .
	
	self assertThat: portfolioA hasBalance: 100*peso .! !

!PortfolioTests methodsFor: 'tests - balance' stamp: 'RP 11/27/2021 23:54:52'!
test03APortfolioWithMoreThanOneAccountHasTheSumOfTheAccountsBalancesAsBalance

	self register: Deposit for: 100*peso  on: account1 andAddTo: portfolioA .
	self register: Deposit for: 200*peso  on: account2 andAddTo: portfolioA .
	
	self assertThat: portfolioA hasBalance: 300*peso.! !

!PortfolioTests methodsFor: 'tests - balance' stamp: 'RP 11/28/2021 00:06:57'!
test10APortfolioWithAccountsAndPortfoliosHasTheSumOfTheAccountsAndPortfoliosBalanceAsBalance

	self register: Deposit for: 100*peso on: account1 andAddTo: portfolioA .
	self register: Deposit for: 200*peso on: account2 andAddTo: portfolioB .
	
	portfolioA add: portfolioB.
	
	self assertThat: portfolioA hasBalance: 300*peso.! !


!PortfolioTests methodsFor: 'tests - check transactions' stamp: 'RP 11/28/2021 00:29:00'!
test04APortfolioWithOneAccountFindsThatAccountsTransaction

	| aDeposit |
	aDeposit := self register: Deposit for: 100*peso on: account1 andAddTo: portfolioA .
	
	self assertThatAnyAccountIn: portfolioA hasRegistered: aDeposit ! !

!PortfolioTests methodsFor: 'tests - check transactions' stamp: 'RP 11/27/2021 16:01:03'!
test05APortfolioWithOneAccountDoesntFindANonRegisteredTransaction

	| aWithdraw |
	aWithdraw := Withdraw for: 5*peso.
	
	portfolioA add: account1.
	
	self deny: ( portfolioA anyAccountHasRegistered: aWithdraw)! !

!PortfolioTests methodsFor: 'tests - check transactions' stamp: 'RP 11/28/2021 00:02:33'!
test06APortfolioWithMoreThanOneAccountFindsATransactionRegisteredOnAnySavedAccount

	| aDeposit |
	aDeposit := self register: Deposit for: 100*peso on: account2 andAddTo: portfolioA .
	
	portfolioA add: account1.
	
	self assertThatAnyAccountIn: portfolioA hasRegistered: aDeposit! !

!PortfolioTests methodsFor: 'tests - check transactions' stamp: 'RP 11/28/2021 00:07:59'!
test11APortfolioWithAccountsAndPortfoliosFindsATransactionRegisteredOnAnyAccount

	| aDeposit |
	aDeposit := self register: Deposit for: 100*peso on: account2 andAddTo: portfolioB .
	
	portfolioA add: account1.
	portfolioA add: portfolioB.
	
	self assertThatAnyAccountIn: portfolioA hasRegistered: aDeposit! !


!PortfolioTests methodsFor: 'tests - find transactions' stamp: 'RP 11/27/2021 23:44:37'!
test07APortfolioWithOneAccountWithNoTransactionsHasNoTransactions

	portfolioA add: account1.
	
	self assertThatTheAmountOfTransactionsOf: portfolioA is: 0.! !

!PortfolioTests methodsFor: 'tests - find transactions' stamp: 'RP 11/28/2021 11:14:05'!
test08APortfolioWithOneAccountFindThatAccountsTransactions

	| totalTransactions|
	
	totalTransactions := OrderedCollection new.
	totalTransactions add: ( self register: Deposit for: 100*peso on: account1 andAddTo: portfolioA ).
	
	self assertThat: portfolioA finds: totalTransactions .
	self assertThatTheAmountOfTransactionsOf: portfolioA is: 1.! !

!PortfolioTests methodsFor: 'tests - find transactions' stamp: 'RP 11/28/2021 11:14:10'!
test09APortfolioWithMoreThanOneAccountsFindsAllThoseAccountsTransactions

	| totalTransactions|
	
	totalTransactions := OrderedCollection new.
	totalTransactions add: ( self register: Deposit for: 100*peso on: account1 andAddTo: portfolioA ).
	totalTransactions add: ( self register: Deposit for: 10*peso on: account2 andAddTo: portfolioA ).
	
	self assertThat: portfolioA finds: totalTransactions .
	self assertThatTheAmountOfTransactionsOf: portfolioA is: 2.! !

!PortfolioTests methodsFor: 'tests - find transactions' stamp: 'RP 11/28/2021 11:15:05'!
test12APortfolioWithAccountsAndPortfoliosFindsAllAccountsAndPortfoliosTransactions

	| totalTransactions |
	totalTransactions := OrderedCollection new.
	totalTransactions add: ( self register: Deposit for: 100*peso on: account1 andAddTo: portfolioA ).
	totalTransactions add: ( self register: Deposit for: 100*peso on: account2 andAddTo: portfolioB ).
	
	portfolioA add: portfolioB.
	
	self assertThat: portfolioA finds: totalTransactions .	
	self assertThatTheAmountOfTransactionsOf: portfolioA is: 2.! !


!PortfolioTests methodsFor: 'tests - error cases' stamp: 'RP 11/27/2021 23:34:11'!
test13APortfolioCannotAddTheSameAccountTwice

	portfolioA add: account1.
	
	self assertThat: [ portfolioA add: account1 ] shouldRaise: Portfolio cannotAddSameAccountTwiceErrorDescription.
	
	! !

!PortfolioTests methodsFor: 'tests - error cases' stamp: 'RP 11/28/2021 00:09:44'!
test14APortfolioCannotAddAnAccountIncludedInASavedPortfolio
	
	portfolioB add: account1.	
	portfolioA add: portfolioB.	
	
	self assertThat: [ portfolioA add: account1 ] shouldRaise: Portfolio cannotAddAccountIncludedInASavedPortfolioErrorDescription
	
	! !

!PortfolioTests methodsFor: 'tests - error cases' stamp: 'RP 11/27/2021 23:35:32'!
test15APortfolioCannotContainItSelf
	
	self assertThat: [ portfolioA add: portfolioA ] shouldRaise: Portfolio cannotContainItselfErrorDescription
	
	! !

!PortfolioTests methodsFor: 'tests - error cases' stamp: 'RP 11/28/2021 11:06:12'!
test16APortfolioCannotBeAddedToAnotherPortfolioIfTheyHaveAlLeastOneCommonAccount
	
	portfolioB add: account1.	
	portfolioA add: account1 .	
	
	self assertThat: [ portfolioA add: portfolioB.	] shouldRaise: Portfolio cannotBeAddedToAPortfolioIfTheyShareAnAccountErrorDescription
	
	! !

!PortfolioTests methodsFor: 'tests - error cases' stamp: 'RP 11/27/2021 23:36:22'!
test18APortfolioCannotAddAnAccountToASavedPortfolioIfTheAccountIsAlreadyInTheFirstPortfolio
	
	portfolioA add: account1 .	
	portfolioA add: portfolioB .	
	
	self assertThat: [ portfolioA add: account1 to: portfolioB ] shouldRaise: Portfolio cannotAddASavedAccountToASavedPortfolioErrorDescription
	! !


!PortfolioTests methodsFor: 'tests - other' stamp: 'RP 11/27/2021 23:49:20'!
test17APortfolioAddsAnAccountToASavedPortfolio

	portfolioA add: portfolioB .	
	portfolioA add: account1 to: portfolioB.
	
	self assert: ( portfolioA find: portfolioB )
	
	! !


!PortfolioTests methodsFor: 'setUp' stamp: 'RP 11/28/2021 00:01:32'!
register: aTransaction for: anAmountOfMoney on: anAccount andAddTo: aPortfolio

	| transactionPerformed |

	transactionPerformed := aTransaction register: anAmountOfMoney on: anAccount .
	aPortfolio add: anAccount.
	
	^transactionPerformed .! !

!PortfolioTests methodsFor: 'setUp' stamp: 'RP 11/27/2021 16:01:21'!
setUp

	account1 := ReceptiveAccount new.	
	account2 := ReceptiveAccount new.
	
	portfolioA := Portfolio new.	
	portfolioB := Portfolio new.! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferenceTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: 'originAccount destinationAccount transference transferenceDeposit transferenceWithdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceTest methodsFor: 'testing' stamp: 'sm 11/22/2021 17:23:08'!
setUp

	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	transference :=Transference transfer: (100*peso) from: originAccount to: destinationAccount.
	
	transferenceDeposit := transference deposit.
	transferenceWithdraw := transference withdraw.! !

!TransferenceTest methodsFor: 'testing' stamp: 'RP 11/28/2021 11:17:58'!
test01TheTransferAmountHasChangedTheOriginAccountAndTheDestinationAccount

	self assertTheAccount: originAccount balanceIs: -100*peso.
	self assertTheAccount: destinationAccount balanceIs: 100*peso.
	
	
	! !

!TransferenceTest methodsFor: 'testing' stamp: 'RP 11/28/2021 11:18:04'!
test02TheTransferenceAmountIsCorrect

	self assert: 100*peso equals: transference amount.
	
	
	
	! !

!TransferenceTest methodsFor: 'testing' stamp: 'RP 11/28/2021 11:18:10'!
test03TheCounterpartOfTheDepositEqualsTheWithdraw
	
	self assertTheTransferencePart: transferenceWithdraw equalsItsCounterpart: transferenceDeposit.
	
	
	
	! !

!TransferenceTest methodsFor: 'testing' stamp: 'RP 11/28/2021 11:18:14'!
test04TheCounterpartOfTheWithdrawEqualsTheDeposit

	self assertTheTransferencePart: transferenceDeposit equalsItsCounterpart: transferenceWithdraw.
	
	
	
	! !

!TransferenceTest methodsFor: 'testing' stamp: 'RP 11/25/2021 20:47:41'!
test05TransferenceWithTheSameAccountCannotBeDone

	self assertThatThis: [Transference transfer: (50*peso) from: originAccount to: originAccount ] 
	raisesThisError: 
	Transference tranferFromAndToSameAccountErrorDescription .

	
	
	
	! !

!TransferenceTest methodsFor: 'testing' stamp: 'RP 11/25/2021 20:47:29'!
test06ATransferenceWithZeroPesosCannotBeDone

	
	self assertThatThis: [Transference transfer: (0*peso) from: originAccount to: destinationAccount ]  
	raisesThisError: 
	Transference invalidTransferAmountErrorDescription .

	
	
	
	! !


!TransferenceTest methodsFor: 'assertions' stamp: 'sm 11/25/2021 15:38:56'!
assertThatThis: aCodeBlock raisesThisError: aTypeOfError.

	self should: aCodeBlock 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: anError messageText equals: aTypeOfError.].

	
	
	
	! !

!TransferenceTest methodsFor: 'assertions' stamp: 'RP 11/28/2021 11:17:43'!
assertTheAccount: anAccount balanceIs: anExpectedBalanace.
	
	self assert: anExpectedBalanace equals: anAccount balance.
	
	
	! !

!TransferenceTest methodsFor: 'assertions' stamp: 'RP 11/28/2021 11:17:35'!
assertTheTransferencePart: aTransferencePart equalsItsCounterpart: aTransferenceCounterpart
	
	self assert: aTransferencePart equals: (aTransferenceCounterpart counterpart ).
	
	
	
	! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'sm 11/25/2021 19:40:02'!
effectOnBalance: anAccountBalance

	^anAccountBalance + self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'sm 11/25/2021 19:40:08'!
effectOnBalance: anAccountBalance

	^anAccountBalance - self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'additions' stamp: 'RP 11/27/2021 23:26:51'!
add: anAccountOrPortfolio

	anAccountOrPortfolio beAddedTo: self.! !

!Portfolio methodsFor: 'additions' stamp: 'RP 11/27/2021 15:32:56'!
add: anAccountOrPortfolio to: aPortfolio

	( self find: anAccountOrPortfolio ) ifTrue: [^self error: Portfolio cannotAddASavedAccountToASavedPortfolioErrorDescription ].

	aPortfolio add: anAccountOrPortfolio .! !

!Portfolio methodsFor: 'additions' stamp: 'RP 11/27/2021 23:13:34'!
addAccount: aReceptiveAccount 
	
	( self find: aReceptiveAccount ) ifTrue: [ ^self error: Portfolio cannotAddSameAccountTwiceErrorDescription ] .
	
	portfolios do: [ :aPortfolio | ( aPortfolio find: aReceptiveAccount ) ifTrue: [^self error: Portfolio cannotAddAccountIncludedInASavedPortfolioErrorDescription  ] ].
	
	accounts add: aReceptiveAccount .! !

!Portfolio methodsFor: 'additions' stamp: 'RP 11/27/2021 23:17:28'!
addPortfolio: aPortfolio 

	(self = aPortfolio) ifTrue: [^self error: Portfolio cannotContainItselfErrorDescription ].
	
	accounts do: [ :anAccount | ( aPortfolio find: anAccount ) ifTrue: [ ^self error: Portfolio cannotBeAddedToAPortfolioIfTheyShareAnAccountErrorDescription ] ].
	
	portfolios add: aPortfolio .! !

!Portfolio methodsFor: 'additions' stamp: 'RP 11/27/2021 22:56:11'!
beAddedTo: aPortfolio

	aPortfolio addPortfolio: self.! !


!Portfolio methodsFor: 'public' stamp: 'RP 11/27/2021 23:48:01'!
find: anAccountOrPortfolio

	^ ( accounts includes: anAccountOrPortfolio ) or: [ portfolios includes: anAccountOrPortfolio ].! !

!Portfolio methodsFor: 'public' stamp: 'RP 11/27/2021 23:12:49'!
initialize

	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'RP 11/27/2021 23:25:06'!
anyAccountHasRegistered: aTransaction 
	
	accounts do: [ :anAccount |  ( anAccount hasRegistered: aTransaction ) ifTrue: [^true] ] .
	portfolios do: [ :aPortfolio |  ( aPortfolio anyAccountHasRegistered: aTransaction ) ifTrue: [^true] ] .
	^false.! !

!Portfolio methodsFor: 'main protocol' stamp: 'RP 11/28/2021 00:49:13'!
balance

	^( self totalBalanceOf: accounts ) + ( self totalBalanceOf: portfolios ).	! !

!Portfolio methodsFor: 'main protocol' stamp: 'RP 11/28/2021 11:43:02'!
transactions

	| allTransactions |
	allTransactions := OrderedCollection new.
	
	self addAllTransactionsOf: accounts to: allTransactions .
	self addAllTransactionsOf: portfolios to: allTransactions .

	^allTransactions.! !


!Portfolio methodsFor: 'private' stamp: 'RP 11/28/2021 11:42:20'!
addAllTransactionsOf: aListOfAccountsOrPortfolios to: aListOfTransactions

	aListOfAccountsOrPortfolios do: [ :anAccount | 		aListOfTransactions addAll: anAccount transactions		].

	! !

!Portfolio methodsFor: 'private' stamp: 'RP 11/28/2021 00:25:39'!
totalBalanceOf: aListOfAccountsOrPortfolios

	^ aListOfAccountsOrPortfolios sum: [ :anElement | anElement balance ] ifEmpty: [0*peso]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'RP 11/27/2021 15:32:02'!
cannotAddASavedAccountToASavedPortfolioErrorDescription

	^'Portfolio cannot add an account to a saved portfolio if the account is part of the first portfolio!!'.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'RP 11/27/2021 14:00:45'!
cannotAddAccountIncludedInASavedPortfolioErrorDescription

	^'Portfolio cannot add an account that is included into another portfolio within the portfolio!!'.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'RP 11/25/2021 21:06:04'!
cannotAddSameAccountTwiceErrorDescription

	^'An account cannot be added twice to the same portfolio!!'.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'RP 11/27/2021 14:57:44'!
cannotBeAddedToAPortfolioIfTheyShareAnAccountErrorDescription

	^'If two portfolios include the same account, then they cannot be included in eachother!!'.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'RP 11/27/2021 14:56:54'!
cannotContainItselfErrorDescription
	^'A portfolio cannot contain itself!!'.
	! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'RP 11/28/2021 11:16:41'!
balance

	^transactions inject: 0 * peso into: [:runningBalance :aTransaction | aTransaction effectOnBalance: runningBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'RP 11/27/2021 15:13:33'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'RP 11/27/2021 22:56:20'!
beAddedTo: aPortfolio

	aPortfolio addAccount: self.! !


!classDefinition: #Transference category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transference
	instanceVariableNames: 'amount withdraw deposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transference methodsFor: 'as yet unclassified' stamp: 'sm 11/22/2021 16:12:53'!
amount

	^amount

	! !

!Transference methodsFor: 'as yet unclassified' stamp: 'sm 11/22/2021 17:00:48'!
deposit

	^deposit.
	! !

!Transference methodsFor: 'as yet unclassified' stamp: 'sm 11/25/2021 19:36:12'!
with: anAmount  from: anOriginAccount to: aDestinationAccout

	
	(anOriginAccount = aDestinationAccout) ifTrue:[^self error: Transference tranferFromAndToSameAccountErrorDescription ].
	
	((0*peso) = anAmount) ifTrue:[^self error: Transference invalidTransferAmountErrorDescription ].
	
	
	amount := anAmount.
	
	withdraw := TransferenceWithdraw associatedWith: self.
	
	deposit := TransferenceDeposit associatedWith: self.
	
	anOriginAccount register: withdraw.
	aDestinationAccout register: deposit.
	
	
	
	
	
	
	"Withdraw register: anAmount on: anOriginAccount.
	Deposit register: anAmount on: aDestinationAccout."
	
	

	! !

!Transference methodsFor: 'as yet unclassified' stamp: 'sm 11/22/2021 17:00:54'!
withdraw
	
	^withdraw.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'ServiciosFinancieros-Ejercicio'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'as yet unclassified' stamp: 'sm 11/25/2021 14:58:32'!
invalidTransferAmountErrorDescription

	^'Transfer amount cannot be zero!!'.! !

!Transference class methodsFor: 'as yet unclassified' stamp: 'sm 11/25/2021 14:46:48'!
tranferFromAndToSameAccountErrorDescription

	^'Cannot transfer from and to the same account!!'.! !

!Transference class methodsFor: 'as yet unclassified' stamp: 'sm 11/22/2021 16:19:24'!
transfer: anAmount  from: anOriginAccount to: aDestinationAccout
	
	"amount := anAmount.
	Withdraw register: anAmount on: anOriginAccount.
	Deposit register: anAmount on: aDestinationAccout."
	
	^self new with: anAmount from: anOriginAccount to: aDestinationAccout.
	! !


!classDefinition: #TransferenceTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransferenceTransaction
	instanceVariableNames: 'associatedTransference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceTransaction methodsFor: 'as yet unclassified' stamp: 'sm 11/22/2021 17:53:42'!
counterpart

	self subclassResponsibility ! !

!TransferenceTransaction methodsFor: 'as yet unclassified' stamp: 'sm 11/25/2021 19:35:13'!
effectOnBalance: anAccountBalance

	self subclassResponsibility ! !

!TransferenceTransaction methodsFor: 'as yet unclassified' stamp: 'sm 11/22/2021 18:03:53'!
initializeWith: aTransference

	associatedTransference := aTransference.
 ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
TransferenceTransaction class
	instanceVariableNames: ''!

!TransferenceTransaction class methodsFor: 'as yet unclassified' stamp: 'sm 11/22/2021 18:05:13'!
associatedWith: aTransference 
	^self new initializeWith: aTransference.! !


!classDefinition: #TransferenceDeposit category: 'ServiciosFinancieros-Ejercicio'!
TransferenceTransaction subclass: #TransferenceDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceDeposit methodsFor: 'as yet unclassified' stamp: 'sm 11/22/2021 18:05:42'!
counterpart

	^associatedTransference withdraw.! !

!TransferenceDeposit methodsFor: 'as yet unclassified' stamp: 'RP 11/28/2021 11:18:41'!
effectOnBalance: anAccountBalance

	^anAccountBalance + associatedTransference amount.! !


!classDefinition: #TransferenceWithdraw category: 'ServiciosFinancieros-Ejercicio'!
TransferenceTransaction subclass: #TransferenceWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceWithdraw methodsFor: 'as yet unclassified' stamp: 'sm 11/22/2021 18:05:56'!
counterpart

	^associatedTransference deposit.! !

!TransferenceWithdraw methodsFor: 'as yet unclassified' stamp: 'RP 11/28/2021 11:18:47'!
effectOnBalance: anAccountBalance

	^anAccountBalance - associatedTransference amount.! !
