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
