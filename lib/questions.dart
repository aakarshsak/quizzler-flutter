class Question {
  String _q;
  bool _a;

  Question(String q, bool a) {
    this._q = q;
    this._a = a;
  }

  bool getA() {
    return _a;
  }

  String getQ() {
    return _q;
  }
}
