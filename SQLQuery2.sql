--1. Cho biết các chuyến bay đi Đà Lạt (DAD).
select *
from CHUYENBAY
where GaDen='DAD' 
--2. Cho biết các loại máy bay có tầm bay lớn hơn 10.000km.
select *
from MAYBAY
where TamBay > 10000
--3. Tìm các nhân viên có lương nhỏ hơn 10.000.
select *
from NHANVIEN
where Luong < 10000
--4. Cho biết các chuyến bay có độ dài đường bay nhỏ hơn 10.000km và lớn hơn 8.000km.
select *
from CHUYENBAY
where DoDai <10000 and DoDai > 8000
--5. Cho biết các chuyến bay xuất phát từ Sài Gòn (SGN) đi Ban Mê Thuộc (BMV).
select *
from CHUYENBAY
where GaDen='BMV' and GaDi='SGN'
--6. Có bao nhiêu chuyến bay xuất phát từ Sài Gòn (SGN).
select  count(*) as tong
from CHUYENBAY
where GaDi='SGN'
--7. Có bao nhiêu loại máy báy Boeing.
select *
from MAYBAY
where Loai like '%Boeing%'
--8. Cho biết tổng số lương phải trả cho các nhân viên.
select SUM(Luong) as 'Tong So Luong'
from NHANVIEN
--9. Cho biết mã số của các phi công lái máy báy Boeing.
select MaNV as 'Ma Nhan Vien'
from MAYBAY 
inner join CHUNGNHAN on MAYBAY.MaMB=CHUNGNHAN.MaMB 
where Loai like '%Boeing%'
group by MaNV
--10. Cho biết các nhân viên có thể lái máy bay có mã số 747.
select MaNV as 'Ma Nhan Vien'
from MAYBAY 
inner join CHUNGNHAN on MAYBAY.MaMB=CHUNGNHAN.MaMB 
where MAYBAY.MaMB='747'
group by MaNV
--11. Cho biết mã số của các loại máy bay mà nhân viên có họ Nguyễn có thể lái.
select MaMB as 'Ma may bay'
from NHANVIEN 
inner join CHUNGNHAN on NHANVIEN.MaNV=CHUNGNHAN.MaNV
where Ten like '%Nguyen%'
group by MaMB

--12. Cho biết mã số của các phi công vừa lái được Boeing vừa lái được Airbus.
select MaNV as 'Ma Nhan Vien'
from MAYBAY 
inner join CHUNGNHAN on MAYBAY.MaMB=CHUNGNHAN.MaMB 
where Loai like '%Boeing%' and Loai like '%Airbus%'
group by MaNV
--13. Cho biết các loại máy bay có thể thực hiện chuyến bay VN280.

--14. Cho biết các chuyến bay có thể được thực hiện bởi máy bay Airbus A320.

--15. Cho biết tên của các phi công lái máy bay Boeing.
select NHANVIEN.MaNV as 'Ma Nhan Vien' ,Ten as 'Ten'
from MAYBAY 
inner join CHUNGNHAN on MAYBAY.MaMB=CHUNGNHAN.MaMB 
inner join NHANVIEN on NHANVIEN.MaNV=CHUNGNHAN.MaNV
where Loai like '%Boeing%'
group by NHANVIEN.MaNV,Ten
--16. Với mỗi loại máy bay có phi công lái cho biết mã số, loại máy báy và tổng số phi công có
--thể lái loại máy bay đó.
select CHUNGNHAN.MaMB as 'Ma May Bay' ,Loai,count (*) as tong
from MAYBAY 
inner join CHUNGNHAN on MAYBAY.MaMB=CHUNGNHAN.MaMB 
group by CHUNGNHAN.MaMB,Loai

--17. Giả sử một hành khách muốn đi thẳng từ ga A đến ga B rồi quay trở về ga A. Cho biết các
--đường bay nào có thể đáp ứng yêu cầu này.
select *
from CHUYENBAY
where GaDen in ('SGN','DAD') AND GaDi in ('SGN','DAD')
--Gom nhóm
--18. Với mỗi ga có chuyến bay xuất phát từ ga đó cho biết có bao nhiêu chuyến bay khởi hành.
select GaDi,Count(*)
from CHUYENBAY
group by GaDi
--19. Với mỗi ga có chuyến bay xuất phát từ ga đó cho biết tổng chi phí phải trả cho phi công lái
--các chuyến bay khởi hành.
select GaDi,Sum(ChiPhi) as 'Chi phi'
from CHUYENBAY
group by GaDi
--20. Với mỗi địa điểm xuất phát cho biết có bao nhiêu chuyến bay có thể khởi hành trước 12:00.
select GaDi,Count(*)
from CHUYENBAY
where GioDi >='12:00:00'
group by GaDi
--21. Cho biết mã số của các phi công chỉ lái được 3 loại máy bay.
select MaNV ,Count(*) as 'So loai'
from CHUNGNHAN
group by MaNV
having COUNT(*)=3
--22. Với mỗi phi công có thể lái nhiều hơn 3 loại máy bay, cho biết mã số phi công và tầm bay
--lớn nhất của các loại máy bay mà phi công đó có thể lái.
--23. Với mỗi phi công cho biết mã số phi công và tổng số loại máy bay mà phi công đó có thể
--lái.
--24. Cho biết mã số của các phi công có thể lái được nhiều loại máy bay nhất.
--25. Cho biết mã số của các phi công có thể lái được ít loại máy bay nhất.
--Truy vấn lồng
--26. Tìm các nhân viên không phải là phi công.

--27. Cho biết mã số của các nhân viên có lương cao nhất.
select MaNV as 'Ma'
from NHANVIEN
where Luong=(select MAX(Luong) from NHANVIEN)
--28. Cho biết tổng số lương phải trả cho các phi công.
--29. Tìm các chuyến bay có thể được thực hiện bởi tất cả các loại máy bay Boeing.
--30. Cho biết mã số của các máy bay có thể được sử dụng để thực hiện chuyến bay từ Sài Gòn
--(SGN) đến Huế (HUI).
--31. Tìm các chuyến bay có thể được lái bởi các phi công có lương lớn hơn 100,000.
--32. Cho biết tên các phi công có lương nhỏ hơn chi phí thấp nhất của đường bay từ Sài Gòn
--(SGN) đến Buôn Mê Thuộc (BMV).
--33. Cho biết mã số của các phi công có lương cao nhất.
--34. Cho biết mã số của các nhân viên có lương cao thứ nhì.
--35. Cho biết mã số của các nhân viên có lương cao thứ nhất hoặc thứ nhì.
--36. Cho biết tên và lương của các nhân viên không phải là phi công và có lương lớn hơn lương
--trung bình của tất cả các phi công.
--37. Cho biết tên các phi công có thể lái các máy bay có tầm bay lớn hơn 4,800km nhưng không
--có chứng nhận lái máy bay Boeing.
--38. Cho biết tên các phi công lái ít nhất 3 loại máy bay có tầm bay xa hơn 3200km.