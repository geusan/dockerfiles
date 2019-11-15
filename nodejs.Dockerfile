FROM node:10

# timezone
ENV TZ="/usr/share/zoneinfo/Asia/Seoul"
ENV HOST 0.0.0.0

##########################################################
# set project path
##########################################################
ARG PROJECT_DIR=/path/to/project

##########################################################
# install dependencies
##########################################################
COPY package.json ${PROJECT_DIR}/package.json
COPY package-lock.json ${PROJECT_DIR}/package-lock.json

##########################################################
# set working directory
##########################################################
WORKDIR ${PROJECT_DIR}
RUN npm install

##########################################################
# move project files to project directory
##########################################################
COPY . ${PROJECT_DIR}

##########################################################
# expose port for single container(Elastic Beanstalk)
##########################################################
EXPOSE 3000

# command
CMD ["npm", "start"]
