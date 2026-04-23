
create database cntt3_session07;

use cntt3_session07;

create table categories(
	category_id int primary key auto_increment,
    category_name varchar(100) not null unique
);

create table products(
	product_id int primary key auto_increment,
    product_name varchar(255) not null unique,
    price decimal(10, 2) not null check(price > 0),
    category_id int
);

INSERT INTO categories (category_name) VALUES
('Điện thoại'),
('Laptop'),
('Phụ kiện'),
('Thiết bị gia dụng'),
('Đồng hồ');

INSERT INTO products (product_name, price, category_id) VALUES
('iPhone 15', 25000000, 1),
('Samsung Galaxy S23', 22000000, 1),
('MacBook Air M2', 28000000, 2),
('Dell XPS 13', 30000000, 2),
('Tai nghe Bluetooth Sony', 3000000, 3),
('Chuột Logitech MX Master 3', 2500000, 3),
('Máy hút bụi Dyson', 12000000, 4),
('Nồi chiên không dầu Philips', 4000000, 4),
('Apple Watch Series 9', 10000000, 5),
('Samsung Galaxy Watch 6', 8000000, 5);

-- Tìm những sản phẩm có giá bán cao hơn mức giá trung bình 
-- của tất cả các sản phẩm trong cửa hàng.
-- Bước 1: Lấy ra mức giá trung bình của tất cả sản phẩm
select avg(price) as avg_price
from products;

-- Bước 2:
select * 
from products
where price > (
	select avg(price) as avg_price
	from products
);

-- Lấy ra danh sách tất cả các sản phẩm có danh mục là "Điện thoại"
-- B1: Lấy ra id của danh mục có tên là "Điện thoại"
select category_id 
from categories 
where category_name = 'Điện thoại';

select *
from products
where category_id = (
	select category_id 
	from categories 
	where category_name = 'Điện thoại'
);

-- Cập nhật tất cả sản phẩm có danh mục là 'Đồng hồ' về mức giá là 1000
-- Bước 1: Lấy id của danh mục có tên là "Đồng hồ"
select category_id 
	from categories 
	where category_name = 'Đồng hồ';
    
set SQL_SAFE_UPDATES= 1;

update products
set price = 1000
where category_id = (
	select category_id 
	from categories 
	where category_name = 'Đồng hồ'
);

-- Hiển thị danh sách các sản phẩm thuộc 
-- danh mục 'Điện thoại' hoặc 'Laptop'.\
-- Bước 1: Lấy ra id của "Điện thoại" và "Laptop"
select category_id
from categories
where category_name in("Điện thoại", "Laptop");

-- Bước 2: Lấy ra danh sách sản phẩm có danh mục là "Điện thoại" và "Laptop"
select *
from products
where category_id in (
	select category_id
	from categories
	where category_name in("Điện thoại", "Laptop")
);

-- Xóa tất cả sản phẩm có danh mục là "Điện thoại" hoặc "Laptop"
delete from products
where category_id in (
	select category_id
	from categories
	where category_name in("Điện thoại", "Laptop")
);

-- Bài tập thực hành
-- Tạo bảng phòng ban
create table departments(
	dept_id int primary key auto_increment,
    dept_name  varchar(100) not null unique,
    location varchar(100)
);

-- Tạo bảng nhân viên
create table employees (
	emp_id int primary key auto_increment,
    first_name varchar(100) not null, 
    last_name varchar(100) not null,
    salary decimal(10, 2) not null check (salary > 0),
    dept_id int,
    hire_date date,
    foreign key(dept_id) references departments(dept_id)
);

-- Thêm dữ liệu vào bảng phòng ban
INSERT INTO departments (dept_id, dept_name, location) VALUES
(1, 'IT', 'Hanoi'),
(2, 'Sales', 'Ho Chi Minh'),
(3, 'HR', 'Da Nang'),
(4, 'Marketing', 'Hanoi'),
(5, 'Finance', 'Ho Chi Minh');

-- Thêm dữ liệu vào bảng nhân viên
INSERT INTO employees (emp_id, first_name, last_name, salary, dept_id, hire_date) VALUES
(1, 'Anh', 'Nguyen', 1500.00, 1, '2023-01-10'),
(2, 'Binh', 'Le', 2500.00, 1, '2022-05-15'),
(3, 'Chi', 'Tran', 1200.00, 2, '2024-02-20'),
(4, 'Dung', 'Pham', 3000.00, 2, '2021-11-05'),
(5, 'Giang', 'Vu', 1800.00, 3, '2023-08-12'),
(6, 'Hoang', 'Do', 2200.00, NULL, '2024-01-01'),
(7, 'Huong', 'Ly', 2100.00, 4, '2023-03-15'),
(8, 'Khanh', 'Ngo', 1700.00, 4, '2022-12-01'),
(9, 'Lan', 'Mai', 2800.00, 1, '2021-06-20'),
(10, 'Minh', 'Phan', 1400.00, 5, '2024-04-10');

-- Câu số 6: Viết câu lệnh lấy ra first_name, last_name và salary 
-- của tất cả nhân viên, sắp xếp theo thứ tự lương giảm dần.
select first_name, last_name, salary
from employees
order by salary desc;

-- Câu số 7: Sử dụng INNER JOIN để hiển thị danh sách gồm tên 
-- nhân viên và tên phòng ban mà họ đang làm việc.
select concat(e.first_name, ' ', e.last_name) as fullname, d.dept_name
from employees e
inner join departments d
on e.dept_id = d.dept_id;

-- Câu số 8: Sử dụng LEFT JOIN để hiển thị tất cả nhân viên 
-- (kể cả những người chưa có phòng ban) và tên phòng ban tương ứng của họ.
select concat(e.first_name, ' ', e.last_name) as fullname, d.dept_name
from employees e
left join departments d
on e.dept_id = d.dept_id;

-- Câu số 9: Sử dụng truy vấn lồng (Subquery) với toán tử IN để tìm 
-- danh sách nhân viên làm việc tại địa điểm 'Hanoi'.
select dept_id
from departments
where location = 'Hanoi';

select concat(e.first_name, ' ', e.last_name) as fullname
from employees e
where dept_id in (
	select dept_id
	from departments
	where location = 'Hanoi'
);

-- Câu số 10: Sử dụng truy vấn lồng để tìm những nhân viên có mức lương cao hơn 
-- mức lương trung bình của toàn bộ công ty.
select concat(first_name, ' ', last_name) as fullname, salary, hire_date
from employees
where salary > (
	select avg(salary) from employees
);

-- Câu số 11: Sử dụng truy vấn lồng để tìm những nhân viên 
-- có mức lương cao hơn mức lương trung bình của chính phòng ban 
-- mà nhân viên đó đang làm việc.