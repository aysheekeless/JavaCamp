
--Burada use,create,insert,update,delete,tarih hesaplama(DATEDIFF,GETDATE), 
--truncate komutu where kosulu order by(NEWID), top komutu konular� islenm�st�r

--intro veritaban�n� kullanmas� icin bunu yazd�k bazen baska veritabanlari uzerinde 
--islem yap�yor
use intro

--veritabanini olusturur
create database intro

--intro veritabanina bir tablo olusturur tablo ad� ve sutunlar ekledik
create table CUSTOMERS(
--id'nin turu int not null ile bos gecilemez dedik ayr�ca primary key yapt�k
--identity ile benzersizlik ve otomatik artma verdik (0,1) degeri 0'dan basla birer birer art demek
customer_id int not null primary key identity(0,1),
customer_name varchar(50) not null,
customer_birthday date not null,
--telefon numaralar� hep farkl� benzersiz oldugu icin unique ozelligini verdik
--char veri tipinde yapt�k cunku uzunlugu sabit bir ozelliktir telefon numaras�
customer_phone char(10) not null unique,
--yas bos gecilebilir yapt�k
customer_age int,
city varchar(20) not null,
gender char(1) not null
)

select * from CUSTOMERS

---INSERT ��LEM�---------------------------------------------------------------------------------------------------------------------------
--tabloya veri ekler tablo ad� yaz�l�r ve sutun adlar� yaz�l�r
--ekleme yaparken customer_id vermemeliyiz biz onu otomatik artan yapt�g�m�z icin
insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
-- sonrada eklenek veriler values icine yaz�l�r string date tek t�rnak icinde yaz�l�r
-- ayr�ca date yaz�l�rken y�l-ay-gun s�ras�nda aralar�nda bir tire veya tiresiz olarak yaz�labilir
values
('Can ESER', '2001-08-08',1111111111,'Sivas','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Nihat ESER', '1971-10-17',2222222222,'�zmir','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Fatma ESER', '1977-01-01',3333333333,'Mersin','K')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Furkan ESER', '2003-02-23',4444444444,'Bolu','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Emirhan ESER', '2009-07-30',5555555555,'Hakkari','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Mehmet ESER', '1940-04-13',6666666666,'Mersin','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Hacer ESER', '1950-12-04',7777777777,'Samsun','K')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Osman ERBA�', '1941-06-28',8888888888,'Rize','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('M�krime ERBA�', '1949-11-11',9999999999,'Mu�la','K')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Gaffar Okan ERKAN', '2001-05-12',0000000000,'Denizli','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Volkan �EK�P', '1997-10-16',1,'Mersin','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Song�l BOZKURT', '1983-01-13',2,'Burdur','K')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Salih �O�KUN', '2001-05-12',3,'Denizli','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Ezgi MOLA', '19860610',4,'Denizli','K')

select * from CUSTOMERS

--UPDATE ��LEM�-------------------------------------------------------------------------------------------------------------------------------

-- bu kod cal�smaz nedeni su biz bir kosul belirtmedik dolay�s�yla butun tablodaki telefon numaralar�n� 
-- 1 yapacak buna izin vermez cunku biz yukar�da telefon numaralar�n� unique(benzersiz) yapm�st�k dolay�s�yla 
-- telefon numaralar�n�n ayn� olamas�na izin vermez
update CUSTOMERS set customer_phone = 1

-- b�rden fazla guncellemeyi virguller ile ay�rarak yapabiliriz
-- butun sehirleri sivas olarak ve yukarda yaslara deger vermem�st�k burada butun yaslara 20 yas�n� vererek guncelledik
update CUSTOMERS set city = 'Sivas', customer_age = 20

select * from CUSTOMERS

-- simdi musterilerin gercek yaslar�n� bulal�m ve onu guncelleyelim
-- bunlar sql fonksiyonlar�d�r: datediff(), getdate()
-- datediff fonksiyonu iki tarih aras�ndaki farki al�r. icine parametreler verdik year parametresi fark�n y�l c�ns�nden bulunmas�n� saglar,
-- customer_birthday ile musterinlerin yaslar�n� verdik, getdate ile s�md�ki yan� bugunun tar�h� almas�n� soyled�k
-- yani bugunun tarihinden muster�lerin dogum tarihlerini c�karad� ve b�ze y�l olarak gosterdi

update CUSTOMERS set customer_age = DATEDIFF(YEAR,customer_birthday,GETDATE())

select * from CUSTOMERS

---DELETE ��LEM�-------------------------------------------------------------------------------------------------------------

-- bir kosul belirmedigimiz icin tablonun icindeki kay�tl� olan butun musterileri siler lakin tabloyu silmez drop ile kar�st�rma 
-- drop table direk tabloyu siler 

delete from CUSTOMERS

select * from CUSTOMERS

---TRUNCATE KOMUTU---------------------------------------------------------------------------------
--tabloyu ilk olusturdugumuz haline donderen bir komuttur.Sanki yeniden olusturmusuz gibi icindeki tum verileri silen bir komuttur
--peki delete komutundan fark� nedir diye sorarsak? eger tablomuzda otomat�k artan bir ozellik varsa delete yapt�g�m�zda veriler
--silindiginde en son veri hangi degeri ald�ysa yeni veri ekledigimizde oradan devam eder.Yani 1000 verimiz varsa ve
--otomat�k artan bir ozellik ise delete yapt�g�mzda yeni veri 1001'den devam eder. Ayr�ca delete islemi yavas bir islemdir.
--truncate islemi ise hem delete islemine gore daha hizli hemde veriler silindiginde delete gibi kald�g� yerden devam etmez
--s�f�rdan baslar dolay�sla silme islemlerinde delete degil truncate daha cok kullanilir
--truncate table tablo_ad� sekl�nde kullanilir
truncate table CUSTOMERS


---WHERE KO�ULU------------------------------------------------------------------------------------------
--where kosulu ile beraber kullan�lan bazi operatorler vard�r bunlar =, <, >, >=, <=, <>...
--where kosulu sadece select komutunda degil delete, update, insert gibi komutlar�nda da kullanilabilir
select * from CUSTOMERS where customer_name = 'Can ESER'
select * from CUSTOMERS where customer_age >= 50
select * from CUSTOMERS where city <> 'sivas'
select * from CUSTOMERS where not city = 'sivas'
-- <> 'sivas' ile not city 'sivas' ayn� komuttur ikiside sivas disinda ki illeri getirir

select * from CUSTOMERS where customer_age between 20 and 30 
-- 20 yas� ile 30 yas� aras�ndaki degerleri getirir 20 ile 30'da bu s�n�rlara dahil

select * from CUSTOMERS where customer_name like 'Gaf%'
--Gaf ile baslayan degeri getirir

select * from CUSTOMERS where customer_name like '%i%'
-- ismi icersinde i harfi olanlar� getirir

select * from CUSTOMERS where customer_name like '%�'
--ismi � ile bitenleri getirir

select * from CUSTOMERS where customer_name not like '%m%'
--ismi icinde m harfi icermeyenleri getirir

select * from CUSTOMERS where city in('Sivas','Mersin')
--sehiri sivas veya mersin olan kay�tlar� getirir

update CUSTOMERS set gender = 'F' where gender = 'K'
update CUSTOMERS set gender = 'M' where gender = 'E'

--cinsiyetlerin isimlerini guncelledik Male ve Female olarak where kosulunu koymasak hepsini ayn� yapar

select * from CUSTOMERS where customer_age >=30 or city ='Mersin'
--birden fazla kosulu baglay�p sorgu yapabiriz

--Coklu kosula bir ornek yapal�m ornegin:
-- select * from customers where city = 'Sivas' and district = 'Zara' and district = 'Kangal'
-- bu sorguda ilk bak�sta olarak dogru gibi gorunsede asl�nda mant�ksal olarak yanl�s bir sorgudur
-- bu sorguda biz sehirini sivas diye belirttik bunda sikinti yok ama bolgesini ayni anda hem zara hemde kangal
-- olanlari sorgulad�k bu durumda gecerli degildir birinin bolgesi ayn� anda iki farkl� yer olamaz dolay�s�yla bu sorgu 
-- yanl�st�r. Araya OR koyarsak o zaman dogru olur. 
-- select * from customers where city = 'Sivas' and district = 'Zara' or district = 'Kangal'
-- sehiri sivas olup bolgesi zara veya kangal olanlar� getir demis olduk

select * from CUSTOMERS where gender = 'M' and customer_birthday between '19450101' and '20220101'
-- cinsiyeti erkek olan ve dogum tar�hleri 01/01/1945 ile 01/01/2022 aras�nda ki kisileri getirdi
-- tarihi boyle tiresiz gondermek en dogru kullan�md�r.boylece platformdan bag�ms�z oluyoruz.yine y�l-ay-gun sekl�nde

--DISCTINCT KOMUTU------------------------------------------------------------------------------------------
-- tekil verileri cekmede kullan�l�r. Yani birden fazla tekrar eden verilerde hepsini getirmeyip tekli tekli getirmeye yarar
-- select distinct sutun ad� from tablo ad�

--customers tablosundan sehirleri getirir lak�n birden fazla ayn� sehir varsa onlar� get�rmez bir tanesini getirir
select distinct city from CUSTOMERS

--customer tablosundan cinsiyeti getirir lakin denizlidekileri
select distinct gender from CUSTOMERS where city = 'Denizli'


--ORDER BY KOMUTU----------------------------------------------------------------------------------
-- order by s�ralama da kullan�l�r iki degeri var ASC ve DESC 
-- ASC kucukten buyuge dogru s�ralama yapar yada alfabetik olarakta A'dan Z'ye dogru
-- DESC buyukten kucuge dogru s�ralama yapar yada alfabetik olarak Z'den A'ya dogru default degeri ASC

--muster�leri A'dan Z'ye dogru s�ralar
select * from CUSTOMERS order by customer_name asc 

-- birden fazla s�ralama yap�lab�l�r cinsiyeti kucukten buyuge dogru s�ralar sonra isimlere gecer onlar�da Z'den A'ya s�ralar
-- ilk once cinsiyeti s�ralar sonra ismi siralar 
select * from CUSTOMERS order by gender asc, customer_name desc

--denizli sehirindeki musterileri tersten s�ralar
select * from CUSTOMERS where city = 'Denizli' order by customer_name desc

--kolon numaras�na gorede s�ralar yani 3. kolon olan dogum tar�h�ne gore bir siralama yapt�
select * from CUSTOMERS order by 1

-- rastgele bir siralama yapmak istiyorsak NEWID() fonksiyonu kullanilir

select * from CUSTOMERS order by NEWID()
---TOP KOMUTU----------------------------------------------------------------------------------------------------
--Ne kadar veri cekmek veya gormek istiyorsak ona yar�yor
-- select top n sutun_adi from tablo adi varsa sartl� ifade
-- n burada ne kadar veri cekmek istiyorsak onu yaz�yoruz

-- 3 tane musteri getirir ve isme gore s�rali bir sekilde
select top 3 * from CUSTOMERS order by customer_name 

-- percent yuzde demek yani burada 50%'ni getir dedik ve 3. kolona gore s�rala dedik yani dogum tar�h�ne gore
select top 50 percent * from CUSTOMERS order by 3
