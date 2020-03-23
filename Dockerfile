FROM continuumio/anaconda3

RUN conda install jupyter
RUN conda install ipykernel
RUN pip install ipython-autotime
RUN conda install ipywidgets
RUN conda install sphinx
RUN jupyter nbextension install --py widgetsnbextension --user
RUN jupyter nbextension enable widgetsnbextension --user --py
RUN apt-get install -y python-numpy python-scipy python-pyfftw python-matplotlib 

RUN apt-get install -y \
make \
build-essential \
m4 \
libboost-dev \
libboost-thread-dev \
libboost-test-dev \
libboost-filesystem-dev \
cmake \
libfftw3-doc \
libfftw3-dev
                                                        



RUN conda create -n pypho-py37 python=3.7

RUN bash -c "source activate pypho-py37 && \
pip install \
numpy \
scipy \
matplotlib \
ipykernel \
sympy"
RUN bash -c "source activate pypho-py37 && \
conda install -c conda-forge pyfftw"


RUN conda create -n pypho-py27 python=2.7

RUN bash -c "source activate pypho-py27 && \
pip install \
numpy \
scipy \
matplotlib \
ipykernel \
sympy"
RUN bash -c "source activate pypho-py27 && \
conda install -c conda-forge pyfftw"


RUN conda env list



RUN git clone https://gitlab.lrz.de/hm-striegle/pypho.git
RUN wget http://www.fftw.org/fftw-3.3.8.tar.gz && \
tar -zxvf fftw-3.3.8.tar.gz && \
cd fftw-3.3.8 && \
./configure --enable-threads --enable-openmp && \
make && \
make install



RUN bash -c "source activate pypho-py37 && \
pip install Cython && \
cd pypho && \
python speedup.py build_ext --inplace"

RUN bash -c "source activate pypho-py27 && \
pip install Cython && \
cd pypho && \
python speedup.py build_ext --inplace"

RUN bash -c "source activate pypho-py37 && \
python -m ipykernel install --user --name=pypho-py37 && \
source activate pypho-py27 && \
python -m ipykernel install --user --name=pypho-py27"

RUN cd pypho && \
mkdir local


ENTRYPOINT bash -c "source activate pypho-py37 && cd pypho && jupyter notebook --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''"
