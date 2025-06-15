import 'package:flutter/material.dart';
import 'package:frontend/view_models/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = context.read<LoginViewModel>();
    viewModel.size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder:
          (context, viewModel, child) => Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top:
                    MediaQuery.of(context).padding.top +
                    0.05 * viewModel.size.height,
                bottom: 1 / 10 * viewModel.size.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'lib/assets/images/core/zuggled-banner-image.png',
                    height: 120,
                    width: 120,
                  ),
                  Center(
                    child: Text(
                      'Welcome to Zuggled',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  SizedBox(height: viewModel.size.height * 0.12),
                  AnimatedSwitcher(
                    layoutBuilder:
                        (currentChild, previousChildren) => Expanded(
                          child: Align(
                            alignment: Alignment.topCenter,
                            // ClipRect helps prevent overflow during slide
                            child: currentChild,
                          ),
                        ),
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                    ) {
                      // Apply a slide animation for the entering child
                      final offsetAnimation = Tween<Offset>(
                        begin: Offset(
                          viewModel.animateWidgetIndex == 0 ? -1.0 : 1.0,
                          0.0,
                        ), // Starts from right
                        end: Offset.zero,
                      ).animate(animation);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: FadeTransition(
                          // Add fade for a smoother blend
                          opacity: Tween<double>(
                            begin: 0,
                            end: 1,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    duration: Durations.medium3,
                    switchInCurve: Cubic(0.05, 0.7, 0.1, 1),
                    switchOutCurve: Cubic(0.3, 0, 0.8, 0.15),
                    child:
                        viewModel.animateWidgetIndex == 0
                            ? viewModel.loginWidget
                            : viewModel.otpVerifWidget,
                  ),

                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
    );
  }
}
