#!/bin/bash
# Скрипт для очистки восстановленных .tf файлов из tfstate

# Папка с восстановленными файлами
RECOVERED_DIR="./recovered"

# Поля, которые нужно удалить (read-only)
READ_ONLY_FIELDS=(
  "creation_timestamp"
  "fingerprint"
  "self_link"
  "id"
  "generated_id"
)

# Обход всех .tf файлов
find "$RECOVERED_DIR" -type f -name "*.tf" | while read -r file; do
  echo "Обрабатываем $file ..."

  # 1. Заменяем (sensitive value) на null
  sed -i 's/=(\s*sensitive value\s*)/ = null/g' "$file"

  # 2. Удаляем read-only поля
  for field in "${READ_ONLY_FIELDS[@]}"; do
    # удаляем строки вида: <field> = ...
    sed -i "/^\s*$field\s*=/d" "$file"
  done

  # 3. Удаляем пустые конфликтующие списки в firewall
  sed -i '/source_service_accounts\s*=\s*\[\s*\]/d' "$file"
  sed -i '/source_tags\s*=\s*\[\s*\]/d' "$file"
  sed -i '/target_service_accounts\s*=\s*\[\s*\]/d' "$file"

done

echo "Очистка завершена. Запусти 'terraform fmt' и 'terraform validate'."

