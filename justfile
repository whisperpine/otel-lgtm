# forward to visit Grafana dashboard at http://localhost:3000
forward:
  kubectl -n monitoring port-forward svc/grafana 3000:80

# get the randomly generated admin password of Grafana
passwd:
  kubectl -n monitoring get secret/grafana \
    -o jsonpath="{.data.admin-password}" | base64 -d
