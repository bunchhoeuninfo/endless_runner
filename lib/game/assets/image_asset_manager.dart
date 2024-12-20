import 'package:flame/cache.dart';

abstract class ImageAssetManager {
  Future<void> preLoadImgAssets(Images images);
}