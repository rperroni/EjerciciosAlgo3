!classDefinition: #CarolinaLaCurandera category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #CarolinaLaCurandera
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CarolinaLaCurandera class' category: 'Ejercicio1-PNJ-Episodio2'!
CarolinaLaCurandera class
	instanceVariableNames: 'frasesPJDesconocido frasesPJPrometedor cantidadDeIteracionesPorPersonaje'!

!CarolinaLaCurandera class methodsFor: 'interacciones' stamp: 'Sebastian 10/1/2021 18:33:49'!
interactuarCon: unPersonajeJugador
	| respuesta |
	self recordarInteraccionCon: unPersonajeJugador .
	respuesta := self responderSegunClasificacionYCantidadDeInteraccionesCon: unPersonajeJugador .
	self cambiarOpinionDeRiverwoodSobre: unPersonajeJugador.
	^respuesta ! !

!CarolinaLaCurandera class methodsFor: 'interacciones' stamp: 'Sebastian 10/1/2021 18:04:27'!
olvidarInteracciones
	cantidadDeIteracionesPorPersonaje := Dictionary new.! !

!CarolinaLaCurandera class methodsFor: 'interacciones' stamp: 'Sebastian 10/1/2021 18:15:57'!
reiniciarInteraccionesCon: unPersonajeJugador
	cantidadDeIteracionesPorPersonaje at: unPersonajeJugador put: 0.! !


!CarolinaLaCurandera class methodsFor: 'interacciones - privado' stamp: 'Sebastian 10/1/2021 18:16:27'!
recordarInteraccionCon: unPersonajeJugador
	| cantidadDeInteracciones |
	cantidadDeInteracciones := cantidadDeIteracionesPorPersonaje at: unPersonajeJugador ifAbsent:[0] .
	cantidadDeIteracionesPorPersonaje at: unPersonajeJugador put: cantidadDeInteracciones + 1.
! !

!CarolinaLaCurandera class methodsFor: 'interacciones - privado' stamp: 'Sebastian 10/1/2021 18:45:58'!
responderSegunClasificacionYCantidadDeInteraccionesCon: unPersonajeJugador
	| respuesta |
	respuesta := frasesPJDesconocido at: ( (cantidadDeIteracionesPorPersonaje at: unPersonajeJugador) min: frasesPJDesconocido size).
	(self puebloDeRiverwood tieneComoPrometedorA: unPersonajeJugador ) ifTrue:[
			respuesta := frasesPJPrometedor at: ( (cantidadDeIteracionesPorPersonaje at: unPersonajeJugador) min: frasesPJPrometedor size)
			].
	^respuesta 
	! !


!CarolinaLaCurandera class methodsFor: 'riverwood' stamp: 'Sebastian 10/1/2021 18:19:23'!
cambiarOpinionDeRiverwoodSobre: unPersonajeJugador
		((cantidadDeIteracionesPorPersonaje at: unPersonajeJugador )>= frasesPJDesconocido size) ifTrue:[
			self puebloDeRiverwood verComoPrometedorA: unPersonajeJugador.
			self reiniciarInteraccionesCon: unPersonajeJugador .
			].! !

!CarolinaLaCurandera class methodsFor: 'riverwood' stamp: 'Sebastian 10/1/2021 17:50:07'!
puebloDeRiverwood
	^PuebloDeRiverwood ! !


!CarolinaLaCurandera class methodsFor: 'as yet unclassified' stamp: 'Sebastian 10/1/2021 18:48:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	frasesPJDesconocido := #('¿Estás enfermo forastero?' 'Ah, solo quieres conversar' 'Cuando tengas una aflicción, ven a verme' ).
	frasesPJPrometedor := #('Salud aventurero!!' 'Toma esta pócima que te hará crecer el pelo. Y cuando tengas una aflicción, ven a verme' ).
	cantidadDeIteracionesPorPersonaje := ((Dictionary new) add: (#Hamilton->0); yourself).! !


!classDefinition: #PruebasInteracionesConCarolinaLaCurandera category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #PruebasInteracionesConCarolinaLaCurandera
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasInteracionesConCarolinaLaCurandera class' category: 'Ejercicio1-PNJ-Episodio2'!
PruebasInteracionesConCarolinaLaCurandera class
	instanceVariableNames: ''!

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 12:48:36'!
test01CuandoLaCuranderaInteractuaPorPrimeraVezConUnPersonajeLeRespondeConSuPrimerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: '¿Estás enfermo forastero?'.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 12:48:37'!
test02CuandoLaCuranderaInteractuaPorSegundaVezConUnPersonajeLeRespondeConSuSegundaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self carolinaLaCurandera interactuarCon: self hamilton.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Ah, solo quieres conversar'.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 12:49:16'!
test03CuandoLaCuranderaInteractuaPorTerceraVezConUnPersonajeLeRespondeConSuTercerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self carolinaLaCurandera interactuarCon: self hamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Cuando tengas una aflicción, ven a verme'.! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con mas de un personaje' stamp: 'JMB 9/25/2021 12:50:11'!
test04LaCuranderaMantieneDosInteraccionesConDiferentesPersonajes
	self olvidarInteraccionesYOpiniones.
	
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: '¿Estás enfermo forastero?'.
	Assert that: (self carolinaLaCurandera interactuarCon: self tirion) isEqualTo: '¿Estás enfermo forastero?'.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con mas de un personaje' stamp: 'JMB 9/25/2021 12:50:18'!
test05LaCuranderaMantieneDosInteraccionesCompletasConDiferentesPersonajes
	self olvidarInteraccionesYOpiniones.
	
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: '¿Estás enfermo forastero?'.
	
	Assert that: (self carolinaLaCurandera interactuarCon: self tirion) isEqualTo: '¿Estás enfermo forastero?'.
	Assert that: (self carolinaLaCurandera interactuarCon: self tirion) isEqualTo: 'Ah, solo quieres conversar'.
	Assert that: (self carolinaLaCurandera interactuarCon: self tirion) isEqualTo: 'Cuando tengas una aflicción, ven a verme'.
	
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: 'Ah, solo quieres conversar'.
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: 'Cuando tengas una aflicción, ven a verme'.
	! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con personajes prometedores' stamp: 'JMB 9/25/2021 12:50:32'!
test06CuandoLaCuranderaInteractuaPorPrimeraVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuPrimerFrase
	| mensaje |	
	self olvidarInteraccionesYOpiniones.
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Salud aventurero!!'.
! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con personajes prometedores' stamp: 'JMB 9/25/2021 12:50:39'!
test07CuandoLaCuranderaInteractuaPorSegundaVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuSegundaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Toma esta pócima que te hará crecer el pelo. Y cuando tengas una aflicción, ven a verme'.
! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'cambio de opiniones' stamp: 'JMB 9/25/2021 12:50:52'!
test08CuandoLaCuranderaTerminaSuRepertorioDeFrasesConUnPersonajeCambiaLaOpinionDelPuebloSobreElPersonajeAPrometedor
	self olvidarInteraccionesYOpiniones.
	self carolinaLaCurandera interactuarCon: self hamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.	
	self carolinaLaCurandera interactuarCon: self hamilton.	
	
	Assert isTrue: (self esVistoPorElPuebloComoPrometedor: self hamilton).! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'cambio de opiniones' stamp: 'Sebastian 10/1/2021 17:14:53'!
test09CuandoLaCuranderaCambiaLaOpinionDelPuebloSobreElPersonajeAPrometedorReiniciaSuHiloDeDialogoConElPersonaje
	self olvidarInteraccionesYOpiniones.
	self carolinaLaCurandera interactuarCon: self hamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.	
	self carolinaLaCurandera interactuarCon: self hamilton.	
	
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: ('Salud aventurero!!')! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'cambio de opiniones' stamp: 'Sebastian 9/29/2021 11:52:25'!
test10CuandoLaCuranderaCambiaLaOpinionDelPuebloSobreElPersonajeAPrometedorReiniciaElHiloDeDialogoDelGuardiaConElPersonaje
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.  
	
	self carolinaLaCurandera interactuarCon: self hamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.	
	self carolinaLaCurandera interactuarCon: self hamilton.	

	Assert that: 'Bienvenido aventurero!!' isEqualTo: (self treborElGuardia interactuarCon: self hamilton)! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'personajes' stamp: 'RP 9/28/2021 19:44:04'!
carolinaLaCurandera
	^CarolinaLaCurandera ! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'personajes' stamp: 'Sebastian 10/1/2021 18:00:55'!
hamilton
	^#Hamilton ! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'personajes' stamp: 'Sebastian 10/1/2021 18:30:49'!
puebloDeRiverwood
	^PuebloDeRiverwood ! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'personajes' stamp: 'RP 9/28/2021 19:40:51'!
tirion
	^#Tirion! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'personajes' stamp: 'JMB 9/21/2021 20:52:20'!
treborElGuardia
	^ TreborElGuardiaDeSkyrim ! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'Sebastian 10/1/2021 18:45:58'!
esVistoPorElPuebloComoPrometedor: unPersonaje
	^self puebloDeRiverwood tieneComoPrometedorA: unPersonaje.
	! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'Sebastian 10/1/2021 18:31:17'!
hacerQueLaCuranderaOlvideSusInteracciones
	self carolinaLaCurandera olvidarInteracciones.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'Sebastian 10/1/2021 18:31:41'!
hacerQueRiverwoodOlvideTodasSusCalificaciones
	self puebloDeRiverwood olvidarPersonajesPrometedores.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'Sebastian 10/1/2021 18:31:55'!
hacerQueRiverwoodVeaPrometedorAHamilton
	self puebloDeRiverwood  verComoPrometedorA: self hamilton.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'JMB 9/25/2021 12:48:36'!
olvidarInteraccionesYOpiniones
	self hacerQueLaCuranderaOlvideSusInteracciones.	
	self hacerQueRiverwoodOlvideTodasSusCalificaciones.
! !


!classDefinition: #PruebasInteracionesConTreborElGuardia category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #PruebasInteracionesConTreborElGuardia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasInteracionesConTreborElGuardia class' category: 'Ejercicio1-PNJ-Episodio2'!
PruebasInteracionesConTreborElGuardia class
	instanceVariableNames: ''!

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:03:53'!
test01CuandoElGuardiaInteractuaPorPrimeraVezConUnPersonajeLeRespondeConSuPrimerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Hola forastero'.
! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:04:08'!
test02CuandoElGuardiaInteractuaPorSegundaVezConUnPersonajeLeRespondeConSuSegundaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: '¿Todo bien?'.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'Sebastian 10/1/2021 18:04:27'!
test03CuandoElGuardiaOlvidaInteraccionesPreviasConUnPersonajeAlVolverAInteractuarLeRespondeConSuPrimerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	self treborElGuardia olvidarInteracciones.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Hola forastero'.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:04:35'!
test04CuandoElGuardiaInteractuaPorTerceraVezConUnPersonajeLeRespondeConSuTercerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	self treborElGuardia interactuarCon: self hamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: '¿Algún problema?'.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:04:44'!
test05CuandoElGuardiaInterctuaYTerminoSuRepertorioDeFrasesConUnPersonajeLeRespondeConSuUltimaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	self treborElGuardia interactuarCon: self hamilton.
	self treborElGuardia interactuarCon: self hamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: '¿Algún problema?'.! !


!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con mas de un personaje' stamp: 'JMB 9/25/2021 12:53:36'!
test06ElGuardiaMantieneDosInteraccionesConDiferentesPersonajes
	self olvidarInteraccionesYOpiniones.

	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: 'Hola forastero'.
	Assert that: (self treborElGuardia interactuarCon: self tirion) isEqualTo: 'Hola forastero'.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con mas de un personaje' stamp: 'JMB 9/25/2021 12:53:43'!
test07ElGuardiaMantieneDosInteraccionesCompletasConDiferentesPersonajes
	self olvidarInteraccionesYOpiniones.
	
	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: 'Hola forastero'.
	
	Assert that: (self treborElGuardia interactuarCon: self tirion) isEqualTo: 'Hola forastero'.
	Assert that: (self treborElGuardia interactuarCon: self tirion) isEqualTo: '¿Todo bien?'.
	Assert that: (self treborElGuardia interactuarCon: self tirion) isEqualTo: '¿Algún problema?'.
	
	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: '¿Todo bien?'.
	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: '¿Algún problema?'.
	! !


!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con personajes prometedores' stamp: 'JMB 9/25/2021 12:54:46'!
test08CuandoElGuardiaInteractuaPorPrimeraVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuPrimerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Bienvenido aventurero!!'.
! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con personajes prometedores' stamp: 'JMB 9/25/2021 12:55:02'!
test09CuandoElGuardiaInteractuaPorSegundaVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuSegundaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	self treborElGuardia interactuarCon: self hamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Espero que tengas una buena estadia en Riverwood'.
! !


!PruebasInteracionesConTreborElGuardia class methodsFor: 'personajes' stamp: 'Sebastian 10/1/2021 17:47:16'!
hamilton
	^ #Hamilton! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'personajes' stamp: 'Sebastian 10/1/2021 18:29:49'!
puebloDeRiverwood
	^PuebloDeRiverwood ! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'personajes' stamp: 'JMB 9/27/2021 21:08:21'!
tirion
	^ #Tirion! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'personajes' stamp: 'JMB 9/21/2021 20:42:44'!
treborElGuardia
	^ TreborElGuardiaDeSkyrim ! !


!PruebasInteracionesConTreborElGuardia class methodsFor: 'opiniones e interacciones' stamp: 'Sebastian 10/1/2021 18:28:57'!
hacerQueElGuardiaOlvideSusInteracciones
	self treborElGuardia olvidarInteracciones.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'opiniones e interacciones' stamp: 'Sebastian 10/1/2021 18:29:58'!
hacerQueRiverwoodOlvideTodasSusCalificaciones
	self puebloDeRiverwood olvidarPersonajesPrometedores.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'opiniones e interacciones' stamp: 'Sebastian 10/1/2021 18:32:46'!
hacerQueRiverwoodVeaPrometedorAHamilton
	self puebloDeRiverwood verComoPrometedorA: self hamilton.
	! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'opiniones e interacciones' stamp: 'JMB 9/25/2021 12:52:12'!
olvidarInteraccionesYOpiniones
	self hacerQueElGuardiaOlvideSusInteracciones. 	
	self hacerQueRiverwoodOlvideTodasSusCalificaciones.
! !


!classDefinition: #PuebloDeRiverwood category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #PuebloDeRiverwood
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PuebloDeRiverwood class' category: 'Ejercicio1-PNJ-Episodio2'!
PuebloDeRiverwood class
	instanceVariableNames: 'personajesPrometedores'!

!PuebloDeRiverwood class methodsFor: 'calificacionDePersonaje' stamp: 'Sebastian 10/1/2021 17:24:19'!
olvidarPersonajesPrometedores
	personajesPrometedores  := OrderedCollection new.
	! !

!PuebloDeRiverwood class methodsFor: 'calificacionDePersonaje' stamp: 'Sebastian 10/1/2021 18:45:58'!
tieneComoPrometedorA: unPersonajeJugador
	^(personajesPrometedores includes: unPersonajeJugador)! !

!PuebloDeRiverwood class methodsFor: 'calificacionDePersonaje' stamp: 'Sebastian 10/1/2021 18:08:30'!
verComoPrometedorA: unPersonajeJugador
	(personajesPrometedores includes: unPersonajeJugador) ifFalse: [
		personajesPrometedores add: unPersonajeJugador.
		self trebor reiniciarInteraccionesCon: unPersonajeJugador.
		].
	! !


!PuebloDeRiverwood class methodsFor: 'npc' stamp: 'Sebastian 10/1/2021 17:59:52'!
trebor
	^TreborElGuardiaDeSkyrim ! !


!PuebloDeRiverwood class methodsFor: 'as yet unclassified' stamp: 'Sebastian 10/1/2021 18:48:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	personajesPrometedores := ((OrderedCollection new) add: #Hamilton; yourself).! !


!classDefinition: #TreborElGuardiaDeSkyrim category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #TreborElGuardiaDeSkyrim
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TreborElGuardiaDeSkyrim class' category: 'Ejercicio1-PNJ-Episodio2'!
TreborElGuardiaDeSkyrim class
	instanceVariableNames: 'frasesPJDesconocido frasesPJPrometedor cantidadDeIteracionesPorPersonaje'!

!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones' stamp: 'Sebastian 10/1/2021 18:33:49'!
interactuarCon: unPersonajeJugador
		self recordarInteraccionCon: unPersonajeJugador .
		^ self responderSegunClasificacionYCantidadDeInteraccionesCon: unPersonajeJugador .! !

!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones' stamp: 'Sebastian 10/1/2021 18:04:27'!
olvidarInteracciones
	cantidadDeIteracionesPorPersonaje := Dictionary new.! !

!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones' stamp: 'Sebastian 10/1/2021 18:08:30'!
reiniciarInteraccionesCon: unPersonajeJugador
	cantidadDeIteracionesPorPersonaje at: unPersonajeJugador  put: 0.
	
	! !


!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones - privado' stamp: 'Sebastian 10/1/2021 17:33:26'!
puebloDeRiverwood
	^PuebloDeRiverwood ! !

!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones - privado' stamp: 'RP 9/28/2021 19:18:03'!
recordarInteraccionCon: unPersonajeJugador
	| cantidadDeInteracciones |
	cantidadDeInteracciones := cantidadDeIteracionesPorPersonaje at: unPersonajeJugador ifAbsent:[0] .
	cantidadDeIteracionesPorPersonaje at: unPersonajeJugador put: cantidadDeInteracciones + 1.
! !

!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones - privado' stamp: 'Sebastian 10/1/2021 18:46:35'!
responderSegunClasificacionYCantidadDeInteraccionesCon: unPersonajeJugador
	|respuesta|
	respuesta := frasesPJDesconocido at: ((cantidadDeIteracionesPorPersonaje  at: unPersonajeJugador) min: frasesPJDesconocido size).
	(self puebloDeRiverwood tieneComoPrometedorA: unPersonajeJugador) ifTrue: [
		respuesta := frasesPJPrometedor at: ((cantidadDeIteracionesPorPersonaje  at: unPersonajeJugador) min: frasesPJPrometedor  size)
		].
	^respuesta
		! !


!TreborElGuardiaDeSkyrim class methodsFor: 'as yet unclassified' stamp: 'Sebastian 10/1/2021 18:48:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	frasesPJDesconocido := #('Hola forastero' '¿Todo bien?' '¿Algún problema?' ).
	frasesPJPrometedor := #('Bienvenido aventurero!!' 'Espero que tengas una buena estadia en Riverwood' ).
	cantidadDeIteracionesPorPersonaje := ((Dictionary new) add: (#Hamilton->1); add: (#Tirion->0); yourself).! !

CarolinaLaCurandera initializeAfterFileIn!
PuebloDeRiverwood initializeAfterFileIn!
TreborElGuardiaDeSkyrim initializeAfterFileIn!