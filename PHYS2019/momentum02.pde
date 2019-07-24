//　運動量保存則（2次元）                                   T. Tomoda, 2019/7/24

float d = 50;                //ボールの直径
int NUM = 5;                 //ボールの数
Ball[] ball = new Ball[NUM]; //ボールの配列を生成

void setup() {
  size(800, 400);
  PFont font = createFont("MS-Gothic", 20); //フォント生成
  textFont(font);                           //使用フォントの設定
  for (int i = 0; i < NUM; i++) {
    ball[i] = new Ball();     //ボールのオブジェクトを生成して配列に代入
    ball[i].set(250 + (d + 5) * i, 200, 0, 0); //ボールの位置と速度を設定
  }
  ball[0].set(25, 200, 0, 0); //0番目のボールだけ離れた位置に再設定
}

void draw() {
  background(255); //背景白色

  for (int i = 0; i < NUM - 1; i++) {
    for (int j = i + 1; j < NUM; j++) {
      ball[i].collision(ball[j]); //i番目とj番目のボールの衝突(速度変化)の計算
    }
  }

  for (int i = 0; i < NUM; i++) {
    ball[i].draw(); //個々のボールを描画
  }
}

//ウィンドウの中でマウスをクリックしたときに一度だけ呼ばれる関数
void mousePressed() {
  for (int i = 0; i < NUM; i++) {
    ball[i].mousePressed(); //個々のボールのmousePressed()を呼ぶ
  }
}

//ウィンドウの中でマウスドラッグ中に繰り返し呼ばれる関数
void mouseDragged() {
  for (int i = 0; i < NUM; i++) {
    ball[i].mouseDragged(); //個々のボールのmouseDragged()を呼ぶ
  }
}

//ウィンドウの中でマウスボタンを離したときに一度だけ呼ばれる関数
void mouseReleased() {
  for (int i = 0; i < NUM; i++) {
    ball[i].mouseReleased(); //個々のボールのmouseReleased()を呼ぶ
  }
}