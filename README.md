# Vagrant CI docker

Dies ist eine Entwicklungsumgebung, um einige Konzepte von Continuous Delivery zu demonstrieren.
Dazu werden einige Docker Container eingesetzt, da Änderungen relativ schnell durchgeführt werden können und weniger Ressourcen benötigt werden als für echt VMs.
Das Demo basiert aktuell auf einem Java Projekt, welches durch das Build Tool Maven gebaut wird.

## Warnungen
Damit die Konstruktion aus unterschiedlichen Containern und ssh Zugriffe dazwischen funktionieren, wurden einige Sicherheitsaspekte stark gelockert:

* SSH Clients überprüfen nicht die Identität des Servers. IP Adressen können sich ändern ohne dass manuell eingegriffen werden muss. Im Allgemeinen wird hier eine Bestätigung durch den Nutzer verlangt. Dies führt dann dazu, dass eigentlich nichts out-of-the-box funktioniert.
* Es werden unsichere (allgemein bekannte) Schlüsselpaare und Passworte verwendet

## Vorbereitungen
Aktuell verwenden die Container einen Docker Container `devopsarchitect/devbase` als Baseimage.
Diser muss einmal gebaut werden

    git clone https://github.com/rattermeyer/docker-java-dev-box.git
    cd docker-java-dev-box
    docker build -t "devopsarchitect/devbase" .
    
## Build Containers
Um die Container zu bauen reicht es `vagrant up --provider=docker`aufzurufen.

_Achtung_: Die Container sind über docker links miteinander verbunden. Aber das funktioniert nicht, wenn die gelinkten Container noch nicht gestartet sind. Vagrant scheint das nicht richtig zu berücksichtigen.
Hier würde ich nochmal `fig`ausprobieren. Aktuell scheint das Problem eher mit dem Slave Container zu bestehen.
Diesen kann man durch folgendes Kommando entsprechend starten

    docker rm slave-1
    docker run -d --name "slave-1" --link "cimaster:cimaster" --link "repos:repos" -P slave-1 -master http://cimaster:8080/jenkins -executors 1 -name slave-1 -fsroot /var/lib/jenkins

Zur Erläuterung:

* Nutze das Image mit dem Tag `slave-1`
* Gebe dem Container den Namen "slave-1" 
* Der Container startet das swarm-client plugin und meldet den Slave unter dem Namen "slave-1" am cimaster an und legt das file system root auf das Jenkins Home Verzeichnis

## Zugriff auf Jenkins
Jenkins ist auf dem Host unter dem Port :8080 erreichbar: `http://localhost:8080/jenkins`.
In der linken Spalte sollte sich unter anderem als Buildknoten "slave-1" zeigen.
Es ist eine Build Pipeline angelegt (BP-*). Einmal starten und sie sollte erfolgreich durchlaufen.

## Hilfreiche Skripte
Im Verzeichnis `docker-cimaster`existieren 2 Shellskripte:

* backup_jenkins_home.sh
* restore_jenkins_home.sh

Welche das Jenkins Home Verzeichnis (also Konfiguration + Job Definitionen) sichert und zurückspielt.
Aufgerufen werden sie mit der ContainerId / Container Namen: `backup_jenkins_home.sh cimaster` oder `backup_jenkins_home.sh 1d4f` (container id ist entsprechend der aktuellen zu ersetzen)

# Container

## docker-repos
Enthält aktuell wesentlich folgende Komponenten

* Nexus
* git repository

Nexus enthält gegenüber der Standardinstallation ein weiteres Repository `candidates`.
Das Git Repository ist ein bare clone von [todolist-demo](https://github.com/rattermeyer/todolist-demo.git)

## docker-cimaster
Die Jenkins Konfiguration soll an anderer Stelle detaillierter dargestellt werden!
Links zu repos

## docker-slave
Client, der mittels des Swarm Client Plugins Kontakt zum Jenkins Master aufnimmt.

# Offene Punkte

* Richtiges automatisches Deployment auf einen Entwicklungsserver / Container
* Manuelles Deployment auf einen Test / Abnahme Server / Container
* Erstellung von JavaDoc und Upload ins Maven Repository
* Sonar Server und Integration in die Build Pipeline
* Performance / Last Test Stage
* Mehrere Steps parallel und dann wieder zusammenführen
