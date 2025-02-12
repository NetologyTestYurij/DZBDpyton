import psycopg2
from pprint import pprint

def personal_information(cur):#создаем таблицу 
        cur.execute("""
        CREATE TABLE IF NOT EXISTS personal_information (
        id SERIAL PRIMARY KEY,
        first_name VARCHAR(20),  
        last_name VARCHAR(30) UNIQUE,
        email VARCHAR(50) UNIQUE);""")
      
        cur.execute("""
        CREATE TABLE IF NOT EXISTS phone_number (
        phone_number_id INTEGER NOT NULL REFERENCES personal_information(id),
        phone_number VARCHAR(15) PRIMARY KEY);""")
        return
    

def insert_tel(cur, client_id, tel):
        cur.execute("""
                    INSERT INTO phone_number(phone_number_id, phone_number)
                    VALUES (%s, %s)""", 
                    (client_id, tel))
        return client_id

def insert_client(cur, first_name=None, last_name=None, email=None, tel=None):
        cur.execute("""
            INSERT INTO personal_information(first_name, last_name, email)
            VALUES (%s, %s, %s)
            """, (first_name, last_name, email))
        cur.execute("""
            SELECT id from personal_information
            ORDER BY id DESC
            LIMIT 1""")
        id = cur.fetchone()[0]
        if tel is None:
            return id
        else:
            insert_tel(cur, id, tel)
            return id
        
def update_personal_information(cur, id, first_name=None, last_name=None, email=None):
        cur.execute("""
            SELECT * from personal_information
            WHERE id = %s""", (id, ))
        info = cur.fetchone()
        if first_name is None:
            first_name = info[1]
        if last_name is None:
            last_name = info[2]
        if email is None:
            email = info[3]
        cur.execute("""
            UPDATE personal_information
            SET first_name = %s, last_name = %s, email =%s 
            where id = %s""", (first_name, last_name, email, id))
        return id
    
def delete_phone(cur, number):
        cur.execute("""
            DELETE FROM phone_number 
            WHERE phone_number = %s""", (number, ))
        return number
    
def delete_client(cur, id):
        cur.execute("""
            DELETE FROM phone_number
            WHERE phone_number_id = %s""", (id, ))
        cur.execute("""
            DELETE FROM personal_information 
            WHERE id = %s""", (id,))
        return id
    
def find_client(cur, first_name=None, last_name=None, email=None, tel=None):
        if first_name is None:
            first_name = '%'
        else:
            first_name = '%' + first_name + '%'
        if last_name is None:
            last_name = '%'
        else:
            last_name = '%' + last_name + '%'
        if email is None:
            email = '%'
        else:
            email = '%' + email + '%'
        if tel is None:
            cur.execute("""
                SELECT pi.id, pi.first_name, pi.last_name, pi.email, p.phone_number FROM personal_information pi
                LEFT JOIN phone_number p ON pi.id = p.phone_number_id
                WHERE pi.first_name LIKE %s AND pi.last_name LIKE %s
                AND pi.email LIKE %s""", (first_name, last_name, email))
        else:
            cur.execute("""
                SELECT pi.id, pi.first_name, pi.last_name, pi.email, p.phone_number FROM personal_information pi
                LEFT JOIN phone_number p ON pi.id = p.phone_number_id
                WHERE pi.first_name LIKE %s AND pi.last_name LIKE %s
                AND pi.email LIKE %s AND p.phone_number LIKE %s
                """, (first_name, last_name, email, tel))
        return cur.fetchall()

def delete_db(cur):
        cur.execute("""
        DROP TABLE personal_information, phone_number CASCADE;""")

if __name__ == '__main__':
    with psycopg2.connect(database = "netology_db", user = "postgres", password="REWQ5432") as conn:
        with conn.cursor() as cur:
        # Удаление таблиц перед запуском
            #delete_db(cur)
            # 1. Cоздание таблиц
            personal_information(cur)
            print("БД создана")
            # 2. Добавляем 5 клиентов "Дмитрий Демидов", "Кирилл Табельский", "Александр Ульянцев"
            print("Добавлен клиент id: ",
                  insert_client(cur, "Евгений", "Шмаргунов", "Evgen08@gmail.com"))
            print("Добавлен клиент id: ",
                  insert_client(cur, "Олег", "Булыгин", "Bulugin25@mail.ru", '79238877799'))
            print("Добавлен клиент id: ",
                  insert_client(cur, "Дмитрий", "Демидов",
                                "DDD3DDD85.com", 7927314644))
            print("Добавлен клиент id: ",
                  insert_client(cur, "Кирилл", "Табельский",
                                "KKKiril25@mail.ru", 790513312643))
            print("Добавлена клиент id: ",
                  insert_client(cur, "Александр", "Ульянцев",
                                "CaschaUX01@outlook.com"))
            print("Данные в таблицах")
            cur.execute("""
                SELECT pi.id, pi.first_name, pi.last_name, pi.email, p.phone_number FROM personal_information pi
                LEFT JOIN phone_number p ON pi.id = p.phone_number_id
                ORDER by pi.id
                """)
            pprint(cur.fetchall())
            # 3. Добавляем номер телефона(одному первый, одному второй)
            print("Телефон добавлен клиенту id: ",
                  insert_tel(cur, 2, 79257872222))
            print("Телефон добавлен клиенту id: ",
                  insert_tel(cur, 1, 79621991111))

            print("Данные в таблицах")

            cur.execute("""
                SELECT pi.id, pi.first_name, pi.last_name, pi.email, p.phone_number FROM personal_information pi
                LEFT JOIN phone_number p ON pi.id = p.phone_number_id
                ORDER by pi.id
                """)
            pprint(cur.fetchall())
            # 4. Изменим данные клиента
            print("Изменены данные клиента id: ",
                  update_personal_information(cur, 4, "Иван", None, '1234567@outlook.com'))
            # 5. Удаляем клиенту номер телефона
            print("Телефон удалён c номером: ",
                  delete_phone(cur, '790513312643'))
            print("Данные в таблицах")
            cur.execute("""
                SELECT pi.id, pi.first_name, pi.last_name, pi.email, p.phone_number FROM personal_information pi
                LEFT JOIN phone_number p ON pi.id = p.phone_number_id
                ORDER by pi.id
                """)
            pprint(cur.fetchall())
            # 6. Удалим клиента номер 2
            print("Клиент удалён с id: ",
                  delete_client(cur, 2))
            cur.execute("""
                            SELECT pi.id, pi.first_name, pi.last_name, pi.email, p.phone_number FROM personal_information pi
                            LEFT JOIN phone_number p ON pi.id = p.phone_number_id
                            ORDER by pi.id
                            """)
            pprint(cur.fetchall())
            # 7. Найдём клиента
            print('Найденный клиент по имени:')
            pprint(find_client(cur, 'Александр'))

            print('Найденный клиент по email:')
            pprint(find_client(cur, None, None, 'Evgen08@gmail.com'))

            print('Найденный клиент по имени, фамилии и email:') 
            pprint(find_client(cur, 'Иван', 'Табельский',
                               '1234567@outlook.com'))

            print('Найденный клиент по имени, фамилии, телефону и email:')
            pprint(find_client(cur, 'Дмитрий', 'Демидов',
                               'DDD3DDD85.com', '7927314644'))

            print('Найденный клиент по имени, фамилии, телефону:')
            pprint(find_client(cur, None, None, None, '79621991111'))

            conn.close
