//　Ballクラス（2次元）                                     T. Tomoda, 2019/7/24

class Ball {
  float x, y;             //ボールの位置
  float vx = 0, vy = 0;   //ボールの速度、初期化
  float d = 50;           //ボールの直径
  float r = d / 2;        //ボールの半径
  float x_start, y_start; //マウスドラッグ開始時のマウスポインタの位置
  float x_end, y_end;     //マウスドラッグ終了時のマウスポインタの位置

  //ボールの位置と速度を設定する関数
  void set(float x0, float y0, float vx0, float vy0) {
    x = x0;
    y = y0;
    vx = vx0;
    vy = vy0;
  }
    
  //ボールを描画
  void draw() {
    x += vx; //速度に応じたxの変化
    y += vy; //速度に応じたyの変化

    //左右のウィンドウ境界で反射
    if (x < r || width - r < x) {
      vx = -vx;
    }

    //上下のウィンドウ境界で反射
    if (y < r || height - r < y) {
      vy = -vy;
    }

    fill(255, 0, 0);     //赤色
    noStroke();          //輪郭線無し
    ellipse(x, y, d, d); //(x, y)を中心とする直径dの円
  }

  //ボールの衝突(主に速度変化)の計算
  void collision(Ball b) {
    float dis = distance(this, b); //自ボールとボールbの中心間の距離
    float ex, ey, new_vx, new_vy, new_bvx, new_bvy;

    if (dis < d) { //ボールの中心間の距離が直径より小さかったら
      ex = (x - b.x) / dis; //ボールbから自ボールへ向かう単位ベクトルのx成分
      ey = (y - b.y) / dis; //ボールbから自ボールへ向かう単位ベクトルのy成分

      //弾性衝突(運動量保存、運動エネルギー保存)、かつ中心間を結ぶ方向に垂直な
      //速度成分は不変と仮定して衝突後の速度を計算し、仮の変数に代入
      new_vx  = vx - ((vx - b.vx) * ex + (vy - b.vy) * ey) * ex;
      new_vy  = vy - ((vx - b.vx) * ex + (vy - b.vy) * ey) * ey;
      new_bvx = b.vx + ((vx - b.vx) * ex + (vy - b.vy) * ey) * ex;
      new_bvy = b.vy + ((vx - b.vx) * ex + (vy - b.vy) * ey) * ey;

      //衝突後の速度を仮の変数から元の変数に代入
      vx   = new_vx;
      vy   = new_vy;
      b.vx = new_bvx;
      b.vy = new_bvy;

      //接する位置に戻す(ボールの中心間の距離を直径に等しくするという微調整)
      x = b.x + d * ex;
      y = b.y + d * ey;
    }
  }

  // 2つのボールの距離を返す関数
  float distance(Ball b1, Ball b2) {
    return dist(b1.x, b1.y, b2.x, b2.y);
  }

  //マウスクリックしたときに一度だけ呼ばれる関数
  void mousePressed() {
    //マウスポインタが自オブジェクトの内部であったら
    if ((x - mouseX) * (x - mouseX) + (y - mouseY) * (y - mouseY) < r * r) {
      x_start = mouseX; //ドラッグ開始時のマウスポインタのx座標
      y_start = mouseY; //ドラッグ開始時のマウスポインタのy座標
    }
  }

  //マウスドラッグ中に繰り返し呼ばれる関数
  void mouseDragged() {
    if ((x - mouseX) * (x - mouseX) + (y - mouseY) * (y - mouseY) < r * r) {
      x = mouseX; //ドラッグ中のマウスポインタの位置からボールのx座標を決める
      y = mouseY; //ドラッグ中のマウスポインタの位置からボールのy座標を決める
      vx = 0;     //ドラッグ中はマウスポインタの位置だけでボールの位置を決める
      vy = 0;     //ドラッグ中はマウスポインタの位置だけでボールの位置を決める
    }
  }

  //マウスボタンを離したときに一度だけ呼ばれる関数
  void mouseReleased() {
    if ((x - mouseX) * (x - mouseX) + (y - mouseY) * (y - mouseY) < r * r) {
      x_end = mouseX; //ドラッグ終了時のマウスポインタのx座標
      y_end = mouseY; //ドラッグ終了時のマウスポインタのy座標
      vx = (x_end - x_start) * 0.02; //ドラッグ終了後の速度のx成分
      vy = (y_end - y_start) * 0.02; //ドラッグ終了後の速度のy成分
    }
  }
}