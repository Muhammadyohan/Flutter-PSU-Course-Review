import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_psu_course_review/blocs/blocs.dart';

class EventEditButton extends StatefulWidget {
  final String eventTitle;
  final String eventDescription;
  final String eventDate;
  final String category;
  final int likesAmount;
  final int eventId;

  const EventEditButton({
    super.key,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    required this.category,
    required this.likesAmount,
    required this.eventId,
  });

  @override
  State<EventEditButton> createState() => _EventEditButtonState();
}

class _EventEditButtonState extends State<EventEditButton> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String _selectedCategory;
  late DateTime _selectedDate;
  late String _selectedDateText;

  final List<String> _categories = ['Education', 'Concert', 'Sport'];
  final List<String> _monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  DateTime _parseDate(String dateString) {
    final parts = dateString.split(' ');
    if (parts.length != 3) {
      // If the format is unexpected, return current date
      return DateTime.now();
    }

    final day = int.tryParse(parts[0]) ?? 1;
    final monthIndex = _monthNames.indexOf(parts[1]);
    final month = monthIndex != -1 ? monthIndex + 1 : 1;
    final year = int.tryParse(parts[2]) ?? DateTime.now().year;

    return DateTime(year, month, day);
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.eventTitle);
    _descriptionController =
        TextEditingController(text: widget.eventDescription);
    _selectedCategory = widget.category;

    _selectedDate = _parseDate(widget.eventDate);
    _selectedDateText = widget.eventDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedDateText =
            '${picked.toLocal().day} ${_monthNames[picked.toLocal().month - 1]} ${picked.toLocal().year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Event"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3E4B92), Color(0xFF5C6BC0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _titleAndCategoryInputForm(),
                const SizedBox(height: 16.0),
                _dateInputForm(context),
                const SizedBox(height: 16.0),
                _descriptionInputForm(),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      backgroundColor: const Color(0xFF3E4B92),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Update',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card _descriptionInputForm() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          controller: _descriptionController,
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Event Description',
            alignLabelWithHint: true,
            prefixIcon: const Icon(Icons.description),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the event description';
            }
            return null;
          },
        ),
      ),
    );
  }

  Card _dateInputForm(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Event Date',
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                child: Text(
                  "  ${_selectedDate.toLocal().day} ${_monthNames[_selectedDate.toLocal().month - 1]} ${_selectedDate.toLocal().year}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card _titleAndCategoryInputForm() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Event Title',
                prefixIcon: const Icon(Icons.title),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the event title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                labelText: 'Event Category',
                prefixIcon: const Icon(Icons.category),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<EventBloc>().add(UpdateEventEvent(
            eventTitle: _titleController.text,
            eventDescription: _descriptionController.text,
            eventDate: _selectedDateText,
            category: _selectedCategory,
            likesAmount: widget.likesAmount,
            eventId: widget.eventId,
          ));
      Navigator.pop(context);
    }
  }
}
