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
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder:
          (context, value, child) => Scaffold(
            appBar: AppBar(title: Text(widget.workoutName)),
            body: ListView.builder(
              itemCount: value.numberOfExercises(widget.workoutName),
              itemBuilder:
                  (context, index) => ListTile(
                    title: Text(
                      value
                          .getReleventWorkout(widget.workoutName)
                          .exercises[index]
                          .name,
                    ),
                    subtitle: Row(
                      children: [
                        // weight
                        Chip(
                          label: Text(
                            "${value.getReleventWorkout(widget.workoutName).exercises[index].weight} kg",
                          ),
                        ),

                        // reps
                        Chip(
                          label: Text(
                            "${value.getReleventWorkout(widget.workoutName).exercises[index].reps} reps",
                          ),
                        ),

                        // sets
                        Chip(
                          label: Text(
                            "${value.getReleventWorkout(widget.workoutName).exercises[index].sets} sets",
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
