sudo apt update
sudo apt install git git-lfs zipalign apksigner
git lfs install
git clone https://github.com/muzei/muzei.git input
cd input
cp ../keystore.properties ./keystore.properties
cp ../local.properties ./local.properties
./gradlew build
mkdir ../outputdebuglegacy
mkdir ../outputreleaselegacy
mkdir ../outputreleasemain
mkdir ../outputdebugmain
cp legacy-standalone/app/build/outputs/apk/debug/*.apk ../outputdebuglegacy
cp legacy-standalone/app/build/outputs/apk/release/*.apk ../outputreleaselegacy
cp main/app/build/outputs/apk/debug/*.apk ../outputdebugmain
cp main/app/build/outputs/apk/release/*.apk ../outputreleasemain
zipalign -p 4 ../outputdebuglegacy/*.apk ../outputdebuglegacy/aligned.apk
zipalign -p 4 ../outputreleaselegacy/*.apk ../outputreleaselegacy/aligned.apk
zipalign -p 4 ../outputreleasemain/*.apk ../outputreleasemain/aligned.apk
zipalign -p 4 ../outputdebugmain/*.apk ../outputdebugmain/aligned.apk
apksigner sign --ks-key-alias lob --ks ../sign.keystore --ks-pass pass:369852 --key-pass pass:369852 ../outputdebugmain/aligned.apk
apksigner sign --ks-key-alias lob --ks ../sign.keystore --ks-pass pass:369852 --key-pass pass:369852 ../outputreleasemain/aligned.apk
apksigner sign --ks-key-alias lob --ks ../sign.keystore --ks-pass pass:369852 --key-pass pass:369852 ../outputreleaselegacy/aligned.apk
apksigner sign --ks-key-alias lob --ks ../sign.keystore --ks-pass pass:369852 --key-pass pass:369852 ../outputdebuglegacy/aligned.apk
mkdir ../prebuilt
cp ../outputdebugmain/aligned.apk ../prebuilt/main-debug.apk
cp ../outputreleasemain/aligned.apk ../prebuilt/main-release.apk
cp ../outputreleaselegacy/aligned.apk ../prebuilt/legacyaddon-release.apk
cp ../outputdebuglegacy/aligned.apk ../prebuilt/legacyaddon-debug.apk
