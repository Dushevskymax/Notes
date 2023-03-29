import 'package:flutter/material.dart';
import 'package:notes/services/Note.dart';
import 'package:notes/services/storage.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.storage});

  final NotesStorage storage;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    widget.storage.readNotes().then((value) => {
      setState(() {
        notes = value;
      })
    });
  }

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: const Text('Notes'),
        centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                    });
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 177, 177, 177),
                    ),
                    fillColor: Color.fromARGB(255, 220, 220, 220),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15),
                    bottom: Radius.circular(35),
                  ),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15),
                    bottom: Radius.circular(35),
                  ),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Find...',
                  ),
                )),



                
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    String searchText = searchController.text;
                    return searchText == '' ||
                     notes[index].noteContent.contains(searchText) ||
                     notes[index].noteTitle.contains(searchText) ? Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: ListTile(
                        onTap: () async {
                          dynamic result = await Navigator.pushNamed(context, '/edit', arguments: {
                            'noteTitle': notes[index].noteTitle,
                            'noteContent': notes[index].noteContent,
                          });
                          if (result == null) {
                            return;
                          } 
                          setState(() {
                            notes[index].noteTitle = result['noteTitle'];
                            notes[index].noteContent = result['noteContent'];
                          });

                          widget.storage.writeNotes(notes);
                        },
                        title: Text(
                          notes[index].noteTitle,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          notes[index].noteContent,
                          style: const TextStyle(
                            fontSize: 14,
                          ), 
                        ),
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color.fromARGB(255, 130, 130, 130), width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                          ),
                          onPressed: () {
                            showDialog(context: context, builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Are you sure?'),
                                actions: [
                                  ElevatedButton(onPressed:() {
                                    setState(() {
                                      notes.remove(notes[index]);
                                    });
                                    Navigator.of(context).pop();
                                  }, child: const Text('Yes')),
                                  ElevatedButton(onPressed:() {
                                    Navigator.of(context).pop();
                                  }, child: const Text('No'))
                                ],
                              );
                            });
                            widget.storage.writeNotes(notes);
                          },
                      ),
                    ),
                  ) : Container();
                }
              ),
            ),
          ],
        ),






        floatingActionButton: FloatingActionButton(
          child: const Icon(
                      Icons.border_color,
                  //    color: Color.fromARGB(255, 177, 177, 177),
                    ),
          onPressed: () async {
            dynamic result = await Navigator.pushNamed(context, '/add');
            if (result == null) {
              return;
            }
            Note newNote = Note(noteTitle: result['noteTitle'], noteContent: result['noteContent']);
            setState(() {
              notes.add(newNote);
            });
            widget.storage.writeNotes(notes);
          },
        ),


      );
  }
}
