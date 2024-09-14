<body>
        <pre>
            <?php
            // SET = 50; //-- sets the timeout to 50 seconds;

            $user = $_POST["username"];
            $pass = $_POST["pass"];
            $age = $_POST["age"];
            $dsn = mysqli_connect("localhost","root","","formvalidation","3307");
            // echo $user;
            if($dsn == 'false'){
                echo "Error in connection";
            }else{
                $str = "insert into user(username,password,age)  values('$user','$pass',$age)";
            }
            
            // echo $str;
            $conn = mysqli_query($dsn,$str);
            //header("location:mine.php?x=$x")
            
            // $arr = [];
            // if($conn){
            //     $arr["success"]="true";
            // }else{
            //     $arr["success"]="false";
            // }
            // print(json_encode($arr));
            if($conn==TRUE){
                echo "data inserted";
            }
            else{
                echo "data not inserted";
            }
            // header("location:mine.php")

            ?>
            
        </pre>
</body>