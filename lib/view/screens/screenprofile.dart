import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stdappbloc/businesslogic/bloc/studentbloc/app_bloc.dart';
import 'package:stdappbloc/businesslogic/bloc/studentbloc/app_state.dart';
import 'package:stdappbloc/data/model/model.dart';

import 'screenhome.dart';
import 'screenupdate.dart';

class ScreenProfile extends StatefulWidget {
  final int index;

  const ScreenProfile({super.key, required this.index});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Student Profile'),
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
            child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: BlocBuilder<StudentBloc, StudentState>(
                  builder: (context, state) {
                if (state is StudentInitialState) {
                  return const CircularProgressIndicator();
                }
                StudentModel data = state.studentList[widget.index];
                return Column(
                  children: [
                    Text(
                      'Details of ${data.firstname} ${data.lastname}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                      child: CircleAvatar(
                        radius: 48,
                        backgroundImage: FileImage(
                          File(
                            data.photo,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'First Name:\t',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          data.firstname,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Last Name: \t',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          data.lastname,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Age:\t',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          data.age,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Major:\t',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          data.major,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton.icon(
                        onPressed: (() {
                          //setState(()
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            return ScreenUpdate(
                                studentObject: data, index: widget.index);
                          })));
                          //});
                        }),
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit'))
                  ],
                );
              }),
            ),
          ),
        )));
  }
}
