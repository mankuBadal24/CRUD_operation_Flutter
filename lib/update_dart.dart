import 'package:first_flutter_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:first_flutter_app/view_data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class update_dart extends StatefulWidget {
    String username;
    String pass;
    String age;
  update_dart(this.username,this.pass,this.age);

  @override
  State<update_dart> createState() => _update_dartState();
}

class _update_dartState extends State<update_dart> {

  TextEditingController username = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController age = TextEditingController();

  Future<void> update_record() async{
try{
  // final url = Uri.parse('http://192.168.1.21:8080/mayank/cris/dataupdat_api.php');   // home wifi
  // final url = Uri.parse('http://10.0.2.2:8080/mayank/cris/dataupdat_api.php');   // emulator url
  // final url = Uri.parse('http://192.168.1.12:8080/mayank/cris/dataupdat_api.php'); //harsh wifi
  final url = Uri.parse('http://192.168.253.183:8080/mayank/cris/dataupdat_api.php');

  var res = await http.post(url,
  body:{
    'username' : username.text,
    'pass' : pass.text,
    'age' : age.text
  });
  // var response = jsonDecode(res.body);
  // print(response);
  print(res.statusCode);
  if( res.statusCode == 200){
    print("record updated");
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text("data Updated successfully"),
          duration: Duration(seconds: 1),
          backgroundColor: Color(0xFF0C66CC),
          closeIconColor: Colors.white)
    );
  }else{
    print("some error");
  }

}catch(e){
  print(e);
}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username.text = widget.username;
    pass.text=widget.pass;
    age.text=widget.age;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update data"),
        toolbarHeight: 60,
        backgroundColor: Color(0xFF0C66CC),
        titleTextStyle: TextStyle(color: Colors.white , fontSize: 24),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background3rd.jpg"),
                      fit: BoxFit.cover,
                  )
                ),
              ),
              Center(
                  child: SingleChildScrollView(
                    child: Card(
                      color: Colors.white.withOpacity(0.8), // Optional: to make form stand out from the background
                      margin: const EdgeInsets.all(20),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: TextFormField(
                                controller: username,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter the username',
                                  labelStyle: TextStyle(color: Color(0xFF0C66CC)),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: TextFormField(
                                controller: pass,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter the password',
                                  labelStyle: TextStyle(color: Color(0xFF0C66CC)),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: TextFormField(
                                controller: age,
                              decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter the Age',
                                labelStyle: TextStyle(color: Color(0xFF0C66CC)),
                              ),
                            ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF0C66CC),
                                  padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 38.0)
                                ),
                                onPressed: (){
                                  update_record();
                                },
                                child: const Text("Update",
                                style: TextStyle(color: Colors.white),),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Builder(
                                builder: (context){
                                  return ElevatedButton(onPressed: (){
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => view_data()));
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) => view_data()),
                                          (Route<dynamic> route) => false,
                                    );
                                  },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF0C66CC),
                                          padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 20.0)
                                      ),
                                      child: const Text("Updated Data",
                                      style: TextStyle(color: Colors.white)));
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: ElevatedButton(onPressed: (){
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => MyApp()),
                                      (Route<dynamic> route) => false,
                                );
                              },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF0C66CC),
                                    padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 14.0)
                                ),
                              child: const Text("Insert New Data",
                              style: TextStyle(color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      ),
                  ),
              )
              )],
      )
    );
  }
}
