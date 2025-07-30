# This file contains helper templates for sanity checks
{{- if .Values.enableExternalSecrets }}{{- if .Values.certs.push.enabled }}
# If push secrets are enabled certStores should also be enabled and a certStore defined
{{- if not .Values.certStores.enabled }}
{{- fail "certStores must be enabled when push secrets are enabled" }}
{{- end }}
{{- if not .Values.certStores.secretStores }}
{{- fail "at least one certStore must be defined when push secrets are enabled" }}
{{- end }}
# If push secrets are enabled a secretStore must be defined
{{- $pushSecretStore := .Values.certs.push.secretStore | default .Values.certStores.secretStores | first | default "" }}
{{- if not $pushSecretStore }}
{{- fail "a secretStore must be defined for push secrets" }}
{{- end }}
# If push secrets are enabled certs need to be enabled
{{- if not .Values.certs.enabled }}
{{- fail "certs must be enabled when push secrets are enabled" }}
{{- end }}
{{- end }}{{- end }}
