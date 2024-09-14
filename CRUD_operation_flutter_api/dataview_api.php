<?php
// include ('form.php');
            // $user = $_POST['username'];
            // $pass = $_POST["pass"];
            // $age = $_POST["age"];
            $ds = mysqli_connect("localhost","root","","formvalidation","3307");
            // echo $ds;

        
        $query = "SELECT * FROM `user`";
        $ex = mysqli_query($ds,$query);
        $arr = [];
        while($row=mysqli_fetch_array($ex)){
            $arr[] =$row; 
        }

        print(json_encode($arr));
    
?>
