//　花火                                                     T. Tomoda, 2019/7/5

float d = 5, x, y, delta_y = 3; //親玉の直径、位置、速度
int count_draw = 0;             //関数draw()が呼ばれる回数のカウント
int NUM = 1000;                 //小玉の数
Ball[] ball = new Ball[NUM];    //小玉の配列を生成

void setup() {
  size(800, 600);
  x = width/2; //親玉の初期位置（横方向）：ウィンドウの中央
  y = height;  //親玉の初期位置（縦方向）：ウィンドウの下端
  for (int i = 0; i < NUM; i++) {
    ball[i] = new Ball();       //小玉のオブジェクトを生成して配列に代入
    //ランダムになるように小玉の初速度を設定
    float velocity = random(4);              //初速度の大きさ（0～4）
    float angle = random(2 * PI);            //初速度の方向（0～2π）
    ball[i].delta_x = velocity * cos(angle); //x方向の初速度
    ball[i].delta_y = velocity * sin(angle); //y方向の初速度
  }
  background(0); //背景を黒に
}

void draw() {
  fill(0, 5); //黒色、α値（0:透明、255:不透明）を透明に近い5に
  rect(0, 0, width, height); //ウィンドウ全体を塗りつぶす（残像が残るように）

  noStroke(); //輪郭線なし
  fill(255);  //白色
  if (count_draw < 300) { //最初の5秒間（親玉の上昇）
    delta_y -= 0.01;              //重力加速度による速度の減少
    y -= delta_y;                 //上昇（y座標の減少）
    x += 0.2 * sin(15 * delta_y); //左右に振動
    ellipse(x, y, d, d);          //(x, y)を中心とする直径dの円を描画
  } else {                //5秒後以降
    //Ballオブジェクトのdraw()により、飛び散る小玉を描画
    for (int i = 0; i < NUM; i++) {
      ball[i].draw();
    }
  }
  count_draw++; //draw()が呼ばれる回数のカウントを1だけ増やす
}