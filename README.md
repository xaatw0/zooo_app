# zooo_app

## インストールと実行
### インストール
```
git clone https://github.com/xaatw0/zooo_app.git
cd  zooo_app

dart pub global activate fvm
fvm use --force
```

### 準備＆実行
```
fvm flutter gen-l10n --no-nullable-getter 
fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter run
```