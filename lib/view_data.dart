import 'dart:convert';

import 'package:first_flutter_app/main.dart';
import 'package:first_flutter_app/update_dart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class view_data extends StatefulWidget {
   view_data({Key? key}): super(key: key);

  @override
  State<view_data> createState() => _view_dataState();
}

class _view_dataState extends State<view_data> {
  List userData =[];

  Future<void> deletRecord( String name) async{
    try{
      // String uri = 'http://192.168.1.21:8080/mayank/cris/datadel_api.php';          // home wifi
      // String uri = 'http://10.0.2.2:8080/mayank/cris/datadel_api.php';             // emulator link
      String uri = 'http://192.168.253.183:8080/mayank/cris/datadel_api.php';   //gourav hotspot

      var res = await http.post(Uri.parse(uri),
      body:{ "username":name } );
      var response = jsonDecode(res.body);
      print(response);
      if(response["sucess"]=="true"){
        print("data deleted");
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text("data deleted successfully"),
            duration: Duration(seconds: 1),
            backgroundColor: Color(0xFF33BD33),
            closeIconColor: Colors.black,)
        );
        getRecord();

      }else{
        print("some issues occur ");
        // getRecord();
      }

    }catch(e){
      print(e);
    }
  }
  Future<void> getRecord() async{
    // String uri = 'http://192.168.1.21:8080/mayank/cris/dataview_api.php';    // home wifi
    // String uri = 'http://10.0.2.2:8080/mayank/cris/dataview_api.php';   // emulator link
    final uri = 'http://192.168.253.183:8080/mayank/cris/dataview_api.php';  //gaurav hotspot
    
    try{
      var response = await http.get(Uri.parse(uri));
      setState(() {
        userData=jsonDecode(response.body);
      });
    }catch(e){
      print(e);
    }
  }
  @override
  void initState() {
    getRecord();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('view data',style: TextStyle(color: Colors.white,fontSize: 28),),
      backgroundColor: Color(0xFF33BD33),
      toolbarHeight: 60,
      toolbarOpacity: 1,
        actions: <Widget>[
          IconButton(onPressed: (){
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MyApp()),
                  (Route<dynamic> route) => false,
            );
          }, icon: Icon(CupertinoIcons.add_circled_solid,color: Colors.white,size: 28,))
        ],
      ),

      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/secondBG.jpg'),
              fit: BoxFit.cover,
              )
            ),
          ),
          ListView.builder(
              itemCount: userData.length,
              itemBuilder: (context, index){
                return Card(
                  margin: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Color(0xFF33BD33),
                      width: 5,
                    )
                  ),
                  child: ListTile(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => update_dart(
                      //     userData[index]["username"],
                      //     userData[index]["password"],
                      //     userData[index]["age"]
                      // )
                      // ));
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => update_dart(
                            userData[index]["username"],
                            userData[index]["password"],
                            userData[index]["age"]
                        )),
                            (Route<dynamic> route) => false,
                      );
                    },
                    leading: Icon(CupertinoIcons.rectangle_grid_1x2_fill,
                    color: Color(0xFF33BD33),),
                    title: Text(userData[index]["username"],style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text(userData[index]["password"]+"\n" +userData[index]["age"]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: (){
                        deletRecord(userData[index]["username"]);
                      },
                      color: Color(0xFF33BD33),
                    ),
                  ),
                );
              }
          ),
        ],
      )
    );
  }
}