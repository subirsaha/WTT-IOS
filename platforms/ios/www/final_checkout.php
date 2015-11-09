<?php
$profileId = $_REQUEST["profileId"];
$busId = $_REQUEST["busId"];
$total = $_REQUEST["total"];
$oilist=array();

$data = array
		(
		'deviceOrderId'=>1,
		'customerProfileId'=>$profileId,
		'contactInfo'=>'85181',
		'tandcversion'=>1,
		'pickupTime'=>'11:00 am',
		'taxAmount'=>'1.75',
		'businessId'=>$busId,
		'email'=>'arunima@esolzmail.com',
		'tip'=>0.00,
		'phone'=>,
		'totalprice'=>number_format($total,2,'.',''),
		'customerProfilePaymentId'=>'133486538',
		'paymentInfo'=>$frdigt,
		'finalprice'=>number_format($total,2,'.',''),
		'deliveryCharge'=>0.00,
		'paymentMethod'=>'CARD, Already Paid',
		'locationId'=>10164,
		//'locationId'=>$this->session->userdata('location_id'),
		'promotionValue'=>0,
		'deliveryMethod'=>'PICKUP',
		'status'=>'P',
		'oilist'=>$oilist,
							
		);  


echo "<pre>";
	print_r($data);
	echo "<pre/>";die;
	//
	//exit;
	//
	// echo json_encode($data);
	$httpRequest = curl_init();
					curl_setopt($httpRequest, CURLOPT_RETURNTRANSFER, 1);
					curl_setopt($httpRequest, CURLOPT_HTTPHEADER, array("Content-Type:  application/json"));
					curl_setopt($httpRequest, CURLOPT_POST, 1);
					curl_setopt($httpRequest, CURLOPT_HEADER, 0);
    			$url = self::remote_url."ordercreate/order";
    				curl_setopt($httpRequest, CURLOPT_URL, $url);
//    				curl_setopt($httpRequest, CURLOPT_URL, 'http://dookansserver.com:8080/Innovommerce-new/rest/ordercreate/order');
					curl_setopt($httpRequest, CURLOPT_POSTFIELDS,json_encode($data));
					$returnHeader = curl_exec($httpRequest);


?>