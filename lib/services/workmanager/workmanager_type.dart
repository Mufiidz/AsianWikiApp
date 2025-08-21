enum WorkManagerType {
  initial('initial', 'initial'),
  initialScheduled('initial-scheduled', 'initialScheduled'),
  scheduledShow('scheduled-show', 'scheduledShow');

  final String uniqueName;
  final String taskName;

  const WorkManagerType(this.uniqueName, this.taskName);
}
