import '../constant/db_keys.dart';
import '../model/monthly_summary.dart';
import '../resources/local_provider.dart';
import '../util/id_util.dart';

class MonthlySummaryRepository {
  factory MonthlySummaryRepository() => _instance;

  MonthlySummaryRepository._();

  static final MonthlySummaryRepository _instance =
      MonthlySummaryRepository._();
  final LocalProvider _localProvider = LocalProvider();

  Future<MonthlySummary> currentMonthlySummary() async {
    return await _localProvider.get<MonthlySummary>(
      where: '${DBKey.MONTHLY_SUMMARY_ID}=?',
      whereArgs: <dynamic>[monthlySummaryID()],
    );
  }

  Future<void> upsert(MonthlySummary summary) async {
    await _localProvider.upsert<MonthlySummary>(summary);
  }

  Future<void> updateMonthlySummary(String monthlySummaryId) async {
    final MonthlySummary updatedSummary = await getUpdatedMonthlySummary(monthlySummaryId);

    if (updatedSummary.monthlySummaryId == null) {
      updatedSummary.balance = 0;
      updatedSummary.expense = 0;
      updatedSummary.budget = 0;
      updatedSummary.income=0;
      updatedSummary.monthlySummaryId = monthlySummaryId;
    }

    updatedSummary.notIncludeInMapping = <String>[
      DBKey.CREATED_AT,
      DBKey.USER_ID,
      DBKey.MONTH,
      DBKey.YEAR,
      DBKey.MONTHLY_SUMMARY_ID,
    ];

    await _localProvider.update<MonthlySummary>(
      updatedSummary,
      where: '${DBKey.MONTHLY_SUMMARY_ID}=?',
      whereArgs: <dynamic>[
        updatedSummary.monthlySummaryId,
      ],
    );
    return;
  }

  Future<MonthlySummary> getUpdatedMonthlySummary(String monthlySummaryId) async {
    return await _localProvider.get<MonthlySummary>(
        tableName: DBKey.ACCOUNT,
        columns: <String>[
          'sum(${DBKey.BALANCE}) as ${DBKey.BALANCE}',
          'sum(${DBKey.EXPENSE}) as ${DBKey.EXPENSE}',
          'sum(${DBKey.INCOME}) as ${DBKey.INCOME}',
          'sum(${DBKey.BUDGET}) as ${DBKey.BUDGET}',
          DBKey.MONTHLY_SUMMARY_ID,
          DBKey.USER_ID,
        ],
        where: '${DBKey.MONTHLY_SUMMARY_ID}=?',
        whereArgs: <dynamic>[monthlySummaryId]);
  }

  Future<List<MonthlySummary>> getMonthlySummaryList() async {
    return await _localProvider.list<MonthlySummary>(orderBy: 'id Desc');
  }
}
