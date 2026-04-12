# Infrastructure AWS avec Terraform

Ce dépôt contient le code permettant de déployer une architecture web résiliente, modulaire et sécurisée sur AWS.

## 1. Description du Projet
Ce projet implémente une architecture réseau sur AWS en utilisant Terraform.
L'objectif est de mettre en pratique les concepts fondamentaux du Cloud et du DevOps :
- Infrastructure as Code (IaC) : Modularisation et réutilisabilité du code.
- Réseau avancé : Gestion des subnets publics/privés, NAT Instance et routage personnalisé.
- Haute Disponibilité : Utilisation d'un Application Load Balancer (ALB) pour distribuer le trafic.
- Sécurité : Isolation des serveurs dans des réseaux privés et filtrage strict via Security Groups.

## 2. Architecture
L'infrastructure est déployée sur la région eu-west-3 (Paris) et s'articule autour des composants suivants :
- VPC : Un réseau isolé avec 2 subnets publics et 2 subnets privés répartis sur 2 Zones de Disponibilité (AZ).
- Bastion Host : Une instance publique permettant l'accès SSH sécurisé aux ressources privées.
- NAT Instance : Permet aux instances privées d'accéder à Internet (pour les mises à jour apt) sans être exposées.
- Application Load Balancer (ALB) : Point d'entrée unique pour le trafic HTTP, redirigeant vers les instances cibles.
- Instances Privées : Serveurs Nginx isolés recevant le trafic de l'ALB.

## 3. Structure du Projet
- live/ : Orchestration et variables d'environnement.
- modules/vpc/ : Gestion du réseau (IGW, Subnets, Routes).
- modules/compute/ : Instances EC2 (Bastion, NAT, Private).
- modules/alb/ : Load Balancer, Target Group et Listeners.
- modules/network_sec/ : Security Groups (Firewalling).

## 4. Guide de Démarrage

### Pré-requis
- Terraform (v1.2+) et AWS CLI installés.
- Une paire de clés SSH (`~/.ssh/id_ed25519.pub`)

### Installation & Déploiement
1. Lier sa clé publique :
Le module compute utilise par défaut le fichier ~/.ssh/id_ed25519.pub. Si votre clé porte un autre nom, modifiez la ressource aws_key_pair dans modules/compute/main.tf.
2. Configuration des variables :
Éditez le fichier `live/terraform.tfvars` pour y ajouter votre adresse IP pour l'accès SSH :
`allowed_ssh_cidrs = ["VOTRE_IP_PUBLIQUE/32"]`
3. Initialisation et déploiement:
`cd live && terraform init && terraform apply`

## 5. Utilisation et Tests

### Accès aux instances (via Bastion)
Pour accéder à une instance privée, utilisez le Bastion comme rebond (SSH ProxyJump) :
`ssh -i ~/.ssh/id_ed25519 -J ubuntu@<BASTION_PUBLIC_IP> ubuntu@<PRIVATE_IP>`

### Vérifier le Load Balancer
Une fois le déploiement terminé, récupérez l'URL de l'ALB via les outputs :
`curl http://<ALB_URL>`
Le serveur devrait répondre : `<h1>Hello from $(hostname)</h1>`.

### Vérifier la NAT Instance
Depuis une instance privée, testez la connectivité vers l'extérieur :
`ping google.com`

---
⚠️ Important : Lancez terraform destroy après vos tests pour éviter des frais inutiles.



# APP

## ETAPE 1: Creer Dockerfile

1. On cree le Dockerfile en partant d'une image python afin d'installer tous les packages necessaires dans un dossier precis.
2. On cree ensuite notre image finale a partir d'une image la plus petite possile (distroless) pour n'y copier que les packages installes + fichiers necessaires
/!\ Voir si  ca n'est pas necessaire d'installer un shell pour le debug
/!\ pas de distroless pour le moment, necessite d'installer beaucoup de librairies supp, a voir plus tard
3. Lancer le script (main.py) qui demarre et configure notre serveur

## ETAPE 2: Creer requirements.txt

1. Creer un environnement virtuel
`python3 -m venv .venv; source .venv/bin/activate`
2. Installer le/les package(s) necessaire(s)
`pip install fastapi uvicorn`
3. En extraire le fichier requirements
`pip freeze > requirements.txt`

## ETAPE 3: Creer main.py

Lancer le serveur
`uvicorn main:app`

## ETAPE 4: Creer script check

Infos a check dans le Dockerfile:
- Pas d'utilisation d'image latest
- Defini un user qui ne soit pas root

