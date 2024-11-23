import 'package:flutter/material.dart';
import 'package:notes_app/note_model.dart';
import 'db_helper.dart';

class AddNotePage extends StatelessWidget{
  DbHelper dbHelper = DbHelper.getInstance();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff252525),
      appBar: AppBar(
        backgroundColor: const Color(0xff252525),
        leading:Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: (){
                Navigator.pop(context);
                if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty){
                  titleController.clear();
                  descriptionController.clear();
                }
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
            onPressed: () async{
                if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty){
                bool check = await dbHelper.addNote(NoteModel(
                    title: titleController.text,
                    description: descriptionController.text,
                    createdAt: DateTime.now().millisecondsSinceEpoch.toString()));
                if(check){
                  Navigator.pop(context);
                  titleController.clear();
                  descriptionController.clear();
              }
          }
              },
              icon: const Text("Save",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              style: ButtonStyle(shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  backgroundColor: const WidgetStatePropertyAll(Color(0xff3B3B3B),),
                  foregroundColor: const WidgetStatePropertyAll(Colors.white)
              ),
            ),
          )
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              keyboardType: TextInputType.multiline,
              cursorColor: const Color(0xff929292),
              minLines: 1,
              maxLines: 2,
              style: const TextStyle(color: Colors.white,fontSize: 24),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xff252525)
                  )
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xff252525)
                  )
                ),
                hintText: "Enter note title here...",
                hintStyle: TextStyle(color: Color(0xff929292),fontSize: 24),
              ),

            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              cursorColor: const Color(0xff929292),
              minLines: 5,
              maxLines: 10,
              style: const TextStyle(color: Colors.white,fontSize: 14),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xff252525)
                  )
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xff252525)
                  )
                ),
                hintText: "Enter note description here...",
                hintStyle: TextStyle(color: Color(0xff929292),fontSize: 14),
              ),

            ),
          ],
        ),
      ),
    );
  }
}