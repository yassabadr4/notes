import 'package:flutter/material.dart';
import 'package:todo_new_app/constants.dart';
import 'package:todo_new_app/models/note_model.dart';
import 'package:todo_new_app/views/widgets/colors_list_view.dart';
class EditNotesColorsList extends StatefulWidget {
  const EditNotesColorsList({Key? key, required this.note}) : super(key: key);
  final NoteModel note;
  @override
  State<EditNotesColorsList> createState() => _EditNotesColorsListState();
}

class _EditNotesColorsListState extends State<EditNotesColorsList> {
  late int currentIndex;
  @override
  void initState() {
    currentIndex = kColors.indexOf(Color(widget.note.color));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38 * 2,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
            ),
            child: GestureDetector(
              onTap: () {
                currentIndex = index;
                widget.note.color = kColors[index].value;
                setState(() {});
              },
              child: ColorItem(
                color: kColors[index],
                isActive: currentIndex == index,
              ),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: kColors.length,
      ),
    );
  }
}
