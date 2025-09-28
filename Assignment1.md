# Assignment 1

## Objectives

- Understand the OS/161 thread subsystem and existing synchronization primitives: spinlocks and semaphores.
- Have implemented working locks, condition variables, and reader-writer locks that you can use it later assignments.
- Be able to properly address different synchronization problems by choosing and applying the correct synchronization primitive.

## Tasks

- [ ] Implement sleeping lock
  - [ ] Learn from Linux's implementation of [`rt_mutex`](https://elixir.bootlin.com/linux/v6.16.9/source/include/linux/rtmutex.h#L23)
  - [ ] Notice how we need 2 things: the details of the cpu task and the wait channel we need to sleep on. Do more research on this.
- [ ] Implement condition variables
- [ ] Implement reader-writer locks
- [ ] Solve synchronization problems
  - `kern/synchprobs/*`: these files are where you will implement your solutions to the synchronization problems.
  - `kern/test/synchprobs.c`: this file contains driver code we will use to test your solutions. You can and should change this file to stress test your code.

## Code Reading Questions

- Thread questions
  - What happens to a thread when it calls thread_exit? What about when it sleeps?

  - What function—or functions—handle(s) a context switch?

  - What does it mean for a thread to be in each of the possible thread states?

  - What does it mean to turn interrupts off? How is this accomplished? Why is it important to turn off interrupts in the thread subsystem code?

  - What happens when a thread wakes up another thread? How does a sleeping thread get to run again?

- Scheduling questions
  - What function (or functions) choose the next thread to run?

  - How is the next thread to run chosen?

  - What role does the hardware timer play in scheduling?

  - What hardware independent function is called on a timer interrupt?

- Synchronization questions
  - Describe how wchan_sleep and wchan_wakeone are used to implement semaphores.

  - Why does the lock API in OS/161 provide lock_do_i_hold, but not lock_get_holder?

## Notes

Finally, to successfully run the ASST1 tests you will need to configure your kernel to use a large amount of memory. We suggest the maximum of 16 MB. This is because your kernel currently leaks memory allocations that are larger than a page, and that includes all 4K thread stacks. So you will find that even if you correctly allocate and deallocate memory in your synchronization primitives and problems, your kernel will only run a certain number of tests before it runs out of memory and `panic`s. This is normal. However, you should make sure that your kernel does not leak smaller amounts of memory. Your kernel includes tools to help you measure this.
