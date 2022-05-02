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
  ScrollController scrollController = ScrollController();

  late PicsumController _controller;

  @override
  void initState() {
    _controller = Provider.of<PicsumController>(context, listen: false);

    scrollListener();

    if (_controller.currentPage == 1) {
      _controller.loadingData();
    }
    super.initState();
  }

  void scrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (_controller.currentPage <= _controller.totalAvailablePage) {
          _controller.currentPage += 1;
          _controller.loadingData();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PicsumController>(builder: (context, data, _) {
      return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: data.isLoading
                ? const CustomShimmer()
                : data.isError
                    ? ErrorView(
                        message: data.errorMessage,
                        onPressed: () {
                          _controller.loadingData();
                        },
                      )
                    : RefreshIndicator(
                        child: CustomStaggeredGridView(
                          controller: scrollController,
                          picsumList: data.picsumModelList,
                          picsumController: _controller,
                        ),
                        onRefresh: () async {
                          _controller.loadingData();
                        },
                      ),
          ),
          bottomNavigationBar: const BottomNavWidget());
    });
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
