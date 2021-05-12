import 'dart:collection';

import '../model/currency.dart';
import '../resources/local_provider.dart';

class CurrencyRepository {
  factory CurrencyRepository() => _instance;

  CurrencyRepository._();

  static final CurrencyRepository _instance = CurrencyRepository._();

  final LocalProvider _localProvider = LocalProvider();

  final List<Currency> _currencyList = <Currency>[
    Currency(name: 'PHP', currencyID: 'PHP'),
    Currency(name: 'AED', currencyID: 'AED'),
    Currency(name: 'AFN', currencyID: 'AFN'),
    Currency(name: 'ALL', currencyID: 'ALL'),
    Currency(name: 'AMD', currencyID: 'AMD'),
    Currency(name: 'ANG', currencyID: 'ANG'),
    Currency(name: 'AOA', currencyID: 'AOA'),
    Currency(name: 'ARS', currencyID: 'ARS'),
    Currency(name: 'AUD', currencyID: 'AUD'),
    Currency(name: 'AWG', currencyID: 'AWG'),
    Currency(name: 'AZN', currencyID: 'AZN'),
    Currency(name: 'BAM', currencyID: 'BAM'),
    Currency(name: 'BBD', currencyID: 'BDT'),
    Currency(name: 'BDT', currencyID: 'BDT'),
    Currency(name: 'BGN', currencyID: 'BGN'),
    Currency(name: 'BHD', currencyID: 'BHD'),
    Currency(name: 'BIF', currencyID: 'BIF'),
    Currency(name: 'BMD', currencyID: 'BMD'),
    Currency(name: 'BND', currencyID: 'BND'),
    Currency(name: 'BOB', currencyID: 'BOB'),
    Currency(name: 'BOV', currencyID: 'BOV'),
    Currency(name: 'BRL', currencyID: 'BRL'),
    Currency(name: 'BSD', currencyID: 'BSD'),
    Currency(name: 'BTN', currencyID: 'BTN'),
    Currency(name: 'BWP', currencyID: 'BWP'),
    Currency(name: 'BYN', currencyID: 'BYN'),
    Currency(name: 'BZD', currencyID: 'BZD'),
    Currency(name: 'CAD', currencyID: 'CAD'),
    Currency(name: 'CDF', currencyID: 'CDF'),
    Currency(name: 'CHE', currencyID: 'CHE'),
    Currency(name: 'CHF', currencyID: 'CHF'),
    Currency(name: 'CHW', currencyID: 'CHW'),
    Currency(name: 'CLF', currencyID: 'CLF'),
    Currency(name: 'CLP', currencyID: 'CLP'),
    Currency(name: 'CNY', currencyID: 'CNY'),
    Currency(name: 'COP', currencyID: 'COP'),
    Currency(name: 'COU', currencyID: 'COU'),
    Currency(name: 'CRC', currencyID: 'CRC'),
    Currency(name: 'CUC', currencyID: 'CUC'),
    Currency(name: 'CUP', currencyID: 'CUP'),
    Currency(name: 'CVE', currencyID: 'CVE'),
    Currency(name: 'CZK', currencyID: 'CZK'),
    Currency(name: 'DJF', currencyID: 'DJF'),
    Currency(name: 'DKK', currencyID: 'DKK'),
    Currency(name: 'DOP', currencyID: 'DOP'),
    Currency(name: 'DZD', currencyID: 'DZD'),
    Currency(name: 'EGP', currencyID: 'EGP'),
    Currency(name: 'ERN', currencyID: 'ERN'),
    Currency(name: 'ETB', currencyID: 'ETB'),
    Currency(name: 'EUR', currencyID: 'EUR'),
    Currency(name: 'FJD', currencyID: 'FJD'),
    Currency(name: 'FKP', currencyID: 'FKP'),
    Currency(name: 'GBP', currencyID: 'GBP'),
    Currency(name: 'GEL', currencyID: 'GEL'),
    Currency(name: 'GHS', currencyID: 'GHS'),
    Currency(name: 'GIP', currencyID: 'GIP'),
    Currency(name: 'GMD', currencyID: 'GMD'),
    Currency(name: 'GNF', currencyID: 'GNF'),
    Currency(name: 'GTQ', currencyID: 'GTQ'),
    Currency(name: 'GYD', currencyID: 'GYD'),
    Currency(name: 'HKD', currencyID: 'HKD'),
    Currency(name: 'HNL', currencyID: 'HNL'),
    Currency(name: 'HRK', currencyID: 'HRK'),
    Currency(name: 'HTG', currencyID: 'HTG'),
    Currency(name: 'HUF', currencyID: 'HUF'),
    Currency(name: 'IDR', currencyID: 'IDR'),
    Currency(name: 'ILS', currencyID: 'ILS'),
    Currency(name: 'INR', currencyID: 'INR'),
    Currency(name: 'IQD', currencyID: 'IQD'),
    Currency(name: 'IRR', currencyID: 'IRR'),
    Currency(name: 'ISK', currencyID: 'ISK'),
    Currency(name: 'JMD', currencyID: 'JMD'),
    Currency(name: 'JOD', currencyID: 'JOD'),
    Currency(name: 'JPY', currencyID: 'JPY'),
    Currency(name: 'KES', currencyID: 'KES'),
    Currency(name: 'KGS', currencyID: 'KGS'),
    Currency(name: 'KHR', currencyID: 'KHR'),
    Currency(name: 'KMF', currencyID: 'KMF'),
    Currency(name: 'KPW', currencyID: 'KPW'),
    Currency(name: 'KRW', currencyID: 'KRW'),
    Currency(name: 'KWD', currencyID: 'KWD'),
    Currency(name: 'KYD', currencyID: 'KYD'),
    Currency(name: 'KZT', currencyID: 'KZT'),
    Currency(name: 'LAK', currencyID: 'LAK'),
    Currency(name: 'LBP', currencyID: 'LBP'),
    Currency(name: 'LKR', currencyID: 'LKR'),
    Currency(name: 'LRD', currencyID: 'LRD'),
    Currency(name: 'LSL', currencyID: 'LSL'),
    Currency(name: 'LYD', currencyID: 'LYD'),
    Currency(name: 'MAD', currencyID: 'MAD'),
    Currency(name: 'MDL', currencyID: 'MDL'),
    Currency(name: 'MGA', currencyID: 'MGA'),
    Currency(name: 'MKD', currencyID: 'MKD'),
    Currency(name: 'MMK', currencyID: 'MMK'),
    Currency(name: 'MNT', currencyID: 'MNT'),
    Currency(name: 'MOP', currencyID: 'MOP'),
    Currency(name: 'MRU', currencyID: 'MRU'),
    Currency(name: 'MUR', currencyID: 'MUR'),
    Currency(name: 'MVR', currencyID: 'MVR'),
    Currency(name: 'MWK', currencyID: 'MWK'),
    Currency(name: 'MXN', currencyID: 'MXN'),
    Currency(name: 'MXV', currencyID: 'MXV'),
    Currency(name: 'MYR', currencyID: 'MYR'),
    Currency(name: 'MZN', currencyID: 'MZN'),
    Currency(name: 'NAD', currencyID: 'NAD'),
    Currency(name: 'NGN', currencyID: 'NGN'),
    Currency(name: 'NIO', currencyID: 'NIO'),
    Currency(name: 'NOK', currencyID: 'NOK'),
    Currency(name: 'NPR', currencyID: 'NPR'),
    Currency(name: 'NZD', currencyID: 'NZD'),
    Currency(name: 'OMR', currencyID: 'OMR'),
    Currency(name: 'PAB', currencyID: 'PAB'),
    Currency(name: 'PEN', currencyID: 'PEN'),
    Currency(name: 'PGK', currencyID: 'PGK'),
    Currency(name: 'PHP', currencyID: 'PHP'),
    Currency(name: 'PKR', currencyID: 'PKR'),
    Currency(name: 'PLN', currencyID: 'PLN'),
    Currency(name: 'PYG', currencyID: 'PYG'),
    Currency(name: 'QAR', currencyID: 'QAR'),
    Currency(name: 'RON', currencyID: 'RON'),
    Currency(name: 'RSD', currencyID: 'RSD'),
    Currency(name: 'RUB', currencyID: 'RUB'),
    Currency(name: 'RWF', currencyID: 'RWF'),
    Currency(name: 'SAR', currencyID: 'SAR'),
    Currency(name: 'SBD', currencyID: 'SBD'),
    Currency(name: 'SCR', currencyID: 'SCR'),
    Currency(name: 'SDG', currencyID: 'SDG'),
    Currency(name: 'SEK', currencyID: 'SEK'),
    Currency(name: 'SGD', currencyID: 'SGD'),
    Currency(name: 'SHP', currencyID: 'SHP'),
    Currency(name: 'SLL', currencyID: 'SLL'),
    Currency(name: 'SOS', currencyID: 'SOS'),
    Currency(name: 'SRD', currencyID: 'SRD'),
    Currency(name: 'SSP', currencyID: 'SSP'),
    Currency(name: 'STN', currencyID: 'STN'),
    Currency(name: 'SVC', currencyID: 'SVC'),
    Currency(name: 'SYP', currencyID: 'SYP'),
    Currency(name: 'SZL', currencyID: 'SZL'),
    Currency(name: 'THB', currencyID: 'THB'),
    Currency(name: 'TJS', currencyID: 'TJS'),
    Currency(name: 'TMT', currencyID: 'TMT'),
    Currency(name: 'TND', currencyID: 'TND'),
    Currency(name: 'TOP', currencyID: 'TOP'),
    Currency(name: 'TRY', currencyID: 'TRY'),
    Currency(name: 'TTD', currencyID: 'TTD'),
    Currency(name: 'TWD', currencyID: 'TWD'),
    Currency(name: 'TZS', currencyID: 'TZS'),
    Currency(name: 'UAH', currencyID: 'UAH'),
    Currency(name: 'UGX', currencyID: 'UGX'),
    Currency(name: 'USD', currencyID: 'USD'),
    Currency(name: 'USN', currencyID: 'USN'),
    Currency(name: 'UYI', currencyID: 'UYI'),
    Currency(name: 'UYU', currencyID: 'UYU'),
    Currency(name: 'UYW', currencyID: 'UYW'),
    Currency(name: 'UZS', currencyID: 'UZS'),
    Currency(name: 'VES', currencyID: 'VES'),
    Currency(name: 'VND', currencyID: 'VND'),
    Currency(name: 'VUV', currencyID: 'VUV'),
    Currency(name: 'WST', currencyID: 'WST'),
    Currency(name: 'XAF', currencyID: 'XAF'),
    Currency(name: 'XAG', currencyID: 'XAG'),
    Currency(name: 'XAU', currencyID: 'XAU'),
    Currency(name: 'XBA', currencyID: 'XBA'),
    Currency(name: 'XBB', currencyID: 'XBB'),
    Currency(name: 'XBC', currencyID: 'XBC'),
    Currency(name: 'XBD', currencyID: 'XBD'),
    Currency(name: 'XCD', currencyID: 'XCD'),
    Currency(name: 'XDR', currencyID: 'XDR'),
    Currency(name: 'XOF', currencyID: 'XOF'),
    Currency(name: 'XPD', currencyID: 'XPD'),
    Currency(name: 'XPF', currencyID: 'XPF'),
    Currency(name: 'XPT', currencyID: 'XPT'),
    Currency(name: 'XSU', currencyID: 'XSU'),
    Currency(name: 'XTS', currencyID: 'XTS'),
    Currency(name: 'XUA', currencyID: 'XUA'),
    Currency(name: 'XXX', currencyID: 'XXX'),
    Currency(name: 'YER', currencyID: 'YER'),
    Currency(name: 'ZAR', currencyID: 'ZAR'),
    Currency(name: 'ZMW', currencyID: 'ZMW'),
    Currency(name: 'ZWL', currencyID: 'ZWL'),
  ];

  UnmodifiableListView<Currency> get currencyList =>
      UnmodifiableListView<Currency>(_currencyList);

  Future<void> saveDefaultCurrencies() async {
    _currencyList.forEach(upsert);
  }

  Future<void> upsert(Currency currency) async {
    await _localProvider.upsert<Currency>(currency);
  }
}
