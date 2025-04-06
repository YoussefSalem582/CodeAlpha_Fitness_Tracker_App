import 'package:fitness_tracker_app/components/exercise_tile.dart';
import 'package:fitness_tracker_app/data/workout_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;

  const WorkoutPage({super.key, required this.workoutName});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  // checkbox was tapped
  void onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(
      context,
      listen: false,
    ).checkOffExercise(workoutName, exerciseName);
  }

  // text controller
  final exerciseNameController = TextEditingController();
  final weightController = TextEditingController();
  final repsController = TextEditingController();
  final setsController = TextEditingController();

  // create a new exercise
  void createNewExercise() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Add a new exercise"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // exercise name
                TextField(controller: exerciseNameController),

                // weight
                TextField(controller: weightController),

                // reps
                TextField(controller: repsController),

                // sets
                TextField(controller: setsController),
              ],
            ),
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
    // get exercise name from text controller
    String newExerciseName = exerciseNameController.text;
    String weight = weightController.text;
    String reps = repsController.text;
    String sets = setsController.text;
    // add exercise to workout
    Provider.of<WorkoutData>(
      context,
      listen: false,
    ).addExercise(
        widget.workoutName,
        newExerciseName,
        weight,
        reps,
        sets
    );

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
    weightController.clear();
    exerciseNameController.clear();
    repsController.clear();
    setsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder:
          (context, value, child) => Scaffold(
            appBar: AppBar(title: Text(widget.workoutName)),
            floatingActionButton: FloatingActionButton(
              onPressed: createNewExercise,
              child: Icon(Icons.add),
            ),
            body: ListView.builder(
              itemCount: value.numberOfExercises(widget.workoutName),
              itemBuilder:
                  (context, index) => ExerciseTile(
                    exerciseName:
                        value
                            .getReleventWorkout(widget.workoutName)
                            .exercises[index]
                            .name,
                    weight:
                        value
                            .getReleventWorkout(widget.workoutName)
                            .exercises[index]
                            .weight,
                    reps:
                        value
                            .getReleventWorkout(widget.workoutName)
                            .exercises[index]
                            .reps,
                    sets:
                        value
                            .getReleventWorkout(widget.workoutName)
                            .exercises[index]
                            .sets,
                    isCompleted:
                        value
                            .getReleventWorkout(widget.workoutName)
                            .exercises[index]
                            .isCompleted,
                    onCheckBoxChanged:
                        (val) => onCheckBoxChanged(
                          widget.workoutName,
                          value
                              .getReleventWorkout(widget.workoutName)
                              .exercises[index]
                              .name,
                        ),
                  ),
            ),
          ),
    );
  }
}
