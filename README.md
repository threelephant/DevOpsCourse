# Notes App – Manual VM Deployment


## 1  Provision a VM (Azure Portal)

1. **Create resource → Virtual Machine**
2. **Basics**

    * *Resource group*: `devops-rg`
    * *Name*: `notes-vm`
    * *Image*: **Ubuntu 22.04 LTS**
    * *Size*: **B1s**
<details>

```bash
az group create -n devops-rg -l westeurope
az vm create -g devops-rg -n notes-vm \
  --image UbuntuLTS --size Standard_B1s \
  --admin-username azureuser --generate-ssh-keys \
  --public-ip-sku Standard --ports 22 80
```

</details>

---

## 2  Install Docker & Docker Compose in VM

```bash
curl -fsSL https://get.docker.com | sudo sh
sudo apt-get install -y docker-compose-plugin

sudo usermod -aG docker $USER
newgrp docker

docker --version && docker compose version

---
```
## 4  Pull images & run containers

### Upload this docker-compose.yml

```yaml
services:
  api:
    image: plunev/notes-api:v1
    environment:
      - PORT=5000
      - CORS_ORIGIN=http://$(curl -s ifconfig.me)
    networks: [appnet]

  web:
    image: plunev/notes-web:v1
    depends_on: [api]
    ports:
      - "80:80"
    networks: [appnet]

networks:
  appnet:
```

Run it:

```bash
docker compose pull
docker compose up -d
docker compose ps
```

---

## 5  Verify

* Browser → **http\://\<VM\_PUBLIC\_IP>** → the Notes UI loads.
* Add a note → refresh → note persists.
* `docker compose ps` shows both services **Up**.

![img.png](images/img.png)

![img_1.png](images/img_1.png)

![img_2.png](images/img_2.png)

---

**Docker User:** plunev <br>
**Date:** 2025-07-12
