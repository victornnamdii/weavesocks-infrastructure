while true
  for directory in (du --bytes --separate-dirs --threshold=100M /mnt)
    echo $directory | read size path
    echo "node_directory_size_bytes{path=\"$path\"} $size" \
    >> /tmp/metrics-temp
  end
  mv /tmp/metrics-temp /tmp/metrics
  sleep 300
end