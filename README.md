# OS161 Learning

## Setup

- Follow instructions from UBC University: <https://people.ece.ubc.ca/~os161/os161-site/install-docker.html>
- Get their docker image and build the container
- Go here to get the OS161 base source tarball <http://www.os161.org/download/>
- Do your magic (gunzip, tar -xvf) and make sure the folder is named `src`
- Next your need a config file, a sample config file (provided by UBC) can be obtained by <https://people.ece.ubc.ca/~os161/os161-site/install.html>
- Then we run the kernel with the help of the `sys161` simulator:

        cd ~/os161/root
        sys161 kernel

## The pieces

- OS/161 Kernel source tree
  - The kernel sources for OS/161 is in the `kern` subdirectory, which has its own configuration script.
  - The `conf.kern` file determines what source files get included in our kernel build so we might have to modify the file later on.

- Debugging
  - Follow the steps at <https://people.ece.ubc.ca/~os161/os161-site/gdb-attach.html>

## Assignments

### Assignments 0

- [Assignment 0 Answers](./Assignment0.md)

### Assignments 1

- [Assignment 1 Answers](./Assignment1.md)
