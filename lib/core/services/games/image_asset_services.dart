import 'dart:convert';

import 'package:endless_runner/core/managers/games/image_asset_manager.dart';
import 'package:endless_runner/game/utils/log_util.dart';
import 'package:flame/cache.dart';
import 'package:flutter/services.dart';

class ImageAssetServices implements ImageAssetManager {
  
  /*
  List<String> _imgAssetNames = [];


  List<String> listAssetName = [
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
        'surfacetolands/trees/tree_spawning.png',

        // surface to land - stone
        'surfacetolands/stones/stone_spawning.png',

        // obstacle - fire
        'obstacles/fires/fire_obstacle.png',
      ];*/

  final String _imgJson = 'assets/data/img_asset_names.json';
  static List<String>? _cachedImgAssetNames;

  @override
  Future<void> preLoadImgAssets(Images images) async {
    try {
      if (_cachedImgAssetNames == null) {
        final String response = await rootBundle.loadString(_imgJson);
        _cachedImgAssetNames = List<String>.from(jsonDecode(response)['imgAssetNames']);
      }
      
      // Load all images in parallel for better performance
      //await images.loadAll(_imgAssetNames);
      await Future.wait(_cachedImgAssetNames!.map((img) => images.load(img)));

      LogUtil.debug('Succesfully completed pre load image assets');
    } catch (e) {
      LogUtil.error('Exception -> $e');
    }
  }

}