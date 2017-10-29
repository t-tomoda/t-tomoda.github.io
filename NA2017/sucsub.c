/*****************************************************************************/
/*  sucsub.c                                                                 */
/*                  ��������@�ɂ�������                                   */
/*                       exp(x) + x*x - 2 = 0                                */
/*                  �������v���O����                                         */
/*                                                     ���l��� 2017 (�F�c)  */
/*                                                                           */
/*****************************************************************************/

#include <stdio.h>   // printf(), scanf(), getchar()���g�����߂ɕK�v
#include <math.h>    // exp(x), fabs(x)���g�����߂ɕK�v

double F(double x)
{
    double value;

    value = x - (exp(x) + x*x - 2) / 10;    // exp(x)��e��x���Ԃ��֐�
    return value;
}

int main(void)
{
    int k, n;
    double x, x_old, epsilon;

    printf("x�̏����l����͂��Ă�������: x= ");
    scanf("%lf", &x);

    printf("��������̂��߂̏����Ȑ�����͂��Ă�������: epsilon= ");
    scanf("%lf", &epsilon);
 
    printf("�J��Ԃ��̉񐔂̏������͂��Ă�������: n= ");
    scanf("%d", &n);

    printf("x= %f, epsilon= %e, n= %d\n", x, epsilon, n);
    printf("����ł悯��΃��^�[���L�[�������Ă�������");
    getchar();    // ���͑҂��̏�Ԃɂ��邽�߂ɕK�v�i2��j
    getchar();

    for (k = 1; k <= n; k++) {
        x_old = x;    // �O�񋁂߂�x�̒l��ޔ�
        x = F(x);     // �E�ӂ�x�͑O�񋁂߂��l�D���ӂ�x�͐V�����l�D
        printf("k= %3d, x= %20.17f\n", k, x);

        // x�̕ω����̐�Βl��epsilon�ȉ��Ȃ�C���������Ɣ��肵�ďI������
        if (fabs((x - x_old) / x) <= epsilon) {    // fabs(x)��|x|��Ԃ��֐�
            printf("�������܂���\n");
            printf("k= %3d, x= %20.17f\n", k, x);
    		return 0;
        }
    }

    printf("�������܂���\n");
    return 0;
}