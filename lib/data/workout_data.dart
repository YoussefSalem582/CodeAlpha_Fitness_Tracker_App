import 'package:fitness_tracker_app/models/workout.dart';
import 'package:flutter/widgets.dart';

import '../models/exercise.dart';

class WorkoutData extends ChangeNotifier {
  /*

  WORKOUT DATA STRUCTURE

  - This overall list contains the different workouts
  - Each workout has a name, and list of exercise
   */
  List<Workout> workoutList = [
    // default workout
    Workout(
      name: 'Upper Body',
      exercises: [
        Exercise(name: "Bicep Curls", weight: "10", reps: "10", sets: "3"),
      ],
    ),
  ];

  // get the list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  // get length of a given workout
  int numberOfExercises(String workoutName) {
    Workout relevantWorkout = getReleventWorkout(workoutName);

    return relevantWorkout.exercises.length;
  }

  // add a workout
  void addWorkout(String name) {
    // add a new workout with a blank list of exercises
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();
  }

  // add an exercise to a workout
  void addExercise(
    String workoutName,
    String exerciseName,
    String weight,
    String reps,
    String sets,
  ) {
    // find the relevant workout
    Workout relevantWorkout = workoutList.firstWhere(
      (workout) => workout.name == workoutName,
    );
    // add the exercise to the relevant workout
    relevantWorkout.exercises.add(
      Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets),
    );

    notifyListeners();
  }

  // check off exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    // find the relevant workout
    Workout relevantWorkout = getReleventWorkout(workoutName);

    // find the relevant exercise in that workout
    Exercise relevantExercise = relevantWorkout.exercises.firstWhere(
          (exercise) => exercise.name == exerciseName,
    );

    // check off boolean to show user completed the exercise
    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();
  }

  // return relevant workout object, given a workout name
  Workout getReleventWorkout(String workoutName) {
    Workout relevantWorkout = workoutList.firstWhere(
      (workout) => workout.name == workoutName,
    );

    return relevantWorkout;
  }

  // return relevant exercise object, given a workout name + exercise name
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    // find relevant workout first
    Workout relevantWorkout = getReleventWorkout(workoutName);

    // then find the relevant exercise in that workout
    Exercise relevantExercise = relevantWorkout.exercises.firstWhere(
      (exercise) => exercise.name == exerciseName,
    );

    return relevantExercise;
  }
}
