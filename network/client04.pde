import processing.net.*; //ネットワーク機能の使用準備
Client myClient;         //Clientクラスのオブジェクトを格納する変数
String string;           //Stringクラスのオブジェクト(文字列)を格納する変数
boolean sent = false;    //論理値を取る変数sentの初期値をfalse(偽)に

int x = -50;      //円の中心のx座標
int y = 100;      //円の中心のy座標
int delta_x = 0;  //x座標の増分
int delta_y = 0;  //y座標の増分
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

    //半角スペースで区切られたstringの内容を分解して配列partに入れる
    String[] part = split(string, ' ');

    //part[0]とpart[1]の文字列をそれぞれ数値に変換してyとdelta_yに入れる
    y       = int(part[0]);
    delta_y = int(part[1]);

    x       = 0;
    delta_x = 2;
    sent = false;                   //送信可能にするための措置
  }

  background(0);       //背景を黒に
  if (y > height) {    //円の中心が床に達したら
    delta_y = -2;      //上に反射するように
  }
  if (y < 0) {         //円の中心が天井に達したら
    delta_y = 2;       //下に反射するように
  }

  x += delta_x;        //x座標をdelta_xだけ増やす
  y += delta_y;        //y座標をdelta_yだけ増やす
  ellipse(x, y, d, d); //中心の座標が(x, y)で直径dの円を描画

  if (x > width && sent == false) { //x > width、かつ sentがfalseであれば
    //yとdelta_yの値を文字列に変換し、半角スペースで区切って連結したものを
    //stringに入れる
    string = str(y) + " " + str(delta_y);
    myClient.write(string); //連結した文字列を送信する
    sent = true;            //続けて2回以上送信しないための措置
  }
}

//マウスボタンが押されたとき呼ばれる関数
void mousePressed() {
  if(mouseButton == LEFT) { //押されたのが左ボタンであれば
    delta_x = 2;            //x座標の増分を2にする
    delta_y = 2;            //y座標の増分を2にする
  }
}