# Inception -- User Guide

------------------------------------------------------------------------

## 1. Introduction

This document explains how to use the Inception infrastructure once it
is installed and running.

The infrastructure provides:

-   Secure HTTPS access
-   A WordPress website
-   Persistent data storage
-   Automated container management via Makefile

------------------------------------------------------------------------

## 2. Requirements

Before running the project, ensure:

-   Docker is installed
-   Docker Compose is available
-   Your user is in the docker group
-   Port 443 is free
-   Domain is configured in /etc/hosts

------------------------------------------------------------------------

## 3. Domain Configuration

Add the following line to:

/etc/hosts

Example:

127.0.0.1 your_login.42.fr

Replace `your_login` with your actual 42 login.

------------------------------------------------------------------------

## 4. Starting the Infrastructure

From the project root directory:

make

Or manually:

make build make up

------------------------------------------------------------------------

## 5. Accessing the Website

Open your browser and go to:

https://your_login.42.fr

Only HTTPS is available. HTTP (port 80) is disabled.

A browser warning may appear due to the self-signed certificate. This is
expected behavior.

------------------------------------------------------------------------

## 6. WordPress Usage

### Admin Login

Use the credentials defined in the `.env` file:

WP_ADMIN_USER

WP_ADMIN_PASSWORD

Login page:

https://your_login.42.fr/wp-admin

------------------------------------------------------------------------

### Create a New Post

1.  Log into the admin dashboard
2.  Navigate to "Posts"
3.  Click "Add New"
4.  Publish the post

------------------------------------------------------------------------

### Add a Comment

1.  Log in with the non-admin user
2.  Open any post
3.  Add a comment
4.  Submit

------------------------------------------------------------------------

## 7. Stopping the Infrastructure

Stop containers:

make down

Remove containers and volumes:

make clean

Full reset (including images):

make fclean

------------------------------------------------------------------------

## 8. Data Persistence

All data is stored in:

/home/your_login/data/

This ensures:

-   WordPress content persists
-   Database data persists
-   Data survives container restart
-   Data survives VM reboot

------------------------------------------------------------------------

## 9. Troubleshooting

### Cannot Access Website

-   Check /etc/hosts
-   Verify containers are running: docker ps
-   Ensure port 443 is open

------------------------------------------------------------------------

### WordPress Not Loading

-   Check logs: docker logs nginx docker logs wordpress docker logs
    mariadb

------------------------------------------------------------------------

## 10. Rebuilding from Scratch

To fully rebuild the infrastructure:

make fclean make

This will recreate everything automatically.

------------------------------------------------------------------------

## 11. Notes

-   The SSL certificate is self-signed.
-   Only port 443 is exposed.
-   All services run inside Docker containers.
-   No manual WordPress setup is required.

------------------------------------------------------------------------

End of User Guide.