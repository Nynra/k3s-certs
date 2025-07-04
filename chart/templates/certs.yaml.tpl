{{- if .Values.enableCerts }}
{{- range .Values.certs }}
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: {{ .name }}
  namespace: "{{ $.Values.namespace }}"
  annotations:
    argocd.argoproj.io/sync-wave: "-8"
spec:
  secretName: {{ .name }}
  commonName: {{ .commonName }}
  dnsNames:
    {{- range .dnsNames }}
    - "{{ . }}"
    {{- end }}
  issuerRef:
    name: {{ .clusterIssuer }}
    kind: ClusterIssuer
{{- end }}
{{- end }}
