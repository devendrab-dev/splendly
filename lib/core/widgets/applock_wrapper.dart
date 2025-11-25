import 'package:flutter/material.dart';
import 'package:money_tracker/core/widgets/secure_app.dart';

class AppLockWrapper extends StatefulWidget {
  final Widget child;
  const AppLockWrapper({required this.child, super.key});

  @override
  State<AppLockWrapper> createState() => _AppLockWrapperState();
}

class _AppLockWrapperState extends State<AppLockWrapper>
    with WidgetsBindingObserver {
  bool locked = true;
  bool _isAuthenticating = false;
  AppLifecycleState? _lastState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    debugPrint("🔒 [LOCK] AppLockWrapper initialized");

    Future.microtask(() {
      _authenticate(); 
    });
  }

  Future<void> _authenticate() async {
    if (_isAuthenticating) {
      debugPrint("⚠️ [LOCK] Already authenticating → skipping");
      return;
    }

    _isAuthenticating = true;
    debugPrint("🔐 [LOCK] Starting authentication flow");

    final bool ok = await DeviceLockAuth.authenticate();
    debugPrint("🔐 [LOCK] Authentication returned: $ok");

    if (mounted) {
      setState(() => locked = !ok);
    }

    _isAuthenticating = false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("📲 [LOCK] Lifecycle changed: $state (last: $_lastState)");

    if (_lastState == AppLifecycleState.paused &&
        state == AppLifecycleState.resumed) {
      debugPrint("🔄 [LOCK] App resumed from background → re-authenticating");
      _authenticate();
    }

    _lastState = state;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("🎨 [LOCK] Building AppLockWrapper → locked: $locked");
    return locked
        ? const Scaffold(body: Center(child: Text("Locked")))
        : widget.child;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    debugPrint("🔒 [LOCK] AppLockWrapper disposed");
    super.dispose();
  }
}
