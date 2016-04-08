+++
date = "2016-04-01T14:00:00Z"
draft = true
title = "Spring MVC 기초 - 1"
categories = ["spring","spring-mvc","progmmaing"]
+++

### Spring MVC 기초 - 1

Spring MVC에 관련한 기초 내용을 정리해 나가자.

-------------
<br>

#### web application 개발 관련 기본 정리
##### web server란?
HTTP 프로토콜을 사용하는 클라이언트로부터의 요청을 받아서, HTML(그림, CSS, 자바스트립트 등의 리소스를 포함한) 문서와 같은 리소스를 반환하는 컴퓨터 프로그램이다.
<br>

##### web application이란?
정적 데이터(정적 HTML 문서 등)가 아니라, 각각의 요청에 따라 동적 데이터(동적 HTML문서 등)를 생성하는 프로그램이며, 이 프로그램의 동작은 web server의 호출에 의해 수행된다. web application은 web server와는 별개의 프로세스로도 동작할 수 있고, 동일한 프로세스로도 동작할 수 있다.
<br>

##### web container란?
servlet container라고도 불리며 웹 서버 안에서 servlet과 JSP를 지원하는 역할을 맡는 컴포넌트이다. web container는 servlet들의 lifecycle을 관리한다. URL과 이를 처리할 servlet의 mapping과 request 전달 등을 수행한다.
<br>

##### servlet이란?
java를 기반으로 하는 web application 프로그래밍 기술이다. web application을 작성한 클래스를 servlet 클래스라고 하며, 이 클래스는 javax.servlet.Servlet 인터페이스를 구현한 클래스이다. servlet은 web container가 servlet 클래스를 이용하여 객체를 생성하고, 그 객체를 초기화하여 웹 서비스를 할 수 있는 상태까지 만든 객체를 의미한다. 
<br>

##### web application deployment descriptor
WAS의 web application 디렉터리의 WEB-INF 서브디렉터리 아래에 있는 web.xml 파일을 의미한다. 해당 파일은 web applcation이 시작될 때 메모리에 로딩되며, 내용이 수정될 경우 web applicaton을 재실행해야 한다. WADD 파일에는 ServletContext의 초기 파라미터, Session의 유효시간 설정, Servlet/JSP에 대한 정의, Servlet/JSP 매핑, Mime Type 매핑, Welcome File list, Error Pages 처리, 리스너/필터, 보안 설정 등에 대한 web application과 관련된 내용이 작성된다.
<br>

#### SpringMVC의 bootstrap
`-` servlet container(3.0+)가 실행될 때, SpringServletContainerInitializer를 bootstapping 시키고, SpringServletContainerInitializer는 WebApplicationInitializer를 implements한 class를 찾아내어 onStartup()를 수행한다.

`-` SpringServeltContainerInitializer는 Servlet 3.0의 ServletContainerInitializer를 impelements한 class이다. 이 클래스는 WebApplicationInitializer를 이용하여 web application의 설정 정보를 java code 기반으로 작성한다.

`-` WebApplicationInitializer는 servlet 3.0+ 스펙에서 ServletContext를 기존의 WADD(web.xml)를 통해 설정하는 방법 이외에 programmatically하게 지원하는 interface이다.

`-` ContextLoaderListener와 DispatcherServlet은 각각 WebApplicationContext(WAC)를 생성하는데, ContextLoaderListener가 생성한 WAC는 root-context가 되고, DispatcherServlet이 생성한 인스턴스는 root-context를 부모로 하는 child-context가 된다. child-context 들은 root-context의 bean을 사용할 수 있다.

<br>


#### ! Spring PUT 
Servlet specification에서 POST만 form field에 접근할 수 있도록 제한이 생김. 이를 위해 Spring에서는 HttpPutFormContentFilter를 도입함. 관련하여 주의하도록 하자.

참조 : http://m.blog.daum.net/rollin/8097064
<br>

#### Spring MVC 설정
Spring MVC의 java 기반 configuration은 @EnableWebMvc 어노테이션과 함께 WebMvcConfigurerAdapter 추상 class를 확장하여 기능을 추가할 method들만 override하여 구현한다. WebMvcConfigurerAdapter 추상 class는 WebMvcConfigurer 인터페이스를 구현한 추상 class이다.
<br>

