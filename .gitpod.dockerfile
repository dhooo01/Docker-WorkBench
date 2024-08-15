# Use OS Debian 12/ Debian Bookworm For Default OS
FROM debian:latest

# Set To noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Install Dependencies
RUN apt-get update && \
    apt-get upgrade -y
RUN apt-get install locales sudo python-is-python3 python3 git bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev tmux tmate openssh-server -y

# Installing Repo
RUN mkdir -p ~/.bin && \
    PATH="${HOME}/.bin:${PATH}" && \
    curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo && \
    chmod a+rx ~/.bin/repo

# Configuring User For Workspace
RUN useradd -m -s /bin/bash rvlpromaster && echo "rvlpromaster:rvlpromaster" | chpasswd && adduser rvlpromaster sudo

# Set Locale and localtime
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
RUN sudo locale-gen en_US.UTF-8
RUN sudo ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# Switch To rvlpromaster User
USER rvlpromaster
WORKDIR /home/rvlpromaster

# Customization Bash
RUN curl -s https://ohmyposh.dev/install.sh | bash
RUN curl -L https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/if_tea.omp.json -o /home/User123/.poshthemes/if_tea.omp.json
RUN echo 'eval "$(oh-my-posh init bash --config ~/.poshthemes/if_tea.omp.json)"' >> /home/rvlpromaster/.bashrc

# Start 
CMD ["bash"]

