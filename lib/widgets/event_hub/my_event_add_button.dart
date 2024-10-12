import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_psu_course_review/blocs/blocs.dart';
import 'package:flutter_psu_course_review/models/event_model.dart';

class MyEventAddButton extends StatefulWidget {
  const MyEventAddButton({super.key});

  @override
  State<MyEventAddButton> createState() => _MyEventAddButtonState();
}

class _MyEventAddButtonState extends State<MyEventAddButton> {
  double _inputHeight = 50;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _catagories = ['Education', 'Concert', 'Sport'];

  String _selectedCategory = "Education";

  DateTime _selectedDate = DateTime.now();
  String _selectedDateText = '';
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

  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(_checkInputHeight);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _checkInputHeight() async {
    int count = _descriptionController.text.split('\n').length;

    if (count == 0 && _inputHeight != 50.0) {
      return;
    }
    if (count <= 5) {
      // use a maximum height of 6 rows
      // height values can be adapted based on the font size
      var newHeight = count == 0 ? 50.0 : 28.0 + (count * 18.0);
      setState(() {
        _inputHeight = newHeight;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedDateText =
            '${_selectedDate.day} ${_monthNames[_selectedDate.month - 1]} ${_selectedDate.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Event"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Event Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the event title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('Event Category', style: TextStyle(fontSize: 17.0)),
                FormField<String>(
                  builder: (state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      isEmpty: _selectedCategory == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedCategory,
                          isDense: true,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedCategory = newValue;
                                state.didChange(newValue);
                              });
                            }
                          },
                          items: _catagories.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('Event Date', style: TextStyle(fontSize: 17.0)),
                Text(
                    "  ${_selectedDate.toLocal().day} ${_monthNames[_selectedDate.toLocal().month - 1]} ${_selectedDate.toLocal().year}"),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Select date'),
                ),
                TextFormField(
                  controller: _descriptionController,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration:
                      const InputDecoration(labelText: 'Event Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the event description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newEvent = EventModel(
                          eventTitle: _titleController.text,
                          eventDescription: _descriptionController.text,
                          eventDate: _selectedDateText,
                          category: _selectedCategory,
                          authorName: "",
                        );
                        _addEvent(
                            eventTitle: newEvent.eventTitle,
                            eventDescription: newEvent.eventDescription,
                            eventDate: newEvent.eventDate,
                            category: newEvent.category);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addEvent(
      {required eventTitle,
      required eventDescription,
      required eventDate,
      required category}) {
    context.read<EventBloc>().add(CreateEventEvent(
        eventTitle: eventTitle,
        eventDescription: eventDescription,
        eventDate: eventDate,
        category: category));
    FocusScope.of(context).unfocus();
  }
}
