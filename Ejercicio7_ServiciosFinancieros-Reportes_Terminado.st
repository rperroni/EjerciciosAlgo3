!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Reportes'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Reportes'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 11/29/2021 18:55:37'!
test12PortfolioCanNotIncludeItself

	| simplePortfolio |
	
	simplePortfolio := Portfolio new.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 0 equals: simplePortfolio accountsSize. ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Reportes'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Reportes'!

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


!classDefinition: #ReportsTest category: 'ServiciosFinancieros-Reportes'!
TestCase subclass: #ReportsTest
	instanceVariableNames: 'account1 account2 portfolioA portfolioB'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Reportes'!

!ReportsTest methodsFor: 'running' stamp: 'RP 12/5/2021 10:06:59'!
accountSummaryWithTheElementsFrom: aCollection

	| accountSummary |
	accountSummary := OrderedCollection new.
	accountSummary addAll: aCollection.
	
	^accountSummary

	! !

!ReportsTest methodsFor: 'running' stamp: 'RP 12/6/2021 15:00:37'!
summaryReportFor: anAccount

	^(AccountSummaryReport for: anAccount) generate.

	! !

!ReportsTest methodsFor: 'running' stamp: 'RP 12/6/2021 15:00:37'!
transferNetReportFor: anAccount

	^(TransferNetReport for: anAccount) generate.


	! !


!ReportsTest methodsFor: 'tests - summary' stamp: 'SM 12/3/2021 18:53:20'!
test01TheSummaryOfAnAccountWithNoTransactionsShowsABalanceOf0

	| summary accountSummary |
	
	summary := self summaryReportFor: account1.
	accountSummary := self accountSummaryWithTheElementsFrom: #('Balance = 0 pesos').
	
	self assertThat: accountSummary hasEqualElementsThan: summary.

	! !

!ReportsTest methodsFor: 'tests - summary' stamp: 'RP 12/3/2021 19:24:34'!
test02TheSummaryOfAnAccountWithADepositsShowsTheDepositAndBalance

	| accountSummary summary |	
	
	Deposit register: 100*peso on: account1.
	summary := self summaryReportFor: account1.
	accountSummary := self accountSummaryWithTheElementsFrom: #('Depósito por 100 pesos' 'Balance = 100 pesos').
	
	self assertThat: accountSummary hasEqualElementsThan: summary.

	! !

!ReportsTest methodsFor: 'tests - summary' stamp: 'RP 12/3/2021 19:25:15'!
test03TheSummaryOfAnAccountWithAWithdrawShowsTheWithdrawAndBalance

	| accountSummary summary |	
	
	Withdraw register: 50*peso on: account1.
	summary := self summaryReportFor:account1.
	accountSummary := self accountSummaryWithTheElementsFrom: #('Extracción por 50 pesos' 'Balance = -50 pesos').	
	
	self assertThat: accountSummary hasEqualElementsThan: summary.

	! !

!ReportsTest methodsFor: 'tests - summary' stamp: 'RP 12/3/2021 19:27:34'!
test04TheSummaryOfAnAccountWithATransferShowsTheTransferDepositLegAndBalance

	| accountSummary summary |	
	
	Transfer amount: 30*peso from: account2 to: account1.
	summary := self summaryReportFor:account1.
	accountSummary := self accountSummaryWithTheElementsFrom: #('Entrada por transferencia de 30 pesos' 'Balance = 30 pesos').
	
	self assertThat: accountSummary hasEqualElementsThan: summary.

	! !

!ReportsTest methodsFor: 'tests - summary' stamp: 'SM 12/3/2021 18:57:37'!
test05TheSummaryOfAnAccountWithATransferShowsTheTransferWithdrawLegAndBalance

	| accountSummary summary |
	
	Transfer amount: 20*peso from: account1 to: account2.
	summary := self summaryReportFor:account1.
	accountSummary := self accountSummaryWithTheElementsFrom: #('Salida por transferencia de 20 pesos' 'Balance = -20 pesos').
	
	self assertThat: accountSummary hasEqualElementsThan: summary.

	! !

!ReportsTest methodsFor: 'tests - summary' stamp: 'RP 12/3/2021 19:27:41'!
test06TheSummaryOfAPortfolioWithNoTransactionsShowsABalanceOf0

	| summary |	
	
	summary := self summaryReportFor: portfolioA .
	
	self assert: 'Balance = 0 pesos' equals: ( summary at: 1 ).


	! !

!ReportsTest methodsFor: 'tests - summary' stamp: 'RP 12/3/2021 19:27:48'!
test07TheSummaryOfAPortfolioWithAnAccountWithADepositShowsTheDepositAndBalance

	| accountSummary summary |	
	
	Deposit register: 100*peso on: account1.	
	
	portfolioA add: account1 .
	summary := self summaryReportFor: portfolioA .
	accountSummary := self accountSummaryWithTheElementsFrom: #('Depósito por 100 pesos' 'Balance = 100 pesos').				
	
	self assertThat: accountSummary hasEqualElementsThan: summary.


	! !

!ReportsTest methodsFor: 'tests - summary' stamp: 'RP 12/3/2021 19:27:53'!
test08TheSummaryOfAPortfolioWithTwoAccountsWithTransactionsShowsTheTransactionsAndBalance

	| accountSummary summary |
	
	Deposit register: 100*peso on: account1.
	Withdraw register: 100*peso on: account2.	
	
	portfolioA add: account1 .
	portfolioA add: account2 .
	summary := self summaryReportFor: portfolioA .
	accountSummary := self accountSummaryWithTheElementsFrom: #('Depósito por 100 pesos' 'Extracción por 100 pesos' 'Balance = 0 pesos').				
	
	self assertThat: accountSummary hasEqualElementsThan: summary.


	! !

!ReportsTest methodsFor: 'tests - summary' stamp: 'RP 12/3/2021 19:21:42'!
test10TheSummaryOfAportfolioWithAPortfolioAndAccountsShowsTheTransactionsAndBalance

	| accountSummary |	
	
	Transfer amount: 100*peso from: account2  to: account1. 	
	portfolioA add: account1.
	portfolioB add: account2 .
	portfolioA add: portfolioB .
	
	accountSummary := self accountSummaryWithTheElementsFrom: #('Entrada por transferencia de 100 pesos' 
							   							'Salida por transferencia de 100 pesos' 
							   							'Balance = 0 pesos').		
	
	self assertThat: accountSummary hasEqualElementsThan: ( self summaryReportFor: portfolioA ).


	! !


!ReportsTest methodsFor: 'tests - transfer net' stamp: 'RP 12/6/2021 12:33:39'!
test11TheTransferNetReportOfAnAccountWithNoTransfersShowsATransferNetOf0

	| transferNet |
	
	transferNet := self transferNetReportFor: account1.
	
	self assertThatTheAmount: '0 pesos' equalsTo: transferNet .


	! !

!ReportsTest methodsFor: 'tests - transfer net' stamp: 'RP 12/6/2021 12:34:37'!
test12TheTransferNetReportOfAnAccountWithATransferDepositShowsATransferNetOfThatDeposit

	| transferNet |	
	
	Transfer amount: 100*peso from: account2  to: account1. 
	transferNet := self transferNetReportFor: account1.
	
	self assertThatTheAmount: '100 pesos' equalsTo: transferNet .


	! !

!ReportsTest methodsFor: 'tests - transfer net' stamp: 'RP 12/6/2021 12:35:21'!
test13TheTransferNetReportOfAnAccountWithATransferWithdrawShowsATransferNetOfThatWithdraw

	| transferNet |	
	
	Transfer amount: 100*peso from: account2  to: account1. 
	transferNet := self transferNetReportFor: account2.
	
	self assertThatTheAmount: '-100 pesos' equalsTo: transferNet .


	! !

!ReportsTest methodsFor: 'tests - transfer net' stamp: 'RP 12/6/2021 12:36:28'!
test14TheTransferNetReportOfAnAccountWithMoreThanOneTransferShowsATransferNetOfTheSumOfTheTransfers

	| transferNet |	
	
	Transfer amount: 100*peso from:account2  to: account1. 
	Transfer amount: 50*peso from: account1  to: account2. 
	transferNet := self transferNetReportFor: account1.

	self assertThatTheAmount: '50 pesos' equalsTo: transferNet .


	! !

!ReportsTest methodsFor: 'tests - transfer net' stamp: 'RP 12/6/2021 12:37:05'!
test15TheTransferNetReportOfAPortfolioWithNoTransfersShowsATransferNetOf0
	
	self assertThatTheAmount: '0 pesos' equalsTo: (self transferNetReportFor: portfolioA).


	! !

!ReportsTest methodsFor: 'tests - transfer net' stamp: 'RP 12/6/2021 12:37:55'!
test16TheTransferNetReportOfAPorfolioContainingAnAccountWithATransferWithdrawShowsATransferNetOfThatWithdraw

	| transferNet |	
	
	Transfer amount: 100*peso from: account1 to: account2 .	
	
	portfolioA add: account1 .
	transferNet := self transferNetReportFor: portfolioA.
	
	self assertThatTheAmount: '-100 pesos' equalsTo: transferNet .


	! !

!ReportsTest methodsFor: 'tests - transfer net' stamp: 'RP 12/6/2021 12:38:55'!
test17TheTransferNetReportOfAPortfolioWithMoreThanOneTransferShowsATransferNetOfTheSumOfTheTransfers

	| transferNet |
	
	Transfer amount: 100*peso from: account1 to: account2 .
	
	portfolioA add: account1 .
	portfolioA add: account2.
	transferNet := self transferNetReportFor: portfolioA.
	
	self assertThatTheAmount: '0 pesos' equalsTo: transferNet .


	! !


!ReportsTest methodsFor: 'assertions' stamp: 'SM 12/3/2021 18:53:20'!
assertThat: anAccountSummary hasEqualElementsThan: aSummary

	"assertThatTheAccountSummaryHasEqualElemen"
	
	self assert:  (anAccountSummary hasEqualElements: aSummary).

	! !

!ReportsTest methodsFor: 'assertions' stamp: 'SM 12/3/2021 18:55:10'!
assertThatTheAmount: anAmount equalsTo: aNetTransferReport.
	
	self assert: anAmount equals: aNetTransferReport .


	! !


!ReportsTest methodsFor: 'setUp/tearDown' stamp: 'SM 12/3/2021 18:08:22'!
setUp

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	portfolioA := Portfolio new.
	portfolioB := Portfolio new.! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Reportes'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Reportes'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Reportes'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Reportes'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!Account methodsFor: 'initialization' stamp: 'RP 12/5/2021 10:20:22'!
withName: aName

	name := aName .! !



!Account methodsFor: 'accesing' stamp: 'RP 12/5/2021 11:08:45'!
name

	^name.! !


!Account methodsFor: 'nil' stamp: 'RP 12/6/2021 15:04:13'!
generateFor: aReport

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'ServiciosFinancieros-Reportes'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'as yet unclassified' stamp: 'RP 12/5/2021 10:24:46'!
named: aName

	self subclassResponsibility .! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Reportes'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Reportes'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'RP 11/30/2021 19:05:40'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'visitor' stamp: 'RP 12/5/2021 16:53:50'!
accounts

	^accounts copy.! !

!Portfolio methodsFor: 'visitor' stamp: 'RP 12/6/2021 16:52:49'!
generateFor: aReport

	accounts ifEmpty: [ ^self. ].
	accounts do: [ :anAccount | anAccount generateFor: aReport.].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Reportes'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

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

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'RP 12/5/2021 10:23:55'!
named: aName

	^self new withName: aName! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'RP 12/5/2021 10:46:32'!
named: aName with: anAccount

	^( self named: aName )
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'RP 12/5/2021 10:46:27'!
named: aName with: anAccount with: anotherAccount

	^( self named: aName )
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Reportes'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Reportes'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'RP 11/29/2021 21:48:02'!
balance

	^transactions 
		inject: (0*peso)
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'visitor' stamp: 'RP 12/6/2021 16:52:41'!
generateFor: aReport
	
	transactions ifEmpty: [ ^self ].
	transactions do: [ :aTransaction | aTransaction generateFor: aReport ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Reportes'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'RP 12/5/2021 10:19:03'!
named: aName

	^self new withName: aName.! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Reportes'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Reportes'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visitor' stamp: 'RP 12/6/2021 15:15:21'!
generateFor: aReport

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Reportes'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Reportes'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Reportes'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'visitor' stamp: 'RP 12/6/2021 15:15:29'!
generateFor: aReport

	^aReport visitDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Reportes'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Reportes'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Reportes'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferLeg methodsFor: 'visitor' stamp: 'RP 12/6/2021 15:15:37'!
generateFor: aReport

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Reportes'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Reportes'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Reportes'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'visitor' stamp: 'RP 12/6/2021 15:15:43'!
generateFor: aReport

	^aReport visitTransferDepositLeg: self.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Reportes'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Reportes'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'visitor' stamp: 'RP 12/6/2021 15:15:49'!
generateFor: aReport

	^aReport visitTransferWithdrawLeg: self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Reportes'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Reportes'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'visitor' stamp: 'RP 12/6/2021 15:15:57'!
generateFor: aReport

	^aReport visitWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Reportes'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Report category: 'ServiciosFinancieros-Reportes'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Reportes'!

!Report methodsFor: 'visitor' stamp: 'RP 12/3/2021 17:24:36'!
visitDeposit: aDeposit

	self subclassResponsibility ! !

!Report methodsFor: 'visitor' stamp: 'RP 12/3/2021 17:25:52'!
visitTransferDepositLeg: aTransferDepositLeg

	self subclassResponsibility ! !

!Report methodsFor: 'visitor' stamp: 'RP 12/3/2021 17:26:21'!
visitTransferWithdrawLeg: aTransferWithdrawLeg

	self subclassResponsibility ! !

!Report methodsFor: 'visitor' stamp: 'RP 12/3/2021 17:25:22'!
visitWithdraw: aWithdraw

	self subclassResponsibility ! !


!Report methodsFor: 'as yet unclassified' stamp: 'SM 12/2/2021 20:41:45'!
balanceMessage 

	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'RP 12/6/2021 15:00:37'!
generate

	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'SM 12/2/2021 20:34:07'!
initializeFor: anAccount

	account := anAccount

	! !


!classDefinition: #AccountSummaryReport category: 'ServiciosFinancieros-Reportes'!
Report subclass: #AccountSummaryReport
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Reportes'!

!AccountSummaryReport methodsFor: 'report' stamp: 'RP 12/6/2021 16:58:44'!
generate	
	
	account generateFor: self.
	summary add: self balanceMessage .
	
	^summary .! !


!AccountSummaryReport methodsFor: 'initialization' stamp: 'RP 12/6/2021 15:09:45'!
initialize

	summary := OrderedCollection new.! !


!AccountSummaryReport methodsFor: 'private' stamp: 'SM 12/2/2021 20:42:19'!
balanceMessage 

	^'Balance = ', account balance asString.! !


!AccountSummaryReport methodsFor: 'visitor' stamp: 'RP 12/6/2021 13:17:42'!
visitDeposit: aDeposit

	summary add: ( 'Depósito por ', aDeposit value asString ).

	! !

!AccountSummaryReport methodsFor: 'visitor' stamp: 'RP 12/6/2021 13:17:47'!
visitTransferDepositLeg: aTransferDepositLeg

	summary add: ( 'Entrada por transferencia de ', aTransferDepositLeg value asString ).! !

!AccountSummaryReport methodsFor: 'visitor' stamp: 'RP 12/6/2021 13:17:53'!
visitTransferWithdrawLeg: aTransferWithdrawLeg

	summary add: ( 'Salida por transferencia de ', aTransferWithdrawLeg value asString ).! !

!AccountSummaryReport methodsFor: 'visitor' stamp: 'RP 12/6/2021 13:17:58'!
visitWithdraw: aWithdraw

	summary add: ( 'Extracción por ', aWithdraw value asString ).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryReport class' category: 'ServiciosFinancieros-Reportes'!
AccountSummaryReport class
	instanceVariableNames: ''!

!AccountSummaryReport class methodsFor: 'as yet unclassified' stamp: 'SM 12/2/2021 20:35:16'!
for: anAccount

	^self new initializeFor: anAccount.! !


!classDefinition: #TransferNetReport category: 'ServiciosFinancieros-Reportes'!
Report subclass: #TransferNetReport
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Reportes'!

!TransferNetReport methodsFor: 'visitor' stamp: 'RP 12/6/2021 15:14:50'!
visitTransferDepositLeg: aTransferDepositLeg

	self addToTransferNet: aTransferDepositLeg value
	
	

	! !

!TransferNetReport methodsFor: 'visitor' stamp: 'RP 12/6/2021 15:15:01'!
visitTransferWithdrawLeg: aTransferWithdrawLeg

	self addToTransferNet: aTransferWithdrawLeg value negated.
! !


!TransferNetReport methodsFor: 'initialization' stamp: 'RP 12/6/2021 15:09:26'!
initialize

	transferNet := 0 * peso.! !


!TransferNetReport methodsFor: 'private' stamp: 'RP 12/6/2021 15:14:41'!
addToTransferNet: aTransferLegValue

	transferNet := transferNet + aTransferLegValue
	
	

	! !


!TransferNetReport methodsFor: 'report' stamp: 'RP 12/6/2021 16:58:56'!
generate

	account generateFor: self.	
	
	^transferNet asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetReport class' category: 'ServiciosFinancieros-Reportes'!
TransferNetReport class
	instanceVariableNames: ''!

!TransferNetReport class methodsFor: 'as yet unclassified' stamp: 'SM 12/2/2021 20:35:30'!
for: anAccount

	^self new initializeFor: anAccount.! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Reportes'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Reportes'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Reportes'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
