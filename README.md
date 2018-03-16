# flowEdu-dev
flowEdu-dev
#flowEdu-dev
# flowEdu



### js, css파일 수정시 유의 사항
js는 babel(ecma2015+ 문법)로, css는 scss 작성 후 webpack이라는 번들러로 번들링 합니다.
따라서 일부 js와 css 파일을 편잡할 때는 환경 설정이 필요합니다.

#### node, 글로벌 패키지 설치

* node가 글로벌로 설치 되어 있지 않다면 설치 (https://nodejs.org/ko/) LTS버젼 권장
* webpack 패키지 글로벌로 설치
    ```
    $ npm i -g webpack  
        
    ```
#### flowedu 프로젝트에 필요한 npm 설치하기
* 프로젝트 디랙토리 경로에서 npm(node package modules)을 설치합니다. 명령어는 아래와 같습니다
    ```
    $ npm i
    ```

#### webpack 번들링 사용하기
* 프로젝트 디랙토리 경로에서 다음 명령어로 js, css를 번들링 할 수 있습니다.
    ```
    $ webpack //번들링 
    $ webpack -w //번들링 & watching (파일 변경사항을 와칭함)
    $ webpack -p //minify하여 번들링. 실 배포시 사용
    ```

