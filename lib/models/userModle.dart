// ignore_for_file: file_names, prefer_typing_uninitialized_variables

class CreateUser {
  final username;
  final userid;
  final matchplayed;
  final matchWon;
  final profilePic;
  final coin;
  final score;
  final type;

  CreateUser(
      {this.username,
      this.userid,
      this.matchplayed,
      this.matchWon,
      this.profilePic,
      this.coin,
      this.score,
      this.type});

  Map<String, dynamic> map() {
    return {
      "username": username,
      "userid": userid,
      "matchplayed": matchplayed,
      "matchwon": matchWon,
      "profilePic": profilePic,
      "coin": coin ?? 500,
      "score": score ?? 0,
      "type": type
    };
  }
}
