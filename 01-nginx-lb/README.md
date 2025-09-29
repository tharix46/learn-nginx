# Nginx - Using As a Reverse Proxy & Load Balancer on Ubuntu

This project demonstrates how to set up Nginx as a reverse proxy and load balancer for multiple instances of a Node.js application.

The setup includes **3 replicas of the Node.js app**, each running **on Docker containers** with different ports binded on host, and **Nginx** configured to distribute incoming requests among these replicas.

---

### Dockerize & Run the Node.js Application

1. Dockerfile is provided to containerize the Node.js app.

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

1. Create the certificate and private key:

```bash
openssl req -x509 -newkey rsa:2048 -nodes -keyout self-sign.key -out self-sign.crt -days 365
```

2. Move the generated files to the appropriate directory:

```bash
sudo mv self-sign.crt /etc/ssl/certs/
sudo mv self-sign.key /etc/ssl/private/
```

---

### Nginx Configuration

1. Change the `server_name` in the `node-app.conf` file to your server's domain name or IP address.

2. Use the provided `nginx-conf.sh` script to install and configure Nginx.

```bash
chmod 744 nginx-conf.sh
./nginx-conf.sh
```

---

### Access the Application

- Open your web browser and navigate to
  - `http://<your-server-ip>`
    or
  - `https://<your-server-ip>`

---

### Load Balancing Verification

1. Open docker compose logs:

```bash
docker compose logs -f
```

2. Refresh the browser multiple times and Check compose logs to see requests being distributed among the replicas.

---
