[db-${envt}]
%{for i in range(length(instance_names_db_st)) ~}
%{if length(regexall("[a-z]+" , instance_names_db_st[i])) >=3  ~}
%{if split("-", instance_names_db_st[i])[1] ==  "db" ~}
${trimprefix(instance_names_db_st[i] , app_name)} ansible_host=${ips_db_st[i]}
%{ endif ~}
%{ endif ~}
%{ endfor ~}
