import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Import Firebase options if using FlutterFire CLI
import 'firebase_options.dart';

// Pages
import 'pages/login_page.dart';
import 'pages/home_page.dart';

// Admin
import 'pages/admin/admin_dashboard.dart';
import 'pages/admin/add_student.dart';
import 'pages/admin/gate_pass_requests.dart';
import 'pages/admin/student_list.dart';

// Student
import 'pages/student/student_dashboard.dart';
import 'pages/student/request_pass.dart';
import 'pages/student/view_my_pass.dart';

// Security
import 'pages/security/security_dashboard.dart';
import 'pages/security/qr_scanner.dart';

// History
import 'pages/history/view_history.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const HostelApp());
}

class HostelApp extends StatelessWidget {
  const HostelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hostel Gate Pass',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 26, 26, 155),
          foregroundColor: Colors.white,
        ),
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    if (!isLoggedIn && state.location != '/login') {
      return '/login';
    }
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),

    // Admin
    GoRoute(
      path: '/admin/dashboard',
      builder: (context, state) => const AdminDashboard(),
    ),
    GoRoute(
      path: '/admin/add-student',
      builder: (context, state) => const AddStudent(),
    ),
    GoRoute(
      path: '/admin/student-list',
      builder: (context, state) => const StudentList(),
    ),
    GoRoute(
      path: '/admin/gate-pass-requests',
      builder: (context, state) => const GatePassRequests(),
    ),

    // Student
    GoRoute(
      path: '/student/dashboard',
      builder: (context, state) => const StudentDashboard(),
    ),
    GoRoute(
      path: '/student/request-pass',
      builder: (context, state) => const RequestPass(),
    ),
    GoRoute(
      path: '/student/view-my-pass',
      builder: (context, state) => const ViewMyPass(),
    ),

    // Security
    GoRoute(
      path: '/security/dashboard',
      builder: (context, state) => const SecurityDashboard(),
    ),
    GoRoute(
      path: '/security/qr-scanner',
      builder: (context, state) => const QRScanner(),
    ),

    // History
    GoRoute(
      path: '/history/view',
      builder: (context, state) => ViewHistoryPage(),
    ),
  ],
);

extension on GoRouterState {
  get location => null;
}
