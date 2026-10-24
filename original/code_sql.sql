Drop database if exists etairia;
Create database etairia;
Use etairia;

Create table Ypokatasthmata(
id int,
onoma varchar(20),
poli varchar(20),
odos varchar(20),
arithmos int,
at_diefthinti varchar(10),
primary key(id));

Create table ThlefwnaYpok(
id int,
ThlefwnaY int,
primary key(id,ThlefwnaY),
constraint foreign key(id) references Ypokatasthmata(id));

Create table Pelates(
AT varchar(10),
onoma varchar(20),
epithero varchar(20),
poli varchar(20),
odos varchar(20),
arithmos int,
arithmos_ypok int,
primary key(AT));

alter table Pelates add constraint foreign key(arithmos_ypok) references Ypokatasthmata(id);

Create table Sinergazetai(
id int,
AT varchar(10),
primary key(id,AT),
constraint foreign key(id) references Ypokatasthmata(id),
constraint foreign key(AT) references Pelates(AT));

Create table Ypalliloi_eterias(
AT_ypall varchar(20),
onoma varchar(20),
epithero varchar(20),
hm_gen date,
misthos float,
hm_proslipsis date,
poli varchar(20),
odos varchar(20),
arithmos int,
arithmos_ypok int,
eidikothta varchar(15),
primary key(AT_ypall),
constraint foreign key(arithmos_ypok) references Ypokatasthmata(id));

Create table Texnikoi(
AT_ypall varchar(20),
eth_proip int,
hm_ask_epag date,
primary key(AT_ypall),
constraint foreign key(AT_ypall) references Ypalliloi_eterias(AT_ypall));

Create table Logistes(
AT_ypall varchar(20),
etos_ktisis date,
titlos varchar(40),
ep_oik_epimel char(50),
primary key(AT_ypall,etos_ktisis,titlos),
constraint foreign key(AT_ypall) references Ypalliloi_eterias(AT_ypall));

Create table Grammatis(
AT_ypall varchar(20),
etos_ktisis date,
titlos varchar(40),
ar_seminariwn int,
primary key(AT_ypall,etos_ktisis,titlos),
constraint foreign key(AT_ypall) references Ypalliloi_eterias(AT_ypall));

Create table Prost_melh(
AT_ypall varchar(20),
onoma varchar(20),
fillo varchar(10),
ilikia int,
primary key(AT_ypall,onoma,ilikia),
constraint foreign key(AT_ypall) references Ypalliloi_eterias(AT_ypall));

Create table Paragelia(
id_paragelias int,
hmerominia date,
dief_apost varchar(30),
hm_diek date,
kostos float,
AT_ypall_et varchar(20),
AT_pelath varchar(20),
primary key(id_paragelias),
constraint foreign key(AT_ypall_et) references Ypalliloi_eterias(AT_ypall),
constraint foreign key(AT_pelath) references Pelates(AT));

Create table Prointa(
kwdikos varchar(20),
Timh float,
eth_egg int,
paragwgos varchar(20),
Kathgoria varchar(20),
primary key(kwdikos));

Create table Prointa_Paragelias(
kwdikos varchar(100),
id_paragelias int,
constraint foreign key(kwdikos) references Prointa(kwdikos),
constraint foreign key(id_paragelias) references Paragelia(id_paragelias));

Create table Exei(
kwdikos varchar(20),
afm_prom int,
timh_prom float,
primary key(kwdikos,afm_prom,timh_prom),
constraint foreign key(kwdikos) references Prointa(kwdikos));

Create table Promitheftes(
afm_prom int,
onoma varchar(20),
poli varchar(20),
odos varchar(20),
arithmos int,
primary key(afm_prom));

alter table Exei add constraint foreign key(afm_prom) references Promitheftes(afm_prom);

Create table Thl_prom(
afm_prom int,
Thl_promitheftwn int,
primary key(afm_prom,Thl_promitheftwn),
constraint foreign key(afm_prom) references Promitheftes(afm_prom));

insert into Ypokatasthmata value(1,'nikos','athina','ermou',154,NULL);
insert into Ypokatasthmata value(2,'loulis','thessaloniki','aerodromio',56,NULL);
insert into Ypokatasthmata value(3,'giwrgos','patra','nikolaou',100,NULL);
insert into Ypokatasthmata value(4,'karanikolas','iwannina','kapou',234,NULL);
insert into Ypokatasthmata value(5,'mitsos','syros','filopapou',546,NULL);

insert into ThlefwnaYpok value(1,234234);
insert into ThlefwnaYpok value(2,565646);
insert into ThlefwnaYpok value(3,345346);
insert into ThlefwnaYpok value(4,566345);
insert into ThlefwnaYpok value(5,34645);

insert into Pelates value('ag9534','nikos','kalogeropulos','rodos','athinas',43,4);
insert into Pelates value('ak4346','thanasis','titopoulos','hrakleio','kornarou',23,5);
insert into Pelates value('ej6532','kwstas','apostolou','nea smirni','kalogritsas',64,1);
insert into Pelates value('ie9825','antonis','karanikolas','santorini','oia',75,2);
insert into Pelates value('fg8729','maria','iakovou','serres','kolokotroni',873,3);

insert into Sinergazetai value(1,'ag9534');
insert into Sinergazetai value(2,'ak4346');
insert into Sinergazetai value(3,'ej6532');
insert into Sinergazetai value(4,'ie9825');
insert into Sinergazetai value(5,'fg8729');

insert into Ypalliloi_eterias value('jf9685','iwanna','xatzialexandrou','1980-04-06',1045.67,'2015-05-13','nikaia','gewrg_labraki',56,3,'tamias');
insert into Ypalliloi_eterias value('ds3435','ioulia','karvela','1990-12-31',900.33,'2015-12-13','peirais','lesbou',34,1,'logistirio');
insert into Ypalliloi_eterias value('as3245','kwstas','panagiwtou','1976-05-27',945.87,'2000-05-15','karditsa','meteoron',43,4,'logistirio');
insert into Ypalliloi_eterias value('lp4632','giannis','papas','1968-01-29',1560.34,'1997-09-20','thessaloniki','aisopou',56,5,'simboul_pol');
insert into Ypalliloi_eterias value('ap1000','dimitris','papadoulos','1995-10-25',890.67,'2005-08-25','agrinio','porou',65,2,'service');

insert into Texnikoi value('ap1000',3,'2013-05-12');

insert into Logistes value('ds3435','2014-05-15','oikonomologos APTH','aristi');
insert into Logistes value('as3245','2000-06-18','logistis kapodistriako','leian kalos');

insert into Grammatis value('jf9685','2005-08-23','filologia kapodistriako',10);

insert into Prost_melh value('ds3435','ioulia','ginaika',27);
insert into Prost_melh value('lp4632','giannis','antras',49);

insert into Paragelia value(3456,'2017-04-12','athina Skoufa 13','2017-04-13',234.56,'ap1000','ak4346');
insert into Paragelia value(6754,'2017-06-05','thessaloniki Giavash 51','2017-06-15',500.50,'lp4632','ag9534');
insert into Paragelia value(2345,'2015-11-23','santorini dikaiosinis 11','2015-12-01',1234.24,'ds3435','ie9825');
insert into Paragelia value(4352,'2016-07-25','Hrakleio evans 12','2016-07-29',300.54,'lp4632','ak4346');
insert into Paragelia value(9837,'2016-09-14','syros Gouna 18','2016-09-20',345.59,'ds3435','ej6532');

insert into Prointa value('kl4353',345.53,2,'karelias','ixeia');
insert into Prointa value('ok8576',789.54,3,'savidis','tileorasis');
insert into Prointa value('ys5739',1049,2,'HP','PC');
insert into Prointa value('df8545',324.3,1,'logitech','pliktrologia');
insert into Prointa value('gf4738',435.43,5,'Samsung','TV');

insert into Prointa_Paragelias value('kl4353',3456);
insert into Prointa_Paragelias value('ok8576' 'df8545',6754);
insert into Prointa_Paragelias value('gf4738''df8545' 'kl4353',2345);
insert into Prointa_Paragelias value('df8545',4352);
insert into Prointa_Paragelias value('kl4353',9837);

insert into Promitheftes value(3234532,'gewrgiou','peiraia','filopapou',32);
insert into Promitheftes value(3453267,'panagiwtou','xania','nikitara',45);
insert into Promitheftes value(6435325,'kwtsovolos','xalandri','xalandras',56);
insert into Promitheftes value(4356326,'pc_building','syntagma','ermou',68);
insert into Promitheftes value(3426784,'zourbielakis','rethimno','papagianni',234);

insert into Thl_prom value(3234532,2105435464);
insert into Thl_prom value(3453265,2310435345);
insert into Thl_prom value(6435325,2103454356);
insert into Thl_prom value(4356326,2105674336);
insert into Thl_prom value(3426784,2410674526);

insert into Exei value('kl4353',3234532,250.7);
insert into Exei value('ok8576',3453267,700.4);
insert into Exei value('ys5739',4356326,950.35);
insert into Exei value('df8545',4356326,200.45);
insert into Exei value('gf4738',3426784,370.87);

select * from Ypokatasthmata;
select * from ThlefwnaYpok;
select * from Pelates;
select * from Ypalliloi_eterias;
select * from Sinergazetai;
select * from Logistes;
select * from Grammatis;
select * from Texnikoi;
select * from Prost_melh;
select * from Paragelia;
select * from Prointa;
select * from Promitheftes;
select * from Thl_prom; 
select * from Exei;

update Ypokatasthmata
set at_diefthinti= 'ds3435'
where id=2;

update Ypokatasthmata
set at_diefthinti= 'ap1000'
where id=1;

update Ypokatasthmata
set at_diefthinti= 'lp4632'
where id=5;

update Ypokatasthmata
set at_diefthinti= 'as3245'
where id=3;

update Ypokatasthmata
set at_diefthinti= 'jf9685'
where id=4;

select * from Ypokatasthmata;

update Ypalliloi_eterias
set misthos=misthos*1.1
where hm_proslipsis < '1997-12-31';

select * from Ypalliloi_eterias;

delete from Paragelia
where hm_diek < '2015-12-31';

select * from Paragelia; 