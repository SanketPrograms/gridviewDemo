import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_data/Services/http_services.dart';
import 'package:json_data/constant/constant.dart';
import 'package:http/http.dart' as http;

class main_page extends StatefulWidget {
  const main_page({Key? key}) : super(key: key);

  @override
  _main_pageState createState() => _main_pageState();
}

class _main_pageState extends State<main_page> {
  List<String> title = [];
  List<String> description = [];
  List<String> image = [];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState

    // Services().shareFeelingsData();

    shareFeelingsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Container(child: dynamicGridView()),
          );
  }

  shareFeelingsData() async {
    String Api = shareFeelingApi;

    var response = await http.get(Uri.parse(Api));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      for (int i = 0; i < jsonResponse['result'].length; i++) {
        title.add(jsonResponse['result'][i]['title']);
        description.add(jsonResponse['result'][i]['description']);
        image.add(jsonResponse['result'][i]['imgpath']);
      }

      setState(() {
        loading = false;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Widget dynamicGridView() {
    // print("this is findword $findWord");
    return LayoutBuilder(builder: (context, constraints) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: padding,
            mainAxisSpacing: padding,
            childAspectRatio: 1),
        itemCount: title.length,
        shrinkWrap: true,
        //  physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            elevation: elevation,
            child: Container(
                decoration: BoxDecoration(color: Colors.white),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    // subtitle: Text(description[index]),
                    Expanded(flex:4,child: Image.network(image[index])),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("  ${title[index].toString()}  "),
                          style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                        ),
                      )
                    )
                  ],
                )),
          );
        },
      );
    });
  }
}
