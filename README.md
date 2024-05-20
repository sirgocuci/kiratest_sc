# Kiratech Test - Kubernetes Challenge

## Progetto Kubernetes Cluster e Applicazione

### Descrizione
Questo progetto è stato sviluppato con l'obiettivo di eseguire il provisioning di un cluster Kubernetes composto da un manager e due worker, e di deployare un'applicazione composta da tre servizi con un'interfaccia grafica accessibile via browser. L'obiettivo è stato in parte raggiunto, soprattutto nella parte riguardante vagrant e terraform. Anche il package e l'installazione vengono correttamente completati. La CI di github presenta invece errori che non sono riuscito a risolvere.

## Architettura
Il progetto utilizza Vagrant per la configurazione delle Virtual Machines, Ansible per il provisioning delle VM e l'installazione di Docker e dei tool Kubernetes, e Terraform per il provisioning del cluster Kubernetes. Helm viene utilizzato per il deployment dell'applicazione. La pipeline di CI utilizza GitHub Actions per l'esecuzione di linting su Terraform, Ansible ed Helm.

### Installazione
1. Clonare il repository
2. Eseguire `vagrant up` per avviare le Virtual Machines
3. Eseguire `terraform init` per inizializzare Terraform
4. Eseguire `terraform apply` per applicare le configurazioni e avviare il cluster Kubernetes
5. Eseguire `helm install my-application ./helm/my-application-0.1.0.tgz` per deployare l'applicazione

## Scelte nell'implementazione

### Vagrantfile
- **Configurazione delle Virtual Machines**: Ogni VM è configurata con le risorse necessarie per l'esecuzione dei servizi Kubernetes.
- **Configurazione di rete**: Utilizzo della rete privata per consentire la comunicazione tra le VM all'interno del cluster.

### Setup.yml di Ansible
- **Installazione dei tool Kubernetes**: Utilizzo di script shell per l'installazione di kubectl, kubelet e kubeadm.
- **Installazione di Docker**: Utilizzo del repository Docker ufficiale per l'installazione del motore Docker.

### Main.tf di Terraform
- **Creazione del namespace Kubernetes**: Utilizzo del resource "kubernetes_namespace" per creare il namespace "kiratech-test" per l'applicazione.
- **Deploy del benchmark di sicurezza**: Utilizzo di resource "null_resource" per applicare il job.yaml che esegue il benchmark di sicurezza con kube-bench.

### Values.yaml di Helm
- **Configurazione dei servizi**: Definizione dei servizi dell'applicazione, incluso il nome e la porta.
- **Abilitazione dell'autoscaling**: Configurazione dell'autoscaling per garantire una scalabilità dinamica in base al carico.
