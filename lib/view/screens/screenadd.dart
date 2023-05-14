import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stdappbloc/businesslogic/bloc/photobloc/photo_bloc.dart';
import 'package:stdappbloc/businesslogic/bloc/photobloc/photo_event.dart';
import 'package:stdappbloc/businesslogic/bloc/photobloc/photo_state.dart';
import 'package:stdappbloc/view/widgets/text_field_widget.dart';

import '../../businesslogic/bloc/studentbloc/app_bloc.dart';
import '../../businesslogic/bloc/studentbloc/app_events.dart';

import 'screenhome.dart';

class ScreenAdd extends StatefulWidget {
  const ScreenAdd({super.key});

  @override
  State<ScreenAdd> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAdd> {
  //textediting controllers
  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();

  final _ageController = TextEditingController();

  final _majorController = TextEditingController();

  File? photo;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Student'),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => const ScreenHome()));
              },
              child: const Icon(Icons.close_rounded),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //check if photo null and assign photo to be shown accordingly
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      BlocBuilder<PhotoBloc, PhotoState>(
                          builder: (context, state) {
                        if (state is PhotoLoaded) {
                          photo = state.photo;
                          if (photo != null) {
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
                        }

                        return const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            radius: 49,
                            backgroundImage: NetworkImage(
                                'https://img.freepik.com/premium-vector/anonymous-user-circle-icon-vector-illustration-flat-style-with-long-shadow_520826-1931.jpg?w=2000'),
                          ),
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
                    height: 15,
                  ),

                  TextFieldWidget(
                      hint: 'First Name',
                      label: 'First Name',
                      textController: _firstNameController),

                  const SizedBox(
                    height: 15,
                  ),

                  TextFieldWidget(
                      hint: 'Last Name',
                      label: 'Last Name',
                      textController: _lastNameController),

                  const SizedBox(
                    height: 15,
                  ),

                  TextFieldWidget(
                    hint: 'Age',
                    label: 'Age',
                    textController: _ageController,
                    typeValue: TextInputType.number,
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                      hint: 'Major',
                      label: 'Major',
                      textController: _majorController),

                  const SizedBox(
                    height: 10,
                  ),

                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            photo != null) {
                          addStudentToModel(context);
                        } else if (photo == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'Please add profile image!',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )));
                        } else {}
                      },
                      child: const Text('Add Student'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//add value to student class model

  Future<void> addStudentToModel(BuildContext ctx) async {
    final firstname = _firstNameController.text.trim();
    final lastname = _lastNameController.text.trim();
    final age = _ageController.text.trim();
    final major = _majorController.text.trim();
    final image = photo;

/*     final studentObject = StudentModel(
        firstname: firstname,
        lastname: lastname,
        age: age,
        major: major,
        photo: image!.path);
 */
    BlocProvider.of<StudentBloc>(ctx).add(AddStudentEvent(
        firstname: firstname,
        lastname: lastname,
        age: age,
        major: major,
        imagepath: image!.path));
    context.read<PhotoBloc>().add(PhotoResetEvent());
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (ctx1) {
      return const ScreenHome();
    }));
  }

  //photo picker function using dart io
}
