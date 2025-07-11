import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/services/authentication/register_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController interestController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();

  @override
  void dispose() {
    interestController.dispose();
    birthdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<RegisterViewModel>(
          builder: (context, vm, _) {
            birthdateController.text = vm.birthdate;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  onChanged: vm.setUsername,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Bio'),
                  onChanged: vm.setBio,
                ),
                TextField(
                  controller: interestController,
                  decoration: const InputDecoration(
                    labelText: 'Interests',
                    hintText: 'Type an interest and press Enter',
                  ),
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      final updated = [...vm.interests, value.trim()];
                      vm.setInterests(updated);
                      interestController.clear();
                    }
                  },
                ),

                if (vm.interests.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Wrap(
                      spacing: 8.0,
                      children:
                          vm.interests.map((interest) {
                            return Chip(
                              label: Text(interest),
                              deleteIcon: const Icon(Icons.cancel, size: 18),
                              onDeleted: () {
                                final updated = List<String>.from(vm.interests)
                                  ..remove(interest);
                                vm.setInterests(updated);
                              },
                            );
                          }).toList(),
                    ),
                  ),

                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Gender'),
                  value: vm.gender.isEmpty ? null : vm.gender,
                  items:
                      ['male', 'female']
                          .map(
                            (gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) vm.setGender(value);
                  },
                ),

                TextField(
                  controller: birthdateController,
                  decoration: const InputDecoration(
                    labelText: 'Birthdate',
                    hintText: 'Select your birthdate',
                  ),
                  readOnly: true,
                  onTap: () async {
                    final selected = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (selected != null) {
                      final formatted =
                          '${selected.year}-${selected.month.toString().padLeft(2, '0')}-${selected.day.toString().padLeft(2, '0')}';
                      vm.setBirthdate(formatted);
                    }
                  },
                ),

                const SizedBox(height: 24),

                Center(
                  child: ElevatedButton(
                    onPressed: vm.isLoading ? null : vm.submitProfile,
                    child:
                        vm.isLoading
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                            : const Text('Save Profile'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
