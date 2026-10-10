#ifndef GHPROBE_H
#define GHPROBE_H

long gh_raw_lstat(const char *path, void *st);
long gh_raw_access(const char *path, int mode);
long gh_raw_open(const char *path, int flags);
long gh_raw_readlink(const char *path, char *buf, unsigned long sz);
long gh_raw_statfs(const char *path, void *sfs);
long gh_raw_connect_loopback(int port);
long gh_raw_osversion(char *buf, unsigned long sz);

#endif
