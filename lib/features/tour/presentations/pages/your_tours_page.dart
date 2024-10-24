import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../../shared/presentations/widgets/default_white_appbar.dart';
import '../../domain/entities/tour.dart';
import '../bloc/tour_bloc.dart';
import '../widgets/your_tour_item.dart';

class YourToursPage extends StatefulWidget {
  const YourToursPage({super.key});

  @override
  State<YourToursPage> createState() => _YourToursPageState();
}

class _YourToursPageState extends State<YourToursPage> {
  List<TourEntity> tours = [];

  @override
  void initState() {
    super.initState();

    // TODO: Get real user
    context.read<TourBloc>().add(const GetToursByUserIdEvent(currentUserId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: defaultWhiteAppBar(titleText: S.current.myTour),
        body: BlocBuilder<TourBloc, TourState>(
          builder: (context, state) {
            if (state is TourActionLoading) {
              return const AppProgressingIndicator();
            } else if (state is ListOfToursLoaded) {
              tours = state.tours;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.separated(
                itemBuilder: _buildTourItem,
                itemCount: tours.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTourItem(BuildContext context, int index) =>
      YourTourItem(tour: tours[index]);
}
