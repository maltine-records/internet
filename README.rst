==================================
もうなんかやけくそでサマーオブラブ
==================================

ネットワーク
============

- https://cacoo.com/diagrams/YToAO6tiP1WwJQEV

Vyatta
======

X-Forwarded-For
---------------

- http://www.vyatta.org/forum/viewtopic.php?p=69266&sid=05702179a928d6547881f89b79064935

- /etc/squid3/local.conf に追記すれば forwarded_for off が on で上書きされる

  - https://gist.github.com/1145853

Parent Proxy
------------

SNMP
----

BridgeMIB
^^^^^^^^^

- RFC 1493

  - IETF / http://www.faqs.org/rfcs/rfc1493.html

  - DD-WRT / http://www.dd-wrt.com/forum/viewtopic.php?t=2443

- IEEE

  - http://www.ieee802.org/1/pages/MIBS.html

    - http://www.ieee802.org/1/files/public/MIBs/IEEE8021-BRIDGE-MIB-200810150000Z.txt

もうなんかやけくそでサマーオブラブ
==================================

課題や反省点
------------

- SNMPマネージャなどの監視の設定を甘くみていた

  - 特に無線LANアクセスポイントに接続しているクライアント数を記録したかったが対応が遅くなってしまった

  - munin罰の発生

    - 設定や挙動がブラックボックスになってて、どこでとまってるのか特定できずに一晩費やして結局動かせず

    - mrtgのほうがトラフィックのみ表示されてシンプルでよかった。トラフィック以外を出力する方法がわからないが…

    - snmpgetコマンドでほしいデータだけ収集して別のサーバーに投げるスクリプト書くほうが気楽だったりして

- IEEE 802.11a/b/g/n の対応状況の把握

  - iPhone 4で 11a が使えると思っていたことなど

- VyattaマシンにNICをさすたびに eth0, eth1, eth2, ... とインターフェース名が変化してしまう

  - 固定する方法があったはずなので調べる

- @mapi の ALIENWAREはクズ

  - ネットワークの設定ではなくて、検証にしようしているマシンの不具合も疑おう

- アクセスポイントあたりに接続するユーザ数が増えると機器が正常に動かない

  - アクセスポイントが出力する電波強度をわざと弱くし、物理的な配置を考えるなどすればよいかもしれない

