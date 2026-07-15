#!/usr/bin/env bash
# Refreshes submission/ with the current contents of the source-of-truth files
# in the repo. Safe to re-run any time; each target is wiped and recopied.
#
# Usage: ./submission/sync_submission.sh   (run from anywhere, resolves repo root itself)

set -euo pipefail
cd "$(dirname "$0")/.."   # repo root (performance_testing/)
SUB="submission"

echo "Syncing into $SUB/ from repo root: $(pwd)"

# --- 01_Report ---------------------------------------------------------
rm -rf "$SUB/01_Report"
mkdir -p "$SUB/01_Report"
cp "report/report.md"                        "$SUB/01_Report/Report.md"
cp "docs/User_Guide.md"                       "$SUB/01_Report/User_Guide.md"
[ -f "docs/User_Guide.pdf" ] && cp "docs/User_Guide.pdf" "$SUB/01_Report/User_Guide.pdf"
# Graded separately per the rubric (S1 proposal is its own 10% line), but content is
# extracted from Report.md rather than maintained twice -- see the file's own header.
# If Report.md Sections 6 / 7.6 / 11 change, regenerate this extract file by hand first.
cp "report/S1_Tool_Survey_and_SLO_Extract.md" "$SUB/01_Report/S1_Tool_Survey_and_SLO_Extract.md"

# --- 04_Source_Code (excludes node_modules, .git, runtime db, results) --
rm -rf "$SUB/04_Source_Code"
mkdir -p "$SUB/04_Source_Code"

cp -r "eshop" "$SUB/04_Source_Code/eshop"
rm -rf "$SUB/04_Source_Code/eshop/backend/node_modules"
rm -rf "$SUB/04_Source_Code/eshop/frontend-web/node_modules"
rm -rf "$SUB/04_Source_Code/eshop/frontend-admin/node_modules"
rm -rf "$SUB/04_Source_Code/eshop/frontend-mobile/node_modules"
rm -f  "$SUB/04_Source_Code/eshop/backend/database.sqlite"

cp -r "load-tests" "$SUB/04_Source_Code/load-tests"
rm -rf "$SUB/04_Source_Code/load-tests/reports/results"
mkdir -p "$SUB/04_Source_Code/load-tests/reports/results"
touch "$SUB/04_Source_Code/load-tests/reports/results/.gitkeep"

cp -r "scripts" "$SUB/04_Source_Code/scripts"

# --- 05_AI_Audit_Pack ----------------------------------------------------
# Source of truth is report/[AI-0X]...docx.md -- the filled-in, official
# FIT@HCMUS templates (as of commit b0ead9b "ai declaration upload"). The
# older ai/AI-02_Audit_Report.md and ai/AI-04_Reflective_Statement.md are a
# stale, unfinished duplicate scaffold and are intentionally NOT used here.
rm -rf "$SUB/05_AI_Audit_Pack"
mkdir -p "$SUB/05_AI_Audit_Pack/prompts"
cp "report/[AI-02] - FIT@HCMUS - AI Audit Report_En.docx.md"          "$SUB/05_AI_Audit_Pack/[AI-02] - FIT@HCMUS - AI Audit Report_En.docx.md"
cp "report/[AI-03] - FIT@HCMUS - AI Disclosure Form_En.docx.md"       "$SUB/05_AI_Audit_Pack/[AI-03] - FIT@HCMUS - AI Disclosure Form_En.docx.md"
cp "report/[AI-04] - FIT@HCMUS - AI Reflective Statement_En.docx.md"  "$SUB/05_AI_Audit_Pack/[AI-04] - FIT@HCMUS - AI Reflective Statement_En.docx.md"
cp "ai/prompts/prompts_log.md"        "$SUB/05_AI_Audit_Pack/prompts/prompts_log.md"
# Raw per-member AI transcripts referenced by prompts_log.md
cp -r "prompts" "$SUB/05_AI_Audit_Pack/prompts/transcripts"

# --- 06_Activity_And_Feedback --------------------------------------------
rm -rf "$SUB/06_Activity_And_Feedback"
mkdir -p "$SUB/06_Activity_And_Feedback"
cp "docs/S5_Activity_Worksheet.md"             "$SUB/06_Activity_And_Feedback/S5_Activity_Worksheet.md"
cp "docs/S7_Audience_Feedback_Aggregated.md"   "$SUB/06_Activity_And_Feedback/S7_Audience_Feedback_Aggregated.md"
cp "docs/S8_Final_Reflection.md"               "$SUB/06_Activity_And_Feedback/S8_Final_Reflection.md"
cp "docs/team_log.md"                          "$SUB/06_Activity_And_Feedback/team_log.md"

# --- 02_Slides / 03_Demo_Video: pull in real files if the team has dropped them in place ---
[ -f "slides/Seminar_Slides.pptx" ] && cp "slides/Seminar_Slides.pptx" "$SUB/02_Slides/Seminar_Slides.pptx"
mp4=$(find media -maxdepth 1 -iname "*.mp4" | head -n 1 || true)
[ -n "$mp4" ] && cp "$mp4" "$SUB/03_Demo_Video/"

echo "Done. Review $SUB/README.md for the remaining TODOs before zipping."
