FROM muconsulting/ubuntu
MAINTAINER Sylvain Gibier <sylvain@munichconsulting.de>

# Install and configure Redis 2.8
RUN cd /tmp && \
    wget http://download.redis.io/releases/redis-2.8.19.tar.gz && \
    tar xzvf redis-2.8.19.tar.gz && \
    cd redis-2.8.19 && \
    make && \
    make install && \
    cp -f src/redis-sentinel /usr/local/bin && \
    mkdir -p /etc/redis && \
    cp -f *.conf /etc/redis && \
    sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf && \
    sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf && \
    sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \
    sed -i 's/^\(appendonly .*\)$/# \1\nappendonly yes/' /etc/redis/redis.conf && \
    sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf && \
    sed -i 's/^\(maxmemory-policy .*\)$/# \1\\nmaxmemory-policy allkeys-lru/' /etc/redis/redis.conf && \
    sed -i 's/^\(maxmemory .*\)$/# \1\\nmaxmemory 100mb/' /etc/redis/redis.conf && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add scripts
ADD scripts /scripts
RUN chmod +x /scripts/*.sh
RUN touch /.firstrun

# Command to run
CMD ["/scripts/run.sh"]

# Expose listen port
EXPOSE 6379

# Expose our data and configuration volumes
VOLUME ["/data", "/etc/redis"]
