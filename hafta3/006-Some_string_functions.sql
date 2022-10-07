select CHARINDEX('e', 'Mehmetcan ESER')
-- e harfinin indexsini verir

select LEFT('Mehmetcan ESER', 3)
-- soldan baslar 3 karakter al�r

select RIGHT('Mehmetcan ESER',3)
-- sagdan baslar 3 karakter al�r

-- simdi isim ve soyisimin bir kolonda tututldugu dusunulsun ve isim ile soyisimin ayr�lmas�
-- gerekmektedir. isim ile soyisimi ayr�n�z

select 'Mehmetcan ESER' as isim_soyisim -- isim ile soyisimin bitisik hali

select LEFT('Mehmetcan ESER', CHARINDEX(' ','Mehmetcan ESER')- 1) as isim,
-- bosluga kadar aldi bosluk karakteri de dahil lakin 1 c�kar�rsak bosluk karakterini c�karm�s oluruz
 RIGHT('Mehmetcan ESER', LEN('Mehmetcan ESER') - CHARINDEX(' ' , 'Mehmetcan ESER')) as soyisim
-- uzunluktan aradaki boslugun index numaras�n� c�kar�rsak soyisimi buluruz

-- deg�sken tan�mlama
-- cumle degiskeninin icinde bugun kelimesi kac defa geciyor bunu bulan komutu yaz�n�z
declare @cumle as varchar(max)
set @cumle = 'Bug�n hava �ok g�zel. Bug�n d��ar� ��kaca��m.'

declare @len1 as int 
set @len1 = LEN(@cumle)
-- cumle degiskeninin uzunlugunu atad�k

set @cumle = REPLACE(@cumle,'Bug�n','')
-- cumle degiskeninden bugun kelimesinin yerine '' koyduk. replace degistirmeye yarar

declare @len2 as int
set @len2 = LEN(@cumle)

select (@len1 - @len2) / LEN('Bug�n')

-- len1'den len2'yi c�kar�p arad�g�m�z kelmenin uzunluguna bolersek kac defa gectigini buluruz



