<?php 
$json2 = file_get_contents("http://dookansserver.com/Innovommerce/rest/businessinfolist/itemswithchoiceft?BUSINESSID=10003"); // this WILL do an http request for you
$data2 = json_decode($json2, true);]

$counterf=count($data2['locations'][0]['items']);
									
for($j=0;$j<$counterf;$j++)
	{
		$item_list=$data2['locations'][0]['items'][$j]['itemChoice'];

		echo $itemList= json_encode($item_list).'<br>';  
	}



?>