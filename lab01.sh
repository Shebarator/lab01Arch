cd ~

git init
git config user.name  "Андрей"
git config user.email "andrusnka.suvorov@yandex.ru"
git branch -M main

mkdir -p lab0/claude_monet/kitchen/hot_station
mkdir -p lab0/claude_monet/kitchen/pastry_station
mkdir -p lab0/claude_monet/hall
mkdir -p lab0/claude_monet/bar
mkdir -p lab0/claude_monet/office
mkdir -p lab0/claude_monet/locker_room

cat > lab0/claude_monet/kitchen/hot_station/senya_task << 'EOF'
Сеня готовит мясо для банкета
Проверяет температуру горячего цеха
После смены считает оставшиеся продукты
EOF

cat > lab0/claude_monet/kitchen/hot_station/fedya_task << 'EOF'
Федя разделывает рыбу для гостей
Готовит фирменную закуску вместе с Сеней
Перед подачей зовёт Баринова
EOF

cat > lab0/claude_monet/kitchen/pastry_station/lui_dessert << 'EOF'
Луи выпекает коржи для мильфея
Готовит крем по старому рецепту
Оставляет один десерт для команды
EOF

cat > lab0/claude_monet/kitchen/pastry_station/katya_idea << 'EOF'
Катя предлагает новый шоколадный десерт
Баринов просит уменьшить количество сахара
Пробную порцию получает Макс
EOF

cat > lab0/claude_monet/kitchen/barinov_order << 'EOF'
Баринов собирает всю команду перед сменой
Каждый повар отвечает за своё рабочее место
Лёва контролирует выдачу блюд
EOF

cat > lab0/claude_monet/hall/waiter_plan << 'EOF'
Настя обслуживает столики у окна
Официанты встречают гостей в главном зале
Особые просьбы гостей передают Вике
EOF

cat > lab0/claude_monet/bar/kostya_report << 'EOF'
Костя проверил запас напитков
Для вечера подготовлены новые коктейли
Бар откроется одновременно с залом
EOF

cat > lab0/claude_monet/bar/nastya_note << 'EOF'
Настя просит Костю не опаздывать
После смены они ужинают вместе
Для гостей оставлены чистые бокалы
EOF

cat > lab0/claude_monet/office/vika_summary << 'EOF'
Вика проверила кухню и главный зал
Команда готова к вечерней смене
Отчёт нужно передать Нагиеву
EOF

cat > lab0/claude_monet/locker_room/max_note << 'EOF'
Макс придумал новое блюдо для меню
Баринов разрешил приготовить пробную порцию
Вика ждёт Макса после смены
EOF

cat > lab0/claude_monet/locker_room/leva_note << 'EOF'
Лёва проверяет форму новых поваров
Ключ от кладовой лежит у шефа
Последним кухню закрывает су-шеф
EOF

chmod 755 lab0/claude_monet
chmod 750 lab0/claude_monet/kitchen/hot_station
chmod 640 lab0/claude_monet/kitchen/hot_station/fedya_task
chmod 644 lab0/claude_monet/kitchen/pastry_station/lui_dessert
chmod 640 lab0/claude_monet/kitchen/barinov_order
chmod 644 lab0/claude_monet/hall/waiter_plan
chmod 750 lab0/claude_monet/bar
chmod 640 lab0/claude_monet/bar/nastya_note
chmod 640 lab0/claude_monet/office/vika_summary
chmod 750 lab0/claude_monet/locker_room
chmod 644 lab0/claude_monet/locker_room/leva_note

chmod u=rwx,g=rx,o= lab0/claude_monet/kitchen
chmod u=rw,g=r,o= lab0/claude_monet/kitchen/hot_station/senya_task
chmod u=rwx,g=rx,o= lab0/claude_monet/kitchen/pastry_station
chmod u=rw,g=r,o=r lab0/claude_monet/kitchen/pastry_station/katya_idea
chmod u=rwx,g=rx,o= lab0/claude_monet/hall
chmod u=rw,g=r,o= lab0/claude_monet/bar/kostya_report
chmod u=rwx,g=rx,o= lab0/claude_monet/office
chmod u=rw,g=r,o= lab0/claude_monet/locker_room/max_note

git status
git add .
git commit -m "ЛР1: создано дерево lab0, файлы и права доступа"

cp lab0/claude_monet/locker_room/max_note lab0/claude_monet/office/max_report
cp -r lab0/claude_monet/bar lab0/claude_monet/hall/bar_backup
ln -s claude_monet/kitchen/barinov_order lab0/final_menu
ln -s ../kitchen lab0/claude_monet/office/kitchen_access
ln lab0/claude_monet/kitchen/hot_station/senya_task \
   lab0/claude_monet/kitchen/hot_station/senya_task_copy
cat lab0/claude_monet/kitchen/hot_station/senya_task \
    lab0/claude_monet/kitchen/hot_station/fedya_task \
    > lab0/claude_monet/kitchen/cook_tasks
cat lab0/claude_monet/hall/waiter_plan >> lab0/claude_monet/office/vika_summary
mv lab0/claude_monet/locker_room/max_note lab0/claude_monet/kitchen/max_final_note

git status
git add .
git commit -m "ЛР1: копирование, ссылки, объединение файлов"

ls -lR lab0 | grep '^-' | sort -k5 -n -r | head -n 5

grep -rhi -e 'баринов' -e 'макс' lab0/claude_monet \
  | grep -vi 'порц' | sort | head -n 6

grep -rli -e 'кост' -e 'наст' lab0/claude_monet/bar lab0/claude_monet/hall/bar_backup | wc -l

for f in lab0/claude_monet/kitchen/hot_station/*_task; do
  head -n 1 "$f"
  tail -n 1 "$f"
done | grep -i -e 'сеня' -e 'федя' -e 'продукт' | sort -r

grep -v -e 'Сеня' -e 'Федя' lab0/claude_monet/kitchen/cook_tasks \
  | sort -r | head -n 4 | wc -w

ls -liR lab0 | grep -E '^ *[0-9]+ -[rwx-]{9} +2 ' | sort -k1 -n

ls -lR lab0 | grep '^l' | grep -v 'final' | sort -k9

rm lab0/claude_monet/office/max_report
rm lab0/final_menu
rm lab0/claude_monet/office/kitchen_access
rm lab0/claude_monet/kitchen/hot_station/senya_task_copy
rm lab0/claude_monet/locker_room/leva_note
rmdir lab0/claude_monet/locker_room
rm lab0/claude_monet/kitchen/max_final_note
rm -r lab0/claude_monet/hall/bar_backup

git status
git add .
git commit -m "ЛР1: поиск, фильтрация, удаление файлов и ссылок"
git push
