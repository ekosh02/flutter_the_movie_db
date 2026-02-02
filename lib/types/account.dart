class RequestTokenResponse {
  final bool success;
  final String expiresAt;
  final String requestToken;

  RequestTokenResponse({
    required this.success,
    required this.expiresAt,
    required this.requestToken,
  });

  factory RequestTokenResponse.fromJson(Map<String, dynamic> json) {
    return RequestTokenResponse(
      success: json['success'] ?? false,
      expiresAt: json['expires_at'] ?? '',
      requestToken: json['request_token'] ?? '',
    );
  }
}

class SessionResponse {
  final bool success;
  final String sessionId;

  SessionResponse({required this.success, required this.sessionId});

  factory SessionResponse.fromJson(Map<String, dynamic> json) {
    return SessionResponse(
      success: json['success'] ?? false,
      sessionId: json['session_id'] ?? '',
    );
  }
}
