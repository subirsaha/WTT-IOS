<?php
$itemname = $_REQUEST["itemname"];
$description = $_REQUEST["description"];
$price = $_REQUEST["price"];

$html='';

$html.='<div class="inner-content">
					
					<div class="contactInfoHeader">					
						<div class="bar bar-default">
							<div class="search-result-box">
								<h2><a class="ui-link" href="#">'.$itemname.'</a></h2>
								<p>'.$description.'</p>
								<div class="right-small-box">
									<h5>$'.$price.'</h5>
								</div>
							</div>
						</div>
						<div class="ui-bar ui-bar-blue">
							<h2>Special Instructions</h2>
						</div>
					</div>
					<div class="listGroup">
						<div class="bar bar-default">
							<label for="speInstruction">Enter special instructions here.</label>
							<textarea name="speInstruction" id="speInstruction"></textarea>
						</div>
					</div>
					
				</div>';

echo $html;
?>