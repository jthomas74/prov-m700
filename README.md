prov_m700_global.pl :
=====================

Generation des fichiers :
-------------------------

```./prov_m700_global.pl -fg conf_m700.txt –gl```(avec configuration LDAP).

```./prov_m700_global.pl -fg conf_m700.txt –gs``` (sans configuration LDAP).

Dans le cas où la génération est commandée avec l’option « -gl », le script génère deux fichiers xml
nommés ainsi :

m700-global-ldap-{@MAC}.xml

m700-{@MAC}-firmware.xml

Dans le cas où la génération est commandée avec l’option « -gs », le script génère deux fichiers xml
nommés ainsi :

m700-global-{@MAC}.xml

m700-{@MAC}-firmware.xml

Les fichiers m700-global-ldap-{@MAC}.xml et m700-global-{@MAC}.xml sont utilisés par la borne
quand celle-ci redémarre et va chercher sa configuration sur le XiVO.

Le fichier m700-{@MAC}-firmware.xml est utilisé par le script quand on l’appel avec l’option « -s ».

Envoi de la configuration :
--------------------------

```./prov_m700_global.pl -fg conf_m700.txt -s -IP <IP_de_la_borne>```

Quand vous exécutez le script, il faut spécifier le fichier de config, car l’adresse MAC de la borne est
récupérée dans le fichier, ainsi que le login et le mot de passe de la borne.

prov-m700-extensions.pl :
=========================

Generation des fichiers :
-------------------------

```./prov-m700-extensions.pl -g -fg conf_dect.txt```

```./prov-m700-extensions.pl -g -fg <fichier_de_conf.txt>```

Le script génère le fichier de configuration dans le dossier ou le script a été lancé. Le fichier généré
sera nommé ainsi :

dect-{Compte_SIP}.xml (exemple : dect-wk2m8p.xml)

Envoi de la configuration :
--------------------------

```./prov-m700-extensions.pl -s -fs dect-107987.xml -U "admin" -P pass-file -H 10.10.10.10```

```./prov-m700-extensions.pl -s -fs <fichier.xml> -U "login_borne" -P <fichier_pass> -H <IP_Borne>```

Quand le script est exécuté en mode envoi, il envoie une commande en POST via curl pour charger la
configuration du combiné sur la borne. Dans ce cas de figure, il n’y pas besoin de redémarrer la
borne pour que la configuration soit chargée.
