#!/bin/bash
# Заменяет все строки вида = (sensitive value) на = null
# Работает для всех .tf файлов в текущей папке и подкаталогах

find . -type f -name "*.tf" | while read tf_file; do
  echo "Обрабатываю $tf_file..."
  sed -i 's/=(\s*sensitive value\s*)/ = null/g' "$tf_file"
done

echo "Готово! Теперь можно запускать terraform fmt и terraform validate."

