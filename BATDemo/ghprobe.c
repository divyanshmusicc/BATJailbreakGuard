#include "ghprobe.h"
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string.h>

/* Raw BSD syscalls (numbers from XNU bsd/kern/syscalls.master, verified for
   the iOS 16 kernel): bypasses every libc wrapper, exercising the tweak's
   syscall() delegation directly. */

long gh_raw_lstat(const char *path, void *st) { return syscall(190, path, st); }
long gh_raw_access(const char *path, int mode) { return syscall(33, path, mode); }
long gh_raw_open(const char *path, int flags) { return syscall(5, path, flags, 0); }
long gh_raw_readlink(const char *path, char *buf, unsigned long sz) { return syscall(58, path, buf, sz); }
long gh_raw_statfs(const char *path, void *sfs) { return syscall(157, path, sfs); }

long gh_raw_connect_loopback(int port) {
    int s = socket(AF_INET, SOCK_STREAM, 0);
    if (s < 0) return -2;
    struct sockaddr_in a;
    memset(&a, 0, sizeof(a));
    a.sin_len = sizeof(a);
    a.sin_family = AF_INET;
    a.sin_port = htons((uint16_t)port);
    a.sin_addr.s_addr = inet_addr("127.0.0.1");
    long r = syscall(98, s, &a, (unsigned int)sizeof(a));
    close(s);
    return r;
}

long gh_raw_osversion(char *buf, unsigned long sz) {
    size_t len = (size_t)sz;
    return syscall(274, "kern.osversion", 14, buf, &len, 0, 0);
}
