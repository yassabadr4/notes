import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_new_app/constants.dart';
import 'package:todo_new_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:todo_new_app/views/widgets/edit_note_view.dart';
import '../../models/note_model.dart';

class NotesItem extends StatelessWidget {
  NotesItem({Key? key, required this.note}) : super(key: key);

  final NoteModel note;

  final GlobalKey<FormState> dismissKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return EditNoteView(
              note: note,
            );
          },
        ));
      },
      child: Dismissible(
        key: dismissKey,
        confirmDismiss: (DismissDirection direction) async {
          if (direction == DismissDirection.startToEnd || direction == DismissDirection.endToStart) {

            return await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Delete"),
                  content:
                      const Text("Are you sure you want to delete this note ?"),
                  actions: [
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(kPrimaryColor),
                      ),
                      onPressed: () { Navigator.of(context).pop(true);
                        note.delete();
                      },
                      child: const Text("Yes",style: TextStyle(
                        color: Colors.black,
                      ),),

                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(kPrimaryColor),
                      ),
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("No",style: TextStyle(
                     color: Colors.black,
                      ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return null;
        },
        background: Container(
          height: 50,
          color: Colors.red,
          margin: const EdgeInsets.all(8),
          child: const Icon(FontAwesomeIcons.trash,size: 50,),
        ),
        child: Container(
          padding: const EdgeInsets.only(
            top: 24,
            bottom: 24,
            left: 16,
          ),
          decoration: BoxDecoration(
            color: Color(note.color),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListTile(
                title: Text(
                  note.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 16,
                  ),
                  child: Text(
                    note.subTitle,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 18,
                    ),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Delete"),
                          content:
                          const Text("Are you sure you want to delete this note ?"),
                          actions: [
                            ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(kPrimaryColor),
                              ),
                              onPressed: () { Navigator.of(context).pop(true);
                              note.delete();
                              BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                              },
                              child: const Text("Yes",style: TextStyle(
                                color: Colors.black,
                              ),),

                            ),
                            ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(kPrimaryColor),
                              ),
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("No",style: TextStyle(
                                color: Colors.black,
                              ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Text(
                  note.date,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
