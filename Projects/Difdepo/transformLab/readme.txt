# Transformation docx to tei

* Placer les fichiers .docx stylés dans "transformLab/docx"
* Ouvrir "transformLab/docx2tei.xpr" avec Oxygen
* Dans la fenêtre projet, si un dossier "docx" n’apparaît pas, faire un clic droit (ou Control + clic) sur "docx2tei.xpr" > "Ajouter un dossier" > Sélectionner "transformLab/docx"
* Clic droit sur sur "docx2tei.xpr" > "Transformation" > "Appliquer les scénarios de transformation". Les fichiers xml-tei sont progressivement versés dans "transformLab/tei"
* Ouvrir "transformLab/norm2ou.xpr" avec Oxygen
* Dans la fenêtre projet, si un dossier "tei" n’apparaît pas, faire un clic droit (Control + clic) sur "docx2tei.xpr" > "Ajouter un dossier" > Sélectionner "transformLab/tei"
* Clic droit sur sur "docx2tei.xpr" > "Transformation" > "Appliquer les scénarios de transformation". Les fichiers xml-tei sont progressivement transformés dans "transformLab/tei" (les anciens fichiers sont écrasés).


# Ajout d’un identifiant unique aux entités nommées

## Extraction des entités sans identifiants

* Le dossier "transformLab/namedEntities" contient deux fichiers "namedEntities.xls" et "namedEntities.xml" qui sont la clef de voûte du processus d’extraction et de marquage. Dans leur version initiale, ils contiennent déjà la liste des membres de l’Oulipo, mais sont destinés à s’enrichir à chaque fois que l’on lance le processus d’extraction. Avant d’aller plus loin, il faut donc s’assurer que l’on dispose de la dernière version de ces deux fichiers.
* Ouvrir "transformLab/namedEntitiesExtract.app" (qui extrait toutes les entités nommés ne possédant pas encore d’identifiant)
* Attendre que l’application se ferme d’elle-même

## Vérification manuelles des entités

* Ouvrir "transformLab/namedEntities/namedEntities.csv" dans un éditeur de texte (TextEdit, par exemple)
* Sélectionner tout le contenu du fichier (Command + a) et le copier (Command + c)
* Faire une copie de sauvegarde du dossier "transformLab/namedEntities" au cas où les choses se passeraient mal
* Ouvrir "transformLab/namedEntities/namedEntities.xsl" dans Excel
* Aller à la première ligne vide, colonne A
* Coller le contenu du fichier "transformLab/namedEntities/namedEntities.csv" (Command + v)
* Au cas où le calcul automatique serait désactivé, calculer la feuille (Command + =). Toutes les nouvelles entités nommées apparaissent à la suite des anciennes. Structure de la table :

** Colonne A (obligatoire) : id de l’entité
** Colonne B (facultative) : vide si l’entité a déjà été traitée ; "nouveau" si l’entité vient d’être enregistrée
** Colonne C (obligatoire) : type d’entité ("name" équivaut "name type='manif'")
** Colonne D (obligatoire) : le nom de l’entité tel qu’il s’affichera dans le formulaire de recherche (pour les noms de personne, je propose le format "Nom, Prénom", qui permet d’atteindre rapidement la personne souhaité dans une liste déroulante en tapant les premières lettres de son nom)
** Colonne E (facultative) : description générale de l’entité (biographie d’une personne, description d’un événement, etc.)
** Colonne F (facultative) : URL de l’image illustrant l’entité
** Colonne G-K (facultative) : informations spécifiques aux entités "persName" (la colonne "persName_cooptation" est plus importante, car c’est elle qui permet de distinguer les membres de l’OULIPO des autres)
** Colonne L-M (facultative) : informations spécifiques aux entités "name type='manif'"
** Colonne N (facultative) : information spécifique aux entités "title" (auteur de l’ouvrage)
** Colonne O-V (un champ au moins doit être rempli) : formes que l’entité peut prendre dans les textes
** Colonne W (généré automatiquement) : "Doublon" si deux entités possèdent le même identifiant
** Colonne X (générée automatiquement) : "Doublon" si une même forme correspond à deux entités différentes

* Nettoyer la table :

** Si une nouvelle forme correspond à une entité déjà enregistrée, on la copie à la suite des autres dans les colonnes O-V (c’est la partie la plus fastidieuse du travail. Pour faciliter les choses, on peut classer les filter par type (cliquer sur le triangle à en haut de la colonne C) et les classer par nom (triangle en haut de la colonne D) ou par forme (colonne O). Cela dit, il n’y en aura peut-être pas beaucoup, et les interventions manuelles deviendront de moins en moins nombreuses à mesure que les premiers lots de fichiers auront été traités. Les formes qui ne se distinguent que par des espaces ou des signes de ponctuations sont automatiquement traitées comme appartenant à la même entité ("RQ" = "R.Q." = "R Q" = "R. Q." = "R.Q" etc.) ; les formes ne sont pas sensibles à la casse ("Queneau" = "QUENEAU") ; en revanche, les formes "plagiaire par anticipation" et "plagiat par anticipation", par exemple, doivent être attribuées manuellement à la même entité.
** Vérifier qu’il n’y a aucun doublon d’id (filtrer la colonne W). S’il y en a, il faut changer l’id de l’entité (sans toucher aux entités déjà enregistrées : ne toucher qu’aux entités marquées comme "nouveau")
** Vérifier qu’il n’y a pas de doublon de forme (filtrer la colonne X). S’il y en a, ne toucher à rien, mais noter la forme qui correspond à plusieurs entités distinctes. Il faudra intervenir manuellement dans les fichiers xml-tei en recherchant la forme en question dans tous les fichiers (dans Oxygen, "Rechercher" > "Rechercher/Remplacer dans les fichiers > "Portée" et sélectionner le répertoire "transformLab/tei"
** Effacer toutes les cellules de la colonne B dont la valeur est "nouveau"

* Enregister "transformLab/namedEntities/namedEntities.xls" (.xls, pas .xlsx)
* Ouvrir Oxygen et importer le fichier "transformLab/namedEntities/namedEntities.xls" ("Fichier" > "Importer" > "Fichier MS Excel"). 

** Dans "URL", cliquer sur l’icône "Dossier" et sélectionner le fichier "transformLab/namedEntities/namedEntities.xls" dans l’explorateur de fichiers
** Cliquer sur "Suivant"
** Réglages : 

*** Cocher la case "La première ligne contient le nom des champs"
*** Cocher la case "Enregistrer dans un fichier", cliquer sur l’icône "Dossier" et sélectionner le fichier "transformLab/namedEntities/namedEntities.xml". Cliquer sur "Enregister" > "Remplacer"
*** Cliquer sur "Importer" > "Écraser ? Oui" 

## Transformation des fichiers xml-tei

* Revenir au Finder et ouvrir "transformLab/namedEntitiesMark.app"
* Aller prendre un deuxième café en attendant que l’application se ferme d’elle-même
* Les fichiers xsl-tei sont transformés dans le dossier "transformLab/tei" (les anciens fichiers sont écrasés), un identifiant unique (attribut @ref) a été ajouté à toutes les entités nommées

