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
  aqua -.1a. has vulnerabilities .-> artifactory_stag(gv-images-products_stage/oss)
  aqua -.1b. has no vulnerabilities .-> artifactory_clean(gv-images-products/oss)
  
  eng(Enterprise Engineer) --> golden
  eng -. 1. pushes build instructions .-> vendor($team-vendor-images/images.txt)

  jenkins(Jenkins Image Onboarding) --> vendor
  jenkins -. 1. if clean .-> artifactory_clean
  jenkins --> artifactory(cache.artifactory../$team-third-party/)
  pss(Prod Support) --> ptp(Promote to Prod)
  ptp --> artifactory_prod(production-cache.artifactory...)



```





