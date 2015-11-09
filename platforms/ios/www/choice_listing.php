<?php
$item_id = $_REQUEST["itemid"];
$choiceLimit = $_REQUEST["choiceLimit"];


//echo "http://dookansserver.com/Innovommerce/rest/businessinfolist/itemswithchoiceft?itemid=".$item_id."&choiceLimit=".$choiceLimit."";

$json = file_get_contents("http://dookansserver.com/Innovommerce/rest/itemchoicelist/choices?itemid=".$item_id."&choiceLimit=".$choiceLimit.""); // this WILL do an http request for you
$data = json_decode($json, true);

$html='';


$counter=count($data['itemChoiceInfo']);
$newcounter=0;

for($i=0;$i<$counter;$i++)
{

	if($data['itemChoiceInfo'][$i]['choiceCategory']=="Choice")
	{
		$newcounter++;
	}
}




		$html.='<div class="inner-content">
                    <form action="">
                        <ul class="listingRadio">';
                        for($i=0;$i<$newcounter;$i++)
						{

							if($data['itemChoiceInfo'][$i]['choiceCategory']=="Choice")
							{
		                            $html.='<li>
		                                <div class="inputRadio">
		                                    <input type="radio" name="Item" id="'.$i.'Item" data-role="none" onclick = "MyRadio1(\'' . $data['itemChoiceInfo'][$i]['choiceName'] . '\')"/>
		                                    <label for="'.$i.'Item">'.$data['itemChoiceInfo'][$i]['choiceName'].'</label>
		                                </div>
		                            </li>';
		                     }
	

						}
                            
                       $html.='</ul>
                    </form>            
                </div>';


// echo "<pre>";
// print_r($data['itemChoiceInfo']);
// echo "</pre>";





													
echo $html;




?>