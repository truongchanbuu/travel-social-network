import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/presentations/widgets/app_progressing_indicator.dart';
import '../../domain/entities/tour.dart';
import '../bloc/tour_bloc.dart';
import '../widgets/your_tour_item.dart';

class YourToursPage extends StatefulWidget {
  const YourToursPage({super.key});

  @override
  State<YourToursPage> createState() => _YourToursPageState();
}

class _YourToursPageState extends State<YourToursPage> {
  late final List<TourEntity> tours;

  @override
  void initState() {
    super.initState();

    // TODO: Get real user
    String userId = 'TCB';
    context.read<TourBloc>().add(GetToursByUserIdEvent(userId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<TourBloc, TourState>(
          builder: (context, state) {
            if (state is TourActionLoading) {
              return const AppProgressingIndicator();
            } else if (state is ListOfToursLoaded) {
              tours = state.tours;
            }

            return ListView.builder(
              itemBuilder: _buildTourItem,
              itemCount: tours.length,
            );
          },
        ),
      ),
    );
  }

  Widget _buildTourItem(BuildContext context, int index) =>
      YourTourItem(tour: tours[index]);
}
