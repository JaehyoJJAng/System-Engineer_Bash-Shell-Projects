#!/usr/bin/bash

# Target HOST
TARGET_HOST='user-01 user-02'

# sshKey
sshKey="${HOME}/.ssh/key.pem"
sshPub="${HOME}/.ssh/key.pub"

# Set Port
PORT='9708'

# Create ssh key
if [[ ! -f "./id_rsa.pub" ]]
then
   /usr/bin/ssh-keygen -t rsa -N '' -f "${sshKey}" <<< y 1>/dev/null
fi

# 생성된 SSH Key를 서버에 복사
for server in ${TARGET_HOST}
do
	echo ${server}
	/usr/bin/scp "${sshKey}" "${server}:/home/${server}"
done
