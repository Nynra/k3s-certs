{{- if .Values.enableIssuers }}
{{- range .Values.issuers }}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: {{ .name }}
  # annotations:
  #   argocd.argoproj.io/sync-wave: "-9"
spec:
  acme:
    server: {{ .server }}
    privateKeySecretRef:
      name: {{ .privateKeyName }}
      key: token
    solvers:
      - dns01:
          cloudflare:
            apiTokenSecretRef:
              name: {{ .externalSecret.name }}
              key: token
        selector:
          dnsZones:
          {{- range .domains }}
          - "{{ . }}"
          {{- end }} 
{{- end }}
{{- end }}