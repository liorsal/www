import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'טופס טיפול ראשוני',
      home: const PrimaryTreatmentForm(),
      // Set text direction to RTL at the root if you prefer
      // Alternatively, wrap your main widget with a Directionality widget
    );
  }
}

class PrimaryTreatmentForm extends StatefulWidget {
  const PrimaryTreatmentForm({super.key});

  @override
  State<PrimaryTreatmentForm> createState() => _PrimaryTreatmentFormState();
}

class _PrimaryTreatmentFormState extends State<PrimaryTreatmentForm> {
  // Example states for radio buttons
  String? airwayValue;
  String? breathingValue;

  // Example states for chip selections (you can store them as booleans or multi-select logic)
  final List<String> mechanismChips = [
    'תאונות דרכים',
    'נפילה',
    'חבלה קהה',
    'פציעת אש',
    'חלל מסלול',
    'רסיסים',
  ];
  final List<bool> mechanismSelected = [false, false, false, false, false, false];

  final List<String> avpuChips = ['ערני', 'מגיב לקול', 'מגיב לכאב', 'לא מגיב'];
  final List<bool> avpuSelected = [false, false, false, false];

  final List<String> neuroDeficitChips = ['חסר תחושתי', 'חסר מוטורי', 'אי שליטה על סוגרים'];
  final List<bool> neuroDeficitSelected = [false, false, false];

  final List<String> eyesChips = ['אין', 'לכאב', 'לקול', 'ספונטני'];
  final List<bool> eyesSelected = [false, false, false, false];

  final List<String> verbalChips = ['לא מגיב', 'לא מובן', 'מילים בודדות', 'מבולבל', 'מתמצא'];
  final List<bool> verbalSelected = [false, false, false, false, false];

  final List<String> motorChips = [
    'ללא תגובה',
    'אקסטנציה',
    'פלקסיה',
    'תגובה לכאב',
    'מיקום כאב',
    'ממלא הוראות'
  ];
  final List<bool> motorSelected = [false, false, false, false, false, false];

  // Example controllers for user inputs
  final TextEditingController personalNumberController = TextEditingController();
  final TextEditingController formNumberController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController injuryDescriptionController = TextEditingController();
  final TextEditingController airwayActionController = TextEditingController();
  final TextEditingController saturationController = TextEditingController();
  final TextEditingController systolicController = TextEditingController();
  final TextEditingController diastolicController = TextEditingController();
  
  // Hard-coded values for date/time examples
  final TextEditingController injuryDateController = TextEditingController(text: "2024-12-16");
  final TextEditingController injuryTimeController = TextEditingController(text: "12:30");
  final TextEditingController airwayActionTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // for Hebrew layout
      child: Scaffold(
        backgroundColor: const Color(0xFF1E293B), // #1E293B
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC), // #F8FAFC
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'טופס טיפול ראשוני',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF1E3A8A), // #1E3A8A
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // פרטים אישיים
                      _buildSectionHeader('פרטים אישיים'),
                      _buildLabeledTextField('מספר אישי', personalNumberController),
                      _buildLabeledTextField('מספר טופס', formNumberController),
                      _buildLabeledTextField('שם מלא', fullNameController),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: _buildLabeledTextField('תאריך פציעה', injuryDateController),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: _buildLabeledTextField('שעת פציעה', injuryTimeController),
                          ),
                        ],
                      ),

                      // מנגנון פציעה
                      _buildSectionHeader('מנגנון פציעה'),
                      _buildChipWrap('בחר מנגנון פציעה', mechanismChips, mechanismSelected),
                      _buildLabeledTextField('תאר את נסיבות הפציעה', injuryDescriptionController,
                          maxLines: 3),

                      // מצב הכרה (AVPU)
                      _buildSectionHeader('מצב הכרה (AVPU)'),
                      _buildChipWrap('AVPU', avpuChips, avpuSelected),

                      // A: נתיב אוויר
                      _buildSectionHeader('A: נתיב אוויר'),
                      _buildRadioRow(
                        label: 'פגיעה בנתיב?',
                        groupValue: airwayValue,
                        onChanged: (value) {
                          setState(() {
                            airwayValue = value;
                          });
                        },
                      ),
                      _buildLabeledTextField('הכנס את הפעולה שבוצעה', airwayActionController),
                      _buildLabeledTextField('שעת פעולה', airwayActionTimeController),

                      // B: נשימה
                      _buildSectionHeader('B: נשימה'),
                      _buildRadioRow(
                        label: 'פגיעה בנשימה?',
                        groupValue: breathingValue,
                        onChanged: (value) {
                          setState(() {
                            breathingValue = value;
                          });
                        },
                      ),
                      _buildLabeledTextField('סטורציה (%)', saturationController,
                          keyboardType: TextInputType.number),

                      // C: מחזור דם
                      _buildSectionHeader('C: מחזור דם'),
                      Row(
                        children: [
                          Expanded(
                            child: _buildLabeledTextField('לחץ דם סיסטולי', systolicController,
                                keyboardType: TextInputType.number),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildLabeledTextField('לחץ דם דיאסטולי', diastolicController,
                                keyboardType: TextInputType.number),
                          ),
                        ],
                      ),

                      // D: הערכה נוירולוגית
                      _buildSectionHeader('D: הערכה נוירולוגית'),
                      _buildChipWrap('חסרים נוירולוגיים', neuroDeficitChips, neuroDeficitSelected),
                      const SizedBox(height: 8),
                      const Text(
                        'סולם גלזגו (GCS)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildSubsectionHeader('עיניים'),
                      _buildChipWrap('', eyesChips, eyesSelected),
                      _buildSubsectionHeader('תגובה מילולית'),
                      _buildChipWrap('', verbalChips, verbalSelected),
                      _buildSubsectionHeader('תגובה מוטורית'),
                      _buildChipWrap('', motorChips, motorSelected),

                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E40AF),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                          textStyle: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          // Handle form submission logic here
                        },
                        child: const Text('שלח טופס'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFF1E3A8A),
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(color: Colors.grey),
      ],
    );
  }

  Widget _buildSubsectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1E3A8A),
        ),
      ),
    );
  }

  Widget _buildLabeledTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),
      ],
    );
  }

  Widget _buildChipWrap(String label, List<String> chipLabels, List<bool> chipStates) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(chipLabels.length, (index) {
            return ChoiceChip(
              label: Text(chipLabels[index]),
              selected: chipStates[index],
              onSelected: (selected) {
                setState(() {
                  chipStates[index] = selected;
                });
              },
              selectedColor: const Color(0xFFCBD5E1), // hover-like color
              backgroundColor: const Color(0xFFE5E7EB),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildRadioRow({
    required String label,
    required String? groupValue,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 20),
          Row(
            children: [
              Radio<String>(
                value: 'yes',
                groupValue: groupValue,
                onChanged: onChanged,
              ),
              const Text('כן'),
            ],
          ),
          const SizedBox(width: 20),
          Row(
            children: [
              Radio<String>(
                value: 'no',
                groupValue: groupValue,
                onChanged: onChanged,
              ),
              const Text('לא'),
            ],
          ),
        ],
      ),
    );
  }
}
