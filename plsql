-- Следующая программа обновит таблицу и увеличит зарплату каждого клиента на 500 и использует атрибут SQL% ROWCOUNT, чтобы определить количество затронутых строк:

DECLARE 
    total_rows NUMBER(2);
BEGIN
    UPDATE employees
    SET annual_salary = annual_salary + 500;
    IF sql%notfound THEN
        dbms_output.put_line('no employee selecter');
    ELSIF sql%found THEN
        total_rows := sql%rowcount;
        dbms_output.put_line( total_rows || ' employee selected ' );
    END IF;
END;
/

-- Синтаксис для создания явного курсора –
-- CURSOR cursor_name IS select_statement; 

--Объявление курсора определяет курсор с именем и соответствующим оператором SELECT. Например –
CURSOR c_customers IS 
   SELECT id, name, address FROM customers; 

-- Открытие курсора выделяет память для курсора и делает его готовым для извлечения в него строк, возвращаемых оператором SQL. Например, мы откроем определенный выше курсор следующим образом:

OPEN c_customers;

-- Выборка курсора вовлекает доступ к одной строке за один раз. Например, мы будем выбирать строки из открытого выше курсора следующим образом:
FETCH c_customers INTO c_id, c_name, c_addr; 

-- Закрытие курсора означает освобождение выделенной памяти. Например, мы закроем вышеуказанный курсор следующим образом:

CLOSE c_customers;

DECLARE
    c_id customers.id%type;
    c_name customers.name%type;
    c_addr customers.adress%type;
    CURSOR c_customer IS
        SELECT id, name, adress FROM customers;
BEGIN 
    OPEN c_customer;
    LOOP
    FETCH c_customer INTO c_id, c_name, c_addr;
        EXIT WHEN c_customer%notfound;
        dbms_output.put_line(c_id || ' ' || c_name || ' ' || c_addr);
    END LOOP;
    CLOSE c_customer;
END;
/
