import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
///上拉抽屉
class BottomDragWidget extends StatelessWidget {
  final Widget body;
  final DragContainer dragContainer;

  BottomDragWidget({Key key, @required this.body, @required this.dragContainer})
    :assert(body!=null),
    assert(dragContainer != null),
    super(key:key);
  
  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: <Widget>[
        body,
        Align(
          alignment: Alignment.bottomCenter,
          child:dragContainer,
        ),
      ],
    );
  }
  
}
typedef DragListener = void Function(
  double dragDistance, ScrollNotificationListener isDragEnd
);
enum ScrollNotificationListener{
  ///滑动开始
  start,

  ///滑动结束
  end,

  ///滑动时，控件在边缘（最上面显示或者最下面显示）位置
  edge
}
class DragController {
  DragListener _dragListener;

  setDrag(DragListener l){
    _dragListener = l;
  }

  void updateDragDistance(
    double dragDistance, ScrollNotificationListener isDragEnd
  ){
    if (_dragListener != null) {
      _dragListener(dragDistance, isDragEnd);
    }
  }
}
DragController _controller;
class DragContainer extends StatefulWidget {
  final Widget drawer;
  final double defaultShowHeight;
  final double height;
  DragContainer(
      {Key key,
      @required this.drawer,
      @required this.defaultShowHeight,
      @required this.height})
      : assert(drawer != null),
        assert(defaultShowHeight != null),
        assert(height != null),
        super(key: key){
    _controller = DragController();
  }
  @override
  State<StatefulWidget> createState() {
    return _DragContainerState();
  }
}
class _DragContainerState extends State<DragContainer> with TickerProviderStateMixin {
  AnimationController animationController;

  ///滑动位置超过这个位置，会滚到顶部；小于，会滚动底部。
  double maxOffsetDistance;
  bool onResetControllerValue = false;
  double offsetDistance;
  Animation<double> animation;
  bool offstage = false;
  bool _isFling =false;

  double get defaultOffsetDistance => widget.height - widget.defaultShowHeight;
  
  @override
  void initState(){
    animationController = AnimationController(
      vsync: this, duration: Duration(milliseconds: 250)
    );
    maxOffsetDistance = (widget.height + widget.defaultShowHeight) * 0.5;
    _controller
      .setDrag((double value, ScrollNotificationListener notification){
        if (notification!= ScrollNotificationListener.edge) {
          _handleDragEnd(null);
        }else{
          setState(() {
            offsetDistance = offsetDistance + value;
          });
        }
      });
    super.initState();
  }
  @override
  void dispose(){
    animationController.dispose();
    super.dispose();
  }
  GestureRecognizerFactoryWithHandlers<MyVerticalDragGestureRecognizer>
      getRecognizer() {
    return GestureRecognizerFactoryWithHandlers<
        MyVerticalDragGestureRecognizer>(
      () => MyVerticalDragGestureRecognizer(flingListener: (bool isFling) {
            _isFling = isFling;
          }), //constructor
      (MyVerticalDragGestureRecognizer instance) {
        //initializer
        instance
          ..onStart = _handleDragStart
          ..onUpdate = _handleDragUpdate
          ..onEnd = _handleDragEnd;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    if (offsetDistance == null || onResetControllerValue){
      offsetDistance = defaultOffsetDistance;
    }
    offsetDistance = offsetDistance.clamp(0.0, defaultOffsetDistance);
    offstage = offsetDistance < maxOffsetDistance;

    return Transform.translate(
      offset: Offset(0.0, offsetDistance),
      child: RawGestureDetector(
        gestures: {MyVerticalDragGestureRecognizer: getRecognizer()},
        child: Stack(
          children: <Widget>[
            Container(
              child: widget.drawer,
              height: widget.height,
            ),
            Offstage(
              child: Container(
                color: Colors.transparent,
                height: widget.height,
              ),
              offstage: offstage,
            ),
          ],
        ),
      ),
    );
  }
  void _handleDragEnd(DragEndDetails details){
    onResetControllerValue = true;
    ///很重要！！！动画完毕后，controller.value = 1.0， 这里要将value的值重置为0.0，才会再次运行动画
    ///重置value的值时，会刷新UI，故这里使用[onResetControllerValue]来进行过滤
    animationController.value = 0.0;
    onResetControllerValue = false;
    double start,end;
    if (offsetDistance<=maxOffsetDistance){
      ///这个判断通过，说明已经child位置超过警戒线了，需要滚动到顶部了
      start=offsetDistance;
      end=0.0;
    } else {
      start = offsetDistance;
      end = defaultOffsetDistance;
    }
    if (_isFling &&
        details != null &&
        details.velocity != null &&
        details.velocity.pixelsPerSecond != null &&
        details.velocity.pixelsPerSecond.dy < 0) {
      ///这个判断通过，说明是快速向上滑动，此时需要滚动到顶部了
      start = offsetDistance;
      end = 0.0;
    }
    final CurvedAnimation curve = new CurvedAnimation(parent: animationController,curve: Curves.easeOut);
    animation = Tween(begin: start, end: end).animate(curve)
      ..addListener((){
        if (!onResetControllerValue){
          offsetDistance = animation.value;
          setState(() {
            
          });
        }
      });
    animationController.forward();
  }
  void _handleDragUpdate(DragUpdateDetails details) {
    offsetDistance = offsetDistance + details.delta.dy;
    setState(() {});
  }

  void _handleDragStart(DragStartDetails details) {
    _isFling = false;
  }
}
class OverscrollNotificationWidget extends StatefulWidget {
  final Widget child;
  OverscrollNotificationWidget({
    Key key,@required this.child
  }):assert(child !=null),super(key:key);
  @override
  State<StatefulWidget> createState() {
    
    return _OverscrollNotificationWidgetState();
  }
  
}
class _OverscrollNotificationWidgetState extends State<OverscrollNotificationWidget> 
  with TickerProviderStateMixin{
    final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
        final Widget child = NotificationListener<ScrollStartNotification>(
      key: _key,
      child: NotificationListener<ScrollUpdateNotification>(
        child: NotificationListener<OverscrollNotification>(
          child: NotificationListener<ScrollEndNotification>(
            child: widget.child,
            onNotification: (ScrollEndNotification notification) {
              _controller.updateDragDistance(
                  0.0, ScrollNotificationListener.end);
              return false;
            },
          ),
          onNotification: (OverscrollNotification notification) {
            if (notification.dragDetails != null &&
                notification.dragDetails.delta != null) {
              _controller.updateDragDistance(notification.dragDetails.delta.dy,
                  ScrollNotificationListener.edge);
            }
            return false;
          },
        ),
        onNotification: (ScrollUpdateNotification notification) {
          return false;
        },
      ),
      onNotification: (ScrollStartNotification scrollUpdateNotification) {
        _controller.updateDragDistance(0.0, ScrollNotificationListener.start);
        return false;
      },
    );

    return child;
  }
  
}
typedef FlingListener = void Function(bool isFling);
///MyVerticalDragGestureRecognizer 负责任务
///1.监听child的位置更新
///2.判断child在手松的那一刻是否是出于fling状态
class MyVerticalDragGestureRecognizer extends VerticalDragGestureRecognizer{
  final FlingListener flingListener;

  /// Create a gesture recognizer for interactions in the vertical axis.
  MyVerticalDragGestureRecognizer({Object debugOwner, this.flingListener})
      : super(debugOwner: debugOwner);
   final Map<int, VelocityTracker> _velocityTrackers = <int, VelocityTracker>{};

  @override
  void handleEvent(PointerEvent event) {
    super.handleEvent(event);
    if (!event.synthesized &&
        (event is PointerDownEvent || event is PointerMoveEvent)) {
      final VelocityTracker tracker = _velocityTrackers[event.pointer];
      assert(tracker != null);
      tracker.addPosition(event.timeStamp, event.position);
    }
  }

  @override
  void addPointer(PointerEvent event) {
    super.addPointer(event);
    _velocityTrackers[event.pointer] = VelocityTracker();
  }

  ///来检测是否是fling
  @override
  void didStopTrackingLastPointer(int pointer) {
    final double minVelocity = minFlingVelocity ?? kMinFlingVelocity;
    final double minDistance = minFlingDistance ?? kTouchSlop;
    final VelocityTracker tracker = _velocityTrackers[pointer];

    ///VelocityEstimate 计算二维速度的
    final VelocityEstimate estimate = tracker.getVelocityEstimate();
    bool isFling = false;
    if (estimate != null && estimate.pixelsPerSecond != null) {
      isFling = estimate.pixelsPerSecond.dy.abs() > minVelocity &&
          estimate.offset.dy.abs() > minDistance;
    }
    _velocityTrackers.clear();
    if (flingListener != null) {
      flingListener(isFling);
    }

    ///super.didStopTrackingLastPointer(pointer) 会调用[_handleDragEnd]
    ///所以将[lingListener(isFling);]放在前一步调用
    super.didStopTrackingLastPointer(pointer);
  }

  @override
  void dispose() {
    _velocityTrackers.clear();
    super.dispose();
  }
}