# Storia User App — API Data Layer

A clean Retrofit + json_serializable + GetX data layer that talks to the Storia
Laravel backend. This is the **data layer only** (models, Retrofit client, Dio
configuration, GetX controllers). No screens are built here.

## Layout

```
lib/
├─ data/
│  ├─ utils/api_utils.dart            # ApiConfig + coercion helpers (boolCoerce, priceCoerce, imageUrl)
│  ├─ model/
│  │  ├─ api_product_model.dart       # List Product shape (endpoints 1, 5, 8, 12a)
│  │  ├─ store_model.dart             # Store (+ legacy StoreData for old UI)
│  │  ├─ product_detail_model.dart    # Endpoint 4 curated join shape
│  │  └─ api_responses.dart           # All per-endpoint response envelopes
│  └─ services/
│     ├─ token_service.dart           # Sanctum token in flutter_secure_storage
│     ├─ api_failure.dart             # Clean ApiFailure + ApiFailureType
│     ├─ dio_provider.dart            # Dio + Auth/LongTimeout/Error interceptors
│     └─ api_client.dart              # @RestApi ApiClient (12 endpoints)
├─ controller/
│  ├─ base_controller.dart            # runGuarded/runPaginated mixin
│  └─ api/
│     ├─ store_controller.dart        # endpoints 2, 3, 6
│     ├─ product_controller.dart      # endpoints 1 (paginated), 5, 4
│     ├─ favorite_controller.dart     # endpoints 8, 7 (optimistic toggle)
│     ├─ report_controller.dart       # endpoints 9, 10
│     ├─ cart_controller.dart         # endpoint 11 (check-store)
│     └─ search_controller.dart       # endpoint 12a (long timeout)
└─ core/binding/api_bindings.dart     # registers Dio + ApiClient + controllers
```

## How it fits together

- `main()` calls `ApiBindings().dependencies()` once. This registers a single
  `Dio` (with interceptors), the `ApiClient`, the `TokenService`, and all
  controllers as lazy singletons. Screens reach them via `Get.find<T>()`.
- **Auth**: `AuthInterceptor` reads the saved Sanctum bearer token and attaches
  `Authorization: Bearer <token>` to every request when present.
- **Long timeout**: `/ai-search` can block ~120s server-side. The
  `_LongTimeoutInterceptor` bumps receive/send timeout to 180s for any request
  whose path contains `/ai-search` or that passes `extras: {'longTimeout': true}`.
- **Errors**: `ErrorInterceptor` maps every `DioException` into an `ApiFailure`
  (categories: unauthorized / notFound / validation / server / network /
  unknown). Controllers never catch Dio errors — `BaseControllerMixin.runGuarded`
  converts them into the `error` Rx + a snackbar and returns `null`.
- **Quirks handled**: decimal `price` arrives as a string → `priceCoerce`;
  `state_product` / `same_store` arrive as 0/1 → `boolCoerce`; relative image
  paths → `imageUrl()` prepends `…/storage/`; nullable ratings →
  `doubleNullableCoerce`.

## pubspec dependencies

```yaml
dependencies:
  dio: ^5.7.0
  retrofit: 4.4.1            # pinned — 4.9.x adds a Parser variant no generator compiles against
  json_annotation: ^4.9.0
  flutter_secure_storage: ^9.2.2

dev_dependencies:
  retrofit_generator: 8.2.1  # matched to retrofit 4.4.1
  build_runner: ^2.4.13
  json_serializable: ^6.8.0
```

## (Re)generate code

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## Notes / decisions

- The network list-product model is named **`ApiProductModel`** (not
  `ProductModel`) so the existing lilav UI's dummy `ProductModel` is untouched
  and keeps compiling. `StoreData` is likewise preserved alongside the API
  `StoreModel` in `store_model.dart`.
- Response envelopes are **flat per-endpoint classes** (no clever generic) per
  the spec — each endpoint uses a different payload key.
- `GET /gemini-test` returns raw Gemini JSON; its Retrofit method returns
  `Future<dynamic>` (the decoded JSON object) because Retrofit 8.2.1 can't
  deserialize a raw `Map<String, dynamic>` return. Cast at the call site.
- `GET /user/stores` returns ALL stores (despite the name) — used as the store
  directory.
- For a normal user, `/products/filter` requires `store_id` (else 422).
  `category_id` is NOT consumed by the backend `filter()` — omitted.
