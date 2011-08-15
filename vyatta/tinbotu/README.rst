vyatta.config.boot
==================

- eth0 が 家サーバのルータ側

- eth4 が USB ether で CentreCOM スイッチ側

- DNS forwarding じゃなくて vyatta 自身で解決する方法がわからなかった (bind とかいれないとだめ?)



8216XL2.config.txt
==================

VLAN
----

- port 16:    ALL, tagged   これを vyatta の eth4 と繋ぐ。

- port 11-15: ALL, untagged 

- port 2-10:  VLAN それぞれのポート と 16, untagged


環境
====

- 192.168.20.10

  - 家サーバ (DNS, ルータになっていてここから外へ出る)

