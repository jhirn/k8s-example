# XYZ INC.

- On prem infrastructure shop
- Considering a move to cloud.
- Not set on which provider.
  - Provider agnostic for now



_Q: Which tech stack is used at XYZ?_

## Current Challenges

- Dev complaints
  - Bootstpping new environments
  - Long lead times/development cycles
  - Lack of consistency
- Management complaints
  - Downtime during deployments
  - Difficulty rolling back
  - Code quality


_Q: How do you measure code quality? What impact do you expect to realize by improving it?_

_Q: Are long lead/cycle times a funciton of process or technical constraints?_

_Q: How much downtime is acceptable? What are the business impacts of this downtime (are additional effort/infrstructure costs justifiable)?_

## Client Request

PoC for cloud deployment of a containeized REST app.

### Internal

- Use AWS as cloud provider.
- REST Endpoint must return this JSON payload:

```json
{
  "message": "Automate all the things!",
  "timestamp": 1529729125
}
```
- Kubernetes cluster deployument
- IoC deployment and build
