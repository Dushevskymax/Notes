import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  void editNote() {
    Navigator.pop(context, {
      'noteTitle': titleController.text,
      'noteContent': contentController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    titleController.text = data['noteTitle'];
    contentController.text = data['noteContent'];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit note'),
        centerTitle: true,),
        body:  Column(
          children: [
             Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextField(
                controller: titleController,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  fillColor: Color.fromARGB(255, 241, 241, 241),
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
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
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
          child: const Text('Save',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  editNote();
                }, 
              ),


      ),
    );
  }
}