<?php
$item_id = $_REQUEST["itemid"];
$choiceLimit = $_REQUEST["choiceLimit"];


$json = file_get_contents("http://dookansserver.com/Innovommerce/rest/businessinfolist/itemswithchoiceft?itemid='".$item_id."'&choiceLimit='".$choiceLimit."'"); // this WILL do an http request for you
$data = json_decode($json, true);


echo "<pre>";
print_r($data);
echo "</pre>";
?>