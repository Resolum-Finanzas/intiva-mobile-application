abstract class HistoryEvent {}

class LoadHistory extends HistoryEvent {
  final int userId;

  LoadHistory(this.userId);
}
