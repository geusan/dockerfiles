# Docker와 배포하기

> 이 설명은 도커머신과 `ebcli`가 설치되어 있다는 가정하에 진행됩니다. [[ebcli 설치하기]](https://docs.aws.amazon.com/ko_kr/elasticbeanstalk/latest/dg/eb-cli3-install-advanced.html) 설치가 어려운 경우 도커머신이 있다면 ebcli.Dockerfile을 사용해보세요 설명은 아래쪽에 있습니다. 

도커 사용과 단일 컨테이너 배포에는 프로젝트 root 위치에 Dockerfile 하나만 있거나 Dockerrun.aws.json 가 함께 있어야한다.
Dockerrun.aws.json이 없는 경우에는 Dockerfile 내의 `EXPOSE` 명령어로 지정한 포트를 기본으로 라우팅 해준다. 없는 경우에는 기본 포트(?) 라서 도커 내의 서버에 연결을 못할 수 있으니까(뇌피셜). 명시해주도록 하자.

Dockerrun.aws.json을 사용하는 경우(example.Dockerrun.aws.json 파일 참조) 아래의 설정만 잘 해주면 문제가 없다.
```
  {
  "AWSEBDockerrunVersion": "1",
  "Ports": [
    {
      "ContainerPort": "CONTAINER_PORT", <= 컨테이너(서버의 포트)
      "HostPort": "HOST_PORT" <= 외부에서 접근할 포트
    }
  ]
}
```

1. Dockerfile 을 골라서 프로젝트에 위치 시킨다.
2. 도커 빌드 후에 잘 동작하는지 테스트 한다.
```bash
  # 도커 이미지 빌드
  docker build -t {tag_name} .

  # 빌드 된 이미지로 컨테이너 생성(옵션을 추가로 줘서 포트를 연결해야 연결이 가능하다.)
  docker run {tag_name}

  # 컨테이너 로그 보는 방법
  docker logs {container_name}

  # 컨테이너 내부 접속하는 방법
  docker exec -it {container_name} bash
```
3. eb를 이용하여 배포한다.
```bash
  # 최초 실행시
  eb init
  eb create
  
  # 초기화한 이후에 기존 앱 재배포
  eb deploy
```

## Django와 NodeJs 배포 예시가 추가되었다.
- [Django](./django)
- [NodejJs](./nodejs)


## ebcli.Dockerfile
윈도우 친구들도 도커만 있다면 eb 컨테이너를 만들어서 배포 환경을 사용할 수 있다.
```bash
# 도커 빌드
docker build -t ebcli -f ebcli.Dockerfile
# 컨테이너 실행
docker run -it --rm --entrypoint bash ebcli
# 컨테이너 접속후 eb 명령어 입력(최초 실행시 인증 정보가 필요하다. volume으로 로컬 컴퓨터의 파일을 연결하면 편하다.)
eb init
```

## 개발시에 유용할 수 있는 것
`docker-compose.yml` 데이터베이스 컨테이너와 서버 컨테이너를 동시에 올리고 연결하여 로컬내에서 서비스를 개발할 수 있는 환경을 구성할 수 있다. 실서버의 데이터를 건드리지 않고 유지보수를 하고싶을 때, 실서버의 데이터를 덤프를 떠서 실서버 데이터와 완전히 일치하는 로컬 디비를 올려서 테스트 및 개발을 하면 좋다.
