// import 'package:flutter/material.dart';
// import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

// // ignore: must_be_immutable
// class AppList<T> extends StatefulWidget {
//   AppList(
//       {super.key,
//       this.scrollController,
//       required this.sourceData,
//       required this.onItemRender,
//       required this.onReload,
//       this.onLoadMore,
//       this.errorMessage,
//       this.emptyListIcon,
//       this.separatedWidget,
//       this.prefixListWidget,
//       this.padding = EdgeInsets.zero,
//       this.mainAxisSpacing = 0});
//   ScrollController? scrollController;
//   final Future<void> Function() onReload;
//   final Future Function(int page)? onLoadMore;
//   final Widget Function(T item) onItemRender;
//   final ApiList<T>? sourceData;
//   final String? errorMessage;
//   final EdgeInsets padding;
//   final Widget? emptyListIcon;
//   final Widget? separatedWidget;
//   final Widget? prefixListWidget;
//   final double mainAxisSpacing;

//   @override
//   State<AppList<T>> createState() => _AppListState<T>();
// }

// class _AppListState<T> extends State<AppList<T>> {
//   late final ScrollController _scrollController =
//       widget.scrollController ?? ScrollController();
//   List<T>? get sources => widget.sourceData?.data;
//   bool isLoadingMore = false;
//   final Debouncer _debouncer =
//       Debouncer(delay: const Duration(milliseconds: 100));

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(onScrollHandle);
//   }

//   @override
//   void dispose() {
//     _scrollController.removeListener(onScrollHandle);
//     super.dispose();
//   }

//   void onScrollHandle() {
//     if (widget.onLoadMore != null &&
//         _scrollController.loadMorePointPassed &&
//         widget.sourceData?.meta?.nextPage != null &&
//         widget.sourceData!.meta!.nextPage >
//             widget.sourceData!.meta!.currentPage &&
//         !isLoadingMore) {
//       setState(() {
//         isLoadingMore = true;
//       });
//       _debouncer.call(() {
//         widget.onLoadMore
//             ?.call(widget.sourceData!.meta!.nextPage)
//             .then((value) {
//           setState(() {
//             isLoadingMore = false;
//           });
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           return AppRefreshIndicator(
//               onRefresh: widget.onReload,
//               child: SingleChildScrollView(
//                 controller: _scrollController,
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 child: Container(
//                   constraints: BoxConstraints(
//                       minHeight: constraints.maxHeight,
//                       maxHeight: widget.errorMessage != null ||
//                               (sources == null || sources!.isEmpty)
//                           ? constraints.maxHeight
//                           : double.infinity),
//                   width: constraints.maxWidth,
//                   padding: widget.padding,
//                   child: Column(
//                     mainAxisAlignment: widget.errorMessage != null ||
//                             (sources == null || sources!.isEmpty)
//                         ? MainAxisAlignment.center
//                         : MainAxisAlignment.start,
//                     children: [
//                       // if (widget.errorMessage != null ||
//                       //     (sources == null || sources!.isEmpty))
//                       //   const Spacer(),

//                       ///
//                       /// Error message
//                       ///

//                       if (widget.errorMessage != null) ...[
//                         Center(
//                           child: AppText(
//                             widget.errorMessage,
//                             textAlign: TextAlign.center,
//                           ),
//                         )
//                       ]

//                       ///
//                       /// Loading
//                       ///
//                       else if (sources == null)
//                         const Center(
//                             child: LoadingAnimation(color: AppColors.darkgreen))

//                       ///
//                       /// Sources empty
//                       ///
//                       else if (sources != null && sources!.isEmpty) ...[
//                         if (widget.emptyListIcon != null)
//                           widget.emptyListIcon!
//                         else
//                           const Center(
//                             child: AppText(
//                               "Danh sách rỗng",
//                               color: AppColors.hintTextColor,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 18,
//                               textAlign: TextAlign.center,
//                             ),
//                           )
//                       ]

//                       ///
//                       /// Render list
//                       ///
//                       else
//                         ...List.generate(sources!.length, (index) => index)
//                             .fold<List<Widget>>(
//                                 <Widget>[],
//                                 (previousValue, index) => [
//                                       ...previousValue,
//                                       widget.onItemRender(sources![index]),
//                                       if (widget.separatedWidget != null &&
//                                           index < sources!.length - 1)
//                                         widget.separatedWidget!,
//                                       if (widget.mainAxisSpacing > 0)
//                                         SizedBox(
//                                           height: widget.mainAxisSpacing,
//                                         )
//                                     ]),

//                       ///
//                       /// Loading more
//                       ///
//                       if (isLoadingMore)
//                         const LinearProgressIndicator(
//                             color: AppColors.orange,
//                             backgroundColor: AppColors.acceptBG),
//                       // Row(
//                       //     mainAxisAlignment: MainAxisAlignment.center,
//                       //     children: [
//                       //       SizedBox(
//                       //         width: 12,
//                       //         height: 12,
//                       //         child: CircularProgressIndicator(
//                       //           strokeWidth: 1.5,
//                       //           color: AppColors.green,
//                       //         ),
//                       //       ),
//                       //       SizedBox(
//                       //         width: 8,
//                       //       ),
//                       //     ]),

//                       ///
//                       /// Center if error or empty
//                       ///
//                       if (widget.errorMessage != null ||
//                           (sources != null && sources!.isEmpty))
//                         const Spacer()
//                     ],
//                   ),
//                 ),
//               ));
//         },
//       ),
//     );
//   }
// }

// extension ScrollControllerExt on ScrollController {
//   bool get loadMorePointPassed =>
//       hasClients &&
//       position.maxScrollExtent > 0 &&
//       offset >= position.maxScrollExtent - 40;
// }
