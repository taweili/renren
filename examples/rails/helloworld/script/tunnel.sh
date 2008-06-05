#! /bin/bash

exec ssh -C -v -o TCPKeepAlive=true admin@www.featha.com -Rwww.featha.com:5100:127.0.0.1:3000
