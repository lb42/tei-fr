<?php
$dirOptions = dirname(dirname(__FILE__))."/options";
$dirTei = dirname(dirname(__FILE__))."/tei";
$dirEntities = dirname(dirname(__FILE__))."/namedEntities";
$labels = array("persName", "orgName", "name", "title", "term", "present", "expéditeur", "destinataire", "invité", "secrétaire", "président", "type");
foreach($labels as $label){
	//entities from namedEntities.xml
	switch($label){
	case "persName":
	case "orgName":
	case "title":
	case "name":
	case "term":
		getOptions($label);
		break;
		//subtype from tei files and namedEntities.xml
	case "present":
	case "expéditeur":
	case "destinataire":
	case "invité":
	case "secrétaire":
	case "président":
		getOptions("persName", $label);
		break;
	case "type":
		break;
	}
}
function array_msort($array, $cols)
{
	$colarr = array();
	foreach ($cols as $col => $order) {
		$colarr[$col] = array();
		foreach ($array as $k => $row) { $colarr[$col]['_'.$k] = strtolower($row[$col]); }
	}
	$eval = 'array_multisort(';
	foreach ($cols as $col => $order) {
		$eval .= '$colarr[\''.$col.'\'],'.$order.',';
	}
	$eval = substr($eval,0,-1).');';
	eval($eval);
	$ret = array();
	foreach ($colarr as $col => $arr) {
		foreach ($arr as $k => $v) {
			$k = substr($k,1);
			if (!isset($ret[$k])) $ret[$k] = $array[$k];
			$ret[$k][$col] = $array[$k][$col];
		}
	}
	return $ret;

}
function getOptions($label, $subtype = ""){
	global $dirEntities;
	global $dirOptions;
	global $dirTei;
	$files = glob($dirTei."/*.xml");
	$entities = simplexml_load_file($dirEntities."/namedEntities.xml");
	if($subtype != ""){
		$options = $entities -> xpath("//row[type='persName']");
		$output = $subtype.".html";
	}else{
		$options = $entities -> xpath("//row[type='".$label."']");
		$output = $label.".html";

	}
	$results = array();
	foreach ($options as $option){
		$id = (string)($option -> id[0]);
		$name = (string)($option -> nom[0]);
		if($subtype != ""){
			foreach ($files as $file)
			{

				$file = simplexml_load_file($file);
				$file->registerXPathNamespace('t', 'http://www.tei-c.org/ns/1.0');
				if ($subtype == "present"){
				$request = "//t:list[@type='present']/t:item/t:persName[@ref='#".$id."']";

				}else{
					$request = "//t:persName[@role='".$subtype."'][@ref='#".$id."']";
				}
				if(count($file -> xpath($request))>0){

					array_push($results, array("id" => "#".$id, "name" => $name));
				}
			}
		}
		else{
			array_push($results, array("id" => "#".$id, "name" => $name));
		}
	}
	//delete duplicate
	$results = array_map("unserialize", array_unique(array_map("serialize", $results)));
	//order
	$results = array_msort($results, array('name'=>SORT_ASC, 'id'=>SORT_ASC));
	$html = "";
	foreach ($results as $result){
		$html .= "<option value='".$result["id"]."'>".$result["name"]."</option>";
	}
	file_put_contents($dirOptions."/".$output, $html);
}
function buildRequest($label){
	return "//row[type='".$label."']";
}
?>