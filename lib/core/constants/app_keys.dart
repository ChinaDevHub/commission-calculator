class AppKeys {
  const AppKeys._();

  static const String fontName = 'Inter';
  static const String transactionsAsset = 'assets/data/transactions.json';
  static const String themeModeKey = 'theme_mode';
  static const String splashFooterText = 'SECURE FINANCIAL CALCULATIONS';
  static const String splashLogoLabel = 'Commission Calc logo';

  static const String commissionText = 'Commission ';
  static const String calcText = 'Calc';

  static const String appTitle = 'Commission Calc';
  static const String eur = 'EUR';
  static const String displayDateFormat = 'd MMM yyyy';
  static const String separator = ' · ';
  static const String approximately = '≈ ';
  static const String oneEurEquals = '1 EUR = ';
  static const String onAmount = 'on ';
  static const String switchToLightTheme = 'Switch to light theme';
  static const String switchToDarkTheme = 'Switch to dark theme';

  // Transactions
  static const String transactionsTitle = 'Transactions';
  static const String totalCommission = 'TOTAL COMMISSION';
  static const String activity = 'ACTIVITY';
  static const String userPrefix = 'User #';
  static const String fee = 'Fee';
  static const String deposit = 'Deposit';
  static const String withdraw = 'Withdraw';
  static const String private = 'Private';
  static const String business = 'Business';

  // States
  static const String emptyTitle = 'No transactions';
  static const String emptyMessage =
      'The loaded file has no transactions to calculate.';
  static const String errorTitle = 'Couldn’t calculate commissions';
  static const String retry = 'Try again';

  // Details
  static const String detailsTitle = 'Calculation';
  static const String breakdown = 'BREAKDOWN';
  static const String commission = 'Commission';
  static const String amount = 'Amount';
  static const String exchangeRate = 'Exchange rate';
  static const String eurEquivalent = 'EUR equivalent';
  static const String freeAllowanceApplied = 'Free allowance applied';
  static const String weeklyAllowanceLeft = 'Weekly allowance left';
  static const String chargedAmount = 'Charged amount';
  static const String commissionRate = 'Commission rate';
  static const String rawCommission = 'Raw commission';
  static const String roundedCommission = 'Rounded commission';

  // Explanations
  static const String depositExplanation =
      'Deposits are charged a flat rate on the full amount.';
  static const String businessWithdrawExplanation =
      'Business withdrawals are charged a flat rate on the full amount.';
  static const String privateWithdrawFreeExplanation =
      'Fits within the weekly free allowance, so no commission is charged.';
  static const String allowanceExceededExplanation =
      'Exceeds the remaining weekly free allowance, so only the excess is '
      'charged.';
  static const String allowanceExhaustedExplanation =
      'The weekly free allowance is already used up, so the full amount is '
      'charged.';
  static const String freeCountExceededExplanation =
      'The free withdrawals of this week are used up, so the full amount is '
      'charged.';
}
