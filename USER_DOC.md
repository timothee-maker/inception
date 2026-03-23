## Understand what services are provided by the stack

## Start and stop the project
```bash
make          # Build and start all containers
make down     # Stop and remove containers
make clean    # Stop containers and remove images
make fclean   # Full cleanup including volumes
make re       # Rebuild everything from scratch
```

## Access the website and the administration panel
### From your host machine
Vagrant exposes the VM on a private network at `192.168.56.10`.
Open your browser and navigate to:
```
https://192.168.56.10
```
Or, if you have added the domain to your `/etc/hosts`:
```
https://tnolent.42.fr
```
The WordPress admin panel is available at:
```
https://tnolent.42.fr/wp-admin
```

> Your browser will warn you about the self-signed TLS certificate — this is expected. Click "Advanced" and then "Proceed anyway".

### From inside the VM
The VM has no graphical interface, but you can verify the site is running with:
```bash
curl -k https://tnolent.42.fr
# or
curl -k https://192.168.56.10
```
A successful response will return the HTML of the WordPress homepage.

## Locate and manage credentials
## Check that the services are running correctly