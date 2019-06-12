//回転運動(速度、加速度)                                    T. Tomoda, 2019/6/11

float r = 150.0;    //質点の回転半径
float theta = 0.0;  //質点の回転角（ラジアン）、初期化
int count_draw = 0; //draw()が呼ばれる回数カウント用、初期化

void setup() {
  size(830, 500);
  PFont font = createFont("MS-Gothic", 20); //フォント生成
  textFont(font); //使用フォントの設定

  fill(0); //文字色黒
  text("S", 358, 255);
  text("位置ベクトル", 135, 400);

  fill(0, 0, 255); //文字色青
  text("S", 495, 170);
  text("速度ベクトル", 430, 400);

  fill(255, 0, 0); //文字色赤
  text("S", 645, 255);
  text("加速度ベクトル", 625, 400);
}

void draw() {
  if (count_draw % 15 == 0 && count_draw < 300) {
    //draw()が15回呼ばれるごと、かつ300回未満に限り以下を実行
    //y軸は下向き、角度は反時計回りがマイナスとなることに注意
    translate(200, 250); //座標系の平行移動、x方向200、y方向250
    pushMatrix(); //現在の座標系を保存
      rotate(-theta);          //座標系を-θだけ回転、
      arrow(0, 0, r, 0);       //原点から長さr、回転後のx軸方向の矢印（黒）

      stroke(0, 0, 255);       //線色青に
      arrow(r, 0, r/2, -PI/2); //(r, 0)から長さr/2、回転後のy軸負方向の矢印（青）
    popMatrix(); //座標系を保存してあった状態（translate(200, 250)の直後）に戻す

    translate(300, 0); //座標系の平行移動、x方向300、y方向0
    pushMatrix(); //現在の座標系を保存
      rotate(-theta - PI/2);     //座標系を-θ-90°だけ回転
      arrow(0, 0, r/2, 0);       //原点から長さr/2、回転後のx軸方向の矢印（青）

      stroke(255, 0, 0);         //線色赤に
      arrow(r/2, 0, r/4, -PI/2); //(r/2, 0)から長さr/4、回転後のy軸負方向の矢印（赤）
    popMatrix(); //座標系を保存してあった状態（translate(300, 0)の直後）に戻す

    translate(200, 0); //座標系の平行移動、x方向200、y方向0
    arrow(0, 0, r/4, -theta - PI); //原点から長さr/4、-θ-180°の方向の矢印（赤）

    stroke(0);     //線色を黒に戻す
  }
  count_draw++;    //draw()が呼ばれる回数のカウントを1だけ増やす
  theta += PI/360; //質点の回転角をπラジアン/360だけ増やす
}

//(x, y)から長さlenの矢印をangleの方向に描画する関数
void arrow(float x, float y, float len, float angle) {
  pushMatrix(); //現在の座標系を保存
    translate(x, y); //座標系の原点を(x, y)の位置まで平行移動
    rotate(angle);   //座標系を原点の周りに角度angle（ラジアン）だけ回転
    line(0,         0, len, 0); //矢の本体となる線を原点から(len, 0)まで引く
    line(len - 10,  5, len, 0); //矢先の部分
    line(len - 10, -5, len, 0); //矢先の部分
  popMatrix();  //座標系を保存してあった状態に戻す
 
}