# 🤖 Simulated Edge-Avoidance Robot
This repository contains a **ROS 2-based mobile robot simulation** with an **edge-avoidance behavior**.  
The robot uses a simulated **LIDAR sensor in Gazebo** and reacts to edges or drops detected in its environment.

---

## 🎥 Edge Avoiding Robot Demo  
https://github.com/user-attachments/assets/4429458a-abf8-4671-920a-71deb08a8aca


> **At a glance:** a differential-drive robot built from scratch in a live workshop — URDF, Gazebo, ros2_control and a LiDAR-based node that detects table edges and steers away before falling.
>
> **Watch:** [full workshop recording](https://youtu.be/luZq317FUrE) · **Step-by-step handout:** [session_steps](https://github.com/Curious-Utkarsh/session_steps)
>
> **Related:** [MechaBot](https://github.com/MechaMind-Labs/AMR-Mastery) — the full autonomous robot that followed these workshops · [Gesture Controlled Robot](https://github.com/MechaMind-Labs/MicroROS_Gesture_Controlled_Robot_MPU6050)

---

## 📦 Prerequisites

### Option 1: Docker (Recommended - Easy Setup)
- ✅ **OS:** Any OS with Docker support (Linux, Windows, macOS)  
- ✅ **Docker:** Version 20.10+  
- ✅ **X11 Display:** For GUI applications (Linux native, Windows/Mac needs XServer)

### Option 2: Local Installation
- ✅ **OS:** Ubuntu 22.04  
- ✅ **ROS 2:** Humble Hawksbill  
- ✅ **Simulation Tools:** Gazebo & RViz (included in ROS 2 Desktop Full)  
- ✅ **Python:** 3.10+  

---

## 🐳 Quick Start with Docker (Easiest Method)

### 1️⃣ Install Docker

#### On Ubuntu/Linux:

**Step 1: Set up Docker's apt repository**
```bash
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
```

**Step 2: Install Docker packages**
```bash
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
```

**Step 3: Post-installation steps (Run Docker without sudo)**
```bash
# Create docker group (if not exists)
sudo groupadd docker

# Add your user to the docker group
sudo usermod -aG docker $USER

# Activate the changes to groups
newgrp docker

# Verify installation
docker --version
docker run hello-world
```

#### On Windows/macOS:
Download and install **Docker Desktop** from:  
👉 [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)

---

### 2️⃣ Setup Display for GUI (Linux)

```bash
# Allow Docker to access your display
xhost +local:docker
```

> **Note:** For Windows/macOS, you'll need to install an X Server like [VcXsrv](https://sourceforge.net/projects/vcxsrv/) (Windows) or [XQuartz](https://www.xquartz.org/) (macOS)

---

### 3️⃣ Pull the Docker Image

```bash
docker pull curiousutkarsh/edge_avoiding_robot:humble
```

---

### 4️⃣ Run the Container

```bash
docker run -it --rm \
  --name edge_avoiding_robot \
  --network host \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  curiousutkarsh/edge_avoiding_robot:humble bash
```

---

### 5️⃣ Launch the Simulation (Inside Container)

Once inside the container, run:

```bash
ros2 launch bot_bringup simulated_robot.launch.py
```

✅ **Gazebo and RViz should now open with the robot simulation!**

---

### 🛑 Exiting and Cleaning Up Docker

#### Exit the container:
```bash
# Inside container, press Ctrl+D or type:
exit
```

#### Stop running container (from another terminal):
```bash
docker stop edge_avoiding_robot
```

#### Remove stopped containers:
```bash
docker container prune -f
```

#### Remove the image (if needed):
```bash
docker rmi curiousutkarsh/edge_avoiding_robot:humble
```

#### Revoke X11 access (Linux):
```bash
xhost -local:docker
```

---

## 💻 Local Installation (Without Docker)

### 🧰 Step-by-Step Installation

#### 1️⃣ Install ROS 2 Humble  
Follow the official ROS 2 installation guide:  
👉 [ROS 2 Humble Installation](https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html)

#### 2️⃣ Source ROS 2 and Add to `.bashrc`
```bash
source /opt/ros/humble/setup.bash
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
```

#### 3️⃣ Source `.bashrc`
```bash
source ~/.bashrc
```

---

### 🧠 Workspace Setup

#### 4️⃣ Install Git
```bash
sudo apt install git
```

#### 5️⃣ Clone This Repository
```bash
cd ~
git clone https://github.com/MechaMind-Labs/Edge_Avoiding_Robot_Gazebo.git Edge_Avoiding_Robot
cd Edge_Avoiding_Robot
```

---

### ⚙️ Setup ROS Dependencies

#### 6️⃣ Install `rosdep` and initialize
```bash
sudo apt install python3-rosdep
```
```bash
sudo rosdep init
rosdep update
```

#### 7️⃣ Install package dependencies
```bash
cd ~/Edge_Avoiding_Robot
rosdep install --from-paths src -y --ignore-src
```

---

### 🧱 Build the Workspace

```bash
cd ~/Edge_Avoiding_Robot
colcon build
```

#### 8️⃣ Source the workspace
```bash
source install/setup.bash
echo "source ~/Edge_Avoiding_Robot/install/setup.bash" >> ~/.bashrc
```

---

### 🧩 (Optional) Shell Autocompletion

```bash
sudo apt install python3-colcon-argcomplete
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc
```

---

## 🚀 Run the Simulation

### Launch Gazebo with the robot
```bash
ros2 launch bot_bringup simulated_robot.launch.py
```

✅ You should now see:
* Gazebo with the robot and a world environment
* The robot running an **edge avoidance algorithm** using LIDAR data

---

## 📁 Project Structure

```
Edge_Avoiding_Robot/
├── src/
│   ├── bot_description/   # URDF and Gazebo assets
│   ├── bot_controller/    # Robot control nodes
│   ├── bot_bringup/       # Launch files
│   ├── bot_script/        # Edge detection and logic
```

---

## 🛠 Troubleshooting

### Docker Issues:
* **GUI not showing:** Make sure you ran `xhost +local:docker` before starting the container
* **Permission denied:** Add your user to docker group: `sudo usermod -aG docker $USER`
* **Container exits immediately:** Check container logs: `docker logs edge_avoiding_robot`

### Local Installation Issues:
* If LIDAR is not detecting correctly, check its **pose and scan angle** in `bot_description`.
* Always source the workspace in every new terminal:
  ```bash
  source ~/Edge_Avoiding_Robot/install/setup.bash
  ```
* If `colcon build` fails, try: `rosdep install --from-paths src -y --ignore-src` again

---

## 📚 Useful Docker Commands

```bash
# List all running containers
docker ps

# List all containers (including stopped)
docker ps -a

# View container logs
docker logs edge_avoiding_robot

# Execute command in running container
docker exec -it edge_avoiding_robot bash

# Stop all running containers
docker stop $(docker ps -q)

# Remove all stopped containers
docker container prune -f

# Remove all unused images
docker image prune -a -f

# Check disk usage
docker system df
```

---

## 🙌 Credits

Maintained by **[Curious-Utkarsh](https://github.com/Curious-Utkarsh)**  
Inspired by real-world **edge-avoidance robotics** applications.

---

## 📄 License

This project is open-source and available under the MIT License.

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!  
Feel free to check the [issues page](https://github.com/MechaMind-Labs/Edge_Avoiding_Robot_Gazebo/issues).

---

## ⭐ Show your support

Give a ⭐️ if this project helped you!
