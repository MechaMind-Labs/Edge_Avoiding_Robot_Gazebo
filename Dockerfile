FROM osrf/ros:humble-desktop-full

ENV ROS_WS=/root/bot_ws
WORKDIR /root

# Install base tools
RUN apt-get update && apt-get install -y \
    git \
    python3-rosdep \
    && rm -rf /var/lib/apt/lists/*

# Initialize rosdep (safe for Docker)
RUN rosdep init || true && rosdep update || true

# Create workspace and clone repo
RUN mkdir -p $ROS_WS/src
WORKDIR $ROS_WS/src
RUN git clone https://github.com/MechaMind-Labs/Edge_Avoiding_Robot.git .

# Install dependencies
WORKDIR $ROS_WS
RUN rosdep install --from-paths src -y --ignore-src

# Build workspace
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && colcon build"

# Auto-source ROS and workspace
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc && \
    echo "source $ROS_WS/install/setup.bash" >> /root/.bashrc

WORKDIR $ROS_WS
CMD ["bash"]
