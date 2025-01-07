#!/bin/bash

if [ ! -f "access.log" ]; then
	echo "File 'access.log' does not exist"
	exit 1
fi

all_count=$(wc -l < access.log)

echo "Общее количество запросов:  $all_count" > report.txt
echo "Количество уникальных IP-адресов: $(awk -F  '-' '{print $1}' access.log | sort -u | wc -l)" >> report.txt
echo -e "\nКоличество запросов по методам:\n$(awk -F '"' '{print $2}' access.log | awk '{print $1}' | sort | uniq -c)" >> report.txt
echo -e "\nСамый популярный URL:$(awk -F '"' '{print $2}' access.log | awk '{print $2}' | sort | uniq -c | sort -nr | sed 1q)" >> report.txt
cat report.txt
