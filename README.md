# docker-wrappers
Wrapper scripts for Docker-based study infrastructure scripts

These scripts are quick wrappers to do things, mostly in the Docker environment, for a study. They assume that, for a study called `mystudy`, they'll be run in a directory structure like:

```
/path/to/mystudy/
  config/
    secrets/
      *env  (docker endpoint)
  scripts/  (The root for these scripts)
    infrastructure/
      Dockerfile
      run.sh  (The main docker endpoint)
```

The scripts will build a docker image tagged with `mystudy` from `infrastructure/Dockerfile`

Note: The `infrastructure` directory should _not_ be part of this repository. This is a general-use set of scripts to make running and building all studies' infrastructure easier.