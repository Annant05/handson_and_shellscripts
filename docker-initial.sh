# Creating custom images using docker using Dockerfile
# Commmand to build image using Dockerfile
# 1)
docker build .

# 2) tagging docker image 
docker build -t myusername/myimage:latest .

# 3) docker image using manual commit \
# In simple words create a image from container by manually login and editing in the container.
# command to create a image using containerid 
docker commit -c 'CMD ["redis-server"]' containerid
