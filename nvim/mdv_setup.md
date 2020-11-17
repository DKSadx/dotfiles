# Best current theme: 960.847

# Testing best themes
for i in 1101.9593 630.2337 630.2337 674.5261 718.9891 741.557 754.5889 785.3229 837.6638 845.69 960.847
do
   echo $i >> best_themes
   MDV_THEME=$i mdv markdown_file.md >> best_themes
done

# ansi_tables location
cat /usr/local/Cellar/mdv/1.7.4/libexec/lib/python3.8/site-packages/mdv/ansi_tables.json | jq  'keys' > mdv_colors

