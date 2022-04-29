[app-${envt}]
%{for i in range(length(instance_names_app_st)) ~}
%{if length(regexall("[a-z]+" , instance_names_app_st[i])) >=3  ~}
%{if split("-", instance_names_app_st[i])[1] ==  "app" ~}
${trimprefix(instance_names_app_st[i] , app_name)} ansible_host=${ips_app_st[i]}
%{ endif ~}
%{ endif ~}
%{ endfor ~}
