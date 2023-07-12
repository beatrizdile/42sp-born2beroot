<h1 align=center>
  42 Cursus
 </h1>
<h2 align=center>
  born2beroot

  ![born Logo](https://game.42sp.org.br/static/assets/achievements/born2berootm.png)

  </h2>

Born2beroot is a system administration project that focuses on setting up and securing a server running a Debian-based operating system.

## Description

born2beroot is a project that provides hands-on experience in system administration tasks and server setup. By completing this project, you will learn how to configure and secure a server environment based on the Debian operating system. The project emphasizes the importance of following security best practices and implementing proper server administration techniques.

To complete the born2beroot project, you need the following:

- A computer with hardware virtualization support
- Virtualization software (e.g., VirtualBox, VMware) installed
- Internet connectivity for downloading necessary packages

## Installation

To install and set up the project environment, follow these steps:

1. Download the Debian-based operating system ISO file from the official website.
2. Install the operating system on your virtualization software, ensuring that hardware virtualization support is enabled.
3. Set up the partitions demanded by the subject using LVM and encryption.
4. Once the installation is complete, log in to the system using the provided credentials.
5. Update the system using the package manager, ensuring that all installed packages are up to date.

## Configuration

The born2beroot project involves the following configuration steps:

1. Network Configuration:
   - Set up a static IP address for the server.
   - Configure the DNS resolution.

2. User Management:
   - Create a non-root user with sudo privileges.
   - Implement secure password policies.

3. SSH Configuration:
   - Secure the SSH server by configuring key-based authentication.
   - Disable SSH root login for enhanced security.

4. Firewall Configuration:
   - Set up a firewall to restrict incoming and outgoing traffic.
   - Allow necessary services and ports while blocking unauthorized access.

5. System Monitoring:
   - Create a bash script that runs every ten minutes.
   - The script must display relevant info about the system.

## Usage

Once the server is configured, you can use it for various purposes, such as hosting websites, running applications, or experimenting with server administration tasks. Interact with the server via SSH using the configured user account and the assigned IP address.

## Security Considerations

The born2beroot project focuses on implementing security best practices, including:

- Secure SSH configuration to protect against unauthorized access.
- Implementation of a firewall to control network traffic and protect against malicious activities.
- User management with strong password policies to prevent unauthorized account access.
- System monitoring tools to detect and respond to potential security breaches.

It is important to understand and follow these security measures to maintain the integrity and security of the server.
