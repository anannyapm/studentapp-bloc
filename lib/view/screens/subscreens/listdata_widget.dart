import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../businesslogic/bloc/studentbloc/app_bloc.dart';
import '../../../businesslogic/bloc/studentbloc/app_events.dart';
import '../../../businesslogic/bloc/studentbloc/app_state.dart';
import '../../../data/model/model.dart';
import '../screenprofile.dart';

class ListDataWidget extends StatefulWidget {
  const ListDataWidget({super.key});

  @override
  State<ListDataWidget> createState() => _ListDataWidgetState();
}

class _ListDataWidgetState extends State<ListDataWidget> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StudentBloc>(context).add(LoadingEvent());

    return BlocBuilder<StudentBloc, StudentState>(builder: (context, state) {
      List<StudentModel> studentList = state.studentList;

      return ListView.separated(
        itemBuilder: (ctx, indexVal) {
          final studentdata = studentList[indexVal];
          return InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (ctx1) {
                return ScreenProfile(
                  index: indexVal,
                );
              }));
            },
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: FileImage(File(studentdata.photo)),
              ),
              title: Text(
                "${studentdata.firstname} ${studentdata.lastname}",
              ),
              trailing: IconButton(
                onPressed: () {
                  popupDialogueBox(indexVal, context);

                  log('Deleted value from $indexVal');
                },
                icon: const Icon(Icons.delete),
                tooltip: 'Delete profile',
                color: Colors.red,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: studentList.length,
      );
    });
  }

  popupDialogueBox(int indexValue, BuildContext ctx) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Do you want to delete this entry?"),
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16),
            actionsOverflowButtonSpacing: 20,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<StudentBloc>(ctx)
                        .add(DeleteStudentEvent(index: indexValue));
                    Navigator.of(context).pop();
                  },
                  child: const Text("YES")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "NO",
                  )),
            ],
          );
        });
  }
}
