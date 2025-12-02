--9.3--
ALTER FUNCTION Fn_DemSV (@Malop VARCHAR(10))
RETURNS INT
AS 
	BEGIN
		DECLARE @tongsosinhvien INT;

		SELECT @tongsosinhvien = COUNT(S.Masinhvien)
		FROM LOP L LEFT JOIN SINHVIEN S ON L.Malop = S.Malop
		WHERE L.Malop = @Malop

		RETURN ISNULL(@tongsosinhvien,0)
	END
	
SELECT dbo.Fn_DemSV('K46HDDL')

--9.6--
ALTER FUNCTION Fn_SV_HoLe (@HoSV NVARCHAR(10))
RETURNS @SV_HoLe TABLE
(
Masinhvien NVARCHAR(15),
Ho NVARCHAR(25),
Ten NVARCHAR(20)
)
AS
	BEGIN
		INSERT INTO @SV_HoLe
		SELECT Masinhvien, Hodem, Ten
		FROM SINHVIEN
		WHERE Hodem LIKE @HoSV+'%'

		RETURN;
	END

SELECT * FROM dbo.Fn_SV_HoLe(N'Nguyễn')
--9.9--
CREATE FUNCTION Fn_TongSV_Lop(@Malop NVARCHAR(15))
RETURNS TABLE
AS
RETURN (
	SELECT L.Malop, L.Tenlop, COUNT(S.Masinhvien) AS Tongsosinhvien
	FROM LOP L LEFT JOIN SINHVIEN S ON L.Malop = S.MaLop
	WHERE L.Malop = @Malop
	GROUP BY L.Malop, L.TenLop
);

SELECT * FROM dbo.Fn_TongSV_Lop('K45HDDL')

--9.13--
ALTER FUNCTION Fn_TongSV_Namsinh (@namsinh INT)
RETURNS TABLE
AS
  RETURN (
	SELECT YEAR(Ngaysinh) AS Namsinh, COUNT(Masinhvien) AS Tongsosinhvien
	FROM SINHVIEN
	WHERE YEAR(Ngaysinh) = @namsinh
	GROUP BY YEAR(Ngaysinh)
  );

SELECT * FROM dbo.Fn_TongSV_Namsinh(1992)