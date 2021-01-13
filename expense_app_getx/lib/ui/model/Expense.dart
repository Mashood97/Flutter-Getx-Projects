class Expense {
  final String id;
  final String expenseName;
  final double Amount;
  final String date;
  final isDeleted;

  Expense({
    this.id,
    this.Amount,
    this.date,
    this.expenseName,
    this.isDeleted =false,
  });
}
