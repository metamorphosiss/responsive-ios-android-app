import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/expense.dart';
import 'package:flutter_application_1/widget/expenses_list/expends_item.dart';

class Expenseslist extends StatelessWidget {
  const Expenseslist({
    super.key,
    required this.expense,
    required this.remover,
  });

  final List<Expense> expense;
  final void Function(Expense exxpense) remover;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(.75),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        key: ValueKey(expense[index]),
        onDismissed: (direction) => remover(expense[index]),
        child: ExpenseItem(expense[index]),
      ),
    );
  }
}
