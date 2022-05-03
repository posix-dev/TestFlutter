import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project_flutter/controllers/picsum_controller.dart';
import 'package:test_project_flutter/widgets/custom_shimmer.dart';
import '../widgets/custom_staggered_grid_list.dart';
import '../widgets/error_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
  final PicsumController _controller = context.read<PicsumController>();

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Consumer<PicsumController>(builder: (context, data, _) {
            return data.isLoading
                ? const CustomShimmer()
                : data.isError
                    ? ErrorView(
                        message: data.errorMessage,
                        onPressed: () {
                          _controller.loadData();
                        },
                      )
                    : RefreshIndicator(
                        child: const CustomStaggeredGridView(),
                        onRefresh: () async {
                          _controller.loadData();
                        },
                      );
          }),
        ),
        bottomNavigationBar: const BottomNavWidget());
  }
}

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.black,
      child: InkWell(
        onTap: () => print('tap on item'),
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.home_filled,
                color: Theme.of(context).colorScheme.secondary,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
