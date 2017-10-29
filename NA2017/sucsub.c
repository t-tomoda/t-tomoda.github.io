/*****************************************************************************/
/*  sucsub.c                                                                 */
/*                  逐次代入法により方程式                                   */
/*                       exp(x) + x*x - 2 = 0                                */
/*                  を解くプログラム                                         */
/*                                                     数値解析 2017 (友田)  */
/*                                                                           */
/*****************************************************************************/

#include <stdio.h>   // printf(), scanf(), getchar()を使うために必要
#include <math.h>    // exp(x), fabs(x)を使うために必要

double F(double x)
{
    double value;

    value = x - (exp(x) + x*x - 2) / 10;    // exp(x)はeのx乗を返す関数
    return value;
}

int main(void)
{
    int k, n;
    double x, x_old, epsilon;

    printf("xの初期値を入力してください: x= ");
    scanf("%lf", &x);

    printf("収束判定のための小さな数を入力してください: epsilon= ");
    scanf("%lf", &epsilon);
 
    printf("繰り返しの回数の上限を入力してください: n= ");
    scanf("%d", &n);

    printf("x= %f, epsilon= %e, n= %d\n", x, epsilon, n);
    printf("これでよければリターンキーを押してください");
    getchar();    // 入力待ちの状態にするために必要（2回）
    getchar();

    for (k = 1; k <= n; k++) {
        x_old = x;    // 前回求めたxの値を退避
        x = F(x);     // 右辺のxは前回求めた値．左辺のxは新しい値．
        printf("k= %3d, x= %20.17f\n", k, x);

        // xの変化率の絶対値がepsilon以下なら，収束したと判定して終了する
        if (fabs((x - x_old) / x) <= epsilon) {    // fabs(x)は|x|を返す関数
            printf("収束しました\n");
            printf("k= %3d, x= %20.17f\n", k, x);
    		return 0;
        }
    }

    printf("収束しません\n");
    return 0;
}