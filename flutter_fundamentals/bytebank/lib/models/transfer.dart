class Transfer {
  final double transferValue;
  final int accountNumber;

  Transfer(
    this.transferValue,
    this.accountNumber,
  );

  @override
  String toString() {
    return 'Transfer{transferValue: $transferValue, accountNumber: $accountNumber}';
  }
}
