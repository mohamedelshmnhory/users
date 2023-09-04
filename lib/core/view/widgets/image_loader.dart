import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources.dart';

class ImageLoader extends StatefulWidget {
  ImageLoader({
    Key? key,
    required this.path,
    this.width,
    this.scale,
    this.color,
    this.height,
    this.repeated = false,
    this.fit = BoxFit.contain,
    this.padding,
    this.borderRadius,
    this.onAnimationFinish,
  }) : super(key: key) {
    image = ImageModel(path);
  }

  final String path;
  final BoxFit fit;
  final double? width;
  final double? scale;
  final Color? color;
  final bool repeated;
  final double? height;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Function()? onAnimationFinish;
  late final ImageModel image;

  @override
  State<ImageLoader> createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late double? height = widget.height?.sp;
  late double? width = widget.width?.sp;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  Widget loadImage() {
    final memCacheHeight = height == null ? null : (height! * 2).toInt();
    final memCacheWidth = width == null ? null : (width! * 2).toInt();
    CachedNetworkImage.logLevel = CacheManagerLogLevel.none;

    switch (widget.image.checkImageType()) {
      case ImageType.json:
        return Lottie.asset(
          widget.image.imagePath,
          width: width,
          height: height,
          fit: widget.fit,
          controller: (!widget.repeated) ? _controller : null,
          onLoaded: (composition) {
            if (!widget.repeated) {
              _controller
                ..duration = composition.duration
                ..forward();
              _controller.addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  widget.onAnimationFinish!();
                }
              });
            }
          },
          repeat: (widget.repeated),
        );
      case ImageType.svg:
        return Transform.scale(
          scale: widget.scale ?? 1,
          child: SvgPicture.asset(
            widget.image.imagePath,
            width: width,
            height: height,
            fit: widget.fit,
            color: widget.color,
          ),
        );
      case ImageType.png:
        return Image.asset(
          widget.image.imagePath,
          width: width,
          height: height,
        );
      case ImageType.url:
        return CachedNetworkImage(
          fit: widget.fit,
          width: width,
          height: height,
          memCacheHeight: memCacheHeight,
          memCacheWidth: memCacheWidth,
          imageUrl: widget.image.imagePath,

          // CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return Center(
              child: SizedBox(
                width: (width ?? 40) / 2,
                height: (height ?? 40) / 2,
                child: Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: AppColors.primary,
                    strokeWidth: 2,
                  ),
                ),
              ),
            );
          },
          errorWidget: (context, url, error) => PlaceHolder(
            fit: widget.fit,
            width: width,
            height: height,
          ),
        );
      default:
        return Padding(
          padding: widget.padding ?? EdgeInsets.zero,
          child: PlaceHolder(
            fit: widget.fit,
            width: width,
            height: height,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.image.imagePath.isEmpty) {
      return Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: PlaceHolder(
          fit: widget.fit,
          width: width,
          height: height,
        ),
      );
    }
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return const Center(child: Text('Image'));
    }

    return ClipRRect(borderRadius: widget.borderRadius ?? BorderRadius.zero, child: loadImage());
  }
}

class PlaceHolder extends StatelessWidget {
  const PlaceHolder({
    Key? key,
    this.asset,
    this.fit,
    this.width,
    this.height,
  }) : super(key: key);
  final String? asset;
  final BoxFit? fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.placeHolder,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
    );
  }
}

class ImageModel {
  final String imagePath;

  ImageModel(this.imagePath);

  ImageType checkImageType() {
    if (imagePath.startsWith('http')) {
      return ImageType.url;
    } else if (imagePath.endsWith('.svg')) {
      return ImageType.svg;
    } else if (imagePath.endsWith('.json')) {
      return ImageType.json;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, url, json }
