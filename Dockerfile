FROM tensorflow/tensorflow:2.1.0-py3 AS unit3

MAINTAINER Denis Kamotsky "dkamotsky@gmail.com"

ENV PIP_DEFAULT_TIMEOUT 300

RUN apt-get update -y
RUN apt-get install -y vim less libhdf5-dev git # ruby libyajl2
#RUN gem install tiller

RUN pip uninstall -y tensorflow tensorflow-gpu
COPY lib/tensorflow-2.1.0-cp36-cp36m-linux_x86_64.whl /tmp/tensorflow-2.1.0-cp36-cp36m-linux_x86_64.whl
RUN pip install /tmp/tensorflow-2.1.0-cp36-cp36m-linux_x86_64.whl

# /app does not exist yet!
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt

ENV PYTHONPATH /app/src
ENV DISPLAY docker.for.win.localhost:0.0

EXPOSE 8888

WORKDIR /app

CMD ["sh", "-c", "echo 'Starting from local image...' && /app/scripts/launch.sh"]
