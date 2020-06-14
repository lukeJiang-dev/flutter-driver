
class HomeInfo{
  String orderNum;
  String todayIncome;
  String score;

  HomeInfo({this.orderNum, this.todayIncome, this.score});

  @override
  String toString() {
    return 'HomeInfo{orderNum: $orderNum, todayIncome: $todayIncome, score: $score}';
  }


}
