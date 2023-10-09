mkdir -p /opt/datasense

DATASENSE_HOME=/opt/datasense

apt-get update -yq && apt-get install -yq --no-install-recommends \
bzip2 \
build-essential \
tabix \
cmake \
zlib1g-dev \
libbz2-dev \
liblzma-dev \
libncurses5-dev \
libncursesw5-dev \
vim \
less \
libcurl4-openssl-dev \
wget \
git \
tabix \
python3-pip \
python3-venv \
python3-dev \
pkg-config \
libboost-all-dev \
g++

apt autoclean -y && apt autoremove -y

cd /opt/datasense

SAMTOOLS_VERSION=1.15.1

wget https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 \
&& tar -xjf ${DATASENSE_HOME}/samtools-${SAMTOOLS_VERSION}.tar.bz2 -C ${DATASENSE_HOME} \
&& rm -rf samtools-${SAMTOOLS_VERSION}.tar.bz2 \
&& cd ${DATASENSE_HOME}/samtools-${SAMTOOLS_VERSION}/ \
&& ./configure \
&& make \
&& make install


wget https://github.com/vcftools/vcftools/releases/download/v0.1.16/vcftools-0.1.16.tar.gz \
&& tar xvzf vcftools-0.1.16.tar.gz \
&& rm -rf vcftools-0.1.16.tar.gz \
&& cd vcftools-0.1.16 \
&& ./configure \
&& make \
&& make install


WHATSHAP_VERSION=1.1
pip3 install --user whatshap
PATH="$HOME/.local/bin:${PATH}"

pip3 install pypgx

cd /tmp && mkdir tool && \
	git clone https://github.com/pezmaster31/bamtools && \
	cd bamtools && mkdir build && cd build && \
	cmake -DCMAKE_INSTALL_PREFIX=/tmp/tool/ -DBUILD_SHARED_LIBS=ON .. && \
	make && make install && \
	cd /tmp/tool/ && ln -s lib lib64


cd ${DATASENSE_HOME} && \
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
	bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3 && \
	/root/miniconda3/condabin/conda install -y -c bioconda bwa samtools picard mummer minimap2
PATH=$PATH:/root/miniconda3/bin


PICARD_VERSION=1.123
cd ${DATASENSE_HOME} && \
    wget https://github.com/broadinstitute/picard/releases/download/${PICARD_VERSION}/picard-tools-${PICARD_VERSION}.zip -O picard-tools-${PICARD_VERSION}.zip && \
    unzip picard-tools-${PICARD_VERSION}.zip && \
    rm -rf picard-tools-${PICARD_VERSION}.zip

${DATASENSE_HOME} && \
	mkdir HLA-LA HLA-LA/bin HLA-LA/src HLA-LA/obj HLA-LA/temp HLA-LA/working HLA-LA/graphs && \
	cd HLA-LA/src && git clone https://github.com/DiltheyLab/HLA-LA.git . && \
	make all BOOST_PATH=/usr/include/boost BAMTOOLS_PATH=/tmp/tool/
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/tmp/tool/lib64

PATH="/opt/datasense/HLA-LA/bin/:${PATH}"
PATH="/opt/datasense/HLA-LA/src/:${PATH}"

cp /Users/amaan.saifan/Documents/kube/new/next/samples/reference/paths.ini ${DATASENSE_HOME}/HLA-LA/src/


####   Old 




# export PATH="$HOME/.local/bin:${PATH}"

# pip3 install pypgx


# cd /tmp && mkdir tool && \
# 	git clone https://github.com/pezmaster31/bamtools && \
# 	cd bamtools && mkdir build && cd build && \
# 	cmake -DCMAKE_INSTALL_PREFIX=/tmp/tool/ -DBUILD_SHARED_LIBS=ON .. && \
# 	make && make install && \
# 	cd /tmp/tool/ && ln -s lib lib64



# wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
# 	bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3 && \
# 	/root/miniconda3/condabin/conda install -y -c bioconda bwa samtools picard mummer minimap2 pypgx

# export PATH=$PATH:/root/miniconda3/bin


# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/tmp/tool/lib64
# echo "Done" > /Users/amaan.saifan/Documents/kube/new/next/s.out




# #cd /Users/amaan.saifan/Documents/kube/new/next/samples/reference #&& \
# #	mkdir -p HLA-LA/bin HLA-LA/src HLA-LA/obj HLA-LA/temp HLA-LA/working  && \
# #	cd HLA-LA/src && git clone https://github.com/DiltheyLab/HLA-LA.git . && \
# #	make all BOOST_PATH=/usr/include/boost BAMTOOLS_PATH=/tmp/tool/
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/tmp/tool/lib64

# export PATH="/Users/amaan.saifan/Documents/kube/new/next/samples/referenceHLA-LA/bin/:${PATH}"
# export PATH="/Users/amaan.saifan/Documents/kube/new/next/samples/reference/HLA-LA/src/:${PATH}"

# cp /Users/amaan.saifan/Documents/kube/new/next/samples/reference/paths.ini /Users/amaan.saifan/Documents/kube/new/next/samples/reference/HLA-LA/src/
