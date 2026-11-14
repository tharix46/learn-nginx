# 🚀 Nginx - Using as a Reverse Proxy & Load Balancer on Ubuntu

This project demonstrates how to set up Nginx as a reverse proxy and load balancer for multiple instances of a Node.js application.

The setup includes:

- **3 replicas of the Node.js app**
- Each running **in Docker containers** with different host ports
- **Nginx** configured to **distribute incoming requests** among these replicas.

---

### Dockerize & Run the Node.js Application

1. A Dockerfile is provided to containerize the Node.js app.

2. Use the provided `compose.yaml` to build and run the application replicas.

```bash
docker compose up --build -d
```

3. Verify that the containers are running:

```bash
docker compose ps
```

---

### Self-sign SSL Certificate Configuration

⚠️ **IMPORTANT** ⚠️

1. Before running the `nginx-conf.sh` script, generate certificate and private key:

```bash
sudo openssl req -x509 -newkey rsa:2048 -nodes -keyout node-app-self-sign.key -out node-app-self-sign.crt -days 365
```

2. The `nginx-conf.sh` script will move them to the standard SSL directories (`/etc/ssl/certs/` and `/etc/ssl/private/`).

---

### Nginx Configuration

1. Update the `server_name` in `node-app.conf` with your server's domain name or IP. Currently, it's set to `192.168.1.22`.

2. Run the provided `nginx-conf.sh` script with root privileges to install and configure Nginx.

```bash
chmod 744 nginx-conf.sh
sudo ./nginx-conf.sh
```

---

### Access the Application

Open your web browser and navigate to:

- `http://<your-server-ip>`

- `https://<your-server-ip>`

---

### Load Balancing Verification

1. Tail docker compose logs:

```bash
docker compose logs -f
```

2. Refresh the browser multiple times and check compose logs to see requests being distributed among the replicas.

---
