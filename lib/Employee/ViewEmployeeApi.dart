import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:mvvmproject/Employee/InsertEmployeeApi.dart';

class ViewEmployeeApi extends StatefulWidget {
  const ViewEmployeeApi({Key? key}) : super(key: key);

  @override
  State<ViewEmployeeApi> createState() => _ViewEmployeeApiState();
}

class _ViewEmployeeApiState extends State<ViewEmployeeApi> {
  Future<List<dynamic>?>?alldata;
  data()async{
    Uri uri = Uri.parse("https://dummy.restapiexample.com/api/v1/employees");
    print("uri :${uri}");
    var responce = await http.get(uri);
    print(responce.statusCode);
    if(responce.statusCode==200)
      {
        var body = responce.body.toString();
        print(body);
       var json = jsonDecode(body);
       setState(() {
         alldata= json['data'];

       });
       // return json["data"];

      }

    else
      {
        print("API ERROR");
      }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // alldata =  data();
    data();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ViewEmployeeApi"),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed:(){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InsertEmployeeApi()));
      }, label: Icon(Icons.add)),
      body: FutureBuilder(
        future: alldata,
        builder: (context, snapshot) {
          if(snapshot.hasData)
            {
              if(snapshot.data!.length<=0)
                {
                  return Center(child: Text("NO DATA"),);
                }
              else
                {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [

                              Text(snapshot.data![index]["id"].toString()),
                              Text(snapshot.data![index]["employee_name"].toString()),
                              Text(snapshot.data![index]["employee_salary"].toString()),
                              Text(snapshot.data![index]["employee_age"].toString()),
                              Text(snapshot.data![index]["profile_image"].toString()),

                              Row(
                                children: [
                                  SizedBox(width: 100),
                                  IconButton(
                                    onPressed: (){
                                      AlertDialog alert = AlertDialog(
                                        title: Text("DELETE"),
                                        content: Text("ARE YOU SURE"),
                                        actions: [
                                         ElevatedButton(
                                             onPressed: () async {
                                               var id = snapshot.data![index]["id"].toString();
                                               print(id);
                                               
                                               Uri uri =Uri.parse("https://dummy.restapiexample.com/api/v1/delete/$id}");
                                               var responce = await http.delete(uri,);

                                               print("response : ${responce.statusCode}");




                                               if(responce.statusCode==200)
                                               {
                                                 var body = responce.body.toString();
                                                 print(body);
                                                  var json = jsonDecode(body);
                                                  if(json["status"]=="success")
                                                    {
                                                      var msg = json["message"].toString();
                                                      print(msg);
                                                      Navigator.of(context).pop();
                                                      setState(() {
                                                        alldata =  data();
                                                      });
                                                    }
                                                  else
                                                    {
                                                      var msg = json["message"].toString();
                                                      print(msg);
                                                    }
                                               }
                                               else
                                                 {
                                                   print("API ERROR");
                                                 }
                                             },
                                             child:Text("YES")
                                         ),
                                          ElevatedButton(
                                              onPressed: (){},
                                              child:Text("NO")
                                          )
                                        ],
                                      );
                                      showDialog(context: context, builder: (context){
                                        return alert ;
                                      });

                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                  IconButton(onPressed: (){}, icon: Icon(Icons.update)),
                                ],
                              )

                            ],
                          ),
                        );
                      },
                  );
                }
            }
          else
            {
              return Center(child: CircularProgressIndicator(),);
            }
        },
      ),
    );
  }
}

