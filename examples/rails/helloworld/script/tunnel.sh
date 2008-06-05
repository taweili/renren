#! /bin/bash

exec ssh -C -v -o TCPKeepAlive=true admin@fb.onceup.com -Rwww.featha.com:7000:127.0.0.1:3000
