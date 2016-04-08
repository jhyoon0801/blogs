+++
date = "2016-03-25T05:18:14Z"
draft = true
title = "summary to use git"
tags = ["vcs", "scm"]
categories = ["tools"]
+++

### Git 사용 방법 정리

Git의 기초 내용 정리와 사용하다 자주 까먹는 내용을 정리해 보자

-------------

#### 기존 VCS와 차이점
기존 VCS와 Git의 차이점은 다음과 같다.
<br>
##### **CVSC**
CVS, Subversion, Perforce, Bazaar 등의 시스템은 파일의 집합으로정보를 관리하고, 각 파일의 **변화**를 다음 그림 처럼 시간순으로 관리한다

![enter image description here](https://lh3.googleusercontent.com/-fNVALfocMUo/VviZqTUbhsI/AAAAAAAAAD8/VN9tL2TnCh4lROCZ3E_mAaFsJOUKaihZg/s0/1.png "CVCS_방식.png")

<br>


##### **Git**
Git은 CVCS와는 다르게 파일 시스템의 Snapshot과 같은 데이터를 저장한다( 크기가 아주 작음 )

![DVCS 방식](https://lh3.googleusercontent.com/--uGWmtZSfbQ/VviamZBVSnI/AAAAAAAAAEI/hx42b1ae-_U_Z3zuWsftuEJmeqYJR9fxQ/s0/1.png "DVCS_방식.png")



Git은 파일이 존재하는 그 순간을 중요하게 여기며, 파일이 달라지지 않으면 성능을 위해 파일을 새롭게 저장하지 않고, 단지 이전 상태의 파일에 대한 링크만 저장한다

<br>

-------------
### **Branches**
Git은 다른 VCS와 비교하여 Branches에 대한 강점이 많다. Git의 Branche 특징과 강점들을 살펴보자.
<br>
#### Git의 Branches
Git은 commit이 발생하면 해당 snapshot에 대한 포인터, 저자나 commit 메세지 같은 메터데이터, 이전 commit에 대한 포인터 등을 포함하는 **commit object**를 저장한다.
최초 커밋을 제외한 commit object에는 이전 commit에 대한 포인터를 가지고 있기 때문에 변경된 사항을 파악할 수 있다. Branches를 합친 Merge commit object 같은 경우에는 이전 commit 포인터를 여러 개 갖는다.

Git의 branche는 commit 사이를 이동하는 어떤 **포인터**로 이해하면 이해가 쉽다. 최초의 commit이 발생하면 Git은기본적으로 master라는 이름의 branche를 만들고, 가장 마지막 commit을 가리키게 한다.

> $git branche `<branche 이름>`

위의 명령어를 통해 새로운 branche를 생성할 수 있고, 새로 만든 branche는 작업하고 있던 마지막 commit을 가리킨다. 또한 Git은 'HEAD'라는 특수한 포인터를 갖는다. 이 특수한 포인터는 지금 작업하고 있는 로컬 branche를 가리킨다. 위의 명령을 통해 branche를 새롭게 생성하더라도 'HEAD'는 원래 가리키고 있던 branche를 여전히 가리킨다. 작업 branche를 옮기기 위해서는 다음 명령을 사용한다.

> $git checkout `<branche 이름>`


checkout 명령은 해당 branche로 이동하기 위하여 현재의 working directory에 파일들을 추가 및 삭제, 수정하여 변경을 원하는 snapshot으로 되돌려 놓는다.

Git에서의 branche는 SHA-1 체크섬 파일에 불과하기 때문에 새로운 branche를 만든다는 것은 41바이트의 크기(40바이트 체크섬 + 줄바꿈) 파일을 하나 만드는 것 뿐이다. 이는 branche 생성 시 모든 소스 코드를 복사하는 다른 VCS와는 확연히 비교되며, 효율적인 측면에서 Git이 강점을 갖는 부분이다.

 > **주의 :** checkout을 통해서 branche를 이동할 때는 커밋하지 않은 파일의 충돌 문제가 발생할 수 있기 때문에 working directory를 정리하고 checkout 작업을 수행한다.

<br>
#### Git의 Merge
branche를 생성하여 작업하고, 변경된 내용을 하나로 합치기 위하여 Merge를 수행한다. Merge 명령은 다음과 같다.

> $git merge `<branche 이름>`

위의 명령을 수행하면 현재 작업 중인 branche에 명령에서 지정한 branche를 Merge 한다.(Merge 수행 후 현재 작업 중인 branche는 Merge된 결과의 새로운 snapshot을 가리킨다) Git은 Merge할 각 branche가 가리키는 두 개의 snapshot과 공통 조상 snapshot을 사용하여 3-way Merge를 진행한다. ( *참고 :  Fast Forward ) Merge를 수행하면 Merge 결과인 나타내는 새로운 snapshot이 생성되며(commit 및 새로운 snapshot이 생성) 이를 Merge commit이라고 한다. Merge 완료 후 삭제는 다음 명령을 통해 수행한다.

> $git branch -d `<branche 이름>`

각 branche에서 파일의 동일한 부분을 수정하여 Merge가 실패하면, Git은 충돌 메세지를 출력해준다. 이 내용은 git status 명령을 통해 어느 시점에서든 확인할 수 있다. 충돌을 해결한 후 merge tool을 사용하여 충돌 파일을 Staging Area에 등록하고, 사용자가 commit을 진행하면 commit 메세지에는 충돌에 관련한 내용이 자동으로 삽입된다.

<br>

#### Branche workflow
Git에서의 branche workflow에 대한 내용을 이해하자
<br>
##### Long-Running branche
장기간에 걸쳐 프로젝트를 진행할 때, 배포했거나 배포할 코드들만 master branche에 Merge해서 안정 버전의 코드만 master branche에 두고, 개발을 위해서 develop이나 next라는 branche를 사용한다. develop이나 next는 충분한 테스트를 거쳐 안정성을 검증한 후 master에 Merge한다. 또한 규모가 큰 프로젝트에서는 propsed 혹은 pu(proposed updates)라는 중간 단계의 branche를 생성하고 개발중이고 테스트를 거쳤지만 아직 master에는 Merge하지 않는 단계의 버전을 임시 저장하는 workflow를 생각할 수 있다.
<br>

##### Topic branche
Topic branhce는 프로젝트의 크기에 상관없이 사용되며 어떤 한 가지 주제나 작업을 위해 만든 짧은 호흡의 branche를 의미한다. 이는 Git branche의 가벼움 이라는 장점을 이용한 것이다.
<br>

#### 리모트 branche
리모트 branche란 리모트 저장소에 있는 branche를 의미한다. 이는 리모트 저장소에서 마지막으로 데이터를 가져온 시점의 branche 상태를 알려주는 책갈피라고 볼 수 있다. 따라서 리모트 branche는 리모트 저장소를 fetch 하기 전까지는 변하지 않는다.(단, fetch를 진행하여도 리모트 저장소에 수정이 있을 경우에만 변경)
리모트 branche의 단축 이름은 (remote)/(branche) 형식으로 설정된다. 

##### Push 하기
로컬의 branche를 서버로 push하기 위해서는 권한이 필요하고, 로컬 저장소의 branche는 자동으로 리모트 저장소에 전송되지 않기 때문에 사용자가 명시적으로 push를 수행해야 한다.  push는 다음의 명령을 사용하여 수행한다.

> $git push `<remote>` `<local-branche>`:`<remote-branche>`

> $git push `<remote>` `<branche>` => 간단히 이렇게 사용 가능

리모트 저장소를 fetch하여 새로운 branche를 가져오더라도, 이는 수정하지 못하는 branche이다. 이 새로운 branche를 사용하여 작업을 하기 위해선 로컬에 새로운 branche를 생성하거나, 기존 로컬 branche에 Merge를 진행해야 함을 주의하자.
<br>


##### branche tracking 및 삭제
바로 위에서 리모트 저장소에 push를 할 때, 그리고 새로운 branche를 fetch하였을 때 사용자가 수동으로 신경써야할 사항이 있었다.(push 시 파라미터 입력 / fetch 후 로컬 branche 생성 혹은 Merge) 
하지만 branche tracking을 사용하면, 리모트 branche와 로컬 branche를 연결시켜주고, 그 이후의 push나 pull 명령을 통해 추가 파라미터를 입력하지 않고 원하는 동작을 수행할 수 있게 해준다. Git은 서버로부터 Clone을 수행할 경우 master branhce에 대한 tracking을 자동으로 수행한다. 추가 다른 branche에 대한 tracking을 하기 위해서는 다음 명령을 사용한다.

> $git checkout `--track` `<branche>` `<remotename>`/`<branche>`

협업 완료 후 리모트 branche를 삭제하기 위해서는 다음 명령을 사용한다.

> $git push `<remote>` :`<remote-branche>`

위 명령을 수행하면 리모트 저장소의 branche를 삭제할 수 있고, 이는 '로컬에서 빈 내용을 리모트 branche에 채워 넣어라'로 쉽게 이해할 수 있다.
<br>

#### Rebase 
Git에서 branche를 합치는 방법은 Merge와 Rebase 두 가지가 있다. Rebase의 특징을 알아보자.
##### Git의 rebase
Rebase는 Merge와 비슷한 결과를 만드는 방식으로, 동작 방식은 다음과 같다. 
![enter image description here](https://lh3.googleusercontent.com/-2N9L6A_VIWA/Vv3job8SNWI/AAAAAAAAAFE/5qcm3r59heg-kd1s3Vna9KjRaAe_TOB5g/s0/rebase.png "rebase.png")

두 branche(C3, C4)가 나뉘기 전인 공통 commit(C2)로 이동하고 나서, 그 commit부터 지금 Checkout한 branche가 가리키는 commit까지 diff를 차례대로 만들어 이를 임시저장한다. 그리고 이 변화부분을 taget branche에 차례대로 적용한다. 그리고 그 target branche를 Merge하여하여 Fast-forward 시킨다. Rebase의 명령은 다음과 같다.

> $git rebase `<target-branche>` `<source-branche>`

> $git checkout `<target-branche>`

> $git merge `<source-branche>`

Rebase는 branche의 변경사항을 순서대로 다른 branche에 적용하면서 합치고,  Merge의 경우는 두 branche의 최종 결과만을 가지고 합친다. Rebase를 사용하면 commit 히스토리도 반영되기 때문에, 리모트 branche에 commit을 깔끔하게 적용하고 싶을 때 사용된다. 
<br>

##### Rebase 사용 시 주의 사항
Rebase는 장점이 많은 기능이지만 다음 내용은 정말 주의하여야 한다.
**이미 공개 저장소에 Push한 commit을 Rebase 하지 마라**
새로운 커밋을 리모트 저장소에 Push하고, 이를 동료가 Pull하여 작업을 하는 상황을 생각해보자. 이미 commit된 내용을 rebase를 사용하여 push해 버리면 brance구조의 변경이 일어나고, 당신의 동료는 이 내용을 자신의 작업 branche에 Merge를 하고 push해야한다. 이는 동료의 push 후 당신이 pull할 때도 동료의 push로 인한 변경 내용에 대해 당신은 다시 한 번 Merge를 진행해야 하는 엄청나게 번거로운 일들이 발생한다. 따라서 위의 주의 사항을 어길 시 당신은 협업하는 동료에게 엄청난 욕을 먹을 수 있다. 

-------------

### Git 환경 설정 하기

Git 설치 후 사용 환경 설정을 진행해야 한다. 이는 최초 1회만 진행하면 되며, 설치된 Git의 버전을 업그레이드하더라도 기존 설정이 유지된다. 

 - /etc/gitconfig : 시스템의 **모든 사용자**와 **모든 저장소**에 적용되는 설정. git config  `--`system 옵션 사용
 - ~/.gitconfig : **특정 사용자**에게만 적용되는 설정. git config `--`global 옵션 사용
 - .git/config : 이 파일은 Git Directory 내에 있고, **특정 저장소**에만 적용된다. 

각 설정의 우선순위는 위의 정리된 항목의 **역순**이다. ( .git/config > ~/.gitconfig > /etc/gitconfig )

다음 명령을 통해 설정 내용을 확인할 수 있다.

> $git config `--`list

---------------

### Git 사용 방법 정리


#### Git 저장소 만들기
Git저장소를 만드는 방법은 두 가지 이며, 기존에 있는 프로젝트에 Git repository를 만드는 방법과 다른 서버의 Git repository를 clone 하는 방법이 있다.
<br>
#### 1. 이미 있는 디렉토리에 새 저장소 만들기
추가하려는 디렉토리로 이동하여 다음 명령을 실행한다.

> $ git init

위 명령은 .git이라는 하위디렉토리를 만들며, 디렉토리에는 저장소를 이루는 뼈대가 있는 파일(Skeleton)이 들어 있다.
이 후 파일들의 버전 관리를 위하여 저장소에 파일 추가, 커밋 등을 진행 한다.

> $ git add *.go
> 
> $ git add README
> 
> $ git commit -m 'initial project version'


<br>
#### 2. 이미 있는 저장소를 clone하기

다른 프로젝트에 contribute하거나 Git 저장소를 복사할 때 사용된다. 다음은 예제이다.

> $git clone git://github.com/schacon/grit.git mygrit

Git은 git:// 프로토콜 이외에도 http(s)://나 user@server:/path.git 처럼 ssh도 사용할 수 있다.

---------------
#### 파일 상태와 라이프 사이클

작업 디렉토리의 모든 파일은 Tracked(관리대상)과 Untracked(비관리대상)으로 나눌 수 있다. Tracked 파일은 이미 snapshot에 포함되 있던 파일을 나타낸다. 다음 그림은 파일의 라이프 사이클을 나타낸다.

![enter image description here](https://lh3.googleusercontent.com/-NvvfqOEHB4o/Vvi6IyWNUtI/AAAAAAAAAEw/5z-Y4r8dTM43oxqV0KV-cqfeI9EiD65wA/s0/1.png "git_file_life_cycle.png")


<br>
commit 수행 시 -a 옵션을 줄 경우 Tracked 된 파일 중 수정된 모든 파일을 commit 한다. -a 옵션을 주지 않을 경우 staging area에 등록되어 있지 않은 파일은 장소에 반영되지 않음을 유의하자. commit을 수행할 때 -m 옵션으로 commit 메세지를 입력할 수 있고, 이를 생략할 경우 default 편집기가 실행되며 commit 메세지를 입력하게 한다. 다음 명령을 통해 commit을 수행할 수 있다.

    $git commit -m <commit message>



<br>

_____________________
#### **Git 명령어 정리**
<br>
##### 상태 조회

> $git status


git repository의 상태를 확인한다. Tracked, Untracked, modified 등의 git repository 내의 파일들의 상태를 확인한다. 'Changes to be committed'에 속한 파일들은 staged 상태라는 것을 의미한다.

<br>

##### 새 파일 추적 및 staged 변경
 
> $git add `<file or directory>`


Untracked 파일(디렉토리)을 Tracked 파일(디렉토리)로 만들기 위해 사용하고, 이미 Tracked된 파일(디렉토리)이 modified상태일 때 staged로 변경하기 위해 사용된다.

 > **주의 :** modified된 파일을 staged로 변경 한 후 commit 전에 해당 파일을 다시 수정한다면, git add를 **한 번 더** 해줘야 한다.

<br>


##### 파일의 변경 내용 확인
 
> $git diff 


**작업 디렉토리**와 **Staging Area**에 있는 수정된 파일을 비교한다. 즉 파일 수정 후 staged로 만든 후, 곧 바로 diff 명령을 수행하면 작업 디렉토리와 Staging Area에 있는 파일의 내용이 동일하기 때문에 아무것도 출력되지 않는다. 

커밋 전 **Staging Area**와 **저장소**의 내용을 비교하기 위해서는 `--staged` 옵션을 사용한다.

<br>

##### 커밋 하기
> $git commit -m `<commit message>`


 Staging Area에 있는 파일들만을 저장소에 commit 한다. (Staging Area에 있는 파일 뿐 아니라 수정된 모든 Tracked 파일을 commit 하기 위해서는 -a 옵션을 사용한다.) 

-v 옵션을 사용하면, diff 내용도 commit message로 출력된다. 

<br>

##### 파일 삭제
> $git rm `<file or directory>`


 Git 저장소의 파일 및 로컬 파일도 함께 삭제 된다. Git 저장소의 파일만 삭제하기 위해선 `--`cached 옵션을 사용한다. file-glob 패턴을 사용하여 여러 파일을 삭제할 수 있다. ( ex] *.log )



<br>

##### 파일 이름 변경
> $git mv `<old_file_name>` `<new_file_name>`


파일 이름을 변경하면 변경된 내용이 Staging Area에 저장된다. Git 저장소에 반영하기 위해서는 commit이 필요함. ( 내부적으로 mv -> git rm -> git add 의 3단계가 진행된다. )


<br>

##### commit 히스토리
> $git log


commit 히스토리를 최신 순서로 정렬하여 출력한다.  Git은 pager류의 프로그램을 거쳐서 조회 내용을 출력하기 때문에 모든 commit 히스토리를 출력하지는 않는다. 여러 옵션을 사용할 수 있고, 다음은 자주 사용되는 각 옵션에 대한 간략한 설명이다.

| 옵션 | 설명 |
| :--- | :--- |
| -p | 각 commit의 diff 결과를 함께 보여준다 |
| `--stat` | 각 commit의 통계 정보(수정된 파일, 수정된 파일 개수, 변경된 라인 수 등)을 함께 보여준다 |
| `--pretty` | 지정된 포맷으로 출력한다.(ex] oneline, format:"%h - %an, %ar %s" 등 )
| 기타 필터 | `--since`, `--after`, `--untile`, `--before`, `--author`, `--comiter` 등의 옵션을 사용할 수 있다 |


<br> 

##### commit 수정
> $git commit `--amend` 


이미 commit 최근 내용을 수정한다. Staging Area의 내용으로 수정하며, 만약 Staging Area에 수정 사항이 없다면 commit 메세지만 수정한다.


<br>

##### Staging Area 수정
> $git reset HEAD `<file>` 


현재 Staging Area에 추가된 파일을 unstaged로 변경한다.

<br>

##### 파일 되돌리기
> $git checkout `--` `<file>` 



modified상태의 파일을 수정 전으로 되돌린다.

<br>

##### 리모트 저장소 확인
> $git remote 


현재 프로젝트와 연관된 remote list를 조회할 수 있다. -v 옵션을 사용하여 URL도 함께 확인 가능하다.

<br>

##### 리모트 저장소 추가
> $git remote add `<리모트 저장소 단축 이름>` `<URL>` 


현재 프로젝트에 새로운 리모트 저장소를 추가한다. 


<br>

##### 리모트 저장소 pull, fetch
> $git fetch(pull) `<리모트 저장소 단축 이름>`


해당 명령을 통해 지정된 리모트 저장소에서 로컬에는 없는 데이터를 가져온다. fetch 명령의 경우 리모트 저장소의 데이터를 가져온 후 merge를 진행하지 않고, pull은 진행한다는 차이가 있다.

<br>

##### 리모트 저장소 push
> $git push `<리모트 저장소 단축 이름>` `<로컬 브랜치>` 


 단축 이름에 해당하는 리모트 저장소에 지정된 로컬 브랜치를 push 한다. 리모트 저장소에 push가 있었을 경우, merge를 먼저 진행 후 push를 진행해야 한다.(충돌의 위험성)

<br>

##### 리모트 저장소 정보 확인
> $git remote show `<리모트 저장소 단축 이름>`





<br>

##### 리모트 저장소 이름 변경
> $git remote rename `<리모트 저장소 이전 단축 이름>` `<리모트 저장소 변경 단축 이름>`

<br>

##### 리모트 저장소 삭제
> $git remote rm `<리모트 저장소 단축 이름>`


<br>

##### Tag 조회
> $git tag


이미 만들어져 있는 tag를 조회할 수 있다. -l 옵션으로 검색 패턴을 사용할 수 있다.

<br>

> $git show `<version>`


특정 version의 tag에 대한 상세 내용을 확인할 수 있다.

<br>

##### Annotated Tag 붙이기
> $git tag -a `<version>` -m `<메세지>`


Annotated Tag는 Git 데이터베이스에 Tag를 만든 사람의 이름, 이메일, Tag 생성 날짜, Tag 메세지를 함께 생성한다. GPG(GNU Privacy Guard)로 서명할 수 있고, -a 대신 -s 옵션을 사용한다.

<br>

##### Lightweight Tag 붙이기
> $git tag `<version>` 


-a, -s, -m 옵션을 사용하지 않고, 단순히 커밋 정보(체크섬)만 저장한다.


<br>

##### snapshot tagging
> $git tag -a `<verson>` `<체크섬>`


이미 커밋된 이전 버전의 snapshot에 tagging할 수 있다.

<br>

##### push Tag 
> $git push `<리모트 저장소 단축 이름>` `<tag version>`


push 명령은 리모트 저장소에 자동으로 Tag를 전송하지 않는다. `--tags` 옵션을 사용하면, 리모트 저장소에 없는 모든 Tag 정보를 전송한다.


<br>

##### Git Alias
	ex) $git config --global alias.co checkout
	    $git config --global alias.unstage 'reset HEAD --'


위 예시를 참고하여 Git 명령어에 alias를 생성할 수 있다.

<br>

##### Branch 조회
> $git branch 

현재 프로젝트의 branche list를 조회한다. -v 옵션을 사용하면 각 branche의 마지막 commit 메세지도 함께 보여준다. `--merged`와 `--no-merged`옵션을 사용하면 현재 Checkout한 branche를 기준으로 Merge 혹은 Merge가 되지 않았는지 필터링해 볼 수 있다.

<br>

##### Branch 생성
> $git branche `<branche 이름>`

새로운 branche를 생성한다. 하지만 HEAD는 새로 생성한 branche가 아닌 기존의 branche를 가리킨다.

<br>
##### Branche 이동( HEAD 포인터 이동 )
> $git checkout `<branche 이름>`

branche간 이동을 수행한다. 이는 곧 HEAD 포인터의 이동을 뜻한다.  -b 옵션을 추가하면 새로운 branche를 생성한 후 새롭게 생성된 branche로 HEAD 포인터를 이동하도록 한다. 

<br>

##### Branche 삭제
> $git branche -d `<branche 이름>`

branche를 삭제한다. Merge 하지 않은 Branche를 삭제하기 위해서는 -d 대신 -D를 사용한다.

<br>
##### Merge
> $git merge `<branche 이름>`

HEAD가 가리키는 현재 branche에 지정한 branche를 3-Way-Merge한다.
