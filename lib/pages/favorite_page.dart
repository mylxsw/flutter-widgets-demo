import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late OverlayEntry _popupDialog;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
          key: const ValueKey(0),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            // dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              SlidableAction(
                onPressed: (BuildContext context) {
                  print("share $index clicked");
                },
                backgroundColor: const Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.share,
                label: '分享',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (BuildContext context) {
                  print("edit $index clicked");
                },
                backgroundColor: const Color.fromARGB(255, 24, 192, 63),
                foregroundColor: Colors.white,
                icon: Icons.share,
                label: '编辑',
              ),
              SlidableAction(
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: '删除',
                onPressed: (BuildContext context) {
                  showDialog(
                    context: context,
                    builder: ((context) => AlertDialog(
                          title: const Text("删除"),
                          content: const Text("确定删除吗？"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("取消")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("删除成功")));
                                },
                                child: const Text("确定")),
                          ],
                        )),
                  );
                },
              ),
            ],
          ),
          child: GestureDetector(
            onLongPress: () {
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => SnackBarPage()));
              _popupDialog = _createPopupDialog(index);
              Overlay.of(context)?.insert(_popupDialog);
            },
            // onLongPressEnd: (LongPressEndDetails details) {
            //   _popupDialog.remove();
            // },
            child: ListTile(
              title: Text("这是第$index条数据"),
            ),
          ),
        );
      },
    );
  }

  OverlayEntry _createPopupDialog(int index) {
    return OverlayEntry(
        builder: (context) =>
            AnimatedDialog(child: _createPopupContent(index)));
  }

  Widget _createPopupContent(int index) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ClipRRect(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.abc),
                        title: Text("这是个弹框 $index"),
                        subtitle: Text("这是弹窗描述 $index"),
                      ),
                      ButtonBar(
                        children: [
                          TextButton(
                            onPressed: () {
                              // Navigator.of(context).pop();
                              _popupDialog.remove();
                            },
                            child: const Text("取消"),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigator.of(context).pop();
                              _popupDialog.remove();
                            },
                            child: const Text("确定"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class AnimatedDialog extends StatefulWidget {
  const AnimatedDialog({super.key, required this.child});

  final Widget child;

  @override
  State<AnimatedDialog> createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo);
    _opacityAnimation = Tween<double>(begin: 0.0, end: 0.6).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo));

    _controller.addListener(() => setState(() {}));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(_opacityAnimation.value),
      child: Center(
        child: FadeTransition(
          opacity: _scaleAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
