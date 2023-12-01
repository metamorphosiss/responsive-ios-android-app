import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  // or can it be final List<Expense> expense; ?
  final Expense expense;
  // final List<Map<Category, Icon>> cat;
  @override
  Widget build(BuildContext context) {
    return Card(
      
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.formatedDate)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
