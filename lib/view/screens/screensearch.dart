import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../businesslogic/bloc/studentbloc/app_bloc.dart';
import '../../businesslogic/bloc/studentbloc/app_events.dart';
import '../../businesslogic/bloc/studentbloc/app_state.dart';
import '../../data/model/model.dart';
import 'screenprofile.dart';

class ScreenSearch extends SearchDelegate {
  // first override to clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  //to pop out of the search menu
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        BlocProvider.of<StudentBloc>(context).add(LoadingEvent());
        close(context, null); // for closing the search page and going back
      },
    );
  }

//to show query result
  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<StudentBloc>(context).add(SearchStudentEvent(query: query));

    //bool output = true;
    return BlocBuilder<StudentBloc, StudentState>(
      builder: ((context, state) {
        List<StudentModel> studentList = state.studentList;
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = studentList[index];
            /*  if ((nameVal).contains((query.trim()))) { */
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) {
                          return ScreenProfile(
                            index: index,
                          );
                        }),
                      ),
                    );
                  },
                  title: Text("${data.firstname} ${data.lastname}"),
                  leading: CircleAvatar(
                    backgroundImage: FileImage(File(data.photo)),
                  ),
                ),
                const Divider()
              ],
            );
            /* } else {
              //output = false;
            }
            return null; */
          },
          itemCount: studentList.length,
        );
      }),
    );
  }

  //to show the querying process ie suggestions at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    BlocProvider.of<StudentBloc>(context).add(SearchStudentEvent(query: query));

    return BlocBuilder<StudentBloc, StudentState>(
      builder: ((context, state) {
        List<StudentModel> studentList = state.studentList;

        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = studentList[index];

            /*  String nameVal = studentList + studentList.lastname;
            if ((nameVal).contains((query))) { */
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) {
                          return ScreenProfile(
                            index: index,
                          );
                        }),
                      ),
                    );
                  },
                  title: Text("${data.firstname} ${data.lastname}"),
                  leading: CircleAvatar(
                    backgroundImage: FileImage(File(data.photo)),
                  ),
                ),
                const Divider()
              ],
            );
            /*  } else {
              return Container();
            } */
          },
          itemCount: studentList.length,
        );
      }),
    );
  }
}
