FROM archlinux
RUN pacman -Sy
RUN pacman -Su -q --noconfirm
RUN pacman -S -q --noconfirm python zsh xfce4 xpra xorg noto-fonts noto-fonts-emoji psmisc python-paramiko python-pip base-devel pulseaudio sudo git vim
RUN pip3 install python-uinput dumb-init pyinotify
RUN useradd -m user
COPY 10-user-nopasswd /etc/sudoers.d/
COPY sudo.conf /etc/sudo.conf
RUN chsh --shell /bin/zsh user
USER user
WORKDIR /home/user/
COPY install-zprezto.sh /home/user/
COPY entry.py /usr/local/bin/
RUN /home/user/install-zprezto.sh && rm install-zprezto.sh
VOLUME /home/user/
EXPOSE 9999/TCP
ENTRYPOINT ["/usr/bin/dumb-init", "/usr/local/bin/entry.py"]
CMD []
