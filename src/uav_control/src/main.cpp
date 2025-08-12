#include "uav_control/uav_control_node.h"

int main(int argc, char **argv) {
    ros::init(argc, argv, "uav_control_node");
    ros::NodeHandle pnh("~");

    UAVControlNode node(pnh);
    node.run();

    return 0;
}
