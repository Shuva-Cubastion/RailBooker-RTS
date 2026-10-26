1. Manual `kubectl scale` does not persist when Argo CD self-heal is enabled because Argo CD restores the replica count defined in Git. Update Git to make the change permanent.

2. Liveness checks whether a container needs restarting, while readiness checks whether it can receive traffic. `/health.php` checks database connectivity, so using it for liveness could cause unnecessary restarts during a temporary database outage.

3. Users were logged out because PHP sessions stored locally on one replica were unavailable on other replicas. Shared session storage, such as Redis, solves this but adds infrastructure and configuration. Sticky sessions are simpler but less reliable if a replica fails.

4. Exposing phpMyAdmin under `/phpadmin` created a database administration entry point that could be abused if publicly accessible or poorly secured. It should be removed from public access or properly restricted.

5. After `helm uninstall`, persistent volumes or claims may remain depending on retention policies. Separately managed resources, such as Secrets and namespaces, may also remain and should be checked before cleanup.

6. The original repository contained hardcoded database credentials. Credentials should be provided through environment variables and Kubernetes Secrets, kept out of Git, and rotated if exposed.
