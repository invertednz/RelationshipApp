import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';

class RelationshipScreen extends ConsumerStatefulWidget {
  const RelationshipScreen({super.key});

  @override
  ConsumerState<RelationshipScreen> createState() => _RelationshipScreenState();
}

class _RelationshipScreenState extends ConsumerState<RelationshipScreen> {
  final _formKey = GlobalKey<FormState>();
  final _partnerNameController = TextEditingController();
  DateTime? _relationshipStartDate;

  @override
  void dispose() {
    _partnerNameController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() => _relationshipStartDate = date);
    }
  }

  void _continue() {
    if (_formKey.currentState!.validate()) {
      final currentProfile = ref.read(userProfileProvider);
      if (currentProfile != null) {
        final updated = currentProfile.copyWith(
          partnerName: _partnerNameController.text,
          relationshipStartDate: _relationshipStartDate,
        );
        ref.read(userProfileProvider.notifier).updateProfile(updated);
      }
      context.go('/onboarding/preferences/interests');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding/about-you'),
        ),
        title: const Text('Your Relationship'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LinearProgressIndicator(value: 0.4),
                const SizedBox(height: 32),
                Text(
                  'Tell us about your relationship',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _partnerNameController,
                  decoration: const InputDecoration(
                    labelText: 'Partner\'s Name',
                    hintText: 'Enter your partner\'s name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your partner\'s name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _selectDate,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'When did you start dating? (Optional)',
                    ),
                    child: Text(
                      _relationshipStartDate == null
                          ? 'Select date'
                          : '${_relationshipStartDate!.day}/${_relationshipStartDate!.month}/${_relationshipStartDate!.year}',
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
