import 'package:flutter/material.dart';
import 'package:flutter_picture/providers/picture_providers.dart';
import 'package:provider/provider.dart';

class PicturesScreen extends StatelessWidget {
  PicturesScreen({super.key});


  List<Map> pictures = [
    {"picture":"photo", "name":"sjajsaijsiasji.png"},
    {"picture":"photo", "name":"sjajsaijjiijjj.png"},
    {"picture":"photo", "name":"sjajkmjijdijdw.png"},
    {"picture":"photo", "name":"sjajsainsaunsb.png"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fotos"), centerTitle: true,),
      body: SafeArea(
        child: ListView.builder(
          itemCount: pictures.length,
          itemBuilder: (context, i){
            return InkWell(
              onTap: (){

              },
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  
                ),
                trailing: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.delete)
                ),
                title: Text(pictures[i]['name']),
                
              ),
            );
          }
        ), 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          context.read<PictureProviders>().takePhoto();
        },
        child: Icon(Icons.add_a_photo_rounded)
      ),
    );
  }
}