> 완벽한 IT 인프라 구축을 위한 Docker 2판

**Immutable Infrastructure**
- 인프라의 변경 이력을 관리하는 것이 아니라 현재 인프라 상태를 관리하면 되도록 바뀜

**IaC, Infrastructure as Code**
- 인프라 구성 정보를 코드로 관리함으로 git으로 관리 가능
- Docker에서의 Dockerfile

**인프라 구성 관리 툴**
- OS 시작을 자동화하는 툴(Bootstapping)
    - KickStart
    - Vagrant
- OS나 미들웨어의 설정을 자동화하는 툴(Configuration)
    - Ansible
    - Chef
    - Puppet
    - Itamae
- 여러 서버의 관리를 자동화하는 툴(Orchestration)
  - Kubernetes
      - 사실상 표준(de facto standard)

**CI/CD**
- CI, Continuous Integration
- CD, Continuous Delivery
- Tools
    - Jenkins
    - Vamp - toss, copang 사용

**Blue/Green Deployment**
- 구버전과 신버전을 동시에 작동시킨 뒤, 트래픽만 전환하는 방법
- 빠른 롤백이 가능
- 시스템 자원이 x2

**Canary Release**
- 사용자 일부(예를 들어 5%)를 새로운 릴리즈 버전으로 서비스하여 이상 없으면 100%로 전환하는 방식
- 어원: 예전 탄광에서 독가스 유무를 확인하기 위해 카나리아를 투입하여 테스트했던 일에서 나온 표현
- 장애를 빠르게 감지하고(빠른 피드백), 대응하는 배포 기법
- 이 기법으로 A/B Testing 가능

**A/B Testing**
- A안과 B안을 임의로 사용자들에게 보여주고 어떤 것이 나은지 실험하는 방법
- 이 테스트를 통해 가설을 직관이 아니라 데이터로 증명할 수 있음
