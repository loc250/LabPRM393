import 'package:flutter/material.dart';

/// Exercise 2 – Input Widgets: Slider, Switch, RadioListTile, DatePicker
/// Interactive UI allowing users to control and monitor state values in real time.
class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  // 1. Slider value (e.g., Volume / Rating / Budget)
  double _sliderValue = 50.0;

  // 2. Switch value (e.g., Push Notifications)
  bool _notificationsEnabled = true;

  // 3. Radio group value (e.g., Subscription / Genre tier)
  String _selectedPlan = 'Standard';

  // 4. DatePicker value
  DateTime? _selectedDate;

  // Method to open DatePicker
  Future<void> _pickDate() async {
    final DateTime initialDate = _selectedDate ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2 - Input Controls'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live Status Card
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Live State Values',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                    ),
                    const Divider(),
                    Text('• Slider Value: ${_sliderValue.round()}'),
                    const SizedBox(height: 4),
                    Text(
                        '• Notifications: ${_notificationsEnabled ? "Enabled" : "Disabled"}'),
                    const SizedBox(height: 4),
                    Text('• Selected Plan: $_selectedPlan'),
                    const SizedBox(height: 4),
                    Text(
                      '• Selected Date: ${_selectedDate != null ? "${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}" : "Not selected"}',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 1. Slider Section
            Text(
              '1. Slider (0 - 100)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 100,
              divisions: 20,
              label: _sliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),

            const SizedBox(height: 16),

            // 2. Switch Section
            Text(
              '2. Switch Control',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SwitchListTile(
              title: const Text('Push Notifications'),
              subtitle: const Text('Receive alerts and movie updates'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),

            const SizedBox(height: 16),

            // 3. RadioListTile Section
            Text(
              '3. Radio Group (Membership Plan)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Card(
              child: RadioGroup<String>(
                groupValue: _selectedPlan,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      _selectedPlan = value;
                    });
                  }
                },
                child: const Column(
                  children: [
                    RadioListTile<String>(
                      title: Text('Basic (Free)'),
                      value: 'Basic',
                    ),
                    RadioListTile<String>(
                      title: Text('Standard (\$9.99/mo)'),
                      value: 'Standard',
                    ),
                    RadioListTile<String>(
                      title: Text('Premium (\$14.99/mo)'),
                      value: 'Premium',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 4. DatePicker Section
            Text(
              '4. Date Picker',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Select Date'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    _selectedDate != null
                        ? 'Selected: ${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}'
                        : 'No date chosen',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
