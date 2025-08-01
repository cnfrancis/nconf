# experiment 1

## Description
- Let's say you have podman container running on the host
- Now let's say a change is introduced and modifies all the permissions as well as the configuration of podman

Can you rollback to the previous state where the permissions are restored?
Can you rollback to the previous state where the conf file is unchanged?

To test that you can, i am running a small http server on port 8000 and monitor up time.

## Notes
`uv init --script main.py --python 3.12`
`uv add --script main.py 'fastapi' 'uvicorn' 'prometheus-client'`

Run the blackbox exporter
```
podman run --rm -p 9115:9115 --name blackbox_exporter \
  -dt \
  -v $(pwd)/conf:/config:Z \
  quay.io/prometheus/blackbox-exporter:latest \
  --config.file=/config/blackbox.yml
```

Run the prometheus
```
# Create persistent volume for your data
podman volume create --label=prom-data prometheus-data
# Start Prometheus container
podman run \
    -dt \
    -p 9090:9090 \
    -v $(pwd)/conf/prometheus.yml:/etc/prometheus/prometheus.yml:Z \
    -v prometheus-data:/prometheus \
    --rm \
    --name prometheus \
    prom/prometheus
```

Run the grafana

Configuring the prometheus data source ->http://host.containers.internal:9090
```
# Create persistent volume for your data
podman volume create --label=grafana-data grafana-data
# start grafana container
podman run -dt -p 3000:3000 --name=grafana \
  -e "GF_AUTH_ANONYMOUS_ENABLED=true" \
  -e "GF_AUTH_ANONYMOUS_ORG_ROLE=Admin" \
  -e "GF_AUTH_DISABLE_LOGIN_FORM=true" \
  --volume grafana-data:/var/lib/grafana \
  grafana/grafana-enterprise
```

Run on the target
```
podman run --rm -dt -p 9101:8000 --name=experiment-1 localhost/test-service
```

# Results
```
[root@nixos:~]# ls -l /home/arbiter/
total 4
drwxr-xr-x 2 arbiter g_arbiter 4096 Jul 31 20:24 experiment_1
```

```

```