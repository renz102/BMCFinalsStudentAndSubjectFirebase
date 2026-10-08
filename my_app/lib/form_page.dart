// Act2 1
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FormPage extends StatefulWidget {
// const FormPage ({super.key});

// @override
//   State<FormPage> createState() => _FormPageState();

// }

// class _FormPageState extends State<FormPage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Student Form'),
//       ),
//       body: Padding(padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           TextField(
//             decoration: const InputDecoration(
//               labelText: 'Name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 22),
//           TextField(
//             decoration: const InputDecoration(
//               labelText: 'Course',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 22),
//           TextField(
//             decoration: const InputDecoration(
//               labelText: 'Section',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 22),
//         ],
//       ),
//       ),
//     );
//   }
// }




// Act 2 2
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FormPage extends StatefulWidget {
//   const FormPage({super.key});

//   @override
//   State<FormPage> createState() => _FormPageState();
// }

// class _FormPageState extends State<FormPage> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController courseController = TextEditingController();
//   final TextEditingController sectionController = TextEditingController();

//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   Future<void> saveData() async {
//     if (nameController.text.trim().isEmpty ||
//         courseController.text.trim().isEmpty ||
//         sectionController.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill in all fields')),
//       );
//       return;
//     }

//     await firestore.collection('students').add({
//       'name': nameController.text.trim(),
//       'course': courseController.text.trim(),
//       'section': sectionController.text.trim(),
//       'createdAt': FieldValue.serverTimestamp(),
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Data saved successfully')),
//     );

//     nameController.clear();
//     courseController.clear();
//     sectionController.clear();
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     courseController.dispose();
//     sectionController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Registration'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 labelText: 'Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: courseController,
//               decoration: const InputDecoration(
//                 labelText: 'Course',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: sectionController,
//               decoration: const InputDecoration(
//                 labelText: 'Section',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: saveData,
//               child: const Text('Save to Firebase'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// 3
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // User information controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();

  // Subject 1 controllers
  final TextEditingController subject1Controller = TextEditingController();
  final TextEditingController startTime1Controller = TextEditingController();
  final TextEditingController endTime1Controller = TextEditingController();

  // Subject 2 controllers
  final TextEditingController subject2Controller = TextEditingController();
  final TextEditingController startTime2Controller = TextEditingController();
  final TextEditingController endTime2Controller = TextEditingController();

  // Firebase
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Keeps track of which step we are on
  int currentStep = 1;

  // Saves the data to Firebase
  Future<void> saveData() async {
    if (nameController.text.trim().isEmpty ||
        courseController.text.trim().isEmpty ||
        sectionController.text.trim().isEmpty ||
        subject1Controller.text.trim().isEmpty ||
        startTime1Controller.text.trim().isEmpty ||
        endTime1Controller.text.trim().isEmpty ||
        subject2Controller.text.trim().isEmpty ||
        startTime2Controller.text.trim().isEmpty ||
        endTime2Controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
      return;
    }

    try {
      await firestore.collection('Biodata').add({
        'name': nameController.text.trim(),
        'course': courseController.text.trim(),
        'section': sectionController.text.trim(),
        'subjects': [
          {
            'name': subject1Controller.text.trim(),
            'startTime': startTime1Controller.text.trim(),
            'endTime': endTime1Controller.text.trim(),
          },
          {
            'name': subject2Controller.text.trim(),
            'startTime': startTime2Controller.text.trim(),
            'endTime': endTime2Controller.text.trim(),
          },
        ],
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration saved successfully'),
        ),
      );

      // Clear all fields
      nameController.clear();
      courseController.clear();
      sectionController.clear();

      subject1Controller.clear();
      startTime1Controller.clear();
      endTime1Controller.clear();

      subject2Controller.clear();
      startTime2Controller.clear();
      endTime2Controller.clear();

      // Go back to Step 1
      setState(() {
        currentStep = 1;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: $error'),
        ),
      );
    }
  }

  // Goes to the next step
  void nextStep() {
    if (currentStep == 1) {
      if (nameController.text.trim().isEmpty ||
          courseController.text.trim().isEmpty ||
          sectionController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in all registration fields'),
          ),
        );
        return;
      }
    }

    if (currentStep == 2) {
      if (subject1Controller.text.trim().isEmpty ||
          startTime1Controller.text.trim().isEmpty ||
          endTime1Controller.text.trim().isEmpty ||
          subject2Controller.text.trim().isEmpty ||
          startTime2Controller.text.trim().isEmpty ||
          endTime2Controller.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in all subject fields'),
          ),
        );
        return;
      }
    }

    if (currentStep < 3) {
      setState(() {
        currentStep++;
      });
    }
  }

  // Goes back to the previous step
  void previousStep() {
    if (currentStep > 1) {
      setState(() {
        currentStep--;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    courseController.dispose();
    sectionController.dispose();

    subject1Controller.dispose();
    startTime1Controller.dispose();
    endTime1Controller.dispose();

    subject2Controller.dispose();
    startTime2Controller.dispose();
    endTime2Controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: currentStep == 1
            ? null
            : IconButton(
                onPressed: previousStep,
                icon: const Icon(Icons.arrow_back),
              ),
        title: Text(
          currentStep == 1
              ? 'User Registration'
              : currentStep == 2
                  ? 'Subject Enrollment'
                  : 'Subject Verification',
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Shows the current step
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Step $currentStep of 3',
              ),
            ),

            const SizedBox(height: 20),

            // STEP 1
            if (currentStep == 1)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: courseController,
                        decoration: const InputDecoration(
                          labelText: 'Course',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: sectionController,
                        decoration: const InputDecoration(
                          labelText: 'Section',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // STEP 2
            if (currentStep == 2)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // SUBJECT 1
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Subject 1',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: subject1Controller,
                        decoration: const InputDecoration(
                          labelText: 'Subject Name',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: startTime1Controller,
                        decoration: const InputDecoration(
                          labelText: 'Start Time',
                          hintText: 'Example: 8:00 AM',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: endTime1Controller,
                        decoration: const InputDecoration(
                          labelText: 'End Time',
                          hintText: 'Example: 10:00 AM',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // SUBJECT 2
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Subject 2',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: subject2Controller,
                        decoration: const InputDecoration(
                          labelText: 'Subject Name',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: startTime2Controller,
                        decoration: const InputDecoration(
                          labelText: 'Start Time',
                          hintText: 'Example: 10:00 AM',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextField(
                        controller: endTime2Controller,
                        decoration: const InputDecoration(
                          labelText: 'End Time',
                          hintText: 'Example: 12:00 PM',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // STEP 3
            if (currentStep == 3)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Please verify your details:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'Name: ${nameController.text}',
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Course: ${courseController.text}',
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Section: ${sectionController.text}',
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Subjects',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        '1. ${subject1Controller.text}',
                        style: const TextStyle(fontSize: 16),
                      ),

                      Text(
                        '   ${startTime1Controller.text} - '
                        '${endTime1Controller.text}',
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        '2. ${subject2Controller.text}',
                        style: const TextStyle(fontSize: 16),
                      ),

                      Text(
                        '   ${startTime2Controller.text} - '
                        '${endTime2Controller.text}',
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Make sure all information is correct before saving.',
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 15),

            // NEXT / SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: currentStep == 3 ? saveData : nextStep,
                child: Text(
                  currentStep == 3 ? 'Save to Firebase' : 'Next',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}