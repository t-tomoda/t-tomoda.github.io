//　Ballクラス（1次元）                                     T. Tomoda, 2019/7/24

class Ball {
  float x, y;      //ボールの中心位置
  float vx = 0;    //ボールの速度、初期化
  float d = 50;    //ボールの直径
  float r = d / 2; //ボールの半径
  float x_start;   //マウスドラッグ開始時のマウスポインタのx座標
  float x_end;     //マウスドラッグ終了時のマウスポインタのx座標

  //ボールの位置と速度を設定する関数
  void set(float x0, float y0, float vx0) {
    x = x0;
    y = y0;
    vx = vx0;
  }

  //ボールを描画
  void draw() {
    x += vx; //速度に応じたxの変化

    fill(255, 0, 0);     //赤色
    noStroke();          //輪郭線無し
    ellipse(x, y, d, d); //(x, y)を中心とする直径dの円
  }

  //ボールの衝突(主に速度変化)の計算
  void collision(Ball b) {
    float dist = distance(this, b); //自ボールとボールbの中心間の距離
    float temp;

    if (dist < d) { //ボールの中心間の距離が直径より小さかったら
      //1次元の弾性衝突(運動量保存、運動エネルギー保存)→速度の交換
      temp = vx;
      vx = b.vx;
      b.vx = temp;

      //接する位置に戻す(ボールの中心間の距離を直径に等しくするという微調整)
      x = b.x + d * (x - b.x) / abs(x - b.x);
    }
  }

  // 2つのボールの距離を返す関数
  float distance(Ball b1, Ball b2) {
    float dx = b1.x - b2.x;
    float dr = abs(dx);
    return dr;
  }

  //マウスクリックしたときに一度だけ呼ばれる関数
  void mousePressed() {
    //マウスポインタが自オブジェクトの内部であったら
    if ((x - mouseX) * (x - mouseX) + (y - mouseY) * (y - mouseY) < r * r) {
      x_start = mouseX; //ドラッグ開始時のマウスポインタのx座標
    }
  }

  //マウスドラッグ中に繰り返し呼ばれる関数
  void mouseDragged() {
    if ((x - mouseX) * (x - mouseX) + (y - mouseY) * (y - mouseY) < r * r) {
      x = mouseX; //ドラッグ中のマウスポインタの位置からボールのx座標を決める
      vx = 0;     //ドラッグ中はマウスポインタの位置だけでボールの位置を決める
    }
  }

  //マウスボタンを離したときに一度だけ呼ばれる関数
  void mouseReleased() {
    if ((x - mouseX) * (x - mouseX) + (y - mouseY) * (y - mouseY) < r * r) {
      x_end = mouseX; //ドラッグ終了時のマウスポインタのx座標
      vx = (x_end - x_start) * 0.02; //ドラッグ終了後の速度のx成分
    }
  }
}