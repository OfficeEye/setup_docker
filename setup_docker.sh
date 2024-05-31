#!/bin/bash
clear
echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Bem-vindo ao assistente OfficeEye! Estamos aqui para te ajudar a configurar o Docker Engine e rodar a aplicação."
sleep 1
echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) O primeiro passo é verificar se o docker já está instalado na máquina"
sleep 2

docker --version
if [ $? -eq 0 ]; then
    echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Parece que o docker já está instalado e com o setup devidamente configurado!"
    sleep 2
    echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Agora vamos subir o container de Mysql..."
    sleep 2
    docker stop mysql-container 
    docker rm mysql-container
    docker rmi mariaveroneze/db-mysql-officeeye:latest
    clear
    sleep 1
    docker pull mariaveroneze/db-mysql-officeeye:latest
    docker run -d --name mysql-container -p 3306:3306 mariaveroneze/db-mysql-officeeye:latest
    clear
    sleep 2
    echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Agora podemos verificar se sua aplicação já está instalada e pronta para rodar"
    sleep 2
    echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Informe o nome da versão do seu repositório:"
    read versionName
    if [ -d "/home/ubuntu/$versionName" ]; then
        echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) A aplicação OfficeEye já está instalada :)"
        sleep 2
        echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Deseja iniciar a aplicação? [Y/n]"
        read option
        if [ "$option" == "Y" ]; then
            echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Informe o nome da versão do seu repositório:"
            read repositoryName
            sleep 2
            echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Iniciando a aplicação..."
            sleep 2
            clear
            cd /home/ubuntu/$repositoryName/aplicacao-officeeye/target
            java -jar aplicacao-officeeye-1.0-SNAPSHOT-jar-with-dependencies.jar
        else
            echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Você optou por não rodar a aplicação no momento! Até mais, então! :))"
        fi
    else
        echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) A aplicação ainda não está instalada!"
        sleep 2
        echo "Gostaria de instalar? [Y/n]"
        read option2
        if [ "$option2" == "Y" ]; then
            clear
            sleep 1
            echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Informe o link do repositório com a versão da aplicação que você deseja instalar:"
            sleep 1
            read repository
            sleep 2
            cd /home/ubuntu 
            git clone $repository
            sleep 2
            clear
            echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Pronto! A aplicação OfficeEye foi instalada e está pronta para iniciar a qualquer momento!"
            sleep 1
            echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Deseja iniciar agora? [Y/n]"
            read option3
            if [ "$option3" == "Y" ]; then
                echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Informe o nome do seu repositório:"
                read repositoryName
                sleep 2
                echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Iniciando a aplicação..."
                sleep 2
                clear
                cd /home/ubuntu/$repositoryName/aplicacao-officeeye/target
                java -jar aplicacao-officeeye-1.0-SNAPSHOT-jar-with-dependencies.jar
            else
                echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Você optou por não iniciar a aplicação no momento! Até mais, então! :))"
                clear
            fi
        else
            echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Você optou por não iniciar a aplicação no momento! Até mais, então! :))"
        fi
    fi
else
    echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Opa! Não identifiquei nenhuma versão do docker instalado. Podemos iniciar agora a instalação!"
    sleep 2
    echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Começar instalação do Docker (Y/n)?"
    read inst
    if [ "$inst" == "Y" ]; then
        echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Ok! Iremos instalar"
        sleep 2
        echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Atualizando os pacotes do sistema..."
        sleep 2
        sudo apt update -y
        clear
        echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Agora precisamos configurar o repositório Docker"
        sleep 2
        sudo apt-get install ca-certificates curl -y
        clear
        sleep 2
        sudo install -m 0755 -d /etc/apt/keyrings
        clear
        sleep 2
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        clear
        sleep 2
        sudo chmod a+r /etc/apt/keyrings/docker.asc
        clear
        sleep 2
        echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Agora a instância será preparada"
        sleep 2
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
        sleep 2
        clear
        sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin -y
        sleep 2
        clear
        echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Verificando se a instalação do Docker engine foi bem sucedida..."
        sleep 2
        sudo docker run hello-world
        sleep 2
        clear
        docker --version
        if [ $? -eq 0 ]; then
            echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) O Docker foi instalado corretamente :))"
            sleep 2
            echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Agora precisamos habilitar os serviços e configuração de usuário"
            sleep 2
            clear
            sudo systemctl start docker
            sleep 2
            sudo systemctl enable docker
            sleep 2
            sudo usermod --append --groups docker $(whoami)
            clear
            echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Ambiente docker configurado!"
            sleep 2
            echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Com o ambiente docker configurado iremos deslogar para garantir que as alterações foram salvas."
            sleep 1
            echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Escreva 'logout' e após se conecte com o ssh de sua VM e nos acione novamente"
            sleep 2
            exit
        fi
    else
        echo "$(tput setaf 10)[OfficeEye assistant]:$(tput setaf 7) Você optou por não instalar o Docker por enquanto, até a próxima então!"
        sleep 1
    fi
fi
