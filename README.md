# Autentia Tutoriales
Tutorial alternativo de creación de AMPs y webscripts.

## Creación de AMPs
[Source](https://www.adictosaltrabajo.com/2014/09/24/alfresco-amps/)

Supongamos que nuestro cliente nos pide que necesita en los documentos que sube al gestor de contenidos Alfresco cierta información sobre el departamento al que pertenece el documento dentro de la empresa,
por ejemplo:

* Identificador del departamento
* Nombre del departamento
* Nombre de la empresa cliente

Además, quiere una solución que permita que posteriormente mediante el desarrollo de un componente de búsqueda, esos campos sean susceptibles de ser buscados.
Inicialmente podemos pensar en una solución donde todo se almacene en base de datos, pero es una solución muy costosa si el número de campos va creciendo (mayor número de índices de columna, búsquedas más costosas, etc.),
por lo que tendremos que pensar en integrar dicha información con los propios documentos en Alfresco, beneficiándonos de la potencia de las búsquedas con Lucene.

## Creación de webscripts
[Source](https://www.adictosaltrabajo.com/2014/11/13/alfresco-webscripts/)
Hay dos tipos de webscripts: 

* Webscripts de datos: Son aquellos que consultan, modifican y retornan datos de Alfresco (documentos), ofreciendo una interfaz para consumir dicho servicio por terceros (es el que realizaremos en este tutorial)
* Webscripts de presentación: Dichos webscripts modifican o extienden la capa de presentación de Alfresco; Podrán definir nuevos componentes en su interfaz de usuario, definir portlets, crear un website dentro de Alfresco, etc.

