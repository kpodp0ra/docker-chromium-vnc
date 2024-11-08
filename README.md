# Dockerized Chromium Browser with VNC access

This Docker package creates a **Chromium-based kiosk** on **Alpine Linux**. It runs Chromium in a secure, fullscreen mode managed by the **i3 window manager** and orchestrated by **Supervisord**. This lightweight setup can be deployed on **non-GUI cloud servers** and accessed via **TigerVNC** for remote, multi-user access.

## Quick Start
To build and run:
```bash
docker build -t chrome-vnc .
if mkdir data ; then
  sudo chown 1000:1000 data
else
  rm data/SingletonLock -f
fi
docker run -it --rm --cap-add=SYS_ADMIN --name chrome-vm -p 5900:5900 -v ./data:/home/chrome/.config/chromium chrome-vnc
```

### Access the Environment
1. Connect to `localhost:5900` using a VNC client (default is no authentication).
2. Optionally, use **Apache Guacamole** to enable browser-based VNC access for multiple users.

## Key Features
- **Lightweight Alpine Base**: Built on Alpine Linux, keeping the image size small and efficient.
- **Fullscreen Chromium**: Chromium runs in fullscreen for a secure browsing experience.
- **VNC Access with TigerVNC**: Allows remote access to the Chromium session on a virtual display through VNC. No desktop GUI is required on the host server.
- **i3 Window Manager**: Provides a minimal, distraction-free environment where Chromium can run in fullscreen.
- **Supervisord Process Management**: Manages and monitors services (Xvnc, i3wm, and Chromium), ensuring they restart automatically if they fail.

## Use Case
This setup is ideal for creating a **remote-access kiosk** that can be shared with multiple users over VNC. By using **Apache Guacamole** as an optional layer, you can provide **browser access to multiple users concurrently** without needing direct VNC connections for each. It’s perfect for:
- **Demos and Presentations**: Allow users to connect remotely and view the same content.
- **Testing Environments**: Enable access to a controlled browser instance in the cloud for testing.
- **Shared Data**: One browser facilitates collaboration – log in to your accounts and let each VNC user use them. 

## Configuration Files

### `supervisord.ini`
Configures Supervisord to manage:
  - `Xvnc`: Provides the virtual display for remote access.
  - `i3wm`: The i3 window manager, setting up a simple fullscreen environment for Chromium.
  - `Chromium`: Runs with various restrictions for security, in a dedicated user environment (`chrome` user).

### `policies.json`
Specifies **Chrome security policies**, including:
  - Blocking guest mode, incognito, password management, and extensions.
  - Enforcing SafeSearch, HTTPS upgrades, and File access restrictions.
  - Disabling download and file system access for a secure, controlled experience.

### `i3wm.conf`
Configures i3 window manager to hide distractions, run Chromium in fullscreen, and hide all interferences. 
