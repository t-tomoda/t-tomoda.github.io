import processing.net.*; //ネットワーク機能の使用準備
Client myClient;         //Clientクラスのオブジェクトを格納する変数
String string;           //Stringクラスのオブジェクト(文字列)を格納する変数

int x = -50;      //円の中心のx座標
int y = 100;      //円の中心のy座標
int delta_x = 0;  //x座標の増分
int d = 50;       //円の直径

//最初に1度だけ呼ばれる関数
void setup() {
  size(400, 300); //ウィンドウの幅と高さの設定

  //IPアドレス127.0.0.1、ポート番号10001のサーバに接続する
  myClient = new Client(this, "127.0.0.1", 10001); 
}

//1秒間に数十回呼ばれる関数
void draw() {
  if (myClient.available() > 0) {   //何かを送ってきているならば
    string = myClient.readString(); //文字列を受信してstringに入れる
    delta_x = int(string);          //stringの文字列を数値にする
    x = 0;
  }

  background(0);       //背景を黒に
  x += delta_x;        //x座標をdelta_xだけ増やす
  ellipse(x, y, d, d); //中心の座標が(x, y)で直径dの円を描画
}

//マウスボタンが押されたとき呼ばれる関数
void mousePressed() {
  if(mouseButton == LEFT) { //押されたのが左ボタンであれば
    delta_x = 2;            //x座標の増分を2にする
  }
}