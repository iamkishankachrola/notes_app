import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/add_note_page.dart';
import 'package:notes_app/note_model.dart';
import 'package:notes_app/show_note_page.dart';
import 'db_helper.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper dbHelper = DbHelper.getInstance();
  List<NoteModel> notesData = [ ];
  List<Color> cardsColor = [const Color(0xffFFAB91),const Color(0xffFFCC80),const Color(0xffE6EE9B),const Color(0xff80DEEA),const Color(0xffCF93D9),const Color(0xffaebbf6) ];
  DateFormat dateFormat = DateFormat.yMMMd();
  @override
  void initState() {
    super.initState();
    getNotes();
  }
  void getNotes() async{
    notesData = await dbHelper.fetchAllNote();
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff252525),
      appBar: AppBar(
        title: const Text("Notes",style: TextStyle(color: Colors.white,fontSize: 24),),
        backgroundColor: const Color(0xff252525),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: (){},
                icon: const Icon(Icons.search),
                style: ButtonStyle(shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                backgroundColor: const WidgetStatePropertyAll(Color(0xff3B3B3B),),
                foregroundColor: const WidgetStatePropertyAll(Colors.white)
              ),
            ),
          )
        ],
      ),
      body:notesData.isNotEmpty ?Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
        child: GridView.builder(
          gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1
          ),
          itemCount: notesData.length,
          itemBuilder: (context, index) {
            return  InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShowNotePage(id: notesData[index].id!,title: notesData[index].title,description: notesData[index].description,createdAt: notesData[index].createdAt,),)).then((value) => getNotes());
              },
              child: Card(
                color: cardsColor[Random().nextInt(cardsColor.length)],
                child: Padding(
                  padding: const EdgeInsets.only(top: 20,right: 15,left: 15,bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notesData[index].title,style: const TextStyle(fontSize: 16),),
                      const SizedBox(height: 10,),
                      Text(dateFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(notesData[index].createdAt,))),style: const TextStyle(color: Color(0xff929292)),)
                    ],
                  ),
                ),
              ),
            );
          },),
      ) :const Center(child: Text("No notes yet!!",style: TextStyle(color: Colors.white,fontSize: 20),)),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20,right: 20),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage(),)).then((value)=>getNotes());
            },
            backgroundColor: const Color(0xff3B3B3B),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: const Icon(Icons.add,color: Colors.white,size: 28,),
          ),
        ),
      ),
    );
  }
}