FROM python:3

##########################################################
# set timezone
##########################################################
ENV TZ="/usr/share/zoneinfo/Asia/Seoul"
ENV PYTHONUNBUFFERED 1

ARG PROJECT_DIR="/path/to/project"

##########################################################
# install dependencies via pip
##########################################################
COPY requirements.txt requirements.txt
RUN pip install --upgrade pip && pip install -r requirements.txt

##########################################################
# set working directory
##########################################################
WORKDIR ${PROJECT_DIR}

##########################################################
# add proejct files
##########################################################
COPY . $PROJECT_DIR

##########################################################
# expose port for single container(Elastic Beanstalk)
##########################################################
EXPOSE 80

##########################################################
# command
##########################################################
CMD ["python", "manage.py", "runserver", "0.0.0.0:80"]
