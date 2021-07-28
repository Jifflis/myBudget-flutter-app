import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mybudget/controller/initial_controller.dart';
import 'package:mybudget/model/settings.dart';
import 'package:mybudget/repository/acount_repository.dart';
import 'package:mybudget/repository/monthly_repository.dart';
import 'package:mybudget/repository/settings_repository.dart';

import 'add_budget_controller_test.mocks.dart';
import 'initial_controller_test.mocks.dart';

@GenerateMocks(<Type>[SettingsRepository, MonthlySummaryRepository])
Future<void> main() async{
  final InitialController initialController = InitialController();
  final SettingsRepository settingsRepository = MockSettingsRepository();
  final MonthlySummaryRepository monthlySummaryRepository =
      MockMonthlySummaryRepository();
  final AccountRepository accountRepository = MockAccountRepository();

  group('Initial Controller test', () {
    group('Initialize Account Refresher test', () {
      test('should return exact refresh date', () async{
        initialController.initRepositories(
          settingsRepository: settingsRepository,
          monthlySummaryRepository: monthlySummaryRepository,
          accountRepository: accountRepository,
        );

        when(accountRepository.monthlyRefresh(any, any, any, any))
            .thenAnswer((dynamic realInvocation) => null);
        when(monthlySummaryRepository.upsert(any))
            .thenAnswer((dynamic realInvocation) => null);
        when(monthlySummaryRepository.updateMonthlySummary(any))
            .thenAnswer((dynamic realInvocation) => null);
        when(settingsRepository.upsert(any))
            .thenAnswer((dynamic realInvocation) => null);

        final Settings settings = Settings(refreshDate: DateTime(2021,06,30));
        DateTime currentDate = DateTime(2021,06,30);

        await initialController.initAccountRefresher(currentDate,settings);
        expect(settings.refreshDate, currentDate);

        currentDate = DateTime(2021,07,4);
        await initialController.initAccountRefresher(currentDate,settings);
        expect(settings.refreshDate, DateTime(2021,07,31));

        currentDate = DateTime(2021,09,4);
        await initialController.initAccountRefresher(currentDate,settings);
        expect(settings.refreshDate, DateTime(2021,09,30));
      });
    });
  });
}
