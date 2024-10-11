import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/constants/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../../tour/data/models/tour.dart';
import '../../../../tour/domain/entities/tour.dart';
import '../../../../tour/presentations/bloc/tour_bloc.dart';
import '../../../../tour/presentations/widgets/tours_grid_view.dart';
import '../../widgets/app_progressing_indicator.dart';
import '../../widgets/home/destination_list.dart';
import '../../widgets/home/home_app_bar.dart';
import '../../widgets/home/homepage_fab.dart';
import '../../widgets/home/homepage_section_heading.dart';
import '../unsupported_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TourEntity> tours = [];

  @override
  void initState() {
    super.initState();
    context.read<TourBloc>().add(GetTopRatingToursEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: const HomePageFloatingActionButton(),
        body: BlocBuilder<TourBloc, TourState>(
          builder: (context, state) {
            if (state is TourActionLoading || state is TourInitial) {
              return const AppProgressingIndicator();
            } else if (state is ListOfToursLoaded) {
              tours = state.tours;
            }

            return _buildBody();
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 200) {
          return const UnsupportedScreen();
        }

        return CustomScrollView(
          slivers: [
            const HomeAppBar(),
            HomepageSectionHeading(
              title: S.current.popularDest,
              padding: defaultPadding,
            ),
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: DestinationList(),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            HomepageSectionHeading(
              title: S.current.recommendTours,
              padding: defaultPadding,
            ),
            tours.isNotEmpty
                ? SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    sliver: ToursGridView(tours: tours),
                  )
                : _buildNoToursWidget(),
          ],
        );
      },
    );
  }

  Widget _buildNoToursWidget() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const Icon(
            Icons.tour,
            color: Colors.grey,
            size: 25,
          ),
          const SizedBox(height: 10),
          Text(
            S.current.noTours,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
