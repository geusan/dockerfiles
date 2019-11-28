# Django 배포하기

이 레포는 기본 서버를 포함하고 있다.
Debug 모드로 실행하지만, Allowed Hosts 목록에 기본 elasticbeantalk url이 없어서 접속시 오류가 발생한다. 배포시 수정후 배포하면 좋겠다.


```bash
  # eb 초기화
  eb init
  # 최초 배포(eb앱 생성)
  eb create
  # 재배포
  eb deploy
  # 배포된 url로 입력해보기
  eb open
  # eb 콘솔 가기
  eb console
  # 앱 삭제
  eb terminate
```
