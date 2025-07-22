// 头文件保护宏，防止头文件被重复包含
#ifndef __GEOMETRY_UTILS_H
#define __GEOMETRY_UTILS_H

// 包含 Eigen 库的密集矩阵和数组操作头文件
#include <Eigen/Dense>

// 关闭 clang-format 代码格式化，确保代码格式按当前编写方式保留
/* clang-format off */
// 定义一个名为 geometry_utils 的命名空间，用于组织几何相关的工具函数
namespace geometry_utils {

/**
 * @brief 将角度从度转换为弧度
 * 
 * @tparam Scalar_t 模板类型，支持不同数值类型（如 float、double 等）
 * @param x 输入的角度值，单位为度
 * @return Scalar_t 转换后的弧度值
 */
template <typename Scalar_t>
Scalar_t toRad(const Scalar_t& x) {
    // 度转弧度的计算公式：弧度 = 度 * π / 180
    return x / 180.0 * M_PI;
}

/**
 * @brief 将角度从弧度转换为度
 * 
 * @tparam Scalar_t 模板类型，支持不同数值类型（如 float、double 等）
 * @param x 输入的角度值，单位为弧度
 * @return Scalar_t 转换后的度数值
 */
template <typename Scalar_t>
Scalar_t toDeg(const Scalar_t& x) {
    // 弧度转度的计算公式：度 = 弧度 * 180 / π
    return x * 180.0 / M_PI;
}

/**
 * @brief 生成绕 X 轴旋转的旋转矩阵
 * 
 * @tparam Scalar_t 模板类型，支持不同数值类型（如 float、double 等）
 * @param t 绕 X 轴旋转的角度，单位为弧度
 * @return Eigen::Matrix<Scalar_t, 3, 3> 3x3 的旋转矩阵
 */
template <typename Scalar_t>
Eigen::Matrix<Scalar_t, 3, 3> rotx(Scalar_t t) {
    // 创建一个 3x3 的矩阵用于存储旋转矩阵
    Eigen::Matrix<Scalar_t, 3, 3> R;
    // 初始化旋转矩阵的元素
    R(0, 0) = 1.0;
    R(0, 1) = 0.0;
    R(0, 2) = 0.0;
    R(1, 0) = 0.0;
    R(1, 1) = std::cos(t);
    R(1, 2) = -std::sin(t);
    R(2, 0) = 0.0;
    R(2, 1) = std::sin(t);
    R(2, 2) = std::cos(t);

    return R;
}

/**
 * @brief 生成绕 Y 轴旋转的旋转矩阵
 * 
 * @tparam Scalar_t 模板类型，支持不同数值类型（如 float、double 等）
 * @param t 绕 Y 轴旋转的角度，单位为弧度
 * @return Eigen::Matrix<Scalar_t, 3, 3> 3x3 的旋转矩阵
 */
template <typename Scalar_t>
Eigen::Matrix<Scalar_t, 3, 3> roty(Scalar_t t) {
    // 创建一个 3x3 的矩阵用于存储旋转矩阵
    Eigen::Matrix<Scalar_t, 3, 3> R;
    // 初始化旋转矩阵的元素
    R(0, 0) = std::cos(t);
    R(0, 1) = 0.0;
    R(0, 2) = std::sin(t);
    R(1, 0) = 0.0;
    R(1, 1) = 1.0;
    R(1, 2) = 0;
    R(2, 0) = -std::sin(t);
    R(2, 1) = 0.0;
    R(2, 2) = std::cos(t);

    return R;
}

/**
 * @brief 生成绕 Z 轴旋转的旋转矩阵
 * 
 * @tparam Scalar_t 模板类型，支持不同数值类型（如 float、double 等）
 * @param t 绕 Z 轴旋转的角度，单位为弧度
 * @return Eigen::Matrix<Scalar_t, 3, 3> 3x3 的旋转矩阵
 */
template <typename Scalar_t>
Eigen::Matrix<Scalar_t, 3, 3> rotz(Scalar_t t) {
    // 创建一个 3x3 的矩阵用于存储旋转矩阵
    Eigen::Matrix<Scalar_t, 3, 3> R;
    // 初始化旋转矩阵的元素
    R(0, 0) = std::cos(t);
    R(0, 1) = -std::sin(t);
    R(0, 2) = 0.0;
    R(1, 0) = std::sin(t);
    R(1, 1) = std::cos(t);
    R(1, 2) = 0.0;
    R(2, 0) = 0.0;
    R(2, 1) = 0.0;
    R(2, 2) = 1.0;

    return R;
}

/**
 * @brief 将偏航（Yaw）、俯仰（Pitch）、滚转（Roll）角转换为旋转矩阵
 * 
 * @tparam Derived 输入向量的 Eigen 矩阵派生类型
 * @param ypr 包含偏航、俯仰、滚转角的三维向量，单位为弧度
 * @return Eigen::Matrix<typename Derived::Scalar, 3, 3> 3x3 的旋转矩阵
 */
template <typename Derived>
Eigen::Matrix<typename Derived::Scalar, 3, 3> ypr_to_R(const Eigen::DenseBase<Derived>& ypr) {
    // 静态断言，确保输入向量为固定大小的三维列向量
    EIGEN_STATIC_ASSERT_FIXED_SIZE(Derived);
    EIGEN_STATIC_ASSERT(Derived::RowsAtCompileTime == 3, THIS_METHOD_IS_ONLY_FOR_MATRICES_OF_A_SPECIFIC_SIZE);
    EIGEN_STATIC_ASSERT(Derived::ColsAtCompileTime == 1, THIS_METHOD_IS_ONLY_FOR_MATRICES_OF_A_SPECIFIC_SIZE);

    // 定义余弦和正弦值变量
    typename Derived::Scalar c, s;

    // 初始化绕 Z 轴旋转的矩阵
    Eigen::Matrix<typename Derived::Scalar, 3, 3> Rz = Eigen::Matrix<typename Derived::Scalar, 3, 3>::Zero();
    // 提取偏航角
    typename Derived::Scalar y = ypr(0);
    c = cos(y);
    s = sin(y);
    Rz(0, 0) = c;
    Rz(1, 0) = s;
    Rz(0, 1) = -s;
    Rz(1, 1) = c;
    Rz(2, 2) = 1;

    // 初始化绕 Y 轴旋转的矩阵
    Eigen::Matrix<typename Derived::Scalar, 3, 3> Ry = Eigen::Matrix<typename Derived::Scalar, 3, 3>::Zero();
    // 提取俯仰角
    typename Derived::Scalar p = ypr(1);
    c = cos(p);
    s = sin(p);
    Ry(0, 0) = c;
    Ry(2, 0) = -s;
    Ry(0, 2) = s;
    Ry(2, 2) = c;
    Ry(1, 1) = 1;

    // 初始化绕 X 轴旋转的矩阵
    Eigen::Matrix<typename Derived::Scalar, 3, 3> Rx = Eigen::Matrix<typename Derived::Scalar, 3, 3>::Zero();
    // 提取滚转角
    typename Derived::Scalar r = ypr(2);
    c = cos(r);
    s = sin(r);
    Rx(1, 1) = c;
    Rx(2, 1) = s;
    Rx(1, 2) = -s;
    Rx(2, 2) = c;
    Rx(0, 0) = 1;

    // 通过矩阵乘法得到最终的旋转矩阵
    Eigen::Matrix<typename Derived::Scalar, 3, 3> R = Rz * Ry * Rx;
    return R;
}

/**
 * @brief 将旋转矩阵转换为偏航（Yaw）、俯仰（Pitch）、滚转（Roll）角
 * 
 * @tparam Derived 输入矩阵的 Eigen 矩阵派生类型
 * @param R 3x3 的旋转矩阵
 * @return Eigen::Matrix<typename Derived::Scalar, 3, 1> 包含偏航、俯仰、滚转角的三维向量，单位为弧度
 */
template <typename Derived>
Eigen::Matrix<typename Derived::Scalar, 3, 1> R_to_ypr(const Eigen::DenseBase<Derived>& R) {
    // 静态断言，确保输入矩阵为固定大小的 3x3 矩阵
    EIGEN_STATIC_ASSERT_FIXED_SIZE(Derived);
    EIGEN_STATIC_ASSERT(Derived::RowsAtCompileTime == 3, THIS_METHOD_IS_ONLY_FOR_MATRICES_OF_A_SPECIFIC_SIZE);
    EIGEN_STATIC_ASSERT(Derived::ColsAtCompileTime == 3, THIS_METHOD_IS_ONLY_FOR_MATRICES_OF_A_SPECIFIC_SIZE);

    // 提取旋转矩阵的第一列
    Eigen::Matrix<typename Derived::Scalar, 3, 1> n = R.col(0);
    // 提取旋转矩阵的第二列
    Eigen::Matrix<typename Derived::Scalar, 3, 1> o = R.col(1);
    // 提取旋转矩阵的第三列
    Eigen::Matrix<typename Derived::Scalar, 3, 1> a = R.col(2);

    // 创建一个三维向量用于存储偏航、俯仰、滚转角
    Eigen::Matrix<typename Derived::Scalar, 3, 1> ypr(3);
    // 计算偏航角
    typename Derived::Scalar y = atan2(n(1), n(0));
    // 计算俯仰角
    typename Derived::Scalar p = atan2(-n(2), n(0) * cos(y) + n(1) * sin(y));
    // 计算滚转角
    typename Derived::Scalar r =
        atan2(a(0) * sin(y) - a(1) * cos(y), -o(0) * sin(y) + o(1) * cos(y));
    ypr(0) = y;
    ypr(1) = p;
    ypr(2) = r;

    return ypr;
}

/**
 * @brief 将偏航（Yaw）、俯仰（Pitch）、滚转（Roll）角转换为四元数
 * 
 * @tparam Derived 输入向量的 Eigen 矩阵派生类型
 * @param ypr 包含偏航、俯仰、滚转角的三维向量，单位为弧度
 * @return Eigen::Quaternion<typename Derived::Scalar> 对应的四元数
 */
template <typename Derived>
Eigen::Quaternion<typename Derived::Scalar> ypr_to_quaternion(const Eigen::DenseBase<Derived>& ypr) {
    // 静态断言，确保输入向量为固定大小的三维列向量
    EIGEN_STATIC_ASSERT_FIXED_SIZE(Derived);
    EIGEN_STATIC_ASSERT(Derived::RowsAtCompileTime == 3, THIS_METHOD_IS_ONLY_FOR_MATRICES_OF_A_SPECIFIC_SIZE);
    EIGEN_STATIC_ASSERT(Derived::ColsAtCompileTime == 1, THIS_METHOD_IS_ONLY_FOR_MATRICES_OF_A_SPECIFIC_SIZE);

    // 计算偏航角一半的余弦值
    const typename Derived::Scalar cy = cos(ypr(0) / 2.0);
    // 计算偏航角一半的正弦值
    const typename Derived::Scalar sy = sin(ypr(0) / 2.0);
    // 计算俯仰角一半的余弦值
    const typename Derived::Scalar cp = cos(ypr(1) / 2.0);
    // 计算俯仰角一半的正弦值
    const typename Derived::Scalar sp = sin(ypr(1) / 2.0);
    // 计算滚转角一半的余弦值
    const typename Derived::Scalar cr = cos(ypr(2) / 2.0);
    // 计算滚转角一半的正弦值
    const typename Derived::Scalar sr = sin(ypr(2) / 2.0);

    // 创建一个四元数对象
    Eigen::Quaternion<typename Derived::Scalar> q;

    // 计算四元数的 w 分量
    q.w() = cr * cp * cy + sr * sp * sy;
    // 计算四元数的 x 分量
    q.x() = sr * cp * cy - cr * sp * sy;
    // 计算四元数的 y 分量
    q.y() = cr * sp * cy + sr * cp * sy;
    // 计算四元数的 z 分量
    q.z() = cr * cp * sy - sr * sp * cy;

    return q;
}

/**
 * @brief 将四元数转换为偏航（Yaw）、俯仰（Pitch）、滚转（Roll）角
 * 
 * @tparam Scalar_t 模板类型，支持不同数值类型（如 float、double 等）
 * @param q_ 输入的四元数
 * @return Eigen::Matrix<Scalar_t, 3, 1> 包含偏航、俯仰、滚转角的三维向量，单位为弧度
 */
template <typename Scalar_t>
Eigen::Matrix<Scalar_t, 3, 1> quaternion_to_ypr(const Eigen::Quaternion<Scalar_t>& q_) {
    // 对输入的四元数进行归一化处理
    Eigen::Quaternion<Scalar_t> q = q_.normalized();

    // 创建一个三维向量用于存储偏航、俯仰、滚转角
    Eigen::Matrix<Scalar_t, 3, 1> ypr;
    // 计算滚转角
    ypr(2) = atan2(2 * (q.w() * q.x() + q.y() * q.z()), 1 - 2 * (q.x() * q.x() + q.y() * q.y()));
    // 计算俯仰角
    ypr(1) = asin(2 * (q.w() * q.y() - q.z() * q.x()));
    // 计算偏航角
    ypr(0) = atan2(2 * (q.w() * q.z() + q.x() * q.y()), 1 - 2 * (q.y() * q.y() + q.z() * q.z()));

    return ypr;
}

/**
 * @brief 从四元数中提取偏航（Yaw）角
 * 
 * @tparam Scalar_t 模板类型，支持不同数值类型（如 float、double 等）
 * @param q 输入的四元数
 * @return Scalar_t 偏航角，单位为弧度
 */
template <typename Scalar_t>
Scalar_t get_yaw_from_quaternion(const Eigen::Quaternion<Scalar_t>& q) {
    // 调用 quaternion_to_ypr 函数并提取第一个元素（偏航角）
    return quaternion_to_ypr(q)(0);
}

/**
 * @brief 将偏航（Yaw）角转换为四元数
 * 
 * @tparam Scalar_t 模板类型，支持不同数值类型（如 float、double 等）
 * @param yaw 输入的偏航角，单位为弧度
 * @return Eigen::Quaternion<Scalar_t> 对应的四元数
 */
template <typename Scalar_t>
Eigen::Quaternion<Scalar_t> yaw_to_quaternion(Scalar_t yaw) {
    // 通过绕 Z 轴旋转矩阵构造四元数
    return Eigen::Quaternion<Scalar_t>(rotz(yaw));
}

/**
 * @brief 将角度归一化到 [-π, π] 范围内
 * 
 * @tparam Scalar_t 模板类型，支持不同数值类型（如 float、double 等）
 * @param a 输入的角度值，单位为弧度
 * @return Scalar_t 归一化后的角度值，范围在 [-π, π] 内
 */
template <typename Scalar_t>
Scalar_t normalize_angle(Scalar_t a) {
    // 计数器，用于限制循环次数
    int cnt = 0;
    while (true) {
        cnt++;

        // 若角度小于 -π，加上 2π
        if (a < -M_PI) {
            a += M_PI * 2.0;
        } 
        // 若角度大于 π，减去 2π
        else if (a > M_PI) {
            a -= M_PI * 2.0;
        }

        // 若角度在 [-π, π] 范围内，跳出循环
        if (-M_PI <= a && a <= M_PI) {
            break;
        };

        // 断言循环次数小于 10，防止无限循环
        assert(cnt < 10 && "[geometry_utils/geometry_msgs] INVALID INPUT ANGLE");
    }

    return a;
}

/**
 * @brief 将两个角度相加，并将结果归一化到 [-π, π] 范围内
 * 
 * 该函数接收两个角度值，将它们相加后调用 `normalize_angle` 函数
 * 把结果归一化到 [-π, π] 范围内，最后使用 `assert` 确保结果在有效范围内。
 * 
 * @tparam Scalar_t 模板类型，支持不同数值类型（如 float、double 等）
 * @param a 第一个角度值，单位为弧度
 * @param b 第二个角度值，单位为弧度
 * @return Scalar_t 归一化后的角度和，范围在 [-π, π] 内
 */
template <typename Scalar_t>
Scalar_t angle_add(Scalar_t a, Scalar_t b) {
    // 将两个输入角度相加
    Scalar_t c = a + b;
    // 调用 normalize_angle 函数将相加后的角度归一化到 [-π, π] 范围内
    c = normalize_angle(c);
    // 断言验证归一化后的角度在 [-π, π] 范围内
    assert(-M_PI <= c && c <= M_PI);
    // 返回归一化后的角度和
    return c;
}

/**
 * @brief 将两个偏航角相加，并将结果归一化到 [-π, π] 范围内
 * 
 * 该函数调用 `angle_add` 函数实现两个偏航角的相加和归一化操作。
 * 
 * @tparam Scalar_t 模板类型，支持不同数值类型（如 float、double 等）
 * @param a 第一个偏航角，单位为弧度
 * @param b 第二个偏航角，单位为弧度
 * @return Scalar_t 归一化后的偏航角和，范围在 [-π, π] 内
 */
template <typename Scalar_t>
Scalar_t yaw_add(Scalar_t a, Scalar_t b) {
    // 调用 angle_add 函数进行偏航角相加和归一化操作
    return angle_add(a, b);
}

/**
 * @brief 将三维向量转换为对应的反对称矩阵
 * 
 * 对于输入的三维向量 v，生成其对应的反对称矩阵 M，满足 M^T = -M。
 * 
 * @tparam Derived 输入向量的 Eigen 矩阵派生类型
 * @param v 输入的三维向量
 * @return Eigen::Matrix<typename Derived::Scalar, 3, 3> 对应的反对称矩阵
 */
template <typename Derived>
Eigen::Matrix<typename Derived::Scalar, 3, 3> get_skew_symmetric(const Eigen::DenseBase<Derived>& v) {
    // 静态断言，确保输入向量为固定大小的三维列向量
    EIGEN_STATIC_ASSERT_FIXED_SIZE(Derived);
    EIGEN_STATIC_ASSERT(Derived::RowsAtCompileTime == 3, THIS_METHOD_IS_ONLY_FOR_MATRICES_OF_A_SPECIFIC_SIZE);
    EIGEN_STATIC_ASSERT(Derived::ColsAtCompileTime == 1, THIS_METHOD_IS_ONLY_FOR_MATRICES_OF_A_SPECIFIC_SIZE);

    // 创建一个 3x3 的零矩阵
    Eigen::Matrix<typename Derived::Scalar, 3, 3> M;
    M.setZero();
    // 根据三维向量元素填充反对称矩阵
    M(0, 1) = -v(2);
    M(0, 2) = v(1);
    M(1, 0) = v(2);
    M(1, 2) = -v(0);
    M(2, 0) = -v(1);
    M(2, 1) = v(0);
    // 返回生成的反对称矩阵
    return M;
}

/**
 * @brief 将 3x3 的反对称矩阵转换为对应的三维向量
 * 
 * 从输入的反对称矩阵 M 中提取出对应的三维向量 v。
 * 
 * @tparam Derived 输入矩阵的 Eigen 矩阵派生类型
 * @param M 输入的 3x3 反对称矩阵
 * @return Eigen::Matrix<typename Derived::Scalar, 3, 1> 对应的三维向量
 */
template <typename Derived>
Eigen::Matrix<typename Derived::Scalar, 3, 1> from_skew_symmetric(const Eigen::DenseBase<Derived>& M) {
    // 静态断言，确保输入矩阵为固定大小的 3x3 矩阵
    EIGEN_STATIC_ASSERT_FIXED_SIZE(Derived);
    EIGEN_STATIC_ASSERT(Derived::RowsAtCompileTime == 3, THIS_METHOD_IS_ONLY_FOR_MATRICES_OF_A_SPECIFIC_SIZE);
    EIGEN_STATIC_ASSERT(Derived::ColsAtCompileTime == 3, THIS_METHOD_IS_ONLY_FOR_MATRICES_OF_A_SPECIFIC_SIZE);

    // 创建一个三维向量
    Eigen::Matrix<typename Derived::Scalar, 3, 1> v;
    // 从反对称矩阵中提取元素填充三维向量
    v(0) = M(2, 1);
    v(1) = -M(2, 0);
    v(2) = M(1, 0);
    
    // 断言验证重构结果的正确性
    assert(v.isApprox(Eigen::Matrix<typename Derived::Scalar, 3, 1>(-M(1, 2), M(0, 2), -M(0, 1))));
    
    // 返回重构的三维向量
    return v;
}


}  // end of namespace geometry_utils
/* clang-format on */

#endif
