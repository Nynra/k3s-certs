{{- if .Values.enabled }}
{{- if .Values.issuers.enabled }}
{{- range .Values.issuers.issuers }}
{{- if .enabled }}
---
apiVersion: cert-manager.io/v1
kind: Issuer
namespace: {{ $.Release.Namespace | quote }}
metadata:
  name: {{ .name | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "2"
    # Global annotations
    {{- if $.Values.global.commonAnnotations }}
      {{- toYaml $.Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if $.Values.global.commonLabels }}  
  labels:
    # Global labels
    {{- toYaml $.Values.global.commonLabels | nindent 4 }}
  {{- end }}
spec:
  acme:
    server: {{ .server | quote }}
    privateKeySecretRef:
      name: "{{ .name }}-private-key"
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
{{- end }}

{{- if .Values.clusterIssuers.enabled }}
{{- range .Values.clusterIssuers.issuers }}
{{- if .enabled }}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: {{ .name | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "2"
    # Global annotations
    {{- if $.Values.global.commonAnnotations }}
      {{- toYaml $.Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if $.Values.global.commonLabels }}  
  labels:
    # Global labels
    {{- toYaml $.Values.global.commonLabels | nindent 4 }}
  {{- end }}
spec:
  acme:
    server: {{ .server | quote }}
    privateKeySecretRef:
      name: "{{ .name }}-private-key"
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
{{- end }}
{{- end }}