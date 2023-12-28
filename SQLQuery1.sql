CREATE DATABASE QUANLYBANHANG

CREATE TABLE KHACHHANG(
	MaKH varchar(5) PRIMARY KEY,
    HoTenLot varchar(30),
    Ten varchar(10),
    DiaChi varchar(150),
    Email varchar(30),
    DienThoai varchar(13)
);

CREATE TABLE SANPHAM(
	MaSP int PRIMARY KEY,
    TenSP varchar(50),
    MoTa varchar(255),
    SoLuong int,
    DonGia float
);

CREATE TABLE HOADON(
	MaHD int PRIMARY KEY,
    NgayMua date,
    MaKH varchar(5),
    TrangThai varchar(30),
    foreign key (MaKH) references KHACHHANG(MaKH)
);

	CREATE TABLE CHITIETHOADON(
		MaHDCT int identity(1,1) PRIMARY KEY,
		MaHD int,
        MaSP int,
        SoLuong int,
        FOREIGN KEY (MaHD) references HOADON(MaHD),
        FOREIGN KEY (MaSP) references SANPHAM(MaSP)
	);


	INSERT INTO KHACHHANG(MAKH, HoTenLot, Ten, DiaChi, Email, DienThoai) VALUES
('KH001', 'Nguyen Van','Teo','123 Nguyen Van Troi','kh001@gmail.com','98765432'),
('KH002','Le Thi','Trang','54 CMT8','kh002@yahoo.com','0908765422'),
('KH003','Tran Chi','Cong','34/17 Phan Chu Trinh','kh003@yahoo.com','0919087654'),
('KH004','Nguyen Thi Thu','Thao','43/1/2 Cong Hoa','kh004@gmail.com','098876543')

INSERT INTO SANPHAM(MaSP, TenSP, MoTa, SoLuong, DonGia) VALUES
('11','S?n ph?m hàng hóa 001','?ây là s?n ph?m 001','21','100000'),
('22','S?n ph?m áo qu?n 002','?ây là s?n ph?m th? 2','102','99000'),
('33','S?n ph?m hoa qu? trái cây t??i','?ây là s?n ph?m th? 3','25','95000'),
('44','S?n ph?m h?i s?n t??i s?ng','Dây là s?n ph?m h?i s?n','112','150000'),
('55','S?n ph?m ?i?n t?','?ây là s?n ph?m th? 4','54','105000')

INSERT INTO HOADON(MaHD, NgayMua, MaKH, TrangThai) VALUES
('111','2022-1-15','KH002','Da thanh toan'),
('222','2022-2-1','KH003','Chua thanh toan'),
('333','2022-2-15','KH001','Da thanh toan'),
('444','2022-3-10','KH002','Da thanh toan')

INSERT INTO CHITIETHOADON( MaHD, MaSP, SoLuong) VALUES
('222','11','10'),
('111','22','25'),
('333','33','12'),
('333','33','15'),
('222','11','17');

--1. Hiển thị tất cả thông tin có trong bảng khách hàng bao gồm tất cả các cột.
SELECT *
FROM KHACHHANG

--2. Hiển thị 10 khách hàng đầu tiên trong bảng khách hàng bao gồm các cột: mã khách hàng, họ và tên, email, số điện thoại.
SELECT TOP 10* 
FROM KHACHHANG

--3. Hiển thị thông tin từ bảng Sản phẩm gồm các cột: mã sản phẩm, tên sản phẩm, tổng tiền tồn kho. Với tổng tiền tồn kho = đơn giá* số lượng
SELECT MaSP, TenSP, (DonGia * SoLuong) AS 't?ng ti?n t?n kho'
FROM SANPHAM

--4. Hiển thị danh sách khách hàng có tên bắt đầu bởi kí tự ‘H’ gồm các cột: maKhachHang, hoVaTen, diaChi. Trong đó cột hoVaTen ghép từ 2 cột hoVaTenLot và Ten.
SELECT MaKH, HoTenLot + ' '+ Ten AS 'Ho va ten '
FROM KHACHHANG
WHERE Ten like 'C%'

--5. Hiển thị tất cả thông tin các cột của khách hàng có địa chỉ chứa chuỗi ‘Cong Hoa’
SELECT *
FROM KHACHHANG
WHERE DiaChi like '%Cong hoa%'

--6. Hiển thị các sản phẩm có số lượng nằm trong khoảng từ 100 đến 500
SELECT *
FROM SANPHAM
WHERE SoLuong BETWEEN 100 AND 500

--7. Hiển thị danh sách các hoá hơn có trạng thái là chưa thanh toán và ngày mua hàng trong năm 2016
SELECT *
FROM HOADON
WHERE TrangThai ='Chua thanh toan' AND YEAR(NgayMua) = 2022

--8. Hiển thị các hoá đơn có mã Khách hàng thuộc 1 trong 3 mã sau: KH001, KH003, KH006.
SELECT *
FROM KHACHHANG
WHERE MaKH IN('KH001', 'KH003', 'KH006')

--9. Hiển thị số lượng khách hàng có trong bảng khách hàng
SELECT COUNT(MaKH) AS 'So luong'
FROM KHACHHANG

--10. Hiển thị đơn giá lớn nhất trong bảng SanPham.
SELECT MAX(DonGia) AS 'Don gia lon nhat' 
FROM SANPHAM

--11. Hiển thị số lượng sản phẩm thấp nhất trong bảng sản phẩm.
SELECT MIN(DonGia) AS 'Don gia nho nhat' 
FROM SANPHAM

--12. Hiển thị tổng tất cả số lượng sản phẩm có trong bảng sản phẩm.
SELECT SUM(SoLuong) AS 'Tong so luong san pham' 
FROM SANPHAM

--13. Hiển thị số hoá đơn đã xuất trong tháng 12/2016 mà có trạng thái chưa thanh toán.
SELECT COUNT(MaHD) 
FROM HOADON
WHERE MONTH(NgayMua) = 2 AND YEAR(NgayMua) = 2022 AND TrangThai = 'Chua thanh toan'

--14. Hiển thị mã hoá đơn và số loại sản phẩm được mua trong từng hoá đơn.
SELECT MaHD, SoLuong 
FROM CHITIETHOADON

--15. Hiển thị mã hoá đơn và số loại sản phẩm được mua trong từng hoá đơn. Yêu cầu chỉ hiển thị hàng nào có số loại sản phẩm được mua >=5
SELECT MaHD
FROM CHITIETHOADON
WHERE SoLuong >=5

--16. Hiển thị thông tin bảng HoaDon gồm các cột maHoaDon, ngayMuaHang, maKhachHang. Sắp xếp theo thứ tự giảm dần của ngayMuaHang.
SELECT MaHD, NgayMua, MaKH
FROM HOADON
ORDER BY NgayMua DESC


--Phan 2: Nang cao
--1. Hiển thị tất cả thông tin có trong 2 bảng Hoá đơn và Hoá đơn chi tiết gồm các cột sau: maHoaDon, maKhachHang, trangThai, maSanPham, soLuong, ngayMua.
SELECT HD.MaHD, HD.MaKH, HD.TrangThai, CTHD.MaSP, CTHD.SoLuong, HD.NgayMua
FROM HOADON HD
INNER JOIN CHITIETHOADON CTHD ON CTHD.MaHD = HD.MaHD

--2. Hiển thị tất cả thông tin có trong 2 bảng Hoá đơn và Hoá đơn chi tiết gồm các cột sau: maHoaDon, maKhachHang, trangThai, maSanPham, soLuong, ngayMua với điều kiện maKhachHang = ‘KH001’.
SELECT HD.MaHD, HD.MaKH, HD.TrangThai, CTHD.MaSP, CTHD.SoLuong, HD.NgayMua
FROM HOADON HD
INNER JOIN CHITIETHOADON CTHD ON CTHD.MaHD = HD.MaHD
WHERE MaKH = 'KH001'

--3. Hiển thị thông tin từ 3 bảng Hoá đơn, Hoá đơn chi tiết và Sản phẩm gồm các cột sau: maHoaDon, ngayMua, tenSP, donGia, soLuong mua trong hoá đơn, thành tiền. Với thành tiền= donGia* soLuong
SELECT HD.MaHD, HD.NgayMua, SP.TenSP, (SP.DonGia* CTHD.SoLuong) AS 'Thanh Tien'
FROM SANPHAM SP
INNER JOIN CHITIETHOADON CTHD ON SP.MaSP = CTHD.MaSP
INNER JOIN HOADON HD ON HD.MaHD = CTHD.MaHD

--4. Hiển thị thông tin từ bảng khách hàng, bảng hoá đơn, hoá đơn chi tiết gồm các cột: họ và tên khách hàng, email, điện thoại, mã hoá đơn, trạng thái hoá đơn và tổng tiền đã mua trong hoá đơn. Chỉ hiển thị thông tin các hoá đơn chưa thanh toán.
SELECT KH.HoTenLot, KH.Ten, KH.Email, KH.DienThoai, 
	   HD.MaHD, HD.TrangThai,
	   SUM(SP.DonGia* CTHD.SoLuong) AS 'Tong tien'
FROM KHACHHANG KH
INNER JOIN HOADON HD ON KH.MaKH = HD.MaKH
INNER JOIN CHITIETHOADON CTHD ON HD.MaHD = CTHD.MaHD
INNER JOIN SANPHAM SP ON CTHD.MaSP = SP.MaSP
WHERE HD.TrangThai = 'Chua thanh toan'
GROUP BY KH.HoTenLot, KH.Ten, KH.Email, KH.DienThoai,
		 HD.MaHD, HD.TrangThai

--5. Hiển thị maHoaDon, ngàyMuahang, tổng số tiền đã mua trong từng hoá đơn. Chỉ hiển thị những hóa đơn có tổng số tiền >=500.000 và sắp xếp theo thứ tự giảm dần của cột tổng tiền.
SELECT HD.MaHD, HD.NgayMua,
	   SUM(SP.DonGia* CTHD.SoLuong) AS 'Tong tien'
FROM HOADON HD
JOIN CHITIETHOADON CTHD ON CTHD.MaHD = HD.MaHD
JOIN SANPHAM SP ON SP.MaSP = CTHD.MaSP 
GROUP BY HD.MaHD, HD.NgayMua
HAVING   SUM(SP.DonGia* CTHD.SoLuong) >=500000
ORDER BY 'Tong tien' DESC

--6. Hiển thị danh sách các khách hàng chưa mua hàng lần nào kể từ tháng 1/1/2016.
SELECT KH.MaKH, KH.HoTenLot, KH.Ten, KH.DiaChi, KH.Email, KH.DienThoai
FROM KHACHHANG KH
LEFT JOIN HOADON HD ON KH.MaKH = HD.MaKH AND HD.NgayMua >='2016-1-1'
WHERE HD.MaHD IS NULL

--7. Hiển thị mã sản phẩm, tên sản phẩm có lượt mua nhiều nhất trong tháng 12/2016.		
SELECT SP.MaSP, SP.TenSP, COUNT (CTHD.MaSP) AS 'So Luong'
FROM SANPHAM SP
JOIN CHITIETHOADON CTHD ON CTHD.MaSP = SP.MaSP
JOIN HOADON HD ON HD.maHD = CTHD.MaHD
WHERE MONTH(HD.NgayMua) = 2 AND YEAR(HD.NgayMua)= 2022
GROUP BY SP.MaSP, SP.TenSP 
HAVING COUNT (CTHD.MaSP) >=( 
							 SELECT TOP 1 COUNT (CTHD.MaSP)
							 FROM SANPHAM SP
							 JOIN CHITIETHOADON CTHD ON CTHD.MaSP = SP.MaSP
							 JOIN HOADON HD ON HD.maHD = CTHD.MaHD
							 GROUP BY SP.MaSP, SP.TenSP 
							 ORDER BY COUNT (CTHD.MaSP) DESC
							 )
--8. Hiển thị top 5 khách hàng có tổng số tiền mua hàng nhiều nhất trong năm 2016.
SELECT TOP 3 KH.MaKH, KH.HoTenLot, KH.Ten, KH.DiaChi, KH.Email, KH.DienThoai
FROM KHACHHANG KH
JOIN HOADON HD ON HD.maKH = KH.MaKH
JOIN CHITIETHOADON CTHD ON CTHD.MaHD = HD.MaHD
JOIN SANPHAM SP ON SP.MaSP = CTHD.MaSP 
WHERE YEAR(HD.NgayMua)= 2022
GROUP BY KH.MaKH, KH.HoTenLot, KH.Ten, KH.DiaChi, KH.Email, KH.DienThoai
ORDER BY SUM(SP.DonGia* CTHD.SoLuong) DESC

--9. Hiển thị thông tin các khách hàng sống ở ‘Hồ Chí Minh’ có mua sản phẩm có tên “Iphone” trong tháng 12/2016.
SELECT KH.MaKH, KH.HoTenLot, KH.Ten, KH.DiaChi, KH.Email, KH.DienThoai
FROM KHACHHANG KH
JOIN HOADON HD ON HD.maKH = KH.MaKH
JOIN CHITIETHOADON CTHD ON CTHD.MaHD = HD.MaHD
JOIN SANPHAM SP ON SP.MaSP = CTHD.MaSP 
WHERE KH.DiaChi LIKE '%54 CMT8%' AND SP.TenSP LIKE '%S?n ph?m áo qu?n 002%' AND MONTH(HD.NgayMua) = 1 AND YEAR(HD.NgayMua)= 2022

--10.Hiển thị tên sản phẩm có lượt đặt mua nhỏ hơn lượt mua trung bình các các sản phẩm.
SELECT SP.TenSP, COUNT(CTHD.MaSP) AS 'Luot Mua'
FROM SANPHAM SP
JOIN CHITIETHOADON CTHD ON SP.MaSP = CTHD.MaSP
GROUP BY SP.TenSP
HAVING COUNT(CTHD.MaSP) > ( 
								SELECT AVG(TongDoanhSo) AS 'Luot Mua Trung Binh'
								FROM (
									   SELECT COUNT(CTHD.MaSP) AS 'TongDoanhSo'
									   FROM SANPHAM SP
									   JOIN CHITIETHOADON CTHD ON SP.MaSP = CTHD.MaSP
									   GROUP BY SP.MaSP
									 ) sub
						   )
--============================================================================

--1. Sử dụng SQL để cập nhật dữ liệu cho các bảng theo thông tin ở các bảng trên.
INSERT INTO KHACHHANG(MAKH, HoTenLot, Ten, DiaChi, Email, DienThoai) VALUES
('KH008','Nguyễn Thị', 'Nga', '5 Quang Trung TP Đà Nẵng', 'ngant@gamil.com', '0912345670'),
('KH009','Trần Công', 'Thành', '234 Lê Lợi Quảng Nam', 'thanhtc@gmail.com', '16109423443'),
('KH010','Lê Hoàng', 'Nam', '23 Trần Phú TP Huế', 'namlt@yahoo.com', '0989354556'),
('KH011','Vũ Ngọc','Hiền','37 Nguyễn Thị Thập TP Đà Nẵng', 'hienvn@gmail.com ','0894545435')

INSERT INTO SANPHAM(MaSP, TenSP, MoTa, SoLuong, DonGia) VALUES
('1', 'Samsung Galaxy J7 Pro','Samsung Galaxy J7 Pro là một chiếc smartphone phù hợp với những người yêu thích một sản phẩm pin tốt, thích hệ điều hành mới cùng những tính năng đi kèm độc quyền','800','6600000'),
('2', 'iPhone 6 32GB','iPhone 6 là một trong những smartphone được yêu thích nhất. Lắng nghe nhu cầu về thiết kế, khả năng lưu trữ và giá cả, iPhone 6 32Gb được phân phối chính hãng tại Việt Nam', '500','8990000'),
('3','Laptop Dell Inspiron 3467','Dell Inspiron 3467 i3 7100U/4GB/1TB/Win10/(M20NR21)','507','11290000'),
('4','Pin sạc dự phòng','Pin sạc dự phòng Polymer 5.000mAh eSaver JP85','600','200000'),
('5','Nokia 3100','Nokia 3100 phù hợp với SINH VIÊN','100','700000')

INSERT INTO HOADON(MaHD, NgayMua, MaKH, TrangThai) VALUES
('120954','03-23-2016','KH008', 'Đã thanh toán'),
('120955','04-02-2016', 'KH009', 'Đã thanh toán'),
('120956','07-12-2016', 'KH010','Chưa thanh toán'),
('125957','12-04-2016', 'KH011', 'Chưa thanh toán')

INSERT INTO CHITIETHOADON( MaHD, MaSP, SoLuong) VALUES
('120954', '3', '40'),
('120954', '1', '20'),
('120955', '2', '100'),
('120956', '4', '6'),
('120956', '1', '10'),
('125957', '2', '50')

--2. Tạo 1 bảng có tên KhachHang_DaNang chứa các thông tin đầy đủ về khách hàng sinh sống tại Đà Nẵng?
SELECT * INTO KHACHHANGDANANG
FROM KHACHHANG 
WHERE DiaChi LIKE '5 Quang Trung TP Đà Nẵng' OR DiaChi LIKE '37 Nguyễn Thị Thập TP Đà Nẵng'

--3. Cập nhật lại thông tin số điện thoại của khách hàng có mã ‘KH002’ có giá trị mới là ‘999999999’
UPDATE KHACHHANG 
SET DienThoai = '999999999' 
WHERE MaKH = 'KH002'

--4. Tăng số lượng mặt hàng có mã ‘33’ lên thêm ‘200’ đơn vị
SELECT *
FROM SANPHAM
UPDATE SANPHAM
SET SoLuong = SoLuong + 200
WHERE MaSP = '3'

--5. Giảm 5% giá cho tất cả sản phẩm
SELECT *
FROM SANPHAM
UPDATE SANPHAM
SET DonGia = DonGia - (DonGia * 0.05)

--6. Tăng số lượng của mặt hàng bán chạy nhất trong tháng 12/2016 lên 100 đơn vị.
UPDATE SANPHAM
SET SoLuong= SoLuong + 100
WHERE MaSP in(
				    SELECT MaSP
					FROM CHITIETHOADON, HOADON
					WHERE CHITIETHOADON.MaHD = HOADON.MaHD AND MONTH(NgayMua)= '12' AND YEAR(NgayMua) ='2016'
					GROUP BY MaSP
					HAVING COUNT(MaSP) >= ALL 
					(
					SELECT COUNT(MaSP)
					FROM CHITIETHOADON, HOADON
					WHERE CHITIETHOADON.MaHD = HOADON.MaHD AND MONTH(NgayMua)= '12' AND YEAR(NgayMua) ='2016'
					GROUP BY MaSP
					)
     			)

--7. Giảm giá 10% cho 2 sản phẩm bán ít nhất trong năm 2016.
UPDATE SANPHAM
SET DonGia = DonGia - (DonGia * 0.1)
WHERE MaSP in(
SELECT TOP 2 MaSP
FROM CHITIETHOADON, HOADON
WHERE CHITIETHOADON.MaHD = HOADON.MaHD AND YEAR(NgayMua) ='2016'
GROUP BY MaSP
ORDER BY COUNT(MaSP) ASC)

--8. Cập nhật lại trạng thái “đã thanh toán” cho hoá đơn có mã ‘444’
UPDATE HOADON 
SET HOADON.TrangThai = 'Đã thanh toán' 
FROM HOADON
JOIN CHITIETHOADON CTHD ON CTHD.MaHD = HOADON.MaHD
JOIN SANPHAM SP ON CTHD.MaSP = SP.MaSP
WHERE SP.MaSP = '4'

--9. Xoá mặt hàng có mã sản phẩm là ‘22’ ra khỏi hoá đơn ‘120956’ và trạng thái là chưa thanh toán.
DELETE FROM CHITIETHOADON
WHERE MaHD = '120955'
  AND MaSP = '2'
  AND MaHD IN (
    SELECT MaHD
    FROM HOADON
    WHERE TrangThai = 'Đã thanh toán'
  );

--10.Xoá khách hàng chưa từng mua hàng kể từ ngày “1-1-2016"
DELETE FROM KHACHHANG
where MaKH IN( 
				SELECT MaKH
				FROM KHACHHANG
				WHERE MaKH NOT IN( SELECT MaKH FROM HOADON))