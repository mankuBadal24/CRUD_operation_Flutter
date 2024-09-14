<?php
            $ds = mysqli_connect("localhost","root","","formvalidation","3307");
            // if(isset($_POST["username"])){
            //     $user = $_POST["username"];
            // }else{
            //     return;
            // }
            // if(isset($_POST["pass"])){
            // $pass = $_POST["pass"];
            // }else{
            //     return;
            // }
            // if(isset($_POST["age"])){
            // $age = $_POST["age"];
            // }else{
            //     return;
            // }
            $user = $_POST["username"];
            $pass = $_POST["pass"];
            $age = $_POST["age"];
            $update_query = "UPDATE `user` SET  `password` = '$pass', `age` = '$age' WHERE `username` = '$user'";

            $exe = mysqli_query($ds,$update_query);
            // if($exe){
            //     echo "Data updated";
            // }else{
            //     echo "Data not updated";
            // }
            if($exe==TRUE){
                echo "data inserted";
            }
            else{
                echo "data not inserted";
            }
            // $arr = [];
            // if($exe){
            //     $arr["success"]=="true";
            // }else{
            //     $arr["success"]=="false";
            // }
            // print(json_encode($arr));
?>