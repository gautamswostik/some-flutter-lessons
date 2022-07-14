import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluuter_boilerplate/application/local_notes/local_notes_bloc.dart';
import 'package:fluuter_boilerplate/screens/local_notes/add_note_screen.dart';
import 'package:fluuter_boilerplate/utils/app_texts/app_texts.dart';
import 'package:fluuter_boilerplate/utils/extensions/string_extensions.dart';

class LocalNotesScreen extends StatefulWidget {
  const LocalNotesScreen({Key? key}) : super(key: key);

  @override
  State<LocalNotesScreen> createState() => _LocalNotesScreenState();
}

class _LocalNotesScreenState extends State<LocalNotesScreen> {
  @override
  void initState() {
    getNotes();
    super.initState();
  }

  void getNotes() {
    BlocProvider.of<LocalNotesBloc>(context).add(GetLocalNotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTexts.localNotes.translateTo(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => const AddNoteScreen(
                        isEdit: false,
                      )))
              .then((value) => getNotes());
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<LocalNotesBloc, LocalNotesState>(
          listener: (context, state) {
            if (state is LocalNoteDelted) {
              getNotes();
            }
          },
          builder: (context, state) {
            if (state is GetSavedLocalNotes) {
              if (state.localNoteEntities.isEmpty) {
                return Center(
                  child: Text(
                    AppTexts.noNotes.translateTo(context),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: state.localNoteEntities.map((e) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) => AddNoteScreen(
                                  localNoteEntity: e,
                                  isEdit: true,
                                ),
                              ),
                            )
                            .then(
                              (value) => getNotes(),
                            );
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Delete Note',
                              ),
                              content: const Text(
                                'Are you sure you want to delete your note?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Cancel',
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    BlocProvider.of<LocalNotesBloc>(context)
                                        .add(DeleteLocalNote(key: e.key));
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Delete',
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      title: Text(e.title),
                      subtitle: Text(e.descripion),
                    );
                  }).toList(),
                ),
              );
            }
            if (state is LocalNoteError) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return Center(
              child: Text(
                AppTexts.noNotes.translateTo(context),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
