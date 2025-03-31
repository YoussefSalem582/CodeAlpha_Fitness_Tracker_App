import 'package:fitness_tracker_app/data/workout_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final newWorkoutController = TextEditingController();

  // create a new workout
  void createNewWorkout() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Create new Workout"),
            content: TextField(controller: newWorkoutController),
            actions: [
              // save button
              MaterialButton(onPressed: save, child: Text("save")),
              // cancel button
              MaterialButton(onPressed: cancel, child: Text("cancel")),
            ],
          ),
    );
  }

  // save workout
  void save() {
    // get workout name from text controller
    String newWorkoutName = newWorkoutController.text;
    // add workout to workoutdata list
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);

    // pop dialog box
    Navigator.pop(context);
    clear();
  }

  // cancel workout
  void cancel() {
    // pop dialog box
    Navigator.pop(context);
    clear();
  }

  // clear controllers
  void clear() {
    newWorkoutController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder:
          (context, value, child) => Scaffold(
            appBar: AppBar(
              title: const Text('Workout Tracker'),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: createNewWorkout,
            ),
            body: ListView.builder(
              itemCount: value.getWorkoutList().length,
              itemBuilder:
                  (context, index) =>
                      ListTile(title: Text(value.getWorkoutList()[index].name)),
            ),
          ),
    );
  }
}
