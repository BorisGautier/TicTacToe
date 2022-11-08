// ignore_for_file: file_names, prefer_typing_uninitialized_variables

class GameHistoryModal {
  final uid;
  final oppornentId;
  final gameId;
  final playedDate;
  final playedStatus;
  final gotCoin;
  final type;

  GameHistoryModal(
      {this.uid,
      this.oppornentId = "not-available",
      this.gameId,
      this.playedDate,
      this.playedStatus,
      this.gotCoin,
      this.type});
  Map toMap() {
    return {
      "oppornentId": oppornentId,
      "playedStatus": playedStatus,
      "playedDate": playedDate,
      "gotCoin": gotCoin,
      "type": type
    };
  }
}
