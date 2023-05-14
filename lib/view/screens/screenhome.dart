import 'package:flutter/material.dart';
import 'screenadd.dart';
import 'screensearch.dart';
import 'subscreens/listdata_widget.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    /*  return BlocConsumer<StudentBloc, StudentState>(     
        
        listener: (context, state) {},
        
        builder: (context, state) { */
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Repository'),
        leading: GestureDetector(
          onTap: () {},
          child: const Icon(Icons.people_alt_rounded),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: ScreenSearch(),
                );
              },
              child: const Icon(Icons.search),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => const ScreenAdd()));
        },
        tooltip: 'Add Student',
        child: const Icon(Icons.add),
      ),
      body: const SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListDataWidget(),
      )),
    );
    //},);
  }
}
