*This project has been created as part of the 42 curriculum by ogrativ*

# Inception

*This project aims to introduce system administration and containerized
infrastructure using Docker and Docker Compose.*

------------------------------------------------------------------------

## 📌 Project Description

Inception is a system administration project focused on setting up a
small containerized infrastructure using Docker and Docker Compose.

The infrastructure includes:

-   🐳 NGINX with TLSv1.2 / TLSv1.3
-   🧩 WordPress with PHP-FPM
-   🗄 MariaDB database
-   📦 Persistent volumes
-   🌐 Dedicated Docker network

All services are built from scratch using Alpine Linux and custom
Dockerfiles.

------------------------------------------------------------------------

## 🏗 Architecture Overview

The infrastructure consists of three isolated containers:

  Service     Description
  ----------- ----------------------------------------------
  NGINX       Reverse proxy handling HTTPS (port 443 only)
  WordPress   PHP-FPM application server
  MariaDB     Relational database

All containers communicate through a Docker bridge network using service
names as DNS.

Persistent data is stored inside:

/home/<username>/data/

------------------------------------------------------------------------

## 📂 Project Structure

```
.
├── Makefile
└── srcs/
    ├── docker-compose.yml
    ├── nginx/
    ├── wordpress/
    └── mariadb/
```

Each service contains its own Dockerfile and initialization script.

------------------------------------------------------------------------

## 🚀 Installation & Usage

### 1️⃣ Add domain to `/etc/hosts`

127.0.0.1 <username>.42.fr

### 2️⃣ Build and start the infrastructure

make

### 3️⃣ Access the website

https://<username>.42.fr

------------------------------------------------------------------------

## 🔐 Environment Variables

All sensitive credentials are stored inside the `.env` file:

-   Database name
-   Database user
-   Database password
-   WordPress admin credentials

No credentials are hardcoded in Dockerfiles or docker-compose.yml.

------------------------------------------------------------------------

## 🐳 Docker Concepts Explained

### Docker Image vs Container

-   **Image**: Blueprint/template used to create containers.
-   **Container**: Running instance of an image.

### Docker Compose

Docker Compose orchestrates multiple containers: - Builds images -
Creates networks - Manages volumes - Controls lifecycle

### Docker Network

A bridge network allows containers to communicate via service names: -
nginx → wordpress - wordpress → mariadb

### Docker vs Virtual Machines

  Docker               Virtual Machine
  -------------------- ---------------------
  Shares host kernel   Has its own kernel
  Lightweight          Heavy
  Fast startup         Slower
  Low memory usage     Higher memory usage

------------------------------------------------------------------------

## 💾 Persistence

Two named Docker volumes are used:

-   WordPress data
-   MariaDB data

They are mapped to:

/home/<username>/data/

Data remains intact after container restart or VM reboot.

------------------------------------------------------------------------

## 🔒 Security Measures

-   HTTPS only (port 443)
-   TLSv1.2 / TLSv1.3
-   No HTTP (port 80 disabled)
-   No `network: host`
-   No `links`
-   No background infinite loops
-   No pre-built WordPress/MariaDB images

------------------------------------------------------------------------

## 🧪 Testing Persistence

1.  Create a new WordPress user
2.  Restart containers:

make down make up

3.  The user still exists

------------------------------------------------------------------------

## 🤖 AI Usage Disclosure

AI tools (ChatGPT) were used as a learning assistant to:
- Understand Docker networking concepts
- Debug configuration errors
- Improve documentation clarity

All configuration files and scripts were written, tested, and validated manually.

------------------------------------------------------------------------

## 📚 Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)
- [WordPress Documentation](https://wordpress.org/documentation/)
- [WP-CLI Documentation](https://developer.wordpress.org/cli/commands/)
- [Alpine Linux Documentation](https://wiki.alpinelinux.org/wiki/Main_Page)
- [OpenSSL Documentation](https://www.openssl.org/docs/)

------------------------------------------------------------------------

## 👨‍💻 Author

Login: `ogrativ`

42 School -- Inception Project
