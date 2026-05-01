# My personal Homelab Setup


## Updates
###  1/28/2026
Reorganized to have a Docker and a Podman sections. My homelab has been migrated to the Docker folder already.


### 2/3/2026 
Moving some of my services to Podman from Docker in my Production Bluehat enviornment. 
1. Audiobookshelf
2. Navidrome
3. Calibre Web


## Requirements
1. Have the correct Networks already created
2. Have the proper paths mounted and make sure they match
3. Use for Portainer Deploy


## Note
Permissions can be tricky, don't give up hope but may require some extra work on the NAS.


# Make a IPV6 Network
Change the subnet as you see fit. Change the 1 to a 2 or 3 or 4 or some other number

```bash
docker network create \
--driver bridge \
--ipv6 \
--subnet 2001:db9:100::/64  \
NEW_NET_NAME_HERE
```

List networks with command
```bash 
docker network ls
```

```bash
#Single Line
docker network create --driver bridge --ipv6 --subnet 2001:db8:6::/64 koito_default
```
