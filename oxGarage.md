#notes sur l'installation de tei-oxgarage

# installation de tei-oxgarage #

Oxgarage est un outil de transformation générique
(voir http://oxgarage.oucs.ox.ac.uk:8080/ege-webclient/ et http://www.tei-c.org/oxgarage/) ....

Pour l'installer comme service web, il faut:

  * avoir en place une service Tomcat
  * avoir une installation opérationelle de Open Office
  * avoir en place une installation des feuilles de style XSLT TEI (TEI Stylesheets)
  * télécharger et copier dans le dossier prévu pour les WAR  deux fichiers WAR

Si votre serveur marche sous debian ou sous ubuntu:
  * ajouter cette ligne dans votre **/etc/apt/sources.list**
```
deb http://tei.oucs.ox.ac.uk/teideb/binary ./
```
  * ensuite... sudo apt-get install tei-oxgarage

Sinon...

## sites de téléchargement ##

tomcat  et Open Office (Libre Office):

TEI : http://sourceforge.net/projects/tei/files/ (choisir la version courante de Stylesheets)

Oxgarage : http://bits.nsms.ox.ac.uk:8080/jenkins/job/OxGarage/
(choisir les deux fichiers .war)

## locations d'installation ##

  * il faut créer un dossier par ex **/var/cache/oxgarage** accessible à Tomcat
  * il faut dézipper l'archive TEI quelque part, par ex **/usr/share/xml/tei/stylesheet**
  * il faut savoir la location de Open Office, par ex **/usr/lib/openoffice**

## paramétrage ##

Il faut créer un fichier **/etc/oxgarage.properties** contenant:
```
OXGARAGE=/var/cache/oxgarage/
TEI=/usr/share/xml/tei/stylesheet
OpenOfficeConfig=/usr/lib/openoffice/
defaultLocale=fr
defaultProfile=default
```
ce fichier détermine les options disponibles

## test ##

http://localhost/ege-webclient