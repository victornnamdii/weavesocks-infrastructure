echo 'Configuring Slack hook url.'
sed -i -e s,API_URL_SECRET,"$SLACK_HOOK_URL",g /etc/alertmanager-writable/config.yml
exec /bin/alertmanager $*