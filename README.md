# nio in Docker

To run your nio instance in a docker container you will first need to download your nio binary from the [binary downloads page](https://app.n.io/binaries/download).

## Configure the Project

1. Update the submodules for the default project
```
git submodule update --init --recursive
```
2. Open `default_project/nio.conf`
3. Find the hostname and token for your pubkeeper server
    * If you're using a nio hosted Pubkeeper server, these can be found from the [System Designer](http://designer.n.io) in the edit modal for your system
4. Copy your hostname and token into `PK_HOST` and `PK_TOKEN` under the `user_defined` section
5. Copy your hostname into `WS_HOST` being sure to replace `pubkeeper` with `websocket`

## Building the Docker image

1. Copy your nio binary wheel into this folder
2. Build the docker image passing the wheel filename as a build argument:
```
docker build -t nio-binary:latest --build-arg WHEEL_FILE=nio_lite-20171127-py3-none-any.whl .
```

## Running the nio Docker container

To run the nio binary with an empty project just run the image like so:
```
docker run -p 8181:8181 nio-binary:latest
```

You can also volume mount in an existing project directory on disk like so:
```
docker run -p 8181:8181 -v /path/to/your/project:/nio/project nio-binary:latest
```

## Troubleshooting

If you see Pubkeeper connection errors or errors like `RuntimeError: Client not ready` then that means your instance cannot connect to its Pubkeeper server. Make sure the Pubkeeper connection information is set up correctly in your project's `nio.conf` or is being passed in as an environment variable.
