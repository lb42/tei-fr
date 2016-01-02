<?php
$dir= dirname(dirname(__FILE__));
$xsl = new DOMDocument();
$xsl->load($dir."/xsl/namedEntitiesMarkUp.xsl");
$files = glob($dir."/tei/*.xml");
foreach ($files as $file){
	$file_name = basename($file);
	$inputdom = new DomDocument();
	$inputdom->load($file);
	$proc = new XSLTProcessor();
	$proc->importStylesheet($xsl);
	$newdom = $proc->transformToDoc($inputdom);
	$newdom -> save($dir."/tei/".$file_name);
}
?>