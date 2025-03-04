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

# Assignment 0 Answers

## Kernel Settings Exercises

- Which version of System/161 and OS/161 are you using?
The version of sys161 is "2.0.3" and the version of OS/161 is also "2.0.3"
- Where was OS/161 developed and copyrighted?
Hardvard University
- How much memory and how many CPU cores was System/161 configured to use?
sys161 was configured to use the number of cores and memory written in `sys161.conf`
- What configuration was used by your running kernel?
My running kernel is using DUMBVM configuration
- My kernel has been compiled 4 times

- Bootin os161 kernel with 8 cores
We can achieve this by changing:

```
31 mainboard  ramsize=524288  cpus=1
```

into

```
31 mainboard  ramsize=524288  cpus=8
```

in `sys161.conf`.

- Try booting with 256K of memory. What happens?
Usable physical memory goes down.

- Configure System/161 to use a fixed value to initialize its random number generator. (This can be helpful when debugging non-deterministic kernel behavior.)

We can achieve this by changing:

```
28 random autoseed
```

into

```
28 random seed=128
```

## Source Exploration Exercises

- What function initializes the kernel during boot, and what subsystems are currently initialized?
The `boot()` function in `kern/main/main.c` initializes the kernel during boot.

The subsystems that are currently initialized are:

```c
  ram_bootstrap();
  proc_bootstrap();
  thread_bootstrap();
  hardclock_bootstrap();
  vfs_bootstrap();
  kheap_nextgeneration();

  // devices
  mainbus_bootstrap();

  vm_bootstrap();
  kprintf_bootstrap();
  thread_start_cpus();
```

- What VM system does your kernel use by default? What is wrong with it?

Our kernel use the sys161 VM system. What is wrong with sys161 is that it has issues with floating point support and RAM cache management

- OS/161 ships with two working synchronization primitives. What are they?

The 2 synchronization primitives included with OS/161 are `Dijkstra-style semaphore` and `lock/mutex`

- How do you create a thread in OS/161? Give some examples of code that currently creates multiple threads.

You create a new thread by calling `thread_fork()`, an example of code that creates multiple threads is at `main/menu.c` in which a thread of a new program is created, a thread for kernel is created...

- OS/161 has a system for printing debugging messages to the console. How does it work? How could it be useful?

OS/161 system of printing to the console is called `kprintf()` and it works by making sure there is only one thread printing to the console at any time before putting the char to console then release any lock/semaphore it acquired. It could be useful for displaying information.

- What do copyin and copyout do? What is special about these functions compared to other approaches to copying memory in C, like memmove?

`copyin` and `copyout` are meant to use for copying data in/out from/to kernel and userspace. What's special is that `memmove` can only work in userspace but not across kernel/userspace boundary like `copyin/out`

- What is a zombie thread?

According to `src/includes/thread.h`k, a zombie thread is a thread that has exited but not yet deleted

- What is the difference between a thread sleeping and a thread yielding?

I would say the difference is degree of runnable, a sleeping thread can not be ran because it is waiting for something (I/O, mutex, semaphore...) and a yielding thread is perfectly runnable but decides to be nice and yield the CPU control/time to other threads.

- Explain the difference between machine dependent and machine independent code. Where would you put both in the OS/161 source tree?

Machine dependent: are code that are written for a specific hardware architecture: MIPS, x86_64, ARM...

Machine independent: are code that are written to be run on any machine regardless of CPU architecture

I would put the machine dependent stuffs in `kern/arch` and everything else outside.

- What functions are used to enable and restore interrupts? Would this be sufficient to ensure mutual exclusion on an OS/161 kernel?

The function `splx()` and `splhigh()` is used to enable and restore interrupts

This would not be sufficient to ensure mutual exclusion as we still need spinlocks.

