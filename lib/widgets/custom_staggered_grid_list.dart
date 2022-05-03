import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project_flutter/api/api_helper.dart';
import 'package:test_project_flutter/controllers/picsum_controller.dart';
import 'package:test_project_flutter/models/picsum_model.dart';
import 'package:test_project_flutter/widgets/bottom_loading_indicator_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:test_project_flutter/widgets/info_view.dart';

class CustomStaggeredGridView extends StatefulWidget {
  const CustomStaggeredGridView({Key? key}) : super(key: key);

  @override
  State<CustomStaggeredGridView> createState() => _CustomStaggeredGridViewState();
}

class _CustomStaggeredGridViewState extends State<CustomStaggeredGridView> {
  final scrollController = ScrollController();

  late final PicsumController _controller;

  final picList = <Picsum>[];
  int _currentPage = 1;

  final String infoMessageStr = "It's the end of the list. "
      "Please, wait for a second and we upload some new images for you!";

  @override
  void initState() {
    super.initState();

    scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = context.read<PicsumController>();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      physics: const BouncingScrollPhysics(),
      controller: scrollController,
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.zero,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      itemCount: picList.length + 1,
      crossAxisCount: 2,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      itemBuilder: (BuildContext context, int index) {
        if (index == picList.length) {
          if (_currentPage >= _controller.totalAvailablePage) {
            return InfoView(message: infoMessageStr);
          } else {
            return const BottomLoading();
          }
        }

        return _imageViewUI(context, RestApi.picsumImageApi(picList[index].id!));
      },
    );
  }

  void _onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (_currentPage <= _controller.totalAvailablePage) {
        _controller.loadData(page: ++_currentPage).then((value) {
          if (value != null) {
            setState(() {
              picList.addAll(value);
            });
          }
        });
      }
    }
  }

  void _init() {
    _controller.loadData().then((value) {
      if (value != null) {
        setState(() {
          picList.addAll(value);
        });
      }
    });
  }

  Widget _imageViewUI(context, url) {
    return Column(children: [
      Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Align(
        alignment: Alignment.bottomRight,
        child: Icon(
          Icons.more_horiz,
          color: Colors.white,
        ),
      ),
    ]);
  }
}