# metrics for MuseGAN

## Instructions

***
To run the code of this repository it is necessary to have **docker** installed.  
  
To run the container it is necessary to execute the following commands:

```docker
docker build -t tsc:unam .
docker run -p 80:80 --name music --mount type=bind,source="$(pwd)",target=/tsc/ tsc:unam
```
