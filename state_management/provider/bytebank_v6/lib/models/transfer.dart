class Transfer {
  final double transferValue;
  final int accountNumber;

  Transfer(
    this.transferValue,
    this.accountNumber,
  );

  String transferValueToString() {
    return 'R\$ $transferValue';
  }

  String accountNumberToString() {
    return 'Account: $accountNumber';
  }
}
