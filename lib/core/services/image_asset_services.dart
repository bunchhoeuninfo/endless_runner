import 'package:endless_runner/core/managers/image_asset_manager.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/cache.dart';

class ImageAssetServices implements ImageAssetManager {
  @override
  Future<void> preLoadImgAssets(Images images) async {
    try {
      await images.loadAll([
        'coins/gold.jpg',
        'coins/blue.jpg',
        'coins/red.jpg',
        'coins/rocket_coin.jpg',
        'player_1.png',
        'background_tile.jpg',
        'rock.jpg',
        'bg.jpg'
      ]);
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

}