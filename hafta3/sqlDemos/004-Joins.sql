-- Bu derste Joinler ve turleri, Joinler ile update ve delete yapma
-- ve UNION konusu islemleri islenmistir

use e_ticaret

-- biz her kullanicinin adresini bir tabloda gormek istiyorsak bu yontem ise yaramaz cunku 
-- bu yontem iki tablo getirir dolay�s�yla birlestirmemiz laz�m
select * from USERS
select * from ADDRESSES
----------------------------------------------------------------------

-- burada where kosulunu kullanarak her kullanicinin adresini bir tabloda gorduk
select USERS.*, ADDRESSES.address_text from USERS,ADDRESSES 
where USERS.id = ADDRESSES.user_id_
----------------------------------------------------------------------

-- bu sorguda ise id = 1 olan kullanicinin adreslerini goruntuledik
-- temel anlamda iliskisel veri tabanlarini b�rlestirip sorgu cekmenin en temel yontemi budur
-- temel yap�y� yazacak olursak
-- select A.Kolon1, A.Kolon2, B.Kolon1, B.Kolon2... from A, B where A.PK = B.FK seklindedir 
select USERS.*, ADDRESSES.address_text from USERS,ADDRESSES
where USERS.id = ADDRESSES.user_id_ and USERS.id = 1
-----------------------------------------------------------------------

--Alias kullan�m�

--yukar�daki sorguda tablo adlar�n� her defas�nda uzun uzun yaz�yoruz alias kullanarak 
--bu tablo adlar�na bir k�saltma verebiliriz ve alias ile sutunlar�n basl�klar�n�da takma ad verebiliriz
--tablolara takma ad vermek icin from tablo_adi as takma_ad seklinde bir format izlenebilir 

select U.full_name, U.birthdate, U.gender, U.phone_number, 
A.address_text
from USERS as U, ADDRESSES as A
where U.id = A.user_id_ and U.id = 1
-------------------------------------------------------------------------------

--yukar�da ki sorgu da sutunlara bir takma ad vermedik burada ise hem tablolara hem de
--sutunlara bir takma ad verelim

select U.full_name as [Ad Soyad], U.birthdate as [Do�um Tarihi], U.gender as Cinsiyet, U.phone_number as [Telefon Numaras�],
A.address_text as [A��k Adresi]
from USERS as U, ADDRESSES as A
where U.id = A.user_id_ and U.id = 1

-- sutunlara verilen takma isimler ise sutunlar�n adlar�ndan sonra geliyor ayr�ca baz� yerlerde 
-- koseli parantez kullanildi. Bunun anlam� aralar�nda bosluk olan kelimeleri sql'e bir kelimeymis diye
-- gostermek (Ad Soyad aralar�nda bir bosluk var)

-------------------------------------------------------------------------------

-- biz kullanicilar�n sadece adreslerini degil ulke il ilce gibi ozelliklerini de gormek istiyorsak
-- bunun icin en temel anlamla diger tablolar�da where kosulu ile baglayabiliriz

select 
U.full_name as [Ad Soyad],
U.birthdate as [Do�um Tarihi],
U.gender as Cinsiyet,
U.phone_number as [Telefon Numaras�],
A.address_text as [A��k Adres],
C.country as �lke,
CT.city as �ehir
from USERS as U, ADDRESSES as A, COUNTRIES as C, CITIES as CT
where 
U.id = A.user_id_ and 
C.id = A.country_id and
CT.id = A.city_id
order by U.full_name

----------------------------------------------------------------------------------

-- her kullanicinin adres say�s�n� ve bu adreslerin kac tane ulkede oldgunu bulan sorgu
select 
U.full_name, count(A.id) as [Adres Say�s�], count(distinct C.country) as [�lke Say�s�]
from USERS as U, ADDRESSES as A, COUNTRIES as C, CITIES as CT
where 
U.id = A.user_id_ and 
C.id = A.country_id and
CT.id = A.city_id

group by U.full_name

--------------------------------------------------------------------------------
-- ikiye esit veya daha fazla adresi olan kullanicilari getir dedigimizde olay�n icine having giriyor
-- cunku group by ile where bir kullanilmiyor.Dolay�s�yla boyle bir sart� sorgulamak icin 
-- having kullanilir

select 
U.full_name, count(A.id) as [Adres Say�s�], count(distinct C.country) as [�lke Say�s�]
from USERS as U, ADDRESSES as A, COUNTRIES as C, CITIES as CT
where 
U.id = A.user_id_ and 
C.id = A.country_id and
CT.id = A.city_id

group by U.full_name
having count(A.id)>= 2

-----------------------------------------------------------------------------------
-- Yukarida ki sorgular asl�nda yetersizdir hep where kosulu kullanarak yap�lmaktad�r
-- bunun yerine art�k joinler kullan�lmaktadir
-- temel yap�s� soyledir
-- select A.Kolon1, A.Kolon2... from A join B on A.PK = B.FK seklindedir

select U.full_name, U.birthdate, A.address_text 
from USERS as U
join ADDRESSES as A on A.user_id_ = U.id
----------------------------------------------------------------------
-- birden fazla tabloda birlestirilebilir
select U.full_name, U.birthdate, A.address_text, C.country, CT.city
from USERS as U
join ADDRESSES as A on A.user_id_ = U.id
join COUNTRIES as C on C.id = A.country_id
join CITIES as CT on CT.id = A.city_id

-- bu kullan�m ayn� zamanda inner join olarak gecer
-- sonucta tablolar�n kesisimlerini al�yoruz
--------------------------------------------------------------------

-- join'nin turleri bulunmaktad�r 
-- inner join,left join, right join, full join
------------------------------------------------------------------

-- INNER JOIN 
-- bu birlestirme islemi asl�nda kesisim alma islemidir
-- elimizde iki tane kume(tablo) oldugunu dusunelim bu iki kumenin kesisimine
-- inner join denilmektedir. Peki iki kume(tablo) aras�nda ki kesisimi ne saglar
-- diye sorarsak. Bu kesisimleri birinde bulunan primary key diger kumede bulunan
-- foreign key bu kesisimi saglamaktad�r

/*
A kumesi(tablosu)                    B kumesi(tablosu)
-------------------                ---------------------------
| id      user    |                | id    user_id    city   |
|  1      can     |                |  1      1        ankara |  
|  2      ali     |                |  2      1        sivas  |
|  3      veli    |                |  3      2        nigde  |
|  4      alp     |                |  4      3        rize   |
|  5      mehmet  |                |  5      3        sivas  |
-------------------                |  6      6        mugla  |
                                   |  7      10       kars   |
                                   ---------------------------
              
bu tablolar da ortan olan a kumesinde id (primary key) ile b kumesinde ki 
user_id(foreign key). Dolay�s�yla kesisim kumemiz

               kesisim kumesi(tablosu) (inner join)
                    -------------------------
					|  user         city    |
                    |  can          ankara  |
                    |  can          sivas   |
                    |  ali          nigde   |
                    |  veli         rize    |
                    |  veli         sivas   |
                    -------------------------
goruldugu gibi alp ve mehmet kullanicisinin kesisim tablosunda isi yok ayn� sekilde
mugda adl� sehir ile kars adl� sehrinde kesisim tablosunda isi yok 
(veri taban� sekl�nde dusunursen mugla ve karsin bir kullanicisi olmak zorunda 
cunku foreign key'ler lakin burada kumeler sekl�nde dusun)

LEFT JOIN

burada soldaki tablo a kumesi left olurken right tablosu b kumesi olmaktadir

left join ise a tablosunu getir ve a ile b'nin kesisiminide getir demek oluyor

                        left join
                   ----------------------- 
                   |  user       city    |
                   |  can        ankara  | 
                   |  can        sivas   |
                   |  ali        nigde   |
                   |  veli       rize    | 
                   |  veli       sivas   | 
                   |  alp        NULL    | 
                   |  mehmet     NULL    |
                   -----------------------
RIGHT JOIN 
left joinin tam tersidir
sag tarafta ki tablo baz al�n�r 


                        right join
                   ----------------------- 
                   |  user       city    |
                   |  can        ankara  | 
                   |  can        sivas   |
                   |  ali        nigde   |
                   |  veli       rize    | 
                   |  veli       sivas   | 
                   |  NULL       mugla   | 
                   |  NULL       kars    |
                   -----------------------              

FULL JOIN 

iki kumeyide getiren bir birlestirme islemidir. Aralarinda baglant�(kesisim) olsun
olmas�n birlestirir

                        full join
                   ----------------------- 
                   |  user       city    |
                   |  can        ankara  | 
                   |  can        sivas   |
                   |  ali        nigde   |
                   |  veli       rize    | 
                   |  veli       sivas   | 
                   |  alp		 NULL    | 
                   |  mehmet     NULL    |
                   |  NULL       mugla   |
                   |  NULL       kars    |
                   -----------------------   
*/                     

-- Bu tablolar joinlerin sorgular� icin olusturulmustur
create table test_user
(
user_id tinyint primary key identity(1,1),
user_name varchar(10)
)
insert into test_user(user_name)
values('can'),('ali'),('veli'),('alp'),('mehmet')


create table test_address
(
address_id int primary key identity(1,1),
user_id tinyint foreign key references test_user(user_id),
address_city varchar(10)
)
insert into test_address(user_id,address_city)
values(1,'sivas'),(1,'ankara'),(2,'nigde'),(3,'rize'),(3,'sivas'),(6,'mugla')


select * from test_user
select * from test_address
----------------------------------------------------
--inner join icin kesisim (inner keyword yazmasakta olur)
select t_u.user_id as ID, t_u.user_name as users, t_a.address_city
from test_user as t_u
inner join test_address as t_a on t_a.user_id = t_u.user_id 

----------------------------------------------------
-- Left join 
-- solda kalan tabloyu belirlemek icin join'nin solunda ki tablo sol tablo
-- sag�nda ki tablo sag tablo olarak gecer
-- test_user as t_u left join sol tablo
-- left join test_address as t_a ise sag tablo olarak geciyor
-- ayn� sey right join icinde gecersi
select t_u.user_id as ID, t_u.user_name as users, t_a.address_city
from test_user as t_u
left join test_address as t_a on t_a.user_id = t_u.user_id 

-----------------------------------------------------

-- Right join (hepsi kesistigi icin bir fark gorunmuyor gibi duruyor)
select t_u.user_id as ID, t_u.user_name as users, t_a.address_city
from test_user as t_u
right join test_address as t_a on t_a.user_id = t_u.user_id

--------------------------------------------------------------

-- full join (hepsini alir)
select t_u.user_id as ID, t_u.user_name as users, t_a.address_city
from test_user as t_u
full join test_address as t_a on t_a.user_id = t_u.user_id

--------------------------------------------------------------------

-- JOIN KULLANARAK UPDATE YAPMA
-- bir tane ara tablo yapt�k bu tabloya degerleri test_user tablosundan atacag�z
-- test_user2 tablosuna 5 tane can ismi girdim sonra bu degerleri test_user tablosundan
-- isimleri cekerek test_user2 tablosunu guncelledim
create table test_user2
(
user_id int primary key identity(1,1),
user_name varchar(10)
)
insert into test_user2(user_name)
values('can'),('can'),('can'),('can'),('can')


update test_user2 set user_name = test_user.user_name 
from 
test_user inner join test_user2 on test_user.user_id = test_user2.user_id
-- bu sorgu tum kisiler uzerinde guncelleme yapar
-- where kosula koyabiliriz
-- where test_user2.user_name like '%a%'
-- icinde a gecen kisilere uygula

-----------------------------------------------------------------

--JOIN KULLANARAK DELETE YAPMA

delete test_user2 from test_user inner join test_user2 
on test_user.user_id = test_user2.user_id
where test_user2.user_name like '%a%'
-- icinde a harfi gecen kisileri sil

select * from test_user2

------------------------------------------------------------------

-- UNION KOMUTU

--union ile iki sorguyu birlestirebiliriz bu konu daha iyi anlas�ls�n diye
--burada bir tablo olusturacagim adi test_cities
--bu test_cties ile cities tablolar� uzerinde union uygulayacag�m

create table test_cities
(
city varchar(20)
)
insert into test_cities
values('Sivas union'),('Balikesir union'),('Liverpool'),('Nevada union'),('Madrid'),('Barcelona')


-- test_cities tablosuna bir kac deger girdim
-- Sivas union, Bal�kesir union, Liverpool, Nevada union , Madrid, Barcelona
select * from CITIES
select * from test_cities

-- bu iki sorguyu cal�st�rd�g�m da iki farkl� tablo gelir. union ile sorgular�
-- birlestirebiliriz
-- Bu sorgu sonucunda 17 sonuc dondu

select * from CITIES union select * from test_cities
-- sorguyu boyle yazarsak hata al�r�z cunku iki tabloda da kolon say�lar� farkl�
-- uzerinde islem yapt�g�m�z kolonlar�n t�pleri ve sayilari esit olmalidir

select CITIES.city from CITIES
union 
select * from test_cities
-- bu sorgu sonucunda 14 sonuc dondu. 3 tanesini almadi cunku ayni olanlari almali
-- bunlar Liverpool, Madrid, Barcelona iki tabloda da vard�
-- eger ayn� olanlar� da almak istiyorsak all demeliyiz

select CITIES.city from CITIES
union all
select * from test_cities
