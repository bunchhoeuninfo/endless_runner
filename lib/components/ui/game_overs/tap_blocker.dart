import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class TapBlocker extends PositionComponent with TapCallbacks {

  TapBlocker({super.size});

  @override
  void onTapDown(TapDownEvent event) {
    LogUtil.debug('TapBlocker onTapDown called');
    event.handled = true;
  }

}