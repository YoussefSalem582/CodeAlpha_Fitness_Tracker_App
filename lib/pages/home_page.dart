import 'package:fitness_tracker_app/data/workout_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // create a new workout
  void createNewWorkout(){}

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder:
          (context, value, child) => Scaffold(
            appBar: AppBar(title: const Text('Workout Tracker')),
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
