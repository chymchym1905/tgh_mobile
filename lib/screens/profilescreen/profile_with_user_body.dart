import 'package:tgh_mobile/imports.dart';

import 'categorytab.dart';
import 'tableheader_speedrun.dart';
import 'tablerow_speedrun.dart';

class ProfileBody extends ConsumerStatefulWidget {
  const ProfileBody({super.key, required this.user, required this.userProfileInfo});
  final User user;
  final UserProfileInfo userProfileInfo;

  @override
  ConsumerState<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends ConsumerState<ProfileBody> {
  int limit = 10;
  int page = 0;
  int _speedrunCategoryIndex = 0;
  String _currentCategory = 'Abyss';

  final List<String> _categoryOrder = [
    'Abyss',
    'Domain',
    'Event',
    'Weekly Boss',
    'World Boss',
  ];

  Widget _shimmerRow() {
    return Row(
      children: [
        SizedBox(width: 10.wr),
        ShimmerComponent.circular(height: 26.wr, width: 26.wr),
        SizedBox(width: 10.wr),
        Expanded(flex: 4, child: ShimmerComponent.regtangular(height: 26.wr)),
        SizedBox(width: 10.wr),
        Expanded(flex: 4, child: ShimmerComponent.regtangular(height: 26.wr)),
        SizedBox(width: 10.wr),
        Expanded(flex: 3, child: ShimmerComponent.regtangular(height: 26.wr)),
        SizedBox(width: 10.wr),
        Expanded(flex: 2, child: ShimmerComponent.regtangular(height: 26.wr)),
        SizedBox(width: 10.wr),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final speedruns = ref.watch(fetchCompetitorSpeedrunsProvider(
      widget.user.competitor!.id,
      SortBy.createdAt.value,
      SortDir.desc.value,
      page,
      limit,
    ));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(10.wr),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              speedruns.when(
                data: (data) {
                  final uniqueCategories = data.$2.map((e) => e.speedrunCategory).toSet().toList()
                    ..sort((a, b) => _categoryOrder.indexOf(a).compareTo(_categoryOrder.indexOf(b)));
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List<Widget>.generate(
                      uniqueCategories.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(right: 8.wr),
                        child: CategoryTab(
                          name: uniqueCategories[index],
                          selected: _speedrunCategoryIndex == index,
                          onTap: () => setState(() {
                            _speedrunCategoryIndex = index;
                            _currentCategory = uniqueCategories[index];
                          }),
                        ),
                      ),
                    ),
                  );
                },
                error: (error, stack) => AppErrorWidget(message: [error.toString(), stack.toString()]),
                loading: () => SizedBox(
                  width: 20.wr,
                  height: 20.wr,
                  child: const CircularProgressIndicator(),
                ),
              ),
              10.verticalSpace,
              Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceDim,
                    borderRadius: BorderRadius.circular(5.wr),
                    border: Border.all(color: Theme.of(context).colorScheme.outline),
                  ),
                  child: Column(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(5.wr)),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerLowest,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: speedruns.when(
                            data: (data) {
                              if (_currentCategory == 'Abyss') {
                                return const TableHeaderAbyss();
                              } else if (_currentCategory == 'Domain') {
                                return const TableHeaderDomain();
                              } else if (_currentCategory == 'Event') {
                                return const TableHeaderEvent();
                              } else if (_currentCategory == 'Weekly Boss') {
                                return const TableHeaderBoss();
                              } else {
                                return const TableHeaderBoss();
                              }
                            },
                            error: (error, stack) => Text(error.toString(), style: TextStyle(fontSize: 12.wr)),
                            loading: () => _shimmerRow(),
                          )),
                    ),
                    Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                    ClipRRect(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.wr)),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onInverseSurface,
                            ),
                            child: speedruns.when(
                                data: (data) => Column(
                                    children: data.$2
                                        .where((e) => e.speedrunCategory == _currentCategory)
                                        .map((e) => TableRowAbyss(speedrun: e))
                                        .toList()),
                                error: (error, stackTrace) =>
                                    Center(child: AppErrorWidget(message: [error.toString(), stackTrace.toString()])),
                                loading: () => Column(children: [
                                      Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
                                      Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                                      Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
                                      Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                                      Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
                                      Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                                      Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
                                      Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                                      Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
                                      Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                                      Padding(padding: EdgeInsets.symmetric(vertical: 10.wr), child: _shimmerRow()),
                                      Divider(color: Theme.of(context).colorScheme.outline, thickness: 1, height: 0),
                                    ]))))
                  ])),
              10.verticalSpace,
              Row(children: [
                Text('Rows per page:', style: TextStyle(fontSize: 12.wr)),
                SizedBox(width: 5.wr),
                SizedBox(
                  width: 80,
                  child: CustomDropdown(
                      decoration: CustomDropdownDecoration(
                        expandedShadow: [
                          BoxShadow(
                              color: Theme.of(context).colorScheme.surfaceContainerLowest,
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                        closedFillColor: Theme.of(context).colorScheme.surfaceContainerLow,
                        closedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                        expandedBorder: Border.all(color: Theme.of(context).colorScheme.outline),
                        expandedFillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                        listItemStyle: TextStyle(fontSize: 12.wr),
                        headerStyle: TextStyle(fontSize: 12.wr),
                      ),
                      hideSelectedFieldWhenExpanded: true,
                      closedHeaderPadding: EdgeInsets.symmetric(horizontal: 10.wr, vertical: 3.wr),
                      items: const [10, 20, 50, 100],
                      onChanged: (p0) {
                        setState(() {
                          limit = p0!;
                          page = 0;
                        });
                      },
                      initialItem: limit),
                ),
                const Spacer(),
                speedruns.when(
                  data: (data) {
                    final hasNextPage = (page + 1) * limit < data.$1;
                    return Row(
                      children: [
                        IconButton(
                          onPressed: page > 0
                              ? () => setState(() {
                                    page--;
                                  })
                              : null,
                          icon: const Icon(Icons.chevron_left),
                        ),
                        Text('${page + 1}', style: TextStyle(fontSize: 12.wr)),
                        IconButton(
                          onPressed: hasNextPage
                              ? () => setState(() {
                                    page++;
                                  })
                              : null,
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ],
                    );
                  },
                  error: (_, __) => const SizedBox.shrink(),
                  loading: () => SizedBox(
                    width: 20.wr,
                    height: 20.wr,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ]),
              50.verticalSpace,
            ],
          ),
        ),
      ],
    );
  }
}
