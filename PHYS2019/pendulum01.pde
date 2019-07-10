//　単振り子                                                T. Tomoda, 2019/7/7

float r1 = 50;        //小さい弧の半径
float r2 = 250;       //大きい弧の半径（糸の長さL）
float d1 = 2 * r1;    //小さい弧の半径の2倍
float d2 = 2 * r2;    //大きい弧の半径の2倍
float d = 10;         //重りの直径
float gravity = 150;  //重力mgを表すベクトルの大きさ
float mg_sin;         //mg * sinθ（宣言のみ）
float mg_cos;         //mg * cosθ（宣言のみ）
float theta = 0;      //重りの角位置θ（ラジアン）、初期化
int count_draw = 0;   //draw()が呼ばれる回数のカウント、初期化
int count_click = 0;  //マウスクリック回数のカウント、初期化

void setup() {
  size(600, 600);
  PFont font = createFont("MS-Gothic", 20); //フォント生成
  textFont(font); //使用フォントの設定
}

//y軸は下向き、角度は反時計回りがマイナスとなることに注意
void draw() {
  background(255); //背景白色
  translate(300, 100); //座標系を平行移動、x方向300、y方向100
  
  theta = (PI / 6) * sin(PI * count_draw / 60); //θを振幅π/6、周期2秒で振動させる

  fill(0); //文字色黒
  text("単振り子", -250, -60); //表題
  text("L", -30, 125); //振り子の長さ

  if(count_click % 4 == 0) { 
    //マウスクリックの回数が4で割り切れるときは振り子を動かす
    count_draw++;
  } else { //振り子を止めたとき
    //凡例など
    stroke(0, 192, 0);         //線色緑
    arrow(100, 0, 50, 0);      //矢印
    fill(0, 192, 0);           //文字色緑
    text("mg sinθ", 160, 5);  //矢印の右側
    stroke(192, 0, 255);       //線色紫
    arrow(100, 30, 50, 0);     //矢印
    fill(192, 0, 255);         //文字色紫
    text("mg cosθ", 160, 35); //矢印の右側
    fill(255, 0, 0);           //文字色赤
    text("x = Lθ", 100, 70);  //矢印の下

    stroke(0); //線色黒
    noFill();  //扇形の内部は埋めず、弧のみ描画
    arc(0, 0, d1, d1, PI/2 - theta, PI/2); //中心角θを示すための小さい弧
    arc(0, 0, d2, d2, PI * 0.3, PI * 0.7); //半径Lの弧（曲がったx軸）
    arrow(r2 * cos(PI * 0.3), r2 * sin(PI * 0.3), 10, -0.2 * PI); //x軸の矢印

    fill(0); //文字色黒
    text("x", r2 * cos(PI * 0.3) + 14, r2 * sin(PI * 0.3) - 4); //軸の名前
    text("0", -6, r2 + 20); //x＝0を示す
    text("θ", 10, 70); //扇形の中心角

    if (count_click % 4 >= 2) { //クリック2、3、6、7、… 回目
      text("運動方程式　ma＝－mg sinθ", -50, -60);
      if (count_click % 4 == 3) { //クリック3、7、… 回目
        text("sinθ≒θ＝x/L より a≒－(g/L)・x", -50, -30);
      }
    }
  } //ここまで「振り子を止めたとき」

  stroke(0);             //線色黒
  noFill();              //扇形の内部は埋めず、弧のみ描画
  if (theta > 0) {
    arc(0, 0, d2, d2, PI/2 - theta, PI/2); //重りが描く弧
  } else {
    arc(0, 0, d2, d2, PI/2, PI/2 - theta); //重りが描く弧
  }

  stroke(128);                   //線色灰色
  line(0, 0, 0, 430);            //鉛直線
  arrow(-10, r2/2, r2/2, -PI/2); //長さL/2、上向きの矢印
  arrow(-10, r2/2, r2/2, PI/2);  //長さL/2、下向きの矢印

  //重りを原点とし、y軸が法線方向外向きとなるようにする
  rotate(-theta);                //座標系を-θだけ回転
  translate(0, r2);              //座標系の平行移動、x方向0、y方向L

  stroke(0);                     //線色黒
  line(0, 0, 0, -r2);            //振り子の糸

  mg_sin = gravity * sin(theta); //mg * sinθ
  mg_cos = gravity * cos(theta); //mg * cosθ

  stroke(0, 192, 0);             //線色緑
  arrow(0, 0, mg_sin, PI);       //重力の接線方向の成分

  stroke(192, 0, 255);           //線色紫
  arrow(0, 0, mg_cos, PI/2);     //重力の法線方向の成分

  if(count_click % 4 > 0) {      //振り子を止めたとき
    stroke(0);                              //線色黒
    line(-mg_sin, 0,      -mg_sin, mg_cos); //法線方向成分に平行な線
    line(0,       mg_cos, -mg_sin, mg_cos); //接線方向成分に平行な線
    fill(255, 0, 0);                        //文字色赤
    text("x", 5, 15);                       //重りの位置
  }

  fill(255, 0, 0);     //赤色
  ellipse(0, 0, d, d); //振り子の重り

  //重りを原点とし、y軸が下向きになるようにする
  rotate(theta);           //座標系をθだけ回転
  stroke(0, 0, 255);               //線色青に
  arrow(0, 0, gravity, PI/2);      //重力mgを表すベクトル
  fill(0, 0, 255);                 //文字色青
  text("mg", -10, gravity + 20);   //重力を表すベクトルの終点付近に"mg"
  if(count_click % 4 > 0) { //振り子を止めたとき
    fill(0); //文字色黒
    text("θ", -15, gravity - 30); //重力を表すベクトルの終点付近に"θ"
    text("θ",  2, 40);            //重力を表すベクトルの始点付近に"θ"
  }
}

//(x, y)から長さlenの矢印をangleの方向に描画する関数
void arrow(float x, float y, float len, float angle) {
  pushMatrix(); //現在の座標系を保存
    translate(x, y); //座標系の原点を(x, y)の位置まで平行移動
    rotate(angle);   //座標系を原点の周りに角度angle（ラジアン）だけ回転
    line(0, 0, len, 0); //矢の本体となる線を原点から(len, 0)まで引く
    if (len > 0) {
      line(len - 10,  3, len, 0); //矢先の部分
      line(len - 10, -3, len, 0); //矢先の部分
    } else {
      line(len + 10,  3, len, 0); //矢先の部分
      line(len + 10, -3, len, 0); //矢先の部分
    }
  popMatrix();  //座標系を保存してあった状態に戻す
}

//ウィンドウの中でマウスをクリックしたときに呼ばれる関数
void mousePressed() {
  if (theta > 0) { //重りが右側のときに限り、クリックのカウントを1だけ増やす
    count_click++;
  }
}