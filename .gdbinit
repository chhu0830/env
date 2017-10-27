source /usr/local/peda/peda.py
source /usr/local/Pwngdb/pwngdb.py
source /usr/local/Pwngdb/angelheap/gdbinit.py

define hook-run
python
import angelheap
angelheap.init_angelheap()
end
end
