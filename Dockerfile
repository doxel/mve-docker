FROM debian:buster-slim

ARG user=doxel
ARG debian_mirror=deb.debian.org

# setup system and get build dependencies
RUN useradd --create-home --shell /bin/bash $user \
 && sed -r -i -e s/deb.debian.org/$debian_mirror/ /etc/apt/sources.list \
 && apt-get update && apt-get install -y \
      build-essential \
      cmake \
      git \
      libpng-dev \
      libtiff5-dev \
      libjpeg62-turbo-dev \
      mesa-common-dev \
      libtbb-dev 

USER $user
ENV PATH $PATH:/home/$user/local/bin/

# clone build and install
WORKDIR /home/$user
RUN git clone \
      --single-branch \
      -b master \
      --recursive \
      https://github.com/simonfuhrmann/mve \
      src/mve \
 && git clone \
      --single-branch \
      -b master \
      --recursive \
      https://github.com/flanggut/smvs \
      src/smvs \
 && git clone \
      --single-branch \
      -b master \
      --recursive \
      https://github.com/mkazhdan/PoissonRecon \
      src/PoissonRecon \
 && git clone \
      --single-branch \
      -b master \
      --recursive \
      https://github.com/nmoehrle/mvs-texturing \
      src/mvs-texturing

RUN make -j $(nproc) -C src/mve \
 && export CXXFLAGS=-mpopcnt && make -j $(nproc) -C src/smvs && unset CXXFLAGS \
 && make -j $(nproc) -C src/PoissonRecon \
 && cd src/mvs-texturing \
 && mkdir build \
 && cd build \
 && cmake -DCMAKE_BUILD_TYPE=Release .. \
 && make -j $(nproc)  \
 && cd \
 && mkdir bin \
 && find \
      src/mve/apps \
      src/smvs/app \
      src/PoissonRecon/Bin \
      src/mvs-texturing/build/apps \
      -type f -executable -exec mv {} bin \; \
 && rm src -rf

ENV PATH="/home/$user/bin:$PATH"

CMD ["/bin/bash", "-l"]
