# What time is right now, dot com

Have you ever been sitting at your computer wondering, "Gee, What time is it right now?". Well now you don't have to wornder. Simply open up a web browser and visit http://whattimeisitnowrightnow.com and you'll be able to know with certainty what time it is, right now.

Even when you're on the go, simply pull your phone out and visit http://whattimeisitnow.com in your browser of choice to know with certainty what time it is, right now. Mobile apps are in the works.

### Disclaimers
 * Time is represented by the number of seconds elapsed since Jan 1, 1970 at midnight in the Coordinated Universal Time Zone. We're partnering with https://www.epochconverter.com/ to make knowing what time it is right now even easier!
 * We continue our legal battle with domain squatter's existing site at http://whattimeisitrightnow.com. Please stay tuned for updates as we're very excited to finally inform people what time it is right now.

## Contribution Guide

### Dev setup

_Only MacOS with homebrew is currently supported. For convienent ENV management, mise is recommended but not configured by this script._

1. Install dependencies for developing.

```bash
$ script/bootstrap
```

2. Start the application via docker compose.

```bash
# Only use --build if required.
$ docker-compose up --build
```

The application should now be viewable at http://localhost:3000.

#### Debugging

The `compose.yml` configures tty and stdin to connect to debugging breakpoints. When paused at a breakpoint, simply attach to the running container by running this command in a new terminal:

```bash
docker-compose attach app
```

You can detach from the container wihtout killing the process by using _CTRL+SHIFT+p + CTRL+SHIFT+q_

### Deployment

This application contains helm templates in `config/helm` for deploying to a local or remote Kubernets cluster. Instructions to validate the deployment are printed via NOTES.txt for the respective environment.

#### Local deployment:

To demonstrate how one might support multiple environments and test Kubernetes locally, `script/deploy` supports deploying to a local kubernetes cluster which is configured by `script/bootstrap`.

```
$ minikube start # Ensure minikube is running (should be handled by script/bootstrap)

$ script/deploy

Enter the number (1 or 2): 1 # Choose option 1 for Local (minikube)

Switched to context "minikube".
Release "wtrn-webapp" has been upgraded. Happy Helming!
NAME: wtrn-webapp
LAST DEPLOYED: Mon May 19 13:20:49 2025
NAMESPACE: dev
STATUS: deployed
REVISION: 3
TEST SUITE: None
NOTES:
Forward ports by running `minikube tunnel` in a separate window.
After that you can access your app at http://localhost:3000

$ minikube tunnel
$ curl http://localhost:3000 # verify in new terminal
```

#### Production deployment:

See instructions in ../infrastructure/README.md.
