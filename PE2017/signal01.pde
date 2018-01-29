void setup() {
  size(300, 300);
}

void draw() {
  int time = 0;

  background(255);
  time = millis() / 1000; //実行開始からの経過時間（秒）
  if (time % 6 < 2) {
    fill(0, 255, 255); //青緑(シアン)
    ellipse(40, 40, 40, 40);
  } else if (time % 6 < 4) {
    fill(255, 255, 0); //黄
    ellipse(90, 40, 40, 40);
  } else {
    fill(255, 0, 0); //赤
    ellipse(140, 40, 40, 40);
  }

  noFill();
  rect(20, 20, 140, 40);
}