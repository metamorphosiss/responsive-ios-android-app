import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/expense.dart';
import 'package:flutter/cupertino.dart'; // for ios styles and behaiver
import 'dart:io';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // var _enterdtitle = '';
  // void _restorInput(String input) {
  //   _enterdtitle = input;
  // }
  final _controllerEditor = TextEditingController();
  final _controlNum = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedcategory = Category.leisure;
  @override
  void dispose() {
    _controllerEditor.dispose();
    _controlNum.dispose();
    super.dispose();
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text('invalid value'),
                content: const Text(
                    '[plz make sure that u have entered valdide amount,num,date and category]'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('OK'))
                ],
              ));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('invalid value'),
          content: const Text(
              '[plz make sure that u have entered valdide amount,num,date and category]'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('OK'))
          ],
        ),
      );
      
    }
  }

  void _submitExpenseData() {
    final enterdAmount = double.tryParse(_controlNum.text);
    final isEditingAmount = enterdAmount == null || enterdAmount <= 0;
    if (_controllerEditor.text.trim().isEmpty ||
        isEditingAmount ||
        _selectedDate == null) {
      _showDialog();

      return;
    }

    widget.onAddExpense(
      Expense(
          title: _controllerEditor.text,
          amount: enterdAmount,
          date: _selectedDate!,
          category: _selectedcategory),
    );
    Navigator.pop(context);
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final datePicker = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = datePicker;
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity, // for letting it  has the full screen show
          child: SingleChildScrollView(
            //single child scroll for mediaquryy and for removing bug when u use mediaquery

            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controllerEditor,
                            // onChanged: _restorInput,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text('write ur own text'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: TextField(
                            controller: _controlNum,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefix: Text('\$'),
                              label: Text('write ur own num '),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _controllerEditor,
                      // onChanged: _restorInput,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('write ur own text'),
                      ),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedcategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedcategory = value;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_selectedDate == null
                                  ? 'no date added'
                                  : formatter.format(_selectedDate!)),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controlNum,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefix: Text('\$'),
                              label: Text('write ur own num '),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_selectedDate == null
                                  ? 'no date added'
                                  : formatter.format(_selectedDate!)),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('save Expense'),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedcategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedcategory = value;
                            });
                          },
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('save Expense'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
