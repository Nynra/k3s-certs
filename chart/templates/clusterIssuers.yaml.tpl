{{- if .Values.clusterIssuers.enabled }}
{{- range .Values.clusterIssuers.issuers }}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: {{ .name | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-9"
spec:
  acme:
    server: {{ .server | quote }}
    privateKeySecretRef:
      name: {{ .name | quote }}-private-key
      key: token
    solvers:
      - dns01:
          cloudflare:
            apiTokenSecretRef:
              name: {{ .secretName | quote }}
              key: token
        selector:
          dnsZones:
          {{- range .domains }}
          - "{{ . }}"
          {{- end }} 
{{- end }}
{{- end }}