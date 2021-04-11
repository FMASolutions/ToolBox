### [Home](../Home.md) | [Docker Home](./Docker.md)

# Docker / Container Architecture
## Docker Engine
The "Docker Engine" is modular, which we interface by using the docker cli. The Docker Engine is made up of the following modules:

    1. API
    2. daemon
    3. containerd
    4. OCI

## Docker Container
A container is an Isolated area of an OS with resource usage limits applied. They allow easier access to the kernel namespaces and control groups through the "Docker Engine".


## Linux Kernel Namespaces 
Namespaces allow us to take an operating systems and carve it into multiple isolated virtual operating systems called containers. Each container gets its own containerized root file system, process tree, eth0 interface, root user.

Just like a virtual server feels like an actual server, an OS container feels like an actual independent OS, even though they all share the same Kernel on the host.

Linux Namespaces:

    1. Process ID (pid) (this allows the container to have it's own isolated process tree and is unaware of any processes running on other container)
    2. Network (net) (this allows the container to have it's own isolated network stack, nics, eth0, ip addresses, routing tables.)
    3. Filesystem/mount (mnt) (this allows the container to have it's own root file system (C:\) on windows (/) on linux)
    4. Inter-proc comms (ipc) (allows processes in a single container access the same shared memory, but not outside the container)
    5. UTS (uts) (this allows each container to have it's own unique host name)
    6. User (user) (allows you to map accounts in the container to different users on the host. typical container root to non priviliged on the host)

A containe will have it's own isolated collection of the namespaces above i.e. it's own process id table with PID1, own network namespace with eth0 interface, i.p address.

## Linux Kernel Control Groups (cgroups) / Job Objects (Windows equivelant)
The idea of control groups / job objects is to group processes and impose hardware limits.