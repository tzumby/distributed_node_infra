[nodes]
%{ for ip in nodes ~}
${ip}
%{ endfor ~}

[private_nodes]
%{ for ip in private_nodes ~}
${ip}
%{ endfor ~}
