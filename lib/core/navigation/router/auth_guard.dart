import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router/router_names.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthGuard {
  final FlutterSecureStorage _storage;
  AuthGuard(this._storage);
  
  Future<String?> redirect(BuildContext context, GoRouterState state) async {
    final token = await _storage.read(key: 'access_token');
    final hasToken = token != null;
    final isAuthRoute =
        state.matchedLocation == RouteNames.signIn ||
        state.matchedLocation == RouteNames.signUp ||
        state.matchedLocation == RouteNames.register;
    if (!hasToken && !isAuthRoute) return RouteNames.signIn;
    if (hasToken && isAuthRoute) return RouteNames.home;
    return null;
  }
   
}
