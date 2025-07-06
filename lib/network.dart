import 'package:common/models/category.dart';
import 'package:common/models/item_details.dart';
import 'package:common/models/menu_item.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/widgets.dart';
import 'package:http_cache_file_store/http_cache_file_store.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class ApiClient {
  final Dio _client;

  static final imageHeaders = Options(
    responseType: ResponseType.bytes,
    contentType: "image/avif",
  );

  ApiClient._internal(this._client);

  static Future<ApiClient> init() async {
    var client = Dio(
      BaseOptions(
        baseUrl: kDebugMode ? "http://localhost:8787" : "https://rr.net",
      ),
    ); // TODO: Update to actual domain
    debugPrint("Initialized Dio HTTP client");

    if (!kIsWeb) {
      debugPrint("Native platform detected! Setting up File cache");
      try {
        var dir = await path_provider.getApplicationCacheDirectory();

        final cache = FileCacheStore(dir.path);
        final options = CacheOptions(
          store: cache,
          hitCacheOnNetworkFailure: true,
        );

        client.interceptors.add(DioCacheInterceptor(options: options));
      } catch (e) {
        debugPrint("Unable to initialize file cache: ${e.toString()}");
        debugPrint("Continuing with memory cache");

        // Continue with memory cache
        final options = CacheOptions(
          store: MemCacheStore(),
          hitCacheOnNetworkFailure: true,
        );

        client.interceptors.add(DioCacheInterceptor(options: options));
      }
    }

    debugPrint("HTTP client setup completed");
    return ApiClient._internal(client);
  }

  /// Get all the categories
  Future<List<CategoryOrIngredient>> getCategories() async {
    final response = await _client.get("/menu/categories");
    final json = response.data as List<dynamic>;
    final categories = json.map((category) {
      return CategoryOrIngredient.fromJson(category);
    }).toList();

    return categories;
  }

  /// Get all the items of a category
  Future<List<MenuItem>> getCategoryItems(int id) async {
    final response = await _client.get("/menu/category/$id");
    final json = response.data as List<dynamic>;
    final items = json.map((item) {
      return MenuItem.fromJson(item);
    }).toList();

    return items;
  }

  /// Get the information about a category
  Future<CategoryOrIngredient> getCategory(int id) async {
    final response = await _client.get("/menu/category/$id");

    return CategoryOrIngredient.fromJson(response.data as Map<String, dynamic>);
  }

  /// Get all ingredients
  Future<List<CategoryOrIngredient>> getIngredients() async {
    final response = await _client.get("/menu/ingredients");
    final json = response.data as List<dynamic>;
    final categories = json.map((category) {
      return CategoryOrIngredient.fromJson(category);
    }).toList();

    return categories;
  }

  Future<CategoryOrIngredient> getIngredient(int id) async {
    final response = await _client.get("menu/ingredient/$id");

    return CategoryOrIngredient.fromJson(response.data as Map<String, dynamic>);
  }

  /// Get the remaining details of an item
  Future<ItemDetails> getItemDetails(int id) async {
    final response = await _client.get("/menu/$id/details");
    debugPrint(response.data.runtimeType.toString());
    debugPrint(response.data.toString());
    final details = ItemDetails.fromJson(response.data as Map<String, dynamic>);

    return details;
  }

  /// Gets the small image of an item
  Future<ImageProvider> getThumbnail(int id) async {
    final response = await _client.get(
      "/menu/$id/thumbnail",
      options: imageHeaders,
    );

    return MemoryImage(Uint8List.fromList(response.data!));
  }

  /// Gets the full image of an item
  Future<ImageProvider> getImage(int id) async {
    final response = await _client.get(
      "/menu/$id/image",
      options: imageHeaders,
    );

    return MemoryImage(Uint8List.fromList(response.data!));
  }
}
