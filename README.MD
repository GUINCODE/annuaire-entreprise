#telecharger l'image officielle de sql server et lancer un conteneur
docker pull mcr.microsoft.com/mssql/server:2019-latest
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=@Pa$$w0rd" -p 1435:1433 --name my-sqlserver -d mcr.microsoft.com/mssql/server:2019-latest

#Ajout volumes:
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=@Pa$$w0rd" \
-v /home/aguibou/sqlserver_data:/var/opt/mssql/data \
-v /home/aguibou/sqlserver_logs:/var/opt/mssql/log \
-v /home/aguibou/sqlserver_backups:/var/opt/mssql/backup \
-p 1435:1433 --name my-sqlserver -d mcr.microsoft.com/mssql/server:2019-latest

NB: Des fois besoins d'ajouters des autorisations aux dossier pour que SQL Server puis ecrire dans ces dossiers:
sudo chmod -R 777 /home/aguibou/sqlserver_data /home/aguibou/sqlserver_logs /home/aguibou/sqlserver_backups



#Pour executer le script directement:
sqlcmd -S localhost,1435 -U SA -P "@Pa$$w0rd" -i /media/aguibou/Autres/devops_devsecops_perso/apps/annuaire-entreprise/script.sql

#pour se connecter :
sqlcmd -S localhost,1435 -U agb -P "@Pa$$w0rd" -d annuaire_entreprise

#Mettre les deux appl dans le meme reseau:
aguibou@myubuntu:~$ docker network create gn_network

aguibou@myubuntu:~$ docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=@Pa$$w0rd" \
-v sql_app_data:/var/opt/mssql \
-p 1436:1433 \
--name sql_app \
--network gn_network \
-d mcr.microsoft.com/mssql/server:2019-latest

# Mise en communication de conteneur  
# 1. Créer un réseau Docker pour permettre la communication entre les conteneurs
docker network create app_network

# 2. Lancer le conteneur SQL Server en le connectant au réseau 'app_network'
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=@Pa$$w0rd" \
-v sql_app_data:/var/opt/mssql -p 1433:1433 --network app_network \
--name my-sqlserver -d mcr.microsoft.com/mssql/server:2019-latest

# 3. Assurez-vous que dans le fichier .env, le port interne du conteneur SQL Server est utilisé :
# DB_PORT=1433

# 4. Lancer l'application Node.js conteneurisée, en la connectant au même réseau
docker run -p 3000:3000 --network app_network --env-file .env \
--name app_connecte -d img_annuaire_entreprise:1.0

# 5. Vérifier que l'application Node.js fonctionne correctement et se connecte à SQL Server
docker logs app_connecte
