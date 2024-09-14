<?php

$ds = mysqli_connect("localhost","root","","formvalidation","3307");

if(isset($_POST["username"])){
    $saman = $_POST["username"];
}else{
    return;
}
$querrry = "DELETE FROM `user` WHERE username='$saman'";
$exeee=mysqli_query($ds,$querrry);
$arr=[];

if($exeee){
    $arr["sucess"]="true";
}else{
    $arr["sucess"]="false";
}
print(json_encode($arr));


?>