import 'package:tgh_mobile/imports.dart';

class SearchBox extends ConsumerStatefulWidget {
  const SearchBox({super.key});

  @override
  ConsumerState<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends ConsumerState<SearchBox> {
  TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _searchOverlay;
  final GlobalKey _searchBoxKey = GlobalKey();
  final ValueNotifier<List<User>> _resultsNotifier = ValueNotifier<List<User>>([]);
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _searchOverlay?.remove();
    _focusNode.dispose();
    searchController.dispose();
    _resultsNotifier.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus && _searchOverlay == null) {
      _showSearchOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AsyncTextFormField(
      key: _searchBoxKey,
      validator: (value) async {
        try {
          final res = await ref.watch(searchUsersProvider(value).future);
          _resultsNotifier.value = res;
          return true;
        } catch (e) {
          debugPrint("Search error: ${e.toString()}");
          return true;
        }
      },
      height: 40,
      focusNode: _focusNode,
      validationDebounce: const Duration(milliseconds: 500),
      controller: searchController,
      hintText: 'Find a user',
      keyboardType: TextInputType.text,
      padding: EdgeInsets.zero,
      canEmpty: true,
      // suffixIcon: Icon(Icons.search, size: 20),
      decoration: InputDecoration(
          prefixIcon: const Padding(
              padding: EdgeInsetsDirectional.only(start: 10, end: 10), child: Icon(Icons.search, size: 24)),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25), borderSide: const BorderSide(color: Colors.red, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outline)),
          labelStyle:
              Theme.of(context).textTheme.titleMedium!.copyWith(color: const Color.fromARGB(255, 117, 117, 117)),
          contentPadding: const EdgeInsets.only(left: 16, right: 8)),
    );
  }

  void _showSearchOverlay() {
    if (_searchOverlay != null) {
      return;
    }

    final RenderBox renderBox = _searchBoxKey.currentContext?.findRenderObject() as RenderBox;
    final widgetSize = renderBox.size;
    final widgetPosition = renderBox.localToGlobal(Offset.zero);
    final double top = widgetPosition.dy;
    final double left = widgetPosition.dx;
    final double width = widgetSize.width;
    final double height = widgetSize.height;
    final right = MediaQuery.of(context).size.width - widgetPosition.dx - widgetSize.width;
    _searchOverlay = OverlayEntry(
        builder: (context) => Stack(children: [
              // Top area
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: top,
                  child: GestureDetector(
                      onTap: () {
                        _searchOverlay?.remove();
                        _searchOverlay = null;
                      },
                      child: Container(color: Theme.of(context).colorScheme.surfaceContainerLowest.withOpacity(0.5)))),

              // Bottom area
              Positioned(
                  top: top + height,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                      onTap: () {
                        _searchOverlay?.remove();
                        _searchOverlay = null;
                      },
                      child: Container(color: Theme.of(context).colorScheme.surfaceContainerLowest.withOpacity(0.5)))),

              // Left area
              Positioned(
                  top: top,
                  left: 0,
                  width: left,
                  height: height,
                  child: GestureDetector(
                      onTap: () {
                        _searchOverlay?.remove();
                        _searchOverlay = null;
                      },
                      child: Container(color: Theme.of(context).colorScheme.surfaceContainerLowest.withOpacity(0.5)))),

              // Right area
              Positioned(
                  top: top,
                  left: left + width,
                  right: 0,
                  height: height,
                  child: GestureDetector(
                      onTap: () {
                        _searchOverlay?.remove();
                        _searchOverlay = null;
                      },
                      child: Container(color: Theme.of(context).colorScheme.surfaceContainerLowest.withOpacity(0.5)))),
              Positioned(
                  top: kToolbarHeight,
                  left: left,
                  right: right,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ValueListenableBuilder(
                              valueListenable: _resultsNotifier,
                              builder: (context, value, child) {
                                if (value.isEmpty) return const ListTile(title: Text('No Information to display'));
                                return Column(
                                  children: value
                                      .map((e) => ListTile(
                                          onTap: () async {
                                            if (e.competitor == null) {
                                              fToast.showToast(
                                                  child: toast(context, "This user does not have a competitor profile"),
                                                  gravity: ToastGravity.BOTTOM,
                                                  toastDuration: const Duration(seconds: 5));
                                              return;
                                            }
                                            if (context.mounted) {
                                              context.push(Routes.profileNonCurrentWithAlias(e.competitor!.alias));
                                            }
                                          },
                                          leading: UniformCircleAvatar(url: pfpUrl(e.competitor?.id ?? ''), radius: 20),
                                          trailing: RoleChip(roleMapping[e.role]!, roleColorMapping[e.role]!),
                                          title: Text(e.name)))
                                      .toList(),
                                );
                              }),
                        ],
                      ),
                    ),
                  ))
            ]));
    Overlay.of(context).insert(_searchOverlay!);
  }
}
