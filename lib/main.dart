import 'package:first_flutter_app/view_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Operation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController username = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController age = TextEditingController();

  Future<void> storeData() async {
    // final url = Uri.parse('http://192.168.1.21:8080/mayank/cris/form.php');   // home wifi
    // final url = Uri.parse('http://10.0.2.2:8080/mayank/cris/form.php');   // emulator url
    // final url = Uri.parse('http://192.168.1.12:8080/mayank/cris/form.php');
    final url = Uri.parse('http://192.168.253.183:8080/mayank/cris/form.php');
    try {
      var response = await http.post(
        url,
        body: {
          'username': username.text,
          'pass': pass.text,
          'age': age.text,
        },
      );

      if (response.statusCode == 200) {
        print('Record inserted successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text("Record inserted successfully"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.redAccent,
          closeIconColor: Colors.white,)
        );
        // You may also want to show a success message in the UI
      } else {
        print('Failed to insert record: ${response.statusCode}');
        // Handle different status codes accordingly
      }
    } catch (e) {
      print('An error occurred: $e');
      // Handle error accordingly, possibly showing an alert dialog to the user
    }
    username.clear();
    pass.clear();
    age.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('CRUD Operation')),
        backgroundColor: Colors.redAccent,
        toolbarHeight: 60,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Back.jpg'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Centered form
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
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 25.0),
                          ),
                          onPressed: () {
                            // Your onPressed function here
                            storeData();
                          },
                          child: const Text(
                            'Insert',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.all(10),
                          child: Builder(
                            builder: (context){
                              return ElevatedButton(onPressed: (){
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => view_data()),
                                      (Route<dynamic> route) => false,
                                );
                              },
                                  style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                    padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 15.0),
                                  ), child: const Text("View Data",
                              style: TextStyle(color: Colors.white),));
                            },
                          )
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
