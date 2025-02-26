import 'package:endless_runner/core/managers/games/image_asset_manager.dart';
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
        // gold coin
        'coins/golds/gold_coin_idle.png',
        'coins/golds/gold_coin_sheet.png',
        'coins/golds/gold_coin_hit_ground.png',
        // gold silver
        'coins/silvers/silver_coin_sheet.png',
        'coins/silvers/silver_coin_idle.png',
        'coins/silvers/silver_coin_hit_ground.png'
        // test player
        'player_1.png',
        'rock.jpg',
        'backgrounds/road_bg.jpg',
        'backgrounds/grid_bg.png',
        'obstacles/road_cone.png',
        'players/player_sprite.jpg',
        'players/walk_sheet.png',
        'players/car_sprite.png',
        // player kitty
        'players/kitties/kitty_jumping.png',
        'players/kitties/kitty_jump.png',
        'players/kitties/kitty_stand.png',
        'players/kitties/kitty_post_jump.png',
        'players/kitties/kitty_upward.png',
        'players/kitties/kitty_idle.png',
        'players/kitties/kitty_move_left.png',
        'players/kitties/kitty_move_right.png',

        // surface to land - tree
        'surfacetolands/trees/idle_tree.png'
      ]);
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

}