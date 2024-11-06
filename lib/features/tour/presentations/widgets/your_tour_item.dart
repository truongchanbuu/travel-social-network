import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/utils/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../policy/presentations/bloc/policy_bloc.dart';
import '../../../shared/presentations/widgets/quill_content.dart';
import '../../../ticket/presentations/bloc/ticket_bloc.dart';
import '../../domain/entities/tour.dart';
import '../bloc/tour_bloc.dart';
import '../pages/save_tour_page.dart';

class YourTourItem extends StatelessWidget {
  final TourEntity tour;
  const YourTourItem({super.key, required this.tour});

  static const subColor = Colors.grey;
  static const TextStyle subTextStyle = TextStyle(
    color: subColor,
    fontSize: 16,
  );
  static const TextStyle titleTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  static const SizedBox spacing = SizedBox(height: 10);
  static const double itemContentHeight = 50;
  static const double iconSize = 23;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToTourDetail(context),
      child: Container(
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? AppTheme.primaryColorDark
              : AppTheme.secondaryColor,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 2,
              color: Colors.black12,
            )
          ],
          border: context.isDarkMode ? Border.all(color: Colors.grey) : null,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tour.tourName,
                style: titleTextStyle,
              ),
              spacing,
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: subColor,
                    size: iconSize,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${tour.departure} - ${tour.destination}',
                    style: subTextStyle,
                  ),
                ],
              ),
              spacing,
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: subColor,
                    size: iconSize,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    tour.duration,
                    style: subTextStyle,
                  ),
                ],
              ),
              spacing,
              Text(
                S.current.tourDescLabel,
                style: titleTextStyle,
              ),
              SizedBox(
                height: itemContentHeight,
                child: QuillContent(content: tour.tourDescription),
              ),
              spacing,
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToTourDetail(BuildContext context) {
    Navigator.of(context).push(
      PageTransition(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt.get<TourBloc>()),
            BlocProvider(create: (context) => getIt.get<TicketBloc>()),
            BlocProvider(create: (context) => getIt.get<PolicyBloc>()),
          ],
          child: SaveTourPage(tour: tour),
        ),
        type: PageTransitionType.leftToRight,
      ),
    );
  }
}
