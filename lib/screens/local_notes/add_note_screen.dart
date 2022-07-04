import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluuter_boilerplate/application/local_notes/local_notes_bloc.dart';
import 'package:fluuter_boilerplate/infrastructure/local_notes/note_adapter/note_entities.dart';
import 'package:fluuter_boilerplate/utils/app_texts/app_texts.dart';
import 'package:fluuter_boilerplate/utils/extensions/string_extensions.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.addNote),
      ),
      floatingActionButton: BlocConsumer<LocalNotesBloc, LocalNotesState>(
        listener: (context, state) {
          if (state is LocalNewsAdded) {
            Navigator.of(context).pop();
          }
          if (state is LocalNewsAddError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              BlocProvider.of<LocalNotesBloc>(context).add(
                AddLocalNote(
                  localNoteEntity: LocalNoteEntity(
                    title: _titleController.text.trim(),
                    descripion: _descriptionController.text.trim(),
                  ),
                ),
              );
            },
            child: (state is LocalNotesLoading)
                ? const CircularProgressIndicator()
                : const Icon(Icons.add),
          );
        },
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  maxLines: null,
                  maxLength: 60,
                  decoration: InputDecoration(
                    labelText: AppTexts.title.translateTo(context),
                    border: const OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 10,
                  decoration: InputDecoration(
                    labelText: AppTexts.description.translateTo(context),
                    alignLabelWithHint: true,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
