import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stdappbloc/view/widgets/text_field_widget.dart';

import '../../businesslogic/bloc/photobloc/photo_bloc.dart';
import '../../businesslogic/bloc/photobloc/photo_event.dart';
import '../../businesslogic/bloc/photobloc/photo_state.dart';
import '../../businesslogic/bloc/studentbloc/app_bloc.dart';
import '../../businesslogic/bloc/studentbloc/app_events.dart';
import '../../data/model/model.dart';

import 'screenhome.dart';

class ScreenUpdate extends StatefulWidget {
  final StudentModel studentObject;
  final int index;

  const ScreenUpdate(
      {super.key, required this.studentObject, required this.index});

  @override
  State<ScreenUpdate> createState() => _ScreenUpdateState();
}

class _ScreenUpdateState extends State<ScreenUpdate> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _majorController = TextEditingController();
  File? photo;

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _firstNameController =
        TextEditingController(text: widget.studentObject.firstname);
    _lastNameController =
        TextEditingController(text: widget.studentObject.lastname);
    _ageController = TextEditingController(text: widget.studentObject.age);
    _majorController = TextEditingController(text: widget.studentObject.major);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx2) => const ScreenHome()));
              },
              child: const Icon(Icons.close_rounded),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    const Text(
                      'Edit student details',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        BlocBuilder<PhotoBloc, PhotoState>(
                            builder: (context, state) {
                          if (state is PhotoLoaded) {
                            photo = state.photo;
                            return CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                radius: 48,
                                backgroundImage: FileImage(
                                  File(state.photo!.path),
                                ),
                              ),
                            );
                          }
                          return CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                                radius: 48,
                                backgroundImage: FileImage(
                                    File(widget.studentObject.photo))),
                          );
                        }),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                context
                                    .read<PhotoBloc>()
                                    .add(PhotoSelectedEvent());
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        hint: "First Name",
                        label: 'First Name',
                        textController: _firstNameController),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        hint: "Last Name",
                        label: 'Last Name',
                        textController: _lastNameController),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                      hint: "Age",
                      label: 'Age',
                      textController: _ageController,
                      typeValue: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        hint: "Major",
                        label: 'Major',
                        textController: _majorController),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              updateStudentDetail(widget.index, context);
                            }
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('Save Data'),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Future<void> updateStudentDetail(int index, BuildContext ctx) async {
    BlocProvider.of<StudentBloc>(ctx).add(UpdateStudentEvent(
        index: index,
        firstname: _firstNameController.text,
        lastname: _lastNameController.text,
        age: _ageController.text,
        major: _majorController.text,
        imagepath: photo?.path ?? widget.studentObject.photo));

    context.read<PhotoBloc>().add(PhotoResetEvent());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(30),
        backgroundColor: Colors.green,
        content: Text(
          'Saved',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
    Navigator.of(context).pop();
  }
}
