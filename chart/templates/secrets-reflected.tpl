{{- if .Values.enabled }}
{{- if .Values.clusterIssuers.enabled }}
{{- range .Values.clusterIssuers.issuers }}
{{- if .reflectedSecret.enabled }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ .secretName | quote }}
  annotations:
    reflector.v1.k8s.emberstack.com/reflects: "{{ .originNamespace | quote }}/{{ .originSecretName | quote }}"
    # Global annotations
    {{- if $.Values.global.commonAnnotations }}
      {{- toYaml $.Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if $.Values.global.commonLabels }}  
  labels:
    # Global labels
    {{- toYaml $.Values.global.commonLabels | nindent 4 }}
  {{- end }}
data:
  # This is a placeholder. The actual data will be populated by the reflector.
  placeholder: "placeholder-value"
{{- end }}
{{- end }}
{{- end }}

{{- if .Values.issuers.enabled }}
{{- range .Values.issuers.issuers }}
{{- if .reflectedSecret.enabled }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ .secretName | quote }}
  annotations:
    reflector.v1.k8s.emberstack.com/reflects: "{{ .originNamespace | quote }}/{{ .originSecretName | quote }}"
    # Global annotations
    {{- if $.Values.global.commonAnnotations }}
      {{- toYaml $.Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if $.Values.global.commonLabels }}  
  labels:
    # Global labels
    {{- toYaml $.Values.global.commonLabels | nindent 4 }}
  {{- end }}
data:
  # This is a placeholder. The actual data will be populated by the reflector.
  placeholder: "placeholder-value"
{{- end }}
{{- end }}
{{- end }}

{{- if .Values.certStores.enabled }}
{{- range .Values.certStores.stores }}
{{- if .reflectedSecret.enabled }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ .secretName | quote }}
  annotations:
    reflector.v1.k8s.emberstack.com/reflects: "{{ .originNamespace | quote }}/{{ .originSecretName | quote }}"
    # Global annotations
    {{- if $.Values.global.commonAnnotations }}
      {{- toYaml $.Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if $.Values.global.commonLabels }}  
  labels:
    # Global labels
    {{- toYaml $.Values.global.commonLabels | nindent 4 }}
  {{- end }}
data:
  # This is a placeholder. The actual data will be populated by the reflector.
  placeholder: "placeholder-value"
{{- end }}
{{- end }}
{{- end }}
{{- end }}