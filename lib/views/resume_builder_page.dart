import 'package:flutter/material.dart';

class ResumeBuilderPage extends StatefulWidget {
  const ResumeBuilderPage({super.key});

  @override
  State<ResumeBuilderPage> createState() => _ResumeBuilderPageState();
}

class _ResumeBuilderPageState extends State<ResumeBuilderPage> {
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final skillsController = TextEditingController();

  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Resume Builder")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Ім'я"),
            ),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Позиція"),
            ),
            TextField(
              controller: skillsController,
              decoration: const InputDecoration(labelText: "Навички"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  result =
                      "Ім'я: ${nameController.text}\n"
                      "Позиція: ${titleController.text}\n"
                      "Навички: ${skillsController.text}";
                });
              },
              child: const Text("Генерувати резюме"),
            ),

            const SizedBox(height: 20),

            Text(
              result,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
