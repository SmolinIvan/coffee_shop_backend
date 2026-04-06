-- Начальные данные для меню кофейни
-- Основано на фронтенд данных

-- Очистка (опционально, только для dev)
-- TRUNCATE TABLE menu_items RESTART IDENTITY CASCADE;

-- Напитки
INSERT INTO menu_items (id, name, description, price, image_url, category_id, kcal, protein, fat, carbs) VALUES
(1, 'Капучино', 'Классический итальянский кофе с нежной молочной пенкой', 180, 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=800', 
    (SELECT id FROM categories WHERE type = 'drinks'), 120, 6, 6, 10),
(2, 'Свежевыжатый апельсиновый сок', 'Натуральный сок из свежих апельсинов без добавления сахара', 220, 'https://images.unsplash.com/photo-1600271886742-f049cd451bba?w=800',
    (SELECT id FROM categories WHERE type = 'drinks'), 110, 2, 0, 26),
(3, 'Зеленый чай с жасмином', 'Ароматный китайский чай с цветками жасмина', 150, 'https://thumbs.dreamstime.com/b/tea-jasmine-flowers-glass-teapot-tea-jasmine-flowers-glass-teapot-table-117944963.jpg',
    (SELECT id FROM categories WHERE type = 'drinks'), 5, 0, 0, 1),
(4, 'Лимонад домашний', 'Освежающий лимонад из свежих лимонов с мятой', 190, 'https://www.koolinar.ru/all_image/article/3/3187/article-321dcaa7-1884-457b-9620-8783451e814d_large.jpg',
    (SELECT id FROM categories WHERE type = 'drinks'), 85, 0, 0, 22);

-- Закуски
INSERT INTO menu_items (id, name, description, price, image_url, category_id, kcal, protein, fat, carbs) VALUES
(5, 'Брускетта с томатами', 'Хрустящие тосты с сочными томатами, базиликом и оливковым маслом', 280, 'https://images.unsplash.com/photo-1572695157366-5e585ab2b69f?w=800',
    (SELECT id FROM categories WHERE type = 'appetizers'), 180, 6, 8, 22),
(6, 'Сырная тарелка', 'Ассорти из благородных сыров с виноградом и орехами', 650, 'https://images.unsplash.com/photo-1452195100486-9cc805987862?w=800',
    (SELECT id FROM categories WHERE type = 'appetizers'), 420, 24, 35, 5),
(7, 'Креветки в кляре', 'Хрустящие креветки в легком кляре с соусом тартар', 580, 'https://images.unsplash.com/photo-1565680018434-b513d5e5fd47?w=800',
    (SELECT id FROM categories WHERE type = 'appetizers'), 320, 18, 16, 28);

-- Салаты
INSERT INTO menu_items (id, name, description, price, image_url, category_id, kcal, protein, fat, carbs) VALUES
(8, 'Цезарь с курицей', 'Классический салат с курицей, листьями романо, пармезаном и соусом цезарь', 420, 'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=800',
    (SELECT id FROM categories WHERE type = 'salads'), 350, 28, 22, 18),
(9, 'Греческий салат', 'Свежие овощи с сыром фета, маслинами и оливковым маслом', 380, 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=800',
    (SELECT id FROM categories WHERE type = 'salads'), 280, 8, 22, 12),
(10, 'Салат с лососем и авокадо', 'Нежный лосось с авокадо, микс салатов и цитрусовой заправкой', 550, 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800',
    (SELECT id FROM categories WHERE type = 'salads'), 390, 22, 28, 14);

-- Горячее
INSERT INTO menu_items (id, name, description, price, image_url, category_id, kcal, protein, fat, carbs) VALUES
(11, 'Стейк рибай', 'Сочный мраморный стейк рибай средней прожарки с овощами гриль', 1250, 'https://images.unsplash.com/photo-1600891964092-4316c288032e?w=800',
    (SELECT id FROM categories WHERE type = 'hot'), 680, 52, 48, 4),
(12, 'Лосось на гриле', 'Филе лосося на гриле с лимонным маслом и спаржей', 780, 'https://images.unsplash.com/photo-1485921325833-c519f76c4927?w=800',
    (SELECT id FROM categories WHERE type = 'hot'), 420, 38, 26, 8),
(13, 'Ризотто с белыми грибами', 'Кремовое ризотто с белыми грибами и пармезаном', 520, 'https://images.news.ru/2025/08/11/66wLiMLHXQKyAygEKkYd4hbEkTs7gUajJGOW9rqx_780.png',
    (SELECT id FROM categories WHERE type = 'hot'), 480, 14, 18, 62),
(14, 'Утиная грудка с апельсиновым соусом', 'Томленая утиная грудка с карамелизированным апельсиновым соусом', 850, 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=800',
    (SELECT id FROM categories WHERE type = 'hot'), 540, 42, 32, 18);

-- Выпечка
INSERT INTO menu_items (id, name, description, price, image_url, category_id, kcal, protein, fat, carbs) VALUES
(15, 'Круассан классический', 'Хрустящий французский круассан из слоеного теста', 150, 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=800',
    (SELECT id FROM categories WHERE type = 'bakery'), 280, 6, 16, 28),
(16, 'Чиабатта с маслинами', 'Итальянский хлеб чиабатта с маслинами и травами', 180, 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800',
    (SELECT id FROM categories WHERE type = 'bakery'), 240, 8, 6, 38),
(17, 'Синнабон', 'Ароматная булочка с корицей и сливочной глазурью', 220, 'https://images.unsplash.com/photo-1612198188060-c7c2a3b66eae?w=800',
    (SELECT id FROM categories WHERE type = 'bakery'), 420, 7, 18, 58),
(18, 'Эклер шоколадный', 'Воздушное заварное пирожное с шоколадным кремом и глазурью', 180, 'https://d5ln38p3754yc.cloudfront.net/conference_facebook_images/9744171/original/1716906631-ce07c9e649c846d2.jpg?1716906631',
    (SELECT id FROM categories WHERE type = 'bakery'), 350, 6, 20, 38),
(19, 'Штрудель яблочный', 'Традиционный австрийский десерт с яблоками и корицей', 200, 'https://images.unsplash.com/photo-1574085733277-851d9d856a3a?w=800',
    (SELECT id FROM categories WHERE type = 'bakery'), 290, 5, 12, 42);

-- Десерты (используем категорию bakery, так как в исходных данных они там)
INSERT INTO menu_items (id, name, description, price, image_url, category_id, kcal, protein, fat, carbs) VALUES
(20, 'Тирамису', 'Классический итальянский десерт с маскарпоне и савоярди', 350, 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=800',
    (SELECT id FROM categories WHERE type = 'bakery'), 450, 10, 28, 42),
(21, 'Чизкейк Нью-Йорк', 'Нежный сливочный чизкейк на песочной основе', 320, 'https://images.unsplash.com/photo-1533134486753-c833f0ed4866?w=800',
    (SELECT id FROM categories WHERE type = 'bakery'), 380, 8, 24, 34),
(22, 'Шоколадный фондан', 'Горячий шоколадный кекс с жидкой начинкой и ванильным мороженым', 380, 'https://images.unsplash.com/photo-1624353365286-3f8d62daad51?w=800',
    (SELECT id FROM categories WHERE type = 'bakery'), 410, 6, 22, 48),
(23, 'Панна котта с ягодами', 'Нежный итальянский десерт из сливок с ягодным соусом', 280, 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800',
    (SELECT id FROM categories WHERE type = 'bakery'), 290, 5, 18, 26);

-- Бар
INSERT INTO menu_items (id, name, description, price, image_url, category_id, kcal, protein, fat, carbs) VALUES
(24, 'Мохито классический', 'Освежающий коктейль с ромом, мятой, лаймом и содовой', 420, 'https://images.unsplash.com/photo-1551538827-9c037cb4f32a?w=800',
    (SELECT id FROM categories WHERE type = 'bar'), 180, 0, 0, 24),
(25, 'Апероль Шприц', 'Итальянский аперитив с аперолем, просекко и содовой', 480, 'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?w=800',
    (SELECT id FROM categories WHERE type = 'bar'), 150, 0, 0, 18),
(26, 'Олд Фэшн', 'Классический виски-коктейль с биттером и сахаром', 550, 'https://images.unsplash.com/photo-1470337458703-46ad1756a187?w=800',
    (SELECT id FROM categories WHERE type = 'bar'), 160, 0, 0, 8),
(27, 'Эспрессо Мартини', 'Бодрящий коктейль с водкой, кофейным ликером и эспрессо', 490, 'https://images.unsplash.com/photo-1536935338788-846bb9981813?w=800',
    (SELECT id FROM categories WHERE type = 'bar'), 220, 1, 0, 18);

-- Обновляем sequence для ID
SELECT setval('menu_items_id_seq', (SELECT MAX(id) FROM menu_items));
