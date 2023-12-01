import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/expense.dart';
import 'package:flutter_application_1/widget/expenses_list/expenses_list.dart';
import 'package:flutter_application_1/widget/new_expense.dart';
import 'package:flutter_application_1/widget/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _regesterdStates = [
    Expense(
      title: 'my first hope',
      amount: 12.3433,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: 'hello there',
      amount: 11.34653,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];
  void _openNewLayOut() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpenses,
      ),
    );
  }

  void _addExpenses(Expense expense) {
    setState(() {
      _regesterdStates.add(expense);
    });
  }

  void _removeExpendes(Expense expense) {
    final expendIndex = _regesterdStates.indexOf(expense);
    setState(() {
      _regesterdStates.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('item deleted'),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              _regesterdStates.insert(expendIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Widget mainContent = const Center(
      child: Text('please add some value'),
    );
    if (_regesterdStates.isNotEmpty) {
      mainContent = Expenseslist(
        expense: _regesterdStates,
        remover: _removeExpendes,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('flutter appBar tracker', textAlign: TextAlign.center),
        actions: [
          IconButton(
            onPressed: _openNewLayOut,
            icon: const Icon(Icons.add),
            style: IconButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 116, 111, 246),
                foregroundColor: const Color.fromARGB(255, 0, 0, 0)),
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _regesterdStates),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _regesterdStates),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
