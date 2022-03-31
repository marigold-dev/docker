# Deku

This Docker image is a attempt to build Deku artifacts via a source URL and esy's relocatables artifacts feature (ie. `esy release`);

Run,

```sh
docker build . -f Dockerfile -t deku:esy
```
