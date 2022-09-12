class LoginStatus {
  final bool isLogin;
  final String username;
  final DateTime loginTime;

  LoginStatus(this.isLogin, this.username, this.loginTime);

  LoginStatus fromJson(Map<String, dynamic> json) {
    return LoginStatus(
      json['isLogin'] as bool,
      json['username'] as String,
      DateTime.parse(json['loginTime'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLogin': isLogin,
      'username': username,
      'loginTime': loginTime.toIso8601String(),
    };
  }
}
