import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';

import '../../di/injection.dart';
import '../../repository/scheduler_repository.dart';
import '../../res/export_res.dart';
import '../../utils/export_utils.dart';
import 'workmanager_type.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((
    String task,
    Map<String, dynamic>? inputData,
  ) async {
    logger.d('Taskname $task');

    await Future.wait(<Future<void>>[
      EasyLocalization.ensureInitialized(),
      setupDI(),
    ]);

    final SchedulerRepository schedulerRepository =
        getIt<SchedulerRepository>();

    if (task == WorkManagerType.scheduledShow.taskName) {
      await schedulerRepository.weeklyShow();
      return Future<bool>.value(true);
    }

    if (task == WorkManagerType.initial.taskName) {
      logger.d('Init Work');
      return Future<bool>.value(true);
    }

    if (task == WorkManagerType.initialScheduled.taskName) {
      logger.d('runnning init scheduled');
      await schedulerRepository.weeklyShow();
      return Future<bool>.value(true);
    }

    const String initial = 'id.my.mufidz.asianwiki.initial';
    const String initialScheduled =
        'id.my.mufidz.asianwiki.iOSBackgroundAppRefresh';

    if (task == initialScheduled) {
      logger.d('runnning init scheduled.....');
      await schedulerRepository.weeklyShow();
      return Future<bool>.value(true);
    }

    if (task == initial) {
      logger.d('runinnig init work on iOS');
      await schedulerRepository.weeklyShow();
      return Future<bool>.value(true);
    }

    if (task == Workmanager.iOSBackgroundTask) {
      logger.d('iOSBackgroundTask');
      return Future<bool>.value(true);
    }
    return Future<bool>.value(true);
  });
}

class WorkManagerServices {
  final Workmanager _workmanager;

  WorkManagerServices(this._workmanager);

  Future<bool> init() async {
    try {
      logger.d('KdebugMode $kDebugMode');
      await _workmanager.initialize(
        callbackDispatcher,
        isInDebugMode: kDebugMode,
      );
      return true;
    } catch (e) {
      logger.d(e);
      return false;
    }
  }

  Future<void> runScheduledShow() => _workmanager.registerPeriodicTask(
    WorkManagerType.scheduledShow.uniqueName,
    WorkManagerType.scheduledShow.taskName,
    frequency: const Duration(days: 7),
    constraints: Constraints(
      networkType: NetworkType.connected,
      requiresBatteryNotLow: true,
    ),
    existingWorkPolicy: ExistingWorkPolicy.keep,
  );

  Future<void> runInitWork() => _workmanager.registerOneOffTask(
    WorkManagerType.initial.uniqueName,
    WorkManagerType.initial.taskName,
    constraints: Constraints(
      networkType: NetworkType.connected,
      requiresBatteryNotLow: true,
    ),
    existingWorkPolicy: ExistingWorkPolicy.keep,
  );

  Future<void> runInitScheduled() async {
    try {
      logger.d('Init Scheduled Work');
      await _workmanager.registerPeriodicTask(
        WorkManagerType.initialScheduled.uniqueName,
        WorkManagerType.initialScheduled.taskName,
        constraints: Constraints(networkType: NetworkType.connected),
        existingWorkPolicy: ExistingWorkPolicy.replace,
      );
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> runInitScheduledIos() async {
    const String iOSBackgroundAppRefresh =
        'id.my.mufidz.asianwiki.iOSBackgroundAppRefresh';

    try {
      logger.d('Init Scheduled Work Ios');
      await _workmanager.registerPeriodicTask(
        iOSBackgroundAppRefresh,
        iOSBackgroundAppRefresh,
        initialDelay: const Duration(seconds: 10),
      );
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> runInitIos() async {
    const String key = 'id.my.mufidz.asianwiki.initial';

    try {
      logger.d('Init Work Ios');
      await _workmanager.registerOneOffTask(
        key,
        key,
        initialDelay: const Duration(seconds: 20),
      );
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> cancelAll() => _workmanager.cancelAll();
}
