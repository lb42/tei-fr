<?php

//run named_entities_extract.php (faire un sh pour une utilisation en local) : extraire toutes les entités de tous les fichiers tei ne possèdant pas de @ref
//créer un array des formes déjà enregistrées
$normalizeChars = array(
	'A'=>'a',
	'B'=>'b',
	'C'=>'c',
	'D'=>'d',
	'E'=>'e',
	'F'=>'f',
	'G'=>'g',
	'H'=>'h',
	'I'=>'i',
	'J'=>'j',
	'K'=>'k',
	'L'=>'l',
	'M'=>'m',
	'N'=>'n',
	'O'=>'o',
	'P'=>'p',
	'Q'=>'q',
	'R'=>'r',
	'S'=>'s',
	'T'=>'t',
	'U'=>'u',
	'V'=>'v',
	'W'=>'w',
	'X'=>'x',
	'Y'=>'y',
	'Z'=>'z',
	'Š'=>'s',
	'š'=>'s',
	'ß'=>'s',
	'Ž'=>'z',
	'ž'=>'z',
	'À'=>'a',
	'Á'=>'a',
	'Â'=>'a',
	'Ã'=>'a',
	'Ä'=>'a',
	'Å'=>'a',
	'Æ'=>'a',
	'Ç'=>'c',
	'È'=>'e',
	'É'=>'e',
	'Ê'=>'e',
	'Ë'=>'e',
	'Ì'=>'i',
	'Í'=>'i',
	'Î'=>'i',
	'Ï'=>'i',
	'Ñ'=>'n',
	'Ò'=>'o',
	'Ó'=>'o',
	'Ô'=>'o',
	'Õ'=>'o',
	'Ö'=>'o',
	'Œ'=>'œ',
	'Ø'=>'o',
	'Ù'=>'u',
	'Ú'=>'u',
	'Û'=>'u',
	'Ü'=>'u',
	'Ý'=>'y',
	'Þ'=>'b',
	'à'=>'a',
	'á'=>'a',
	'â'=>'a',
	'ã'=>'a',
	'ä'=>'a',
	'å'=>'a',
	'æ'=>'a',
	'ç'=>'c',
	'è'=>'e',
	'é'=>'e',
	'ê'=>'e',
	'ë'=>'e',
	'ì'=>'i',
	'í'=>'i',
	'î'=>'i',
	'ï'=>'i',
	'ð'=>'o',
	'ñ'=>'n',
	'ò'=>'o',
	'ó'=>'o',
	'ô'=>'o',
	'õ'=>'o',
	'ö'=>'o',
	'œ'=>'o',
	'ø'=>'o',
	'ù'=>'u',
	'ú'=>'u',
	'û'=>'u',
	'ý'=>'y',
	'ý'=>'y',
	'þ'=>'b',
	'ÿ'=>'y',
	'.'=>'_',
	'-'=>'_',
	'?'=>'_',
	','=>'_',
	';'=>'_',
	':'=>'_',
	'!'=>'_',
	'/'=>'_',
	'’'=>'_',
	'«'=>'_',
	'»'=>'_',
	'+'=>'_',
	'%'=>'_',
	'='=>'_',
	'('=>'_',
	')'=>'_',
	';'=>'_',
	'*'=>'_',
	' '=>'_',
	' '=>'_',
	'&'=>'_',
	'>'=>'_',
	'<'=>'_',
	'"'=>'_',
);
$dir = dirname(dirname(__FILE__));
$xml = simplexml_load_file($dir."/namedEntities/namedEntities.xml");
$oldentitiesformes = array();
$objectoldentitiesformes = $xml->xpath("//forme1|//forme2|//forme3|//forme4|//forme5|//forme5|//forme6|//forme7|//forme8");
foreach($objectoldentitiesformes as $objectoldentityforme){
	array_push($oldentitiesformes, str_replace("_", "", strtr((string)$objectoldentityforme, $normalizeChars)));
}

echo "<pre>";print_r($oldentitiesformes);echo "</pre>";

//extraire les entités des fichiers tei et les entrer dans un array si leur forme (normalisée) n'est pas déjà présente dans named_entities.xml ; supprimer les doublons
$files = glob($dir."/tei/*.xml");
$newentities = array();
foreach ($files as $file){
	$path = realpath($file);
	$file_name = basename($file);
	$xml = simplexml_load_file($path);
	$xml->registerXPathNamespace('t', 'http://www.tei-c.org/ns/1.0');
	$objectnewformes = $xml->xpath("//t:persName[not(@ref)]|//t:name[@type='manif'][not(@ref)]|//t:orgName[not(@ref)]|//t:text//t:title[not(@ref)]|//t:term[not(@ref)]|//t:placeName[not(@ref)]");
	foreach ($objectnewformes as $objectnewforme){
		$entityforme = (string)$objectnewforme;
		$entityid = str_replace("_", "", strtr($entityforme, $normalizeChars));
		$entitytype = $objectnewforme -> getName();
		//on ne fait pas entrer les entités dont la forme existe déjà dans $oldentitiesformes
		if(!in_array($entityid, $oldentitiesformes)){
			//on ne fait pas entrer les entités dont l'id existent déjà dans $newentities
			$newentitiesid = array();
			foreach($newentities as $newentity){
				array_push($newentitiesid, $newentity["id"]);
			}
			if(!in_array($entityid, $newentitiesid)){
				$entity = array(
					"id" => $entityid,
					"nouveau" => "nouveau",
					"type"=> $entitytype,
					"nom" => $entityforme,
					"description" => "",
					"persName_nom" => "",
					"persName_prenom" => "",
					"persName_naissance" => "",
					"persName_cooptation" => "",
					"persName_mort" => "",
					"manif_date" => "",
					"manif_lieu" => "",
					"title_auteur" => "",
					"forme" => $entityforme);
				array_push($newentities, $entity);
			}
		}
	}
}
echo "<pre>";print_r($newentities);echo "</pre>";
//créer un fichier csv
if (file_exists($dir."/namedEntities/namedEntities.csv")){
	unlink($dir."/namedEntities/namedEntities.csv");
}
$fp = fopen($dir."/namedEntities/namedEntities.csv", "w+");
foreach ($newentities as $fields) {
	fputcsv($fp, $fields, chr(9));
}
fclose($fp);
//importer le csv dans Excel, regrouper les formes correspondant à une même entité, voir si ces formes correspondent à une entité déjà enregistrée (si oui, fusionner)
//regénérer named_entities.xml

//strip space ? caractère Pour comparer les formes, il ne faut pas seulement normaliser, il faut SUPPRIMER ., espace, etc.
//run named_entities_mark.php (faire un sh pour une utilisation en local) : transformer tous les fichiers tei avec named_entities.xsl. S'il y a des doublons de forme, il faut 1° ne pas écraser les anciens @ref 2° générer un message avec la liste des entités sans attribut
?>