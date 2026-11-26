import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tp5/entities/herramienta.dart';
import 'package:tp5/providers/auth_provider.dart';
import 'package:tp5/screens/detalle_screen.dart';
import 'package:tp5/screens/form_herramienta_screen.dart';
import 'package:tp5/screens/home_screen.dart';
import 'package:tp5/screens/login_screen.dart';
import 'package:tp5/screens/register_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final isLoggedIn = ref.watch(authProvider.select((s) => s.user != null));

  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      final path = state.matchedLocation;
      final enRutaAuth = path == '/login' || path == '/register';

      if (!isLoggedIn && !enRutaAuth) {
        return '/login';
      }
      if (isLoggedIn && enRutaAuth) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/detalle',
        builder: (context, state) {
          final productoSeleccionado = state.extra as Herramienta;
          return DetalleScreen(product: productoSeleccionado);
        },
      ),
      GoRoute(
        path: '/formulario',
        builder: (context, state) {
          final herramienta = state.extra as Herramienta?;
          return FormHerramientaScreen(herramienta: herramienta);
        },
      ),
    ],
  );
});