#!/usr/bin/python3
import sys
import subprocess

subprocess.check_call(
    args=[
        "xpra",
        "start",
        "--start",
        "xfce4-terminal",
        "--log-file",
        "/home/user/xpra.log",
        "--bind-tcp",
        "0.0.0.0:9999",
        "--html=on",
    ]
    + sys.argv[1:]
)
try:
    subprocess.check_call(args=["tail", "-F", "/home/user/xpra.log"])
except KeyboardInterrupt:
    sys.exit(1)
