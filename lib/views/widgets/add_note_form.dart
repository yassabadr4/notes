import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_new_app/models/note_model.dart';
import 'package:todo_new_app/views/widgets/custom_button.dart';
import 'package:todo_new_app/views/widgets/custom_text_field.dart';

import '../../cubits/add_note/add_note_cubit.dart';
import 'colors_list_view.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({Key? key}) : super(key: key);

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  String? title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autoValidateMode,
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          CustomTextField(
            onSaved: (value) {
              title = value;
            },
            hint: 'Title',
          ),
          const SizedBox(
            height: 32,
          ),
          CustomTextField(
            onSaved: (value) {
              subTitle = value;
            },
            hint: 'Content',
            maxLines: 5,
          ),
          const SizedBox(
            height: 32,
          ),
           const ColorsListView(),
          const SizedBox(height: 32,),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return customButton(state, context);
            },
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  CustomButton customButton(AddNoteState state, BuildContext context) {
    return CustomButton(
      isLoading: state is AddNoteLoading ? true : false,
      onTap: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          var currentDate = DateTime.now();
          var formattedCurrentDate =
              DateFormat('dd-mm-yyyy').format(currentDate);

          var noteModel = NoteModel(
            title: title!,
            subTitle: subTitle!,
            date: formattedCurrentDate,
            color: Colors.blue.value,
          );
          BlocProvider.of<AddNoteCubit>(context).addNote(noteModel);
        } else {
          autoValidateMode = AutovalidateMode.always;

          setState(() {});
        }
      },
    );
  }
}

