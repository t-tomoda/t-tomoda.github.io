int x = -50;      //円の中心のx座標
int y = 100;      //円の中心のy座標
int delta_x = 0;  //x座標の増分
int d = 50;       //円の直径

//最初に1度だけ呼ばれる関数
void setup() {
  size(400, 300); //ウィンドウの幅と高さの設定
}

//1秒間に数十回呼ばれる関数
void draw() {
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