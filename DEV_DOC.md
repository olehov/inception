# Inception -- Technical Documentation

------------------------------------------------------------------------

# 1. Project Goal

The goal of this project is to build a secure, containerized web
infrastructure using Docker and Docker Compose, strictly following the
requirements defined in the subject.

The infrastructure must:

-   Use only Docker
-   Be composed of multiple services
-   Use a dedicated Docker network
-   Store persistent data in volumes
-   Serve WordPress over HTTPS only
-   Be fully reproducible via Makefile

------------------------------------------------------------------------

# 2. Infrastructure Architecture

## Services Overview

  Service     Role
  ----------- ----------------------------
  NGINX       Reverse proxy with SSL/TLS
  WordPress   PHP-FPM application
  MariaDB     Relational database

------------------------------------------------------------------------

## Service Communication Flow

    Client (Browser)
            │ HTTPS
            ▼
    NGINX (443)
            │ fastcgi_pass
            ▼
    WordPress (php-fpm :9000)
            │ mysqli
            ▼
    MariaDB (:3306)

Containers communicate using Docker's internal DNS through service
names.
Containers communicate using Docker's internal DNS through service
names.

------------------------------------------------------------------------

# 3. Docker Architecture

## Why Docker?

Docker provides:

-   Lightweight containerization
-   Process isolation
-   Simplified dependency management
-   Reproducible builds
-   Fast startup compared to VMs

------------------------------------------------------------------------

## Docker Network

A bridge network is defined in docker-compose.yml.

Why:

-   Isolates containers from host
-   Allows service name resolution
-   Prevents exposure of internal services

Forbidden configurations avoided:

-   network: host
-   links

------------------------------------------------------------------------

## Docker Volumes

Two named volumes are used:

-   WordPress volume
-   MariaDB volume

Mapped to:

/home/`<login>`/data/

Ensures persistence and survives container recreation and VM reboot.

------------------------------------------------------------------------

# 4. Service Implementations

------------------------------------------------------------------------

## 4.1 NGINX

Base Image: Alpine Linux (penultimate stable version)

Responsibilities:

-   Listen only on port 443
-   Enforce HTTPS
-   Use TLSv1.2 and TLSv1.3
-   Forward PHP requests to WordPress

SSL Certificate:

A self-signed certificate is generated using OpenSSL during container
startup.

Example:

`openssl req -x509 -nodes -days 365 -newkey rsa:2048`

------------------------------------------------------------------------

## 4.2 WordPress (PHP-FPM)

Base Image: Alpine Linux

Installed Components:

-   php82
-   php-fpm
-   mysqli
-   curl
-   wp-cli

Why PHP-FPM?

-   Decouples web server from PHP engine
-   More secure
-   Required by subject

Automatic Installation:

The init script:

1.  Waits for MariaDB
2.  Downloads WordPress via wp-cli
3.  Generates wp-config.php
4.  Installs WordPress
5.  Creates admin and additional user

Ensures full automation and reproducibility.

------------------------------------------------------------------------

## 4.3 MariaDB

Base Image: Alpine Linux

Configuration Adjustments:

-   skip-networking disabled
-   Listens on 0.0.0.0
-   Secured with environment credentials

Initialization:

On first run:

-   Database created
-   User created
-   Privileges granted

Persistent data stored in volume.

------------------------------------------------------------------------

# 5. Security Considerations

The project implements:

-   HTTPS only (port 443 exposed)
-   TLSv1.2 / TLSv1.3
-   No port 80
-   No host networking
-   No links
-   No background infinite loops
-   No tail -f hacks
-   No pre-built WordPress/MariaDB images
-   Admin username does not contain "admin"

------------------------------------------------------------------------

# 6. Directory Structure Justification

. ├── Makefile └── srcs/

Why srcs/?

-   Separates infrastructure from project root
-   Keeps repository clean
-   Matches subject requirement

Why separate folders per service?

-   Separation of concerns
-   Independent Dockerfiles
-   Clear maintainability
-   Easier debugging

Why Makefile?

-   Centralizes orchestration
-   Simplifies evaluation
-   Enforces reproducible workflow

------------------------------------------------------------------------

# 7. Persistence Validation

Persistence is verified by:

1.  Creating a new WordPress user
2.  Restarting containers
3.  Confirming data remains

VM reboot tested and data remains intact.

------------------------------------------------------------------------

# 8. Compliance with Subject

This project respects all mandatory constraints:

-   One Dockerfile per service
-   Built from Alpine (penultimate stable)
-   No host networking
-   No links
-   Dedicated network
-   HTTPS only
-   Two WordPress users created
-   Persistent volumes inside /home/`<login>`/data
-   Makefile used for orchestration

------------------------------------------------------------------------

# 9. Reproducibility

To fully rebuild infrastructure:

`make fclean`

`make`

No manual configuration required.

------------------------------------------------------------------------

# 10. Conclusion

This project demonstrates:

-   Understanding of container orchestration
-   Secure service configuration
-   Network isolation
-   Data persistence
-   Infrastructure automation

It complies fully with the Inception subject requirements and follows
best practices for containerized application design.