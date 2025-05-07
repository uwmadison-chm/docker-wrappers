# docker-wrappers
Wrapper scripts for Docker-based study infrastructure scripts

## Prerequisites
- Docker installed and running
- Git (required for infrastructure updates)

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

## Available Scripts

- `build-docker` -- Builds the image defined in `infrastructure/Dockerfile` and tags it with the study name
- `run-docker-cmd` -- Starts a container to run an arbitrary command.
- `shell-docker` -- Starts a shell in the container
- `run-docker-infra` -- Runs the `infrastructure/run.sh` script. This is what you'll normally put in cron.

## Environment and Configuration

### Container environment:

The `_setup_env.bash` file sets the following variables:
- `STUDY_DIR`: The root directory of your study
- `STUDY_NAME`: Name of your study (must be a valid Docker image tag)
- `INFRA_DIR`: Path to the infrastructure directory
- `SCRIPT_DIR`: Directory containing these wrapper scripts
- All environment variables starting with `STUDY_` are automatically exported to the container
- `STUDY_DIR` is mounted at `/s/`

### Configuration:

- `SECRETS_DIR`: Override the default secrets location (defaults to `${STUDY_DIR}/config/secrets`)
- `DOCKER_TTY` and `DOCKER_INTERACTIVE`: Override TTY and interactive behavior (see below)
- Set `DRY_RUN` to a non-empty value to not actually run `docker run` or `docker build` commands
 
## Usage Examples

```bash
# Build the Docker image
./build-docker

# Run a command in the container
./run-docker-cmd python script.py

# Get an interactive shell
./shell-docker

# Run the infrastructure script
./run-docker-infra
```

## Notes

### Study Name Requirements

- Must be a valid Docker image tag (only letters, numbers, dots, underscores, and hyphens)
- Must start with a letter or underscore
- Invalid characters will trigger a warning

### Security and Access

- The study directory is automatically mounted at `/s` in the container
- All readable `.env` files in the secrets directory are automatically passed to the container
- The scripts will warn if they can't read an env file or if the secrets directory doesn't exist

### Interactive Behavior

In normal use, `run-docker-cmd` will auto-detect if you're in an interactive session and set `-t` and `-i` correctly when calling `docker run`. If you want to override that behavior, you can set the `DOCKER_TTY` and `DOCKER_INTERACTIVE` environment variables -- set them to either the empty string or their option (`-t` or `-i`).