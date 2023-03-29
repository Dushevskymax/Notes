import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  void createNote(){
    Navigator.pop(context, {
      'noteTitle': titleController.text,
      'noteContent': contentController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('New note'),
        centerTitle: true,),
        body:  Column(
          children: [
             Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: TextField(
                controller: titleController,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  fillColor: Color.fromARGB(255, 234, 234, 234),
                   filled: true,
                  hintText: 'Enter title...',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: TextField(
                controller: contentController,
                keyboardType: TextInputType.multiline,
                maxLines: 18,
                style: const TextStyle(
                  fontSize: 16,
                ),
                decoration: const InputDecoration(
                  fillColor: Color.fromARGB(255, 241, 241, 241),
                   filled: true,
                  hintText: 'Enter content...',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )
                ),
              )
            ),
          ],
        ),


        floatingActionButton: FloatingActionButton(
                onPressed: () {
                  createNote();
                }, 
                child: const Text('Add')
              ),

              
      ),
    );
  }
}