> 완벽한 IT 인프라 구축을 위한 Docker 2판

**시스템 이용 형태**
1. on-premises
    - 자사에서 데이터센터를 보유하고 시스템 구축부터 운용까지 모두 수행하는 형태
2. public cloud
    - 제공할 서비스에 따라 IaaS/PaaS/SaaS
    - 시스템 기반 부분을 이용하는 서비스는 IaaS
    - aws, gcp, ...
3. private cloud

**네트워크 주소**
1. MAC 주소(물리 주소/이더넷 주소)
    - 48비트 주소. 앞 24비트는 네트워크 부품의 제조업체를 식별, 뒤 24비트는 각 제조업체가 중복되지 않도록 할당
    - 각 NIC(Network Interface Controller)는 고유한 MAC 주소를 가짐
    - 16진수로 표기하며, 앞에서 2바이트씩 구분하여 표시
    - OSI 참조 모델의 2계층인 데이터 링크 계층에서 사용
2. IP 주소

**OSI 참조 모델**
1. 물리 계층: 통신 장비의 물리적 및 전기적 특성을 규정
2. 데이터 링크 계층: MAC 주소로 데이터를 전송
3. 네트워크 계층: 서로 다른 네트워크 간에 통신
4. 전송 계층: TCP, UDP
5. 세션 계층: 커넥션 확인 타이밍이나 데이터 전송 타이밍을 규제
6. 표현 계층: 데이터 저장 형식이나 압축, 문자 인코등 같은 데이터의 표현 형식을 규정
7. 응용 계층: HTTP, DNS, SMTP, SSH, ...

**방화벽**
- 패킷 필터형
    - 통과하는 packet을 port나 ip를 바탕으로 filtering 하는 방법
    - rule을 정하고, 그 rule에 기초하여 packet을 filtering
    - 이러한 rule을 ACL(access control list)
- 어플리케이션 게이트웨형
    - 어플리케이션 프로토콜 레벨에서 외부와의 통신을 대체 제어하는 것
    - 일반전으로 proxy server라고 부름
    
**Linux**
- 1991년 핀란드의 Linus Torvalds가 개발한 Unix 호환 서버 OS

**Linux kernel**
- OS에 코어가 되는 부분.
- 메모리 관리, 파일 시스템, 프로세스 관리, 디바이스 제어 등 OS로서 하드웨어나 애플리케이션 소프트웨어를 제어하기 위한 기본적 기능을 갖고 있는 소프트웨어
- Andriod는 Linux kernel 상에 구축되어 있음
- 디바이스 관리
    - 하드웨어를 디바이스 드라이버라는 소프트웨어를 이용하여 제어
- 프로세스 관리
    - 명령을 실행할 때 해당 프로그램 파일이 쓰여 있는 내용을 읽어 들여 메모리 상에 전개한 후 메모리 상의 프로그램(프로세스)을 실행
    - 프로세스에 PID라는 식별자를 붙여 관리
- 메모리 관리
    - 실행이 끝난 프로세스가 사용하던 메모리 영역을 해제하는 것도 커널의 역할
    - 물리적은 용량을 초과할 경우 하드디스크와 같은 보조기억장치에 가상 메모리 영역(swap)을 만듦
    - kernel은 메모리에 전개된 이용 빈도가 낮은 데이터를 swap으로 swap-out하고, swap 상의 데이터를 메모리로 가져오는 swap-in 함
- Kernel을 조작하기 위해서는 Shell을 사용
    - 사용자가 내린 명령을 커맨드로 받아, 그것을 Linux kernel에 전달

**Linux 배포판**
- kernel과 함께 각종 커맨드, 라이브러리, 애플리케이션 포함
- Debian 계열
    - Debian
    - KNOPPIX
    - Ubuntu: 풍부한 데스크톱 환경을 제공하고 있는 것이 특징
- Red Hat 계열
    - Fedora
    - Red Hat Enterprise Linux: Red Hat이 제공하는 상용 Linux, RHEL로도 불림
    - CentOS: RHEL과 완전히 호환을 지향하는 Linux
    - Vine Linix
- Slackware 계열
    - openSUSE
    - SUSE Linux Enterprise
- 기타
    - Arch Linux
    - Gentoo Linux
    
**Linux File System**
- Kernel이 갖고 있는 중요한 기능으로 파일 시스템이 있음
- VFS(Virtual File System)라는 장치를 사용하여 데이터에 대한 투과 액세스를 가능하게 하고 있음
- VFS는 각 디바이스를 file로 취급하는 것이 특징

|이름|설명|
|---|---|
|ext2|- Linux OS에서 널리 이용되던 file system.<br/>- 초기 ext 파일 시스템을 확장했기 때문에 ext2|
|ext3|- Linux에서 주로 사용되는 file system.<br/>- Linux kernel 2.4.16 부터 사용 가능|
|ext4|- ext3의 후속 저널링 file system.<br/>- storage를 1EiB까지 지원.<br/>- 파일의 단편화를 방지하는 extent file writing이라는 시스템이 도입|
|tmpfs|- Unix 계열 OS에서 임시 파일을 위한 장치<br/>- tmpfs는 file system으로 mount되지만 HD과 같은 영구성을 갖고 있는 기억장치 대신 메모리상에 저장 가능<br/>- /tmp에 저장한 파일의 실체는 메모리상에 저장되어 있기 때문에 서버를 재시작하면 파일은 모두 삭제|
|UnionFS|- 여러 개의 디렉토리를 겹쳐서 하나의 디렉토리로 취급할 수 있는 file system.|
|ISO-9660|- 1988년에 ISO에서 표준화된 CD-ROM의 file system.<br/>- Linux 뿐만 아니라 다양한 OS에서 똑같은 CD-ROM을 읽어 들일 수 있음|
|NFS|- RFC 1094, RFC 1813, RFC 3530 등으로 정의되어 Unix에서 이용하는 분산 파일 시스템 및 그 프로토콜|

**Linux 디렉토리 구성**
- Linux 디렉토리 목록은 FHS(Filesystem Hierarchy Standard)라는 규격에 의해 표준화 됨
```
<root>
├── /bin   기본 command
├── /boot  files for OS booting
├── /dev   device files
├── /etc   config files
├── /home  user home directory
├── /lib   shared library
├── /mnt   file system의 mount point용 directory
├── /media CD/DVD-ROM의 mount point
├── /opt   application software package
├── /proc  kernel, process에 관한 정보
├── /root  root용 home directory
├── /sbin  시스템 관리용 마운트
├── /srv   시스템 고유의 데이터
├── /tmp   temp directory
├── /usr   각종 프로그램이나 커널 소스를 놓아두는 디렉토리
└── /var   로그나 메일 등 가변적인 파일을 놓아두는 디렉토리
```

**Linux 보안 기능**
- permission
    - 디렉토리나 파일에 대한 엑세스 권한을 계정 및 그룹별로 설정 가능
- iptables
    - Linux는 원래 network를 경유하여 멀티유저가 이용하는 것을 전제로 한 OS이기 때문에 네트워크 관련 기능이 풍부
    - iptables는 패킷 필터링 및 네트워크 주소 변환(NAT) 기능을 설정하는 기능
- SELinux(Security-Enhanced Linux)
    - 미국 국가안전보장국이 제공하는 Linux 커널에 강제 액세스 제어 기능을 추가한 기능
    - 기존의 Linux는 root 사용자는 퍼미션에 상관없이 모든 액세스가 가능
    - 보안 대상에 따라 HTTP/FTP와 같은 프로세스마다 액세스 제한을 거는 Type Enforcement(TE)와 root도 포함한 모든 사용자에 관해 제어를 거는 RBAC(role-based access control) 등으로 Linux를 제어 
    
    
    
    
