import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project_flutter/controllers/picsum_controller.dart';
import 'package:test_project_flutter/widgets/custom_shimmer.dart';
import '../widgets/custom_staggered_grid_list.dart';
import '../widgets/error_view.dart';

List a = [
  "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/02/01/22/02/mountain-landscape-2031539_960_720.jpg",
  "https://cdn.pixabay.com/photo/2014/09/14/18/04/dandelion-445228_960_720.jpg",
  "https://cdn.pixabay.com/photo/2022/01/22/16/54/book-6957870_1280.jpg",
  "https://cdn.pixabay.com/photo/2016/07/11/15/43/pretty-woman-1509956_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/02/13/12/26/aurora-1197753_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
  "https://cdn.pixabay.com/photo/2013/11/28/10/03/autumn-219972_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/12/17/19/08/away-3024773_960_720.jpg",
];

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
          _controller.totalAvailablePage += 1;
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
                size: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
