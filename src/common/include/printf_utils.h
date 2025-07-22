#ifndef PRINTF_UTILS_H
#define PRINTF_UTILS_H

#include <string>
#include <iostream>
#include <iomanip>
#include <chrono>
#include <ctime>
using namespace std;

// 定义打印时显示的小数点位数
#define NUM_POINT 2 

// 定义不同颜色的 ANSI 转义序列
#define RED "\033[0;1;31m"
#define GREEN "\033[0;1;32m"
#define YELLOW "\033[0;1;33m"
#define BLUE "\033[0;1;34m"
#define PURPLE "\033[0;1;35m"
#define DEEPGREEN "\033[0;1;36m"
#define WHITE "\033[0;1;37m"

// 定义背景为白色，文字为不同颜色的 ANSI 转义序列
#define RED_IN_WHITE "\033[0;47;31m"
#define GREEN_IN_WHITE "\033[0;47;32m"
#define YELLOW_IN_WHITE "\033[0;47;33m"

// 定义重置颜色的 ANSI 转义序列
#define TAIL "\033[0m"

/**
 * @class Print
 * @brief 用于带颜色和时间间隔控制的打印类
 * 
 * 该类提供了一个可配置打印间隔和颜色的打印功能，
 * 支持在控制台输出带颜色的文本，并且可以控制打印频率。
 */
class Print
{
public:
    /**
     * @brief 构造函数
     * @param interval 打印间隔，单位为秒。若为负数，则显示旋转字符。默认为 0。
     * @param color 打印文本的颜色，使用 ANSI 转义序列。默认为重置颜色。
     */
    Print(float interval = 0, std::string color = TAIL)
        : interval(interval), past_ts(std::chrono::system_clock::now()), color(color)
    {
        // 固定的浮点显示
        std::cout.setf(ios::fixed);
        // 设置显示小数精度为 NUM_POINT 位
        std::cout << std::setprecision(NUM_POINT);
        // 左对齐
        std::cout.setf(ios::left);
        // 强制显示小数点
        std::cout.setf(ios::showpoint);
        // 强制显示符号
        std::cout.setf(ios::showpos);
    };

    /**
     * @brief 重载函数调用运算符，实现带时间间隔和颜色的打印功能
     * @tparam T 模板类型，支持任意可通过 << 输出到 std::cout 的类型
     * @param msg 要打印的消息
     */
    template <typename T>
    void operator()(T &&msg)
    {
        // 获取当前时间
        std::chrono::system_clock::time_point now_ts = std::chrono::system_clock::now();
        // 计算自上次打印以来的时间间隔，单位为毫秒
        auto dt = std::chrono::duration_cast<std::chrono::milliseconds>(now_ts - past_ts).count();

        // 如果当前对象与静态对象不同，换行并更新静态对象指针
        if (this != s_object_name)
        {
            std::cout << std::endl;
            s_object_name = this;
        }

        // 根据间隔值进行不同的打印操作
        if (interval >= 0)
        {
            // 如果时间间隔小于设定的间隔，不进行打印
            if (dt < this->interval * 1000)
                return;
            // 打印带颜色的消息并重置颜色
            std::cout << color << msg << TAIL << std::endl;
        }
        else
        {
            // 如果时间间隔小于 0.1 秒，不进行打印
            if (dt < 0.1 * 1000)
                return;
            char now_char;
            // 根据 times 的值选择旋转字符
            switch (times)
            {
            case 0:
                now_char = '\\';
                break;
            case 1:
                now_char = '|';
                break;
            case 2:
                now_char = '/';
                break;
            case 3:
                now_char = '-';
                break;
            }
            // 更新 times 的值
            times = ++times % 4;
            // 打印旋转字符和带颜色的消息，并刷新输出缓冲区
            std::cout << color << "\r " << now_char << " " << msg << TAIL << std::flush;
        }
        // 更新上次打印时间
        this->past_ts = now_ts;
    };

    // 打印间隔，单位为秒
    float interval;

private:
    // 上次打印的时间点
    std::chrono::system_clock::time_point past_ts;
    // 打印文本的颜色
    std::string color;
    // 静态指针，用于记录上次打印的对象
    static void *s_object_name;
    // 旋转字符的索引
    unsigned int times = 0;
};

// 初始化静态成员变量
void *Print::s_object_name = nullptr;

// 辅助宏，用于连接两个标识符
#define PRINTF_UTILS_CONCAT_(x, y) x##y
// 辅助宏，调用 PRINTF_UTILS_CONCAT_ 进行标识符连接
#define PRINTF_UTILS_CONCAT(x, y) PRINTF_UTILS_CONCAT_(x, y)

/**
 * @brief 用于创建 Print 对象并调用其函数调用运算符的宏
 * @param interval 打印间隔，单位为秒
 * @param color 打印文本的颜色，使用 ANSI 转义序列
 * @param msg 要打印的消息
 * @param sign 唯一标识符，通常使用 __LINE__
 */
#define PRINTF_UTILS_PCOUT_(interval, color, msg, sign)             \
    static Print PRINTF_UTILS_CONCAT(print, sign)(interval, color); \
    PRINTF_UTILS_CONCAT(print, sign)                                \
    (msg)

/**
 * @brief 简化的打印宏，使用当前行号作为唯一标识符
 * @param interval 打印间隔，单位为秒
 * @param color 打印文本的颜色，使用 ANSI 转义序列
 * @param msg 要打印的消息
 */
#define PCOUT(interval, color, msg) PRINTF_UTILS_PCOUT_(interval, color, msg, __LINE__)

// Example:
// cout << GREEN << "Test for Green text." << TAIL <<endl;

// 字背景颜色范围:40--49            字颜色: 30--39
// 40:黑                          30: 黑
// 41:红                          31: 红
// 42:绿                          32: 绿
// 43:黄                          33: 黄
// 44:蓝                          34: 蓝
// 45:紫                          35: 紫
// 46:深绿                        36: 深绿
// 47:白色                        37: 白色

// 参考资料：https://blog.csdn.net/u014470361/article/details/81512330
// cout <<  "\033[0;1;31m" << "Hello World, Red color!"  << "\033[0m" << endl;
// printf(  "\033[0;30;41m color!!! \033[0m Hello \n");
// ROS_INFO("\033[1;33;41m----> Hightlight color.\033[0m");
// 其中41的位置代表字的背景色, 30的位置是代表字的颜色，0 是字的一些特殊属性，0代表默认关闭，一些其他属性如闪烁、下划线等。

// ROS_INFO_STREAM_ONCE ("\033[1;32m---->Setting to OFFBOARD Mode....\033[0m");//绿色只打印一次

#endif