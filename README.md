### Apache Hive Image Builder
This project creates a hive image using a compatible hadoop version. It also copies necessary files from hadoop distribution to hive folder to support usage of s3.


### Usage

```mermaid

graph LR;
  user(Opensource Dev) --> imagemine(Github.com/imagemine/*)
  imagemine --> github(Github Actions)
  github --> makefile(make all)
  makefile --> build(build.sh all)
  build -.load cloudnativek8s username.-> project(Project properties)
  build --> docker(docker build)
  build -.cloudnativek8s.-> dockerhub(Docker Hub Push)
  golden(GV Onboarding URL) -.1. retrieve cloudnativek8s image .-> dockerhub
  golden -. 2.evaluate Vulnerabilities .-> aqua(Aqua)
  aqua -.1a. has vulnerabilities .-> artifactory_stg(gv-images-products_stage/oss)
  aqua -.1b. has no vulnerabilities .-> artifactory_clean(gv-images-products/oss)
  
  eng(Enterprise Engineer) --> golden
  eng -. 1. pushes build instructions .-> vendor($team-vendor-images/images.txt)

  jenkins(Team Image Onboarding) --> vendor
  jenkins -. 1. if clean .-> artifactory_clean
  jenkins --> artifactory(cache.artifactory../$team-third-party/)
  pss(Prod Support) --> ptp(Promote to Prod)
  ptp -. 1. download and tag .-> artifactory
  ptp -. 2. tag and push .-> artifactory_prod(production-cache.artifactory...)


  classDef yellow fill:#fea,stroke:#333,color:#444,stroke-width:1px
  classDef green fill:#0f2,stroke:#0f2,color:#444,stroke-width:1px
  classDef pink fill:#e4a,stroke:#e4a,color:#444,stroke-width:1px
  class eng,golden,aqua,artifactory_stg,artifactory_clean,vendor,jenkins,artifactory yellow
  class pss,ptp,artifactory_prod pink
  class makefile,build,github,user,imagemine,docker,project,dockerhub green
```





