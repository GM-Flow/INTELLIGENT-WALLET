# test_models.py
import sys
sys.path.append(".")   # allow 'app' package import from project root

try:
    import app.models.user as u
    import app.models.transaction as t
    print("Models imported OK")
except Exception as e:
    print("Import error:", e)
