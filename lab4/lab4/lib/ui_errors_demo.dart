import 'package:flutter/material.dart';

/// Exercise 5 – Debug & Fix Common UI Errors
/// Demonstrates 4 common Flutter mistakes, why they happen, and their solutions.
class UIErrorsDemo extends StatefulWidget {
  const UIErrorsDemo({super.key});

  @override
  State<UIErrorsDemo> createState() => _UIErrorsDemoState();
}

class _UIErrorsDemoState extends State<UIErrorsDemo> {
  // Demo State for Fix 3 (setState)
  int _counter = 0;

  // Demo State for Fix 4 (DatePicker with valid context)
  DateTime? _demoDate;

  void _incrementCounterCorrectly() {
    setState(() {
      _counter++;
    });
  }

  Future<void> _pickDateSafely(BuildContext context) async {
    // Calling showDatePicker with a valid mounted BuildContext
    if (!mounted) return;
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && mounted) {
      setState(() {
        _demoDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5 - Debug UI Errors'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade700),
              ),
              child: Row(
                children: [
                  Icon(Icons.bug_report, color: Colors.amber.shade900),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Common Flutter UI pitfalls, root causes, and verified fixes.',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Task 1: Fix ListView inside Column
            _buildFixCard(
              taskNumber: '1',
              title: 'ListView inside Column (Unbounded Height)',
              errorMessage:
                  'Vertical viewport was given unbounded height (RenderFlex overflowed).',
              cause:
                  'Column provides infinite vertical constraint, while ListView by default attempts to occupy all available vertical space.',
              solution:
                  'Wrap ListView in Expanded / Flexible to constrain its height, or set shrinkWrap: true with physics: NeverScrollableScrollPhysics() inside a scrollable view.',
              demoChild: Container(
                height: 140, // Example of constrained container simulating Expanded
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) => ListTile(
                    dense: true,
                    leading: const Icon(Icons.check_circle, color: Colors.green),
                    title: Text('Fixed item #${index + 1} with Expanded'),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Task 2: Fix Overflow using SingleChildScrollView
            _buildFixCard(
              taskNumber: '2',
              title: 'RenderFlex Overflow on Small Screens',
              errorMessage:
                  'A RenderFlex overflowed by xxx pixels on the bottom (Yellow/Black stripes).',
              cause:
                  'Content height exceeds the physical screen viewport when keyboard pops up or on smaller devices.',
              solution:
                  'Wrap Column or root body in SingleChildScrollView to allow the user to scroll vertically without clipping or overflow.',
              demoChild: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.screen_lock_portrait, color: Colors.green),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This entire screen is wrapped in SingleChildScrollView, preventing any bottom overflow on rotation or small devices.',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Task 3: Fix State Update without setState()
            _buildFixCard(
              taskNumber: '3',
              title: 'State Not Updating on Screen',
              errorMessage:
                  'Variable changes in memory but UI does not refresh/re-render.',
              cause:
                  'Modifying a state variable directly without calling setState() will not notify the Flutter framework to trigger build().',
              solution:
                  'Enclose variable modification inside setState(() { ... }) inside a StatefulWidget.',
              demoChild: Row(
                children: [
                  ElevatedButton(
                    onPressed: _incrementCounterCorrectly,
                    child: const Text('Tap to increment'),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Counter: $_counter',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Task 4: Fix DatePicker BuildContext Error
            _buildFixCard(
              taskNumber: '4',
              title: 'DatePicker BuildContext Lifecycle Error',
              errorMessage:
                  'Looking up a deactivated widget ancestor or using context across async gaps without mounted check.',
              cause:
                  'Calling showDatePicker with an unmounted or invalid BuildContext (e.g., during initState or after widget disposal).',
              solution:
                  'Call showDatePicker from user interaction callbacks (onPressed) and verify "if (!mounted) return;" before utilizing results.',
              demoChild: Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _pickDateSafely(context),
                    icon: const Icon(Icons.date_range),
                    label: const Text('Open DatePicker Safely'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _demoDate == null
                          ? 'No date picked'
                          : 'Picked: ${_demoDate!.day}/${_demoDate!.month}/${_demoDate!.year}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFixCard({
    required String taskNumber,
    required String title,
    required String errorMessage,
    required String cause,
    required String solution,
    required Widget demoChild,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.indigo,
                  child: Text(
                    taskNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            Text(
              '⚠️ Error:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red.shade700,
                fontSize: 13,
              ),
            ),
            Text(
              errorMessage,
              style: TextStyle(fontSize: 12, color: Colors.red.shade900),
            ),
            const SizedBox(height: 8),
            const Text(
              '🔍 Root Cause:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            Text(cause, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
            Text(
              '✅ Solution:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
                fontSize: 13,
              ),
            ),
            Text(solution, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: demoChild,
            ),
          ],
        ),
      ),
    );
  }
}
