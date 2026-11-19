#!/bin/sh

# Apacheサービスをバックグラウンドで起動
apache2-foreground > /dev/null 2>&1 &

# ログファイルを作成し、cronが書き込めるように権限を付与
touch /var/log/cron.log
chmod 0666 /var/log/cron.log

# cronジョブを/etc/cron.d/に直接書き込む
# これにより、COPYのタイミング問題を完全に回避する
echo "* * * * * root /usr/local/bin/php /var/www/html/batch/summarize_battles.php >> /var/log/cron.log 2>&1" > /etc/cron.d/battle-cron
# crontabファイルには末尾の改行が必須
echo "" >> /etc/cron.d/battle-cron

# cronデーモンをフォアグラウンドで起動し、ログレベルを上げる(-L 8)
# これがコンテナのメインプロセスになる
exec cron -f -L 8