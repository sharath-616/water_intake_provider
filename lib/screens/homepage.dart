import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake_provider/provider/water_intake_provider.dart';
import 'package:water_intake_provider/utilities/constant.dart';
import 'package:water_intake_provider/utilities/custom_text_widgets.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.blue[300],
        title: const CustomTextWidgets(
          text: "Water Intake App",
          clr: Colors.black,
          fs: 20,
          fw: FontWeight.bold,
          lp: 1,
        ),
        centerTitle: true,
      ),
      body: Consumer<WaterIntakeProvider>(
        builder: (context, waterIntakeProvider, child) {
          double progress = waterIntakeProvider.waterIntake / waterIntakeProvider.dailyGoals;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sizedBox,
              Center(
                child: SizedBox(
                  width: 200,
                  child: Image(
                    image: AssetImage(
                      img,
                    ),
                  ),
                ),
              ),
              sizedBox,
              const CustomTextWidgets(
                text: 'You have consumed..!',
                clr: Colors.black,
                fs: 20,
                fw: FontWeight.w500,
              ),
              sizedBox,
              CustomTextWidgets(
                text: '${waterIntakeProvider.waterIntake} glass "es" of water',
                clr: Colors.black,
                fs: 20,
                fw: FontWeight.w500,
              ),
              sizedBox,
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(50),
                  value: progress,
                  backgroundColor: Colors.grey,
                  valueColor: const AlwaysStoppedAnimation(Colors.blue),
                  minHeight: 20,
                ),
              ),
              sizedBox,
              DropdownButton(
                value: waterIntakeProvider.dailyGoals,
                items: waterIntakeProvider.dailyGoalOptions.map((int value) {
                  return DropdownMenuItem(
                    value: value,
                    child: CustomTextWidgets(
                      text: '$value glasses',
                      clr: Colors.black,
                      fs: 20,
                      fw: FontWeight.w500,
                    ),
                  );
                }).toList(),
                onChanged: (int? newvalue) {
                  if (newvalue != null) {
                    waterIntakeProvider.setDailyGoals(newvalue);
                  }
                },
              ),
              ElevatedButton(
                onPressed: waterIntakeProvider.goalReached
                    ? null
                    : () {
                        waterIntakeProvider.incrementWaterIntake();
                        if (waterIntakeProvider.goalReached) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const CustomTextWidgets(
                                  text: "Congratulations!",
                                ),
                                content: CustomTextWidgets(
                                  text:
                                      "You have reached your daily water intake goal.${waterIntakeProvider.dailyGoals}",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const CustomTextWidgets(
                                      text: "OK",
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                child: const CustomTextWidgets(
                  text: 'Add a glass of water',
                ),
              ),
              sizedBox,
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const CustomTextWidgets(text: "Reset Water Intake..!"),
                        content: const SingleChildScrollView(
                          child: ListBody(
                            children: [
                              CustomTextWidgets(text: "Are you sure you want to reset your water intake...?"),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const CustomTextWidgets(
                              text: 'Cancel',
                              clr: Colors.black,
                              fs: 20,
                              fw: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              waterIntakeProvider.resetWaterIntake();
                              Navigator.of(context).pop();
                            },
                            child: const CustomTextWidgets(
                              text: 'Reset',
                              clr: Colors.black,
                              fs: 20,
                              fw: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const CustomTextWidgets(
                  text: 'Reset',
                  clr: Colors.black,
                  fs: 18,
                  fw: FontWeight.w500,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
