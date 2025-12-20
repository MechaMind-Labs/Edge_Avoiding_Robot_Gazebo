FROM osrf/ros:humble-desktop-full

ENV ROS_WS=/root/bot_ws
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /root

# Install base tools
RUN apt update && apt install -y \
    git \
    python3-rosdep \
    python3-colcon-common-extensions \
    && rm -rf /var/lib/apt/lists/*

# Create workspace and clone repo first
RUN mkdir -p $ROS_WS/src
WORKDIR $ROS_WS/src
RUN git clone https://github.com/MechaMind-Labs/Edge_Avoiding_Robot.git .

# Initialize rosdep AFTER cloning (this is key)
WORKDIR $ROS_WS
RUN rosdep update --rosdistro=humble

# Install dependencies with proper error handling
RUN rosdep install --from-paths src -y --ignore-src --rosdistro=humble || \
    (apt update && rosdep install --from-paths src -y --ignore-src --rosdistro=humble)

# Build workspace
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && colcon build"

# Auto-source ROS and workspace
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc && \
    echo "source $ROS_WS/install/setup.bash" >> /root/.bashrc

WORKDIR $ROS_WS

CMD ["bash"]