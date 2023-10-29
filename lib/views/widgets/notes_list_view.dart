import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_new_app/models/note_model.dart';
import 'package:todo_new_app/views/widgets/custom_note_item.dart';

import '../../cubits/notes_cubit/notes_cubit.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        List<NoteModel> notes =
            BlocProvider.of<NotesCubit>(context).notes ?? [];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: NotesItem(
                  note: notes[index],
                ),
              );
            },
            padding: EdgeInsets.zero,
            itemCount: notes.length,
          ),
        );
      },
    );
  }
}
