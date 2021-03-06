import 'package:flutter_weather/commom_import.dart';

class GiftEggPage extends StatefulWidget {
  GiftEggPage({Key key}) : super(key: key);

  @override
  State createState() => GiftEggState();
}

class GiftEggState extends PageState<GiftEggPage> with MustKeepAliveMixin {
  final _viewModel = GiftEggViewModel();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _viewModel.loadData(type: LoadType.NEW_LOAD);
    _scrollController.addListener(() {
      // 滑到底部加载更多
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _viewModel.loadMore();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    bindErrorStream(_viewModel.error.stream,
        errorText: AppText.of(context).eggFail,
        retry: () => _viewModel.loadData(type: LoadType.NEW_LOAD));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      key: scafKey,
      body: LoadingView(
        loadingStream: _viewModel.isLoading.stream,
        child: StreamBuilder(
          stream: _viewModel.data.stream,
          builder: (context, snapshot) {
            final List<MziData> list = snapshot.data ?? List();

            return RefreshIndicator(
              onRefresh: () => _viewModel.loadData(type: LoadType.REFRESH),
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(
                    parent: const ClampingScrollPhysics()),
                padding: const EdgeInsets.fromLTRB(2, 4, 2, 0),
                itemCount: list.length,
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                itemBuilder: (context, index) {
                  final data = list[index];

                  return GestureDetector(
                    onTap: () {
                      push(context,
                          page: GiftGankWatchPage(
                              index: index,
                              photos: list,
                              photoStream: _viewModel.photoStream,
                              loadDataFun: () => _viewModel.loadMore()));
                    },
                    child: AspectRatio(
                      aspectRatio: data.width / data.height,
                      child: Hero(
                        tag: data.url,
                        child: NetImage(url: data.url),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
