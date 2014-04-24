====
東京
====
http://tokyo-0505.cs8.biz/

::

        2014/05/05 東京 Maltine Records at 恵比寿 LIQUID ROOM + KATA
        OPEN: 15:00 OPEN/START
        CLOSE: about 22:00?
        ADV:3,300JPY, DOOR:3,800JPY 
        EBIS LIQUIDROOM  http://www.liquidroom.net/
        東京都渋谷区東3-16-6 / TEL: 03.5464.0800
        ※未成年入場可!!!
        ※再入場不可 


やること
========


恵比寿リキッドルーム(キャパ1,000位?)で WiFi を構築
--------------------------------------------------

- ほとんどが 802.11a/g/n スマートフォン

- 8割強が Apple 製品


今回の課題
==========

- 会場が 1F, 2F に分かれていて、会場敷設のUTPを利用できないため UTP 敷設が大変

- 会場の回線は利用できない（フレッツを契約）

- セッティングは3時間

- iBeacon の実験を行うため、2.4GHz帯の汚染が予想される

  - Applix の方に AFH (Adaptive Frequency Hopping) の調査を同時にしてもらえて結果を見たいですね…。



会場の概要
==========


恵比寿リキッドルーム

http://www.liquidroom.net/access/


回線は以下の通り


- フレッツネクストを契約

  - 楽屋3の壁の中に終端、ルータ(IX2025)を設置、ここから1Fまで(約80m実測値), 2Fまで(40m実測値)


- 会場敷設の LAN ケーブルは使用不可

  - 1F メインフロアのPAブースに来ているUTPは事務所（家庭用ルータ）へ直結されているため使用不可。

    - 当日は1FメインフロアのPAブースの AirMac Express を停波してもらい、撤収時に現状復帰



配線概念
========

2F 第3楽屋に IX2025 を設置(コアルータ)。


- 1F メインステージ 舞台下手 

  - L2SW Catalyst 2940

    - 1F VJブース（客席下手）

    - AP 8 1F ラウンジ (11/38) (PWRINJ)

      - 2F からきている長い UTP ケーブルを受ける 

      - VJブースとラウンジへ分ける役割

 
- 1F VJブース (客席下手)

  - L2SW Alaxala AX1230P (PoE)

    - 有線接続 PC (監視用)

    - AP 1 ステージ下手ハウススピーカ前 (1/36)

    - AP 2 ステージ上手ハウススピーカ前 (11/44)

    - AP 3 VJブース中 (6/48)

    - AP 4 客席奧下手 エアコン上 (1/64)

    - AP 5 客席奧上手 エアコン上 (11/56)

    - 有線接続 2.5D Ustream 向け

      - 客席奧のケーブル長が長くなるためVJブースで一旦 PoE SW を設置

      - 客席奧のエアコン上への AP 設置はちょっと掃除が必要かも…（ホコリがやばい）

      - フロアが階段状になっているので養生を念入りに行う



- 2F KATA & 物販 & 憩いスペース

  - L2SW Catalyst3524PWR (PoE)

    - AP 7 KATA前 (1/44)

    - AP 8 物販周辺 (11/38)

      - KATA (サブフロア) は防音扉になっており UTP ケーブルを入れることができない。KATA 前にAPを設置して壁抜けに期待する

    - AP 9 楽屋内, ルータと同じ場所 ( 努力目標 )




平面図
======

平面図とAP設置計画と配線計画

`平面図の拡大(PDF)
<https://github.com/maltine-records/internet/raw/master/img/tokyo0505_map3.pdf>`_

.. image:: https://github.com/maltine-records/internet/raw/master/img/tokyo0505_map3_1.png

.. image:: https://github.com/maltine-records/internet/raw/master/img/tokyo0505_map3_2.png

`平面図の拡大(PDF)
<https://github.com/maltine-records/internet/raw/master/img/tokyo0505_map3.pdf>`_


UTPケーブル対向表
=================

別途対向表

- 80m * 1

- 50m * 2

- 40m * 1

- 35m * 1

- 30m * 2

- 20m * 1

- 15m * 1

- 3m * 5

- パッチケーブル

計 359m


SSID とか
=========

- SSID

  - Tokyo_WiFi  (5GHz)

  - Tokyo_WiFi_g (2.4GHz)


- 暗号化

  - Authentication open


準備済のもの
==============


tinbotu
-------

- IX2025

  - CoreGW, DHCPv4Server, DNSProxy

- Alaxala AX1230P
  
  - 24 ポート L2SW / 100BASE-TX / 802.3af PoE (170W)

- Catalyst WS-C3524-PWR-XL

  - 24 ポート L2SW / 100Base-TX / Cisco PoE (not 802.3af)

- Catalyst WS-C2940-8TT-S * 1

  - 8 ポート L2SW / 100Base-TX

- Cisco AIR-AP1242AG-P-K9 * 9台

  - Cisco AIR-ANT2422DB-R(2.4G Antenna) * 18

  - Cisco AIR-ANT5135D-R(5G Antenna) * 18

- Cisco PoE パワーインジェクタ + AC * 4

  - Cisco AIR-PWRINJ3= * 4

  - Cisco AIR-PWR-B= * 4

- 標準AC電源ケーブルとアドン変換 * 8

- AC 延長タップ * 5

- RJ45 コンソールケーブルとUSBtoSerial

- 監視PC (CF-T5)

- パーマセル

- 無線インカム * 3

- UTP準備中


買わないといけないもの
======================

- UTP, RJ45



前回の反省をふまえて
====================

- **ケーブルを外す前に必ずタグをつけて！** （テープを少し巻いてペンで何がつながってたか書くだけだよ）

- 基地はVJブース中（メインステージ下手）
  
  - 爆音なので耳栓推奨

- SSID とかを書いた大きな張り紙を多めに作る
  
.. image:: http://cache.gyazo.com/4bd9e3d7bb231a606570c3b8c308aee6.png

ダウンロード(JPG) `インターネットあります(A)
<https://github.com/maltine-records/internet/raw/master/img/yama_wifi_A.jpg>`_

ダウンロード(JPG) `インターネットあります(B)
<https://github.com/maltine-records/internet/raw/master/img/yama_wifi_B.jpg>`_



想定端末数
==========

メインホール
  400

1Fラウンジ
  100

2Fラウンジ+KATA
  200



会場の回線
----------

- フレッツ光ネクスト

  - 接続試験済(04/21 15:00)


