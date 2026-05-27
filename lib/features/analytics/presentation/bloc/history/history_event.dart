/// Base class for all events handled by [HistoryBloc].
sealed class HistoryEvent {}

/// Loads the simulation history for the user identified by [userId].
///
/// [userId] is injected via constructor — never stored in global state.
class LoadHistory extends HistoryEvent {

  final int userId;

  LoadHistory(this.userId);
}
