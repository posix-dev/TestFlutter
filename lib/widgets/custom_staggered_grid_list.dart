import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project_flutter/api/api_helper.dart';
import 'package:test_project_flutter/controllers/picsum_controller.dart';
import 'package:test_project_flutter/models/picsum_model.dart';
import 'package:test_project_flutter/widgets/bottom_loading_indicator_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:test_project_flutter/widgets/info_view.dart';

class CustomStaggeredGridView extends StatelessWidget {
  const CustomStaggeredGridView(
      {Key? key,
      required this.picsumList,
      this.controller,
      this.picsumController})
      : super(key: key);

  final List<Picsum> picsumList;
  final ScrollController? controller;
  final PicsumController? picsumController;

  final String infoMessageStr = "It's the end of the list. "
      "Please, wait for a second and we upload some new images for you!";

  @override
  Widget build(BuildContext context) {
    return Consumer<PicsumController>(builder: (context, data, _) {
      return StaggeredGridView.countBuilder(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.zero,
        controller: controller,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        itemCount: picsumList.length + 1,
        crossAxisCount: 2,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
        itemBuilder: (BuildContext context, int index) {

          if (index == picsumList.length) {
            if (picsumController!.currentPage >=
                picsumController!.totalAvailablePage) {
              return InfoView(message: infoMessageStr);
            } else {
              return const BottomLoading();
            }
          }

          return _imageViewUI(
              context, RestApi.picsumImageApi(picsumList[index].id!));
        },
      );
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
