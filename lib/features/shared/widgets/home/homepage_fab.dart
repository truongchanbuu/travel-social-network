import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../tour/presentation/pages/create_tour_page.dart';

class HomePageFloatingActionButton extends StatefulWidget {
  const HomePageFloatingActionButton({super.key});

  @override
  State<HomePageFloatingActionButton> createState() =>
      _HomePageFloatingActionButtonState();
}

class _HomePageFloatingActionButtonState
    extends State<HomePageFloatingActionButton> {
  final GlobalKey _fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      key: _fabKey,
      onPressed: _navigateToCreateTourPage,
      backgroundColor: primaryColor,
      shape: const CircleBorder(),
      tooltip: S.current.createTour,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  void _navigateToCreateTourPage() {
    final RenderBox fabRenderBox =
        _fabKey.currentContext!.findRenderObject() as RenderBox;
    Offset originOffset = fabRenderBox.localToGlobal(Offset.zero);

    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const CreateTourPage(),
          transitionDuration:
              const Duration(milliseconds: pageChangeTransitionDuration),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const double begin = 0.0;
            const double end = 1.0;
            const Curve curve = Curves.fastOutSlowIn;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var scaleAnimation = animation.drive(tween);

            return ScaleTransition(
              scale: scaleAnimation,
              alignment: Alignment(
                (originOffset.dx / (MediaQuery.of(context).size.width / 2)) - 1,
                (originOffset.dy / (MediaQuery.of(context).size.height / 2)) -
                    1,
              ),
              child: child,
            );
          },
        ));
  }
}
