sudo apt update
sudo apt install git git-lfs zipalign apksigner
git lfs install
git clone https://github.com/muzei/muzei.git input
cd input
cp ../keystore.properties ./keystore.properties
cp ../local.properties ./local.properties
./gradlew :main:build
mkdir ../outputdebugmain
mkdir ../outputreleasemain
cp main/app/build/outputs/apk/debug/*.apk ../outputdebugmain
cp main/app/build/outputs/apk/release/*.apk ../outputreleasemain
zipalign -p 4 ../outputreleasemain/*.apk ../outputreleasemain/aligned.apk
zipalign -p 4 ../outputdebugmain/*.apk ../outputdebugmain/aligned.apk
apksigner sign --ks-key-alias lob --ks ../sign.keystore --ks-pass pass:369852 --key-pass pass:369852 ../outputdebugmain/aligned.apk
apksigner sign --ks-key-alias lob --ks ../sign.keystore --ks-pass pass:369852 --key-pass pass:369852 ../outputreleasemain/aligned.apk
mkdir ../prebuilt
cp ../outputdebugmain/aligned.apk ../prebuilt/main-debug.apk
cp ../outputreleasemain/aligned.apk ../prebuilt/main-release.apk
