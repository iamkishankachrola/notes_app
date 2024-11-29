import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/add_note_page.dart';
import 'package:notes_app/db_helper.dart';
import 'package:notes_app/db_provider.dart';
import 'package:notes_app/home_page.dart';
import 'package:notes_app/update_note_page.dart';
import 'package:provider/provider.dart';

class ShowNotePage extends StatefulWidget{
  int id;
  String title;
  String description;
  String createdAt;

  ShowNotePage({required this.id, required this.title, required this.description, required this.createdAt});

  @override
  State<ShowNotePage> createState() => _ShowNotePageState();
}

class _ShowNotePageState extends State<ShowNotePage> {
  DbHelper dbHelper = DbHelper.getInstance();

  DateFormat dateFormat = DateFormat.yMMMd();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff252525),
      appBar: AppBar(
        backgroundColor: const Color(0xff252525),
        leading:Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new,size: 18,),
              style: ButtonStyle(shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              backgroundColor: const WidgetStatePropertyAll(Color(0xff3B3B3B),),
              foregroundColor: const WidgetStatePropertyAll(Colors.white)
                  ),
                ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateNotePage(id: widget.id,title: widget.title,description: widget.description,createdAt: widget.createdAt,),));
              },
              icon: Image.asset("assets/images/edit.png",width: 16,height: 16,color: Colors.white,),
              style: ButtonStyle(shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  backgroundColor: const WidgetStatePropertyAll(Color(0xff3B3B3B),),
                  foregroundColor: const WidgetStatePropertyAll(Colors.white)
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
        child: ListView(
          children:  [
            Text(widget.title,style: const TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
            const SizedBox(height: 15,),
            Text(dateFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.createdAt))),style: const TextStyle(color: Color(0xff939393)),),
            const SizedBox(height: 15,),
            Text(widget.description, style: const TextStyle(color: Colors.white),)
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20,right: 10),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: (){
              showDialog(context: context, builder: (context) {
                return  AlertDialog(
                  title: const Text("Confirm"),
                  content: const Text("Are you sure, you want to delete it ?"),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: const Text("No",style: TextStyle(color: Color(0xff3B3B3B)),)),
                    TextButton(onPressed: () async{
                     // bool check = await dbHelper.deleteNote(id: widget.id);
                      context.read<DbProvider>().deleteNote(id: widget.id);
                      Navigator.pop(context);
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage(),));

                    }, child: const Text("Yes",style: TextStyle(color: Color(0xff3B3B3B)),)),
                  ],
                );
              },);
            },
            backgroundColor:Colors.red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: const Icon(Icons.delete,color: Colors.white,size: 28,),
          ),
        ),
      ),
    );
  }
}