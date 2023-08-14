unit sQLite3Api;

{$MINENUMSIZE 4}

interface

uses
  SysUtils, Classes, Types,
  Dialogs;

const
  {$IF Defined(WIN32)}
  bj = 'sqlite3.dll';
  _PU = '';
  {$ELSEIF Defined(WIN64)}
  bj = 'sqlite3.dll';
  _PU = '';
//  {$ELSEIF Defined(MSWINDOS)}
//  bj = 'sqlite.dll';
//  _PU = '';
  {$ELSE}
    {$MESSAGE Error 'Unsupported platform'}
  {$IFEND}

const
  { TODO : Macro probably uses invalid symbol "extern": }
  (* SQLITE_EXTERN extern *)
//  SQLITE_STDCALL = SQLITE_APICALL;
  SQLITE_VERSION = '3.42.0';
  SQLITE_VERSION_NUMBER = 3042000;
  SQLITE_SOURCE_ID = '2023-05-16 12:36:15 831d0fb2836b71c9bc51067c49fee4b8f18047814f2ff22d817d25195cf350b0';
  SQLITE_OK = 0;
  SQLITE_ERROR = 1;
  SQLITE_INTERNAL = 2;
  SQLITE_PERM = 3;
  SQLITE_ABORT = 4;
  SQLITE_BUSY = 5;
  SQLITE_LOCKED = 6;
  SQLITE_NOMEM = 7;
  SQLITE_READONLY = 8;
  SQLITE_INTERRUPT = 9;
  SQLITE_IOERR = 10;
  SQLITE_CORRUPT = 11;
  SQLITE_NOTFOUND = 12;
  SQLITE_FULL = 13;
  SQLITE_CANTOPEN = 14;
  SQLITE_PROTOCOL = 15;
  SQLITE_EMPTY = 16;
  SQLITE_SCHEMA = 17;
  SQLITE_TOOBIG = 18;
  SQLITE_CONSTRAINT = 19;
  SQLITE_MISMATCH = 20;
  SQLITE_MISUSE = 21;
  SQLITE_NOLFS = 22;
  SQLITE_AUTH = 23;
  SQLITE_FORMAT = 24;
  SQLITE_RANGE = 25;
  SQLITE_NOTADB = 26;
  SQLITE_NOTICE = 27;
  SQLITE_WARNING = 28;
  SQLITE_ROW = 100;
  SQLITE_DONE = 101;
  SQLITE_ERROR_MISSING_COLLSEQ = (SQLITE_ERROR or (1 shl 8));	// $101
  SQLITE_ERROR_RETRY = (SQLITE_ERROR or (2 shl 8));				// $201
  SQLITE_ERROR_SNAPSHOT = (SQLITE_ERROR or (3 shl 8));			// $301
  SQLITE_IOERR_READ = (SQLITE_IOERR or (1 shl 8));				// $10A
  SQLITE_IOERR_SHORT_READ = (SQLITE_IOERR or (2 shl 8));		// $20A
  SQLITE_IOERR_WRITE = (SQLITE_IOERR or (3 shl 8));				// $30A
  SQLITE_IOERR_FSYNC = (SQLITE_IOERR or (4 shl 8));				// $40A
  SQLITE_IOERR_DIR_FSYNC = (SQLITE_IOERR or (5 shl 8));			// $50A
  SQLITE_IOERR_TRUNCATE = (SQLITE_IOERR or (6 shl 8));			// $60A
  SQLITE_IOERR_FSTAT = (SQLITE_IOERR or (7 shl 8));				// $70A
  SQLITE_IOERR_UNLOCK = (SQLITE_IOERR or (8 shl 8));			// $80A
  SQLITE_IOERR_RDLOCK = (SQLITE_IOERR or (9 shl 8));			// $90A
  SQLITE_IOERR_DELETE = (SQLITE_IOERR or (10 shl 8));			// $A0A
  SQLITE_IOERR_BLOCKED = (SQLITE_IOERR or (11 shl 8));			// $B0A
  SQLITE_IOERR_NOMEM = (SQLITE_IOERR or (12 shl 8));			// $C0A
  SQLITE_IOERR_ACCESS = (SQLITE_IOERR or (13 shl 8));			// $D0A
  SQLITE_IOERR_CHECKRESERVEDLOCK = (SQLITE_IOERR or (14 shl 8));// $E0A
  SQLITE_IOERR_LOCK = (SQLITE_IOERR or (15 shl 8));				// $F0A
  SQLITE_IOERR_CLOSE = (SQLITE_IOERR or (16 shl 8));			// $100A
  SQLITE_IOERR_DIR_CLOSE = (SQLITE_IOERR or (17 shl 8));		// $110A
  SQLITE_IOERR_SHMOPEN = (SQLITE_IOERR or (18 shl 8));			// $120A
  SQLITE_IOERR_SHMSIZE = (SQLITE_IOERR or (19 shl 8));			// $130A
  SQLITE_IOERR_SHMLOCK = (SQLITE_IOERR or (20 shl 8));			// $140A
  SQLITE_IOERR_SHMMAP = (SQLITE_IOERR or (21 shl 8));			// $150A
  SQLITE_IOERR_SEEK = (SQLITE_IOERR or (22 shl 8));			// $160A
  SQLITE_IOERR_DELETE_NOENT = (SQLITE_IOERR or (23 shl 8));	// $170A
  SQLITE_IOERR_MMAP = (SQLITE_IOERR or (24 shl 8));		// $180A
  SQLITE_IOERR_GETTEMPPATH = (SQLITE_IOERR or (25 shl 8));	// $190A
  SQLITE_IOERR_CONVPATH = (SQLITE_IOERR or (26 shl 8));		// $1A0A
  SQLITE_IOERR_VNODE = (SQLITE_IOERR or (27 shl 8));		// $1B0A
  SQLITE_IOERR_AUTH = (SQLITE_IOERR or (28 shl 8));			// $1C0A
  SQLITE_IOERR_BEGIN_ATOMIC =(SQLITE_IOERR or (29 shl 8));	//  $1D0A
  SQLITE_IOERR_COMMIT_ATOMIC = (SQLITE_IOERR or (30 shl 8));// $1E0A
  SQLITE_IOERR_ROLLBACK_ATOMIC = (SQLITE_IOERR or (31 shl 8));	// $1F0A
  SQLITE_IOERR_DATA = (SQLITE_IOERR or (32 shl 8));			// $200A
  SQLITE_IOERR_CORRUPTFS = (SQLITE_IOERR or (33 shl 8));	// $210A
  SQLITE_LOCKED_SHAREDCACHE = (SQLITE_LOCKED or (1 shl 8));// $106
  SQLITE_LOCKED_VTAB = (SQLITE_LOCKED or (2 shl 8));	// $206
  SQLITE_BUSY_RECOVERY = (SQLITE_BUSY or (1 shl 8));	// $105
  SQLITE_BUSY_SNAPSHOT = (SQLITE_BUSY or (2 shl 8));	// $205
  SQLITE_BUSY_TIMEOUT = (SQLITE_BUSY or (3 shl 8));	// $305
  SQLITE_CANTOPEN_NOTEMPDIR = (SQLITE_CANTOPEN or (1 shl 8));	// $10E
  SQLITE_CANTOPEN_ISDIR = (SQLITE_CANTOPEN or (2 shl 8));	// $20E
  SQLITE_CANTOPEN_FULLPATH = (SQLITE_CANTOPEN or (3 shl 8));	// $30E
  SQLITE_CANTOPEN_CONVPATH = (SQLITE_CANTOPEN or (4 shl 8));	// $40E
  SQLITE_CANTOPEN_DIRTYWAL = (SQLITE_CANTOPEN or (5 shl 8));	// $50E
  SQLITE_CANTOPEN_SYMLINK = (SQLITE_CANTOPEN or (6 shl 8));	// $60E
  SQLITE_CORRUPT_VTAB = (SQLITE_CORRUPT or (1 shl 8));		// $10B
  SQLITE_CORRUPT_SEQUENCE = (SQLITE_CORRUPT or (2 shl 8));	// $20B
  SQLITE_CORRUPT_INDEX = (SQLITE_CORRUPT or (3 shl 8));		// $30B
  SQLITE_READONLY_RECOVERY = (SQLITE_READONLY or (1 shl 8));	// $108
  SQLITE_READONLY_CANTLOCK = (SQLITE_READONLY or (2 shl 8));	// $208
  SQLITE_READONLY_ROLLBACK = (SQLITE_READONLY or (3 shl 8));	// $308
  SQLITE_READONLY_DBMOVED = (SQLITE_READONLY or (4 shl 8));		// $408
  SQLITE_READONLY_CANTINIT = (SQLITE_READONLY or (5 shl 8));	// $508
  SQLITE_READONLY_DIRECTORY = (SQLITE_READONLY or (6 shl 8));	// 608
  SQLITE_ABORT_ROLLBACK = (SQLITE_ABORT or (2 shl 8));			// $204
  SQLITE_CONSTRAINT_CHECK = (SQLITE_CONSTRAINT or (1 shl 8));	// $113;
  SQLITE_CONSTRAINT_COMMITHOOK = (SQLITE_CONSTRAINT or (2 shl 8));	//$213;
  SQLITE_CONSTRAINT_FOREIGNKEY = (SQLITE_CONSTRAINT or (3 shl 8));	// $313
  SQLITE_CONSTRAINT_FUNCTION = (SQLITE_CONSTRAINT or (4 shl 8));	// $413
  SQLITE_CONSTRAINT_NOTNULL = (SQLITE_CONSTRAINT or (5 shl 8));		// $513
  SQLITE_CONSTRAINT_PRIMARYKEY = (SQLITE_CONSTRAINT or (6 shl 8));	// $613
  SQLITE_CONSTRAINT_TRIGGER = (SQLITE_CONSTRAINT or (7 shl 8));		// $713
  SQLITE_CONSTRAINT_UNIQUE = (SQLITE_CONSTRAINT or (8 shl 8));		// $813
  SQLITE_CONSTRAINT_VTAB = (SQLITE_CONSTRAINT or (9 shl 8));		// $913
  SQLITE_CONSTRAINT_ROWID = (SQLITE_CONSTRAINT or (10 shl 8));		// $A13
  SQLITE_CONSTRAINT_PINNED = (SQLITE_CONSTRAINT or (11 shl 8));		// $b13
  SQLITE_CONSTRAINT_DATATYPE = (SQLITE_CONSTRAINT or (12 shl 8));	// $C13
  SQLITE_NOTICE_RECOVER_WAL = (SQLITE_NOTICE or (1 shl 8));			// $11B
  SQLITE_NOTICE_RECOVER_ROLLBACK = (SQLITE_NOTICE or (2 shl 8));	// $21B
  SQLITE_NOTICE_RBU = (SQLITE_NOTICE or (3 shl 8));
  SQLITE_WARNING_AUTOINDEX = (SQLITE_WARNING or (1 shl 8));		// $11C
  SQLITE_AUTH_USER = (SQLITE_AUTH or (1 shl 8));				// $117
  SQLITE_OK_LOAD_PERMANENTLY = (SQLITE_OK or (1 shl 8));		// $100
  SQLITE_OK_SYMLINK = (SQLITE_OK or (2 shl 8));				// $200
  SQLITE_OPEN_READONLY = $00000001;
  SQLITE_OPEN_READWRITE = $00000002;
  SQLITE_OPEN_CREATE = $00000004;
  SQLITE_OPEN_DELETEONCLOSE = $00000008;
  SQLITE_OPEN_EXCLUSIVE = $00000010;
  SQLITE_OPEN_AUTOPROXY = $00000020;
  SQLITE_OPEN_URI = $00000040;
  SQLITE_OPEN_MEMORY = $00000080;
  SQLITE_OPEN_MAIN_DB = $00000100;
  SQLITE_OPEN_TEMP_DB = $00000200;
  SQLITE_OPEN_TRANSIENT_DB = $00000400;
  SQLITE_OPEN_MAIN_JOURNAL = $00000800;
  SQLITE_OPEN_TEMP_JOURNAL = $00001000;
  SQLITE_OPEN_SUBJOURNAL = $00002000;
  SQLITE_OPEN_SUPER_JOURNAL = $00004000;
  SQLITE_OPEN_NOMUTEX = $00008000;
  SQLITE_OPEN_FULLMUTEX = $00010000;
  SQLITE_OPEN_SHAREDCACHE = $00020000;
  SQLITE_OPEN_PRIVATECACHE = $00040000;
  SQLITE_OPEN_WAL = $00080000;
  SQLITE_OPEN_NOFOLLOW = $01000000;
  SQLITE_OPEN_EXRESCODE = $02000000;
  SQLITE_OPEN_MASTER_JOURNAL = $00004000;
  SQLITE_IOCAP_ATOMIC = $00000001;
  SQLITE_IOCAP_ATOMIC512 = $00000002;
  SQLITE_IOCAP_ATOMIC1K = $00000004;
  SQLITE_IOCAP_ATOMIC2K = $00000008;
  SQLITE_IOCAP_ATOMIC4K = $00000010;
  SQLITE_IOCAP_ATOMIC8K = $00000020;
  SQLITE_IOCAP_ATOMIC16K = $00000040;
  SQLITE_IOCAP_ATOMIC32K = $00000080;
  SQLITE_IOCAP_ATOMIC64K = $00000100;
  SQLITE_IOCAP_SAFE_APPEND = $00000200;
  SQLITE_IOCAP_SEQUENTIAL = $00000400;
  SQLITE_IOCAP_UNDELETABLE_WHEN_OPEN = $00000800;
  SQLITE_IOCAP_POWERSAFE_OVERWRITE = $00001000;
  SQLITE_IOCAP_IMMUTABLE = $00002000;
  SQLITE_IOCAP_BATCH_ATOMIC = $00004000;
  SQLITE_LOCK_NONE = 0;
  SQLITE_LOCK_SHARED = 1;
  SQLITE_LOCK_RESERVED = 2;
  SQLITE_LOCK_PENDING = 3;
  SQLITE_LOCK_EXCLUSIVE = 4;
  SQLITE_SYNC_NORMAL = $00002;
  SQLITE_SYNC_FULL = $00003;
  SQLITE_SYNC_DATAONLY = $00010;
  SQLITE_FCNTL_LOCKSTATE = 1;
  SQLITE_FCNTL_GET_LOCKPROXYFILE = 2;
  SQLITE_FCNTL_SET_LOCKPROXYFILE = 3;
  SQLITE_FCNTL_LAST_ERRNO = 4;
  SQLITE_FCNTL_SIZE_HINT = 5;
  SQLITE_FCNTL_CHUNK_SIZE = 6;
  SQLITE_FCNTL_FILE_POINTER = 7;
  SQLITE_FCNTL_SYNC_OMITTED = 8;
  SQLITE_FCNTL_WIN32_AV_RETRY = 9;
  SQLITE_FCNTL_PERSIST_WAL = 10;
  SQLITE_FCNTL_OVERWRITE = 11;
  SQLITE_FCNTL_VFSNAME = 12;
  SQLITE_FCNTL_POWERSAFE_OVERWRITE = 13;
  SQLITE_FCNTL_PRAGMA = 14;
  SQLITE_FCNTL_BUSYHANDLER = 15;
  SQLITE_FCNTL_TEMPFILENAME = 16;
  SQLITE_FCNTL_MMAP_SIZE = 18;
  SQLITE_FCNTL_TRACE = 19;
  SQLITE_FCNTL_HAS_MOVED = 20;
  SQLITE_FCNTL_SYNC = 21;
  SQLITE_FCNTL_COMMIT_PHASETWO = 22;
  SQLITE_FCNTL_WIN32_SET_HANDLE = 23;
  SQLITE_FCNTL_WAL_BLOCK = 24;
  SQLITE_FCNTL_ZIPVFS = 25;
  SQLITE_FCNTL_RBU = 26;
  SQLITE_FCNTL_VFS_POINTER = 27;
  SQLITE_FCNTL_JOURNAL_POINTER = 28;
  SQLITE_FCNTL_WIN32_GET_HANDLE = 29;
  SQLITE_FCNTL_PDB = 30;
  SQLITE_FCNTL_BEGIN_ATOMIC_WRITE = 31;
  SQLITE_FCNTL_COMMIT_ATOMIC_WRITE = 32;
  SQLITE_FCNTL_ROLLBACK_ATOMIC_WRITE = 33;
  SQLITE_FCNTL_LOCK_TIMEOUT = 34;
  SQLITE_FCNTL_DATA_VERSION = 35;
  SQLITE_FCNTL_SIZE_LIMIT = 36;
  SQLITE_FCNTL_CKPT_DONE = 37;
  SQLITE_FCNTL_RESERVE_BYTES = 38;
  SQLITE_FCNTL_CKPT_START = 39;
  SQLITE_FCNTL_EXTERNAL_READER = 40;
  SQLITE_FCNTL_CKSM_FILE = 41;
  SQLITE_FCNTL_RESET_CACHE = 42;
  SQLITE_GET_LOCKPROXYFILE = SQLITE_FCNTL_GET_LOCKPROXYFILE;	// 2
  SQLITE_SET_LOCKPROXYFILE = SQLITE_FCNTL_SET_LOCKPROXYFILE;	//3
  SQLITE_LAST_ERRNO = SQLITE_FCNTL_LAST_ERRNO;					// 4
  SQLITE_ACCESS_EXISTS = 0;
  SQLITE_ACCESS_READWRITE = 1;
  SQLITE_ACCESS_READ = 2;
  SQLITE_SHM_UNLOCK = 1;
  SQLITE_SHM_LOCK = 2;
  SQLITE_SHM_SHARED = 4;
  SQLITE_SHM_EXCLUSIVE = 8;
  SQLITE_SHM_NLOCK = 8;
  SQLITE_CONFIG_SINGLETHREAD = 1;
  SQLITE_CONFIG_MULTITHREAD = 2;
  SQLITE_CONFIG_SERIALIZED = 3;
  SQLITE_CONFIG_MALLOC = 4;
  SQLITE_CONFIG_GETMALLOC = 5;
  SQLITE_CONFIG_SCRATCH = 6;
  SQLITE_CONFIG_PAGECACHE = 7;
  SQLITE_CONFIG_HEAP = 8;
  SQLITE_CONFIG_MEMSTATUS = 9;
  SQLITE_CONFIG_MUTEX = 10;
  SQLITE_CONFIG_GETMUTEX = 11;
  SQLITE_CONFIG_LOOKASIDE = 13;
  SQLITE_CONFIG_PCACHE = 14;
  SQLITE_CONFIG_GETPCACHE = 15;
  SQLITE_CONFIG_LOG = 16;
  SQLITE_CONFIG_URI = 17;
  SQLITE_CONFIG_PCACHE2 = 18;
  SQLITE_CONFIG_GETPCACHE2 = 19;
  SQLITE_CONFIG_COVERING_INDEX_SCAN = 20;
  SQLITE_CONFIG_SQLLOG = 21;
  SQLITE_CONFIG_MMAP_SIZE = 22;
  SQLITE_CONFIG_WIN32_HEAPSIZE = 23;
  SQLITE_CONFIG_PCACHE_HDRSZ = 24;
  SQLITE_CONFIG_PMASZ = 25;
  SQLITE_CONFIG_STMTJRNL_SPILL = 26;
  SQLITE_CONFIG_SMALL_MALLOC = 27;
  SQLITE_CONFIG_SORTERREF_SIZE = 28;
  SQLITE_CONFIG_MEMDB_MAXSIZE = 29;
  SQLITE_DBCONFIG_MAINDBNAME = 1000;
  SQLITE_DBCONFIG_LOOKASIDE = 1001;
  SQLITE_DBCONFIG_ENABLE_FKEY = 1002;
  SQLITE_DBCONFIG_ENABLE_TRIGGER = 1003;
  SQLITE_DBCONFIG_ENABLE_FTS3_TOKENIZER = 1004;
  SQLITE_DBCONFIG_ENABLE_LOAD_EXTENSION = 1005;
  SQLITE_DBCONFIG_NO_CKPT_ON_CLOSE = 1006;
  SQLITE_DBCONFIG_ENABLE_QPSG = 1007;
  SQLITE_DBCONFIG_TRIGGER_EQP = 1008;
  SQLITE_DBCONFIG_RESET_DATABASE = 1009;
  SQLITE_DBCONFIG_DEFENSIVE = 1010;
  SQLITE_DBCONFIG_WRITABLE_SCHEMA = 1011;
  SQLITE_DBCONFIG_LEGACY_ALTER_TABLE = 1012;
  SQLITE_DBCONFIG_DQS_DML = 1013;
  SQLITE_DBCONFIG_DQS_DDL = 1014;
  SQLITE_DBCONFIG_ENABLE_VIEW = 1015;
  SQLITE_DBCONFIG_LEGACY_FILE_FORMAT = 1016;
  SQLITE_DBCONFIG_TRUSTED_SCHEMA = 1017;
  SQLITE_DBCONFIG_STMT_SCANSTATUS = 1018;
  SQLITE_DBCONFIG_REVERSE_SCANORDER = 1019;
  SQLITE_DBCONFIG_MAX = 1019;
  SQLITE_DENY = 1;
  SQLITE_IGNORE = 2;
  SQLITE_CREATE_INDEX = 1;
  SQLITE_CREATE_TABLE = 2;
  SQLITE_CREATE_TEMP_INDEX = 3;
  SQLITE_CREATE_TEMP_TABLE = 4;
  SQLITE_CREATE_TEMP_TRIGGER = 5;
  SQLITE_CREATE_TEMP_VIEW = 6;
  SQLITE_CREATE_TRIGGER = 7;
  SQLITE_CREATE_VIEW = 8;
  SQLITE_DELETE = 9;
  SQLITE_DROP_INDEX = 10;
  SQLITE_DROP_TABLE = 11;
  SQLITE_DROP_TEMP_INDEX = 12;
  SQLITE_DROP_TEMP_TABLE = 13;
  SQLITE_DROP_TEMP_TRIGGER = 14;
  SQLITE_DROP_TEMP_VIEW = 15;
  SQLITE_DROP_TRIGGER = 16;
  SQLITE_DROP_VIEW = 17;
  SQLITE_INSERT = 18;
  SQLITE_PRAGMA = 19;
  SQLITE_READ = 20;
  SQLITE_SELECT = 21;
  SQLITE_TRANSACTION = 22;
  SQLITE_UPDATE = 23;
  SQLITE_ATTACH = 24;
  SQLITE_DETACH = 25;
  SQLITE_ALTER_TABLE = 26;
  SQLITE_REINDEX = 27;
  SQLITE_ANALYZE = 28;
  SQLITE_CREATE_VTABLE = 29;
  SQLITE_DROP_VTABLE = 30;
  SQLITE_FUNCTION = 31;
  SQLITE_SAVEPOINT = 32;
  SQLITE_COPY = 0;
  SQLITE_RECURSIVE = 33;
  SQLITE_TRACE_STMT = $01;
  SQLITE_TRACE_PROFILE = $02;
  SQLITE_TRACE_ROW = $04;
  SQLITE_TRACE_CLOSE = $08;
  SQLITE_LIMIT_LENGTH = 0;
  SQLITE_LIMIT_SQL_LENGTH = 1;
  SQLITE_LIMIT_COLUMN = 2;
  SQLITE_LIMIT_EXPR_DEPTH = 3;
  SQLITE_LIMIT_COMPOUND_SELECT = 4;
  SQLITE_LIMIT_VDBE_OP = 5;
  SQLITE_LIMIT_FUNCTION_ARG = 6;
  SQLITE_LIMIT_ATTACHED = 7;
  SQLITE_LIMIT_LIKE_PATTERN_LENGTH = 8;
  SQLITE_LIMIT_VARIABLE_NUMBER = 9;
  SQLITE_LIMIT_TRIGGER_DEPTH = 10;
  SQLITE_LIMIT_WORKER_THREADS = 11;
  SQLITE_PREPARE_PERSISTENT = $01;
  SQLITE_PREPARE_NORMALIZE = $02;
  SQLITE_PREPARE_NO_VTAB = $04;
  SQLITE_INTEGER = 1;
  SQLITE_FLOAT = 2;
  SQLITE_BLOB = 4;
  SQLITE_NULL = 5;
  SQLITE_TEXT = 3;
  SQLITE3_TEXT = 3;
  SQLITE_UTF8 = 1;
  SQLITE_UTF16LE = 2;
  SQLITE_UTF16BE = 3;
  SQLITE_UTF16 = 4;
  SQLITE_ANY = 5;
  SQLITE_UTF16_ALIGNED = 8;
  SQLITE_DETERMINISTIC = $000000800;
  SQLITE_DIRECTONLY = $000080000;
  SQLITE_SUBTYPE = $000100000;
  SQLITE_INNOCUOUS = $000200000;
  SQLITE_STATIC = Pointer( 0 );
  SQLITE_TRANSIENT  = Pointer( -1 );
  SQLITE_WIN32_DATA_DIRECTORY_TYPE = 1;
  SQLITE_WIN32_TEMP_DIRECTORY_TYPE = 2;
  SQLITE_TXN_NONE = 0;
  SQLITE_TXN_READ = 1;
  SQLITE_TXN_WRITE = 2;
  SQLITE_INDEX_SCAN_UNIQUE = 1;
  SQLITE_INDEX_CONSTRAINT_EQ = 2;
  SQLITE_INDEX_CONSTRAINT_GT = 4;
  SQLITE_INDEX_CONSTRAINT_LE = 8;
  SQLITE_INDEX_CONSTRAINT_LT = 16;
  SQLITE_INDEX_CONSTRAINT_GE = 32;
  SQLITE_INDEX_CONSTRAINT_MATCH = 64;
  SQLITE_INDEX_CONSTRAINT_LIKE = 65;
  SQLITE_INDEX_CONSTRAINT_GLOB = 66;
  SQLITE_INDEX_CONSTRAINT_REGEXP = 67;
  SQLITE_INDEX_CONSTRAINT_NE = 68;
  SQLITE_INDEX_CONSTRAINT_ISNOT = 69;
  SQLITE_INDEX_CONSTRAINT_ISNOTNULL = 70;
  SQLITE_INDEX_CONSTRAINT_ISNULL = 71;
  SQLITE_INDEX_CONSTRAINT_IS = 72;
  SQLITE_INDEX_CONSTRAINT_LIMIT = 73;
  SQLITE_INDEX_CONSTRAINT_OFFSET = 74;
  SQLITE_INDEX_CONSTRAINT_FUNCTION = 150;
  SQLITE_MUTEX_FAST = 0;
  SQLITE_MUTEX_RECURSIVE = 1;
  SQLITE_MUTEX_STATIC_MAIN = 2;
  SQLITE_MUTEX_STATIC_MEM = 3;
  SQLITE_MUTEX_STATIC_MEM2 = 4;
  SQLITE_MUTEX_STATIC_OPEN = 4;
  SQLITE_MUTEX_STATIC_PRNG = 5;
  SQLITE_MUTEX_STATIC_LRU = 6;
  SQLITE_MUTEX_STATIC_LRU2 = 7;
  SQLITE_MUTEX_STATIC_PMEM = 7;
  SQLITE_MUTEX_STATIC_APP1 = 8;
  SQLITE_MUTEX_STATIC_APP2 = 9;
  SQLITE_MUTEX_STATIC_APP3 = 10;
  SQLITE_MUTEX_STATIC_VFS1 = 11;
  SQLITE_MUTEX_STATIC_VFS2 = 12;
  SQLITE_MUTEX_STATIC_VFS3 = 13;
  SQLITE_MUTEX_STATIC_MASTER = 2;
  SQLITE_TESTCTRL_FIRST = 5;
  SQLITE_TESTCTRL_PRNG_SAVE = 5;
  SQLITE_TESTCTRL_PRNG_RESTORE = 6;
  SQLITE_TESTCTRL_PRNG_RESET = 7;
  SQLITE_TESTCTRL_BITVEC_TEST = 8;
  SQLITE_TESTCTRL_FAULT_INSTALL = 9;
  SQLITE_TESTCTRL_BENIGN_MALLOC_HOOKS = 10;
  SQLITE_TESTCTRL_PENDING_BYTE = 11;
  SQLITE_TESTCTRL_ASSERT = 12;
  SQLITE_TESTCTRL_ALWAYS = 13;
  SQLITE_TESTCTRL_RESERVE = 14;
  SQLITE_TESTCTRL_OPTIMIZATIONS = 15;
  SQLITE_TESTCTRL_ISKEYWORD = 16;
  SQLITE_TESTCTRL_SCRATCHMALLOC = 17;
  SQLITE_TESTCTRL_INTERNAL_FUNCTIONS = 17;
  SQLITE_TESTCTRL_LOCALTIME_FAULT = 18;
  SQLITE_TESTCTRL_EXPLAIN_STMT = 19;
  SQLITE_TESTCTRL_ONCE_RESET_THRESHOLD = 19;
  SQLITE_TESTCTRL_NEVER_CORRUPT = 20;
  SQLITE_TESTCTRL_VDBE_COVERAGE = 21;
  SQLITE_TESTCTRL_BYTEORDER = 22;
  SQLITE_TESTCTRL_ISINIT = 23;
  SQLITE_TESTCTRL_SORTER_MMAP = 24;
  SQLITE_TESTCTRL_IMPOSTER = 25;
  SQLITE_TESTCTRL_PARSER_COVERAGE = 26;
  SQLITE_TESTCTRL_RESULT_INTREAL = 27;
  SQLITE_TESTCTRL_PRNG_SEED = 28;
  SQLITE_TESTCTRL_EXTRA_SCHEMA_CHECKS = 29;
  SQLITE_TESTCTRL_SEEK_COUNT = 30;
  SQLITE_TESTCTRL_TRACEFLAGS = 31;
  SQLITE_TESTCTRL_TUNE = 32;
  SQLITE_TESTCTRL_LOGEST = 33;
  SQLITE_TESTCTRL_LAST = 33;
  SQLITE_STATUS_MEMORY_USED = 0;
  SQLITE_STATUS_PAGECACHE_USED = 1;
  SQLITE_STATUS_PAGECACHE_OVERFLOW = 2;
  SQLITE_STATUS_SCRATCH_USED = 3;
  SQLITE_STATUS_SCRATCH_OVERFLOW = 4;
  SQLITE_STATUS_MALLOC_SIZE = 5;
  SQLITE_STATUS_PARSER_STACK = 6;
  SQLITE_STATUS_PAGECACHE_SIZE = 7;
  SQLITE_STATUS_SCRATCH_SIZE = 8;
  SQLITE_STATUS_MALLOC_COUNT = 9;
  SQLITE_DBSTATUS_LOOKASIDE_USED = 0;
  SQLITE_DBSTATUS_CACHE_USED = 1;
  SQLITE_DBSTATUS_SCHEMA_USED = 2;
  SQLITE_DBSTATUS_STMT_USED = 3;
  SQLITE_DBSTATUS_LOOKASIDE_HIT = 4;
  SQLITE_DBSTATUS_LOOKASIDE_MISS_SIZE = 5;
  SQLITE_DBSTATUS_LOOKASIDE_MISS_FULL = 6;
  SQLITE_DBSTATUS_CACHE_HIT = 7;
  SQLITE_DBSTATUS_CACHE_MISS = 8;
  SQLITE_DBSTATUS_CACHE_WRITE = 9;
  SQLITE_DBSTATUS_DEFERRED_FKS = 10;
  SQLITE_DBSTATUS_CACHE_USED_SHARED = 11;
  SQLITE_DBSTATUS_CACHE_SPILL = 12;
  SQLITE_DBSTATUS_MAX = 12;
  SQLITE_STMTSTATUS_FULLSCAN_STEP = 1;
  SQLITE_STMTSTATUS_SORT = 2;
  SQLITE_STMTSTATUS_AUTOINDEX = 3;
  SQLITE_STMTSTATUS_VM_STEP = 4;
  SQLITE_STMTSTATUS_REPREPARE = 5;
  SQLITE_STMTSTATUS_RUN = 6;
  SQLITE_STMTSTATUS_FILTER_MISS = 7;
  SQLITE_STMTSTATUS_FILTER_HIT = 8;
  SQLITE_STMTSTATUS_MEMUSED = 99;
  SQLITE_CHECKPOINT_PASSIVE = 0;
  SQLITE_CHECKPOINT_FULL = 1;
  SQLITE_CHECKPOINT_RESTART = 2;
  SQLITE_CHECKPOINT_TRUNCATE = 3;
  SQLITE_VTAB_CONSTRAINT_SUPPORT = 1;
  SQLITE_VTAB_INNOCUOUS = 2;
  SQLITE_VTAB_DIRECTONLY = 3;
  SQLITE_VTAB_USES_ALL_SCHEMAS = 4;
  SQLITE_ROLLBACK = 1;
  SQLITE_FAIL = 3;
  SQLITE_REPLACE = 5;
  SQLITE_SCANSTAT_NLOOP = 0;
  SQLITE_SCANSTAT_NVISIT = 1;
  SQLITE_SCANSTAT_EST = 2;
  SQLITE_SCANSTAT_NAME = 3;
  SQLITE_SCANSTAT_EXPLAIN = 4;
  SQLITE_SCANSTAT_SELECTID = 5;
  SQLITE_SCANSTAT_PARENTID = 6;
  SQLITE_SCANSTAT_NCYCLE = 7;
  SQLITE_SCANSTAT_COMPLEX = $0001;
  SQLITE_SERIALIZE_NOCOPY = $001;
  SQLITE_DESERIALIZE_FREEONCLOSE = 1;
  SQLITE_DESERIALIZE_RESIZEABLE = 2;
  SQLITE_DESERIALIZE_READONLY = 4;
  NOT_WITHIN = 0;
  PARTLY_WITHIN = 1;
  FULLY_WITHIN = 2;
  FTS5_TOKENIZE_QUERY = $0001;
  FTS5_TOKENIZE_PREFIX = $0002;
  FTS5_TOKENIZE_DOCUMENT = $0004;
  FTS5_TOKENIZE_AUX = $0008;
  FTS5_TOKEN_COLOCATED = $0001;

  SQLITE3_IDENTIFIER_QUOTE_CHAR = Char($22);   // '"';
  SQLITE3_STRING_QUOTE_CHAR = Char($27);

type
{ Defines needed for implementing functions }
  UTF8Char = AnsiChar;
  PUtf8Char = PAnsiChar;

  TUCS16Char = Word;
  TUTF8Char = String[4];
  sqlite3_ptr = Pointer;
{  TSQLite3Affinity = ( afInteger, afText, afNone, afReal, afNumeric ); }
  TSQLite3Affinity = ( afInteger, afText, afBlob, afReal, afNumeric );
  TSQLite3DatabaseType = ( dtMain, dtTemp, dtAttached );

  // Forward declarations
  PPUTF8Char = ^PUTF8Char;
  PPPUTF8Char = ^PPUTF8Char;
  Psqlite3_file = ^sqlite3_file;
  Psqlite3_io_methods = ^sqlite3_io_methods;
  Psqlite3_vfs = ^sqlite3_vfs;
  Psqlite3_mem_methods = ^sqlite3_mem_methods;
  Psqlite3_module = ^sqlite3_module;
  Psqlite3_index_constraint = ^sqlite3_index_constraint;
  Psqlite3_index_orderby = ^sqlite3_index_orderby;
  Psqlite3_index_constraint_usage = ^sqlite3_index_constraint_usage;
  Psqlite3_index_info = ^sqlite3_index_info;
  Psqlite3_vtab = ^sqlite3_vtab;
  PPsqlite3_vtab = ^Psqlite3_vtab;
  Psqlite3_vtab_cursor = ^sqlite3_vtab_cursor;
  PPsqlite3_vtab_cursor = ^Psqlite3_vtab_cursor;
  Psqlite3_mutex_methods = ^sqlite3_mutex_methods;
  Psqlite3_pcache_page = ^sqlite3_pcache_page;
  Psqlite3_pcache_methods2 = ^sqlite3_pcache_methods2;
  Psqlite3_pcache_methods = ^sqlite3_pcache_methods;
  Psqlite3_snapshot = ^sqlite3_snapshot;
  PPsqlite3_snapshot = ^Psqlite3_snapshot;
  Psqlite3_rtree_geometry = ^sqlite3_rtree_geometry;
  Psqlite3_rtree_query_info = ^sqlite3_rtree_query_info;
  PFts5PhraseIter = ^Fts5PhraseIter;
  PFts5ExtensionApi = ^Fts5ExtensionApi;
  Pfts5_tokenizer = ^fts5_tokenizer;
  Pfts5_api = ^fts5_api;

  Psqlite3 = Pointer;
  PPsqlite3 = ^Psqlite3;
  sqlite3_int64 = Int64;
  Psqlite3_int64 = ^sqlite3_int64;
  sqlite3_uint64 = UInt64;

  sqlite3_callback = function(p1: Pointer; p2: Integer; p3: PPUTF8Char; p4: PPUTF8Char): Integer; cdecl;



  sqlite3_file = record
    pMethods: Psqlite3_io_methods;
  end;

  sqlite3_io_methods = record
    iVersion: Integer;
    xClose: function(p1: Psqlite3_file): Integer; cdecl;
    xRead: function(p1: Psqlite3_file; p2: Pointer; iAmt: Integer; iOfst: sqlite3_int64): Integer; cdecl;
    xWrite: function(p1: Psqlite3_file; const p2: Pointer; iAmt: Integer; iOfst: sqlite3_int64): Integer; cdecl;
    xTruncate: function(p1: Psqlite3_file; size: sqlite3_int64): Integer; cdecl;
    xSync: function(p1: Psqlite3_file; flags: Integer): Integer; cdecl;
    xFileSize: function(p1: Psqlite3_file; pSize: Psqlite3_int64): Integer; cdecl;
    xLock: function(p1: Psqlite3_file; p2: Integer): Integer; cdecl;
    xUnlock: function(p1: Psqlite3_file; p2: Integer): Integer; cdecl;
    xCheckReservedLock: function(p1: Psqlite3_file; pResOut: PInteger): Integer; cdecl;
    xFileControl: function(p1: Psqlite3_file; op: Integer; pArg: Pointer): Integer; cdecl;
    xSectorSize: function(p1: Psqlite3_file): Integer; cdecl;
    xDeviceCharacteristics: function(p1: Psqlite3_file): Integer; cdecl;
    xShmMap: function(p1: Psqlite3_file; iPg: Integer; pgsz: Integer; p4: Integer; p5: PPointer): Integer; cdecl;
    xShmLock: function(p1: Psqlite3_file; offset: Integer; n: Integer; flags: Integer): Integer; cdecl;
    xShmBarrier: procedure(p1: Psqlite3_file); cdecl;
    xShmUnmap: function(p1: Psqlite3_file; deleteFlag: Integer): Integer; cdecl;
    xFetch: function(p1: Psqlite3_file; iOfst: sqlite3_int64; iAmt: Integer; pp: PPointer): Integer; cdecl;
    xUnfetch: function(p1: Psqlite3_file; iOfst: sqlite3_int64; p: Pointer): Integer; cdecl;
  end;


  Psqlite3_mutex = Pointer;
  PPsqlite3_mutex = ^Psqlite3_mutex;
  Psqlite3_api_routines = Pointer;
  PPsqlite3_api_routines = ^Psqlite3_api_routines;
  sqlite3_filename = PUTF8Char;

  sqlite3_syscall_ptr = procedure(); cdecl;

  sqlite3_vfs = record
    iVersion: Integer;
    szOsFile: Integer;
    mxPathname: Integer;
    pNext: Psqlite3_vfs;
    zName: PUTF8Char;
    pAppData: Pointer;
    xOpen: function(p1: Psqlite3_vfs; zName: sqlite3_filename; p3: Psqlite3_file; flags: Integer; pOutFlags: PInteger): Integer; cdecl;
    xDelete: function(p1: Psqlite3_vfs; const zName: PUTF8Char; syncDir: Integer): Integer; cdecl;
    xAccess: function(p1: Psqlite3_vfs; const zName: PUTF8Char; flags: Integer; pResOut: PInteger): Integer; cdecl;
    xFullPathname: function(p1: Psqlite3_vfs; const zName: PUTF8Char; nOut: Integer; zOut: PUTF8Char): Integer; cdecl;
    xDlOpen: function(p1: Psqlite3_vfs; const zFilename: PUTF8Char): Pointer; cdecl;
    xDlError: procedure(p1: Psqlite3_vfs; nByte: Integer; zErrMsg: PUTF8Char); cdecl;
{    xDlSym: function(p1: Psqlite3_vfs; p2: Pointer; const zSymbol: PUTF8Char): Pvoid (void); cdecl; }
    xDlSym: function(p1: Psqlite3_vfs; p2: Pointer; const zSymbol: PUTF8Char): sqlite3_syscall_ptr; cdecl;
    xDlClose: procedure(p1: Psqlite3_vfs; p2: Pointer); cdecl;
    xRandomness: function(p1: Psqlite3_vfs; nByte: Integer; zOut: PUTF8Char): Integer; cdecl;
    xSleep: function(p1: Psqlite3_vfs; microseconds: Integer): Integer; cdecl;
    xCurrentTime: function(p1: Psqlite3_vfs; p2: PDouble): Integer; cdecl;
    xGetLastError: function(p1: Psqlite3_vfs; p2: Integer; p3: PUTF8Char): Integer; cdecl;
    xCurrentTimeInt64: function(p1: Psqlite3_vfs; p2: Psqlite3_int64): Integer; cdecl;
    xSetSystemCall: function(p1: Psqlite3_vfs; const zName: PUTF8Char; p3: sqlite3_syscall_ptr): Integer; cdecl;
    xGetSystemCall: function(p1: Psqlite3_vfs; const zName: PUTF8Char): sqlite3_syscall_ptr; cdecl;
    xNextSystemCall: function(p1: Psqlite3_vfs; const zName: PUTF8Char): PUTF8Char; cdecl;
  end;

  sqlite3_mem_methods = record
    xMalloc: function(p1: Integer): Pointer; cdecl;
    xFree: procedure(p1: Pointer); cdecl;
    xRealloc: function(p1: Pointer; p2: Integer): Pointer; cdecl;
    xSize: function(p1: Pointer): Integer; cdecl;
    xRoundup: function(p1: Integer): Integer; cdecl;
    xInit: function(p1: Pointer): Integer; cdecl;
    xShutdown: procedure(p1: Pointer); cdecl;
    pAppData: Pointer;
  end;

  Psqlite3_stmt = Pointer;
  sqlite3_stmt_ptr = Psqlite3_stmt;
  PPsqlite3_stmt = ^Psqlite3_stmt;
  Psqlite3_value = Pointer;
  PPsqlite3_value = ^Psqlite3_value;
  Psqlite3_context = Pointer;
  PPsqlite3_context = ^Psqlite3_context;

  sqlite3_destructor_type = procedure(p1: Pointer); cdecl;
  TSQLite3_Bind_Destructor = sqlite3_destructor_type;

  TSQLite3xFunc = procedure(pContext: Psqlite3_context; argc: Integer; argv: PPsqlite3_value); cdecl;
  pSQLite3xFunc = ^TSQLite3xFunc;
  sqlite3_module = record
    iVersion: Integer;
    xCreate: function(p1: Psqlite3; pAux: Pointer; argc: Integer; const argv: PPUTF8Char; ppVTab: PPsqlite3_vtab; p6: PPUTF8Char): Integer; cdecl;
    xConnect: function(p1: Psqlite3; pAux: Pointer; argc: Integer; const argv: PPUTF8Char; ppVTab: PPsqlite3_vtab; p6: PPUTF8Char): Integer; cdecl;
    xBestIndex: function(pVTab: Psqlite3_vtab; p2: Psqlite3_index_info): Integer; cdecl;
    xDisconnect: function(pVTab: Psqlite3_vtab): Integer; cdecl;
    xDestroy: function(pVTab: Psqlite3_vtab): Integer; cdecl;
    xOpen: function(pVTab: Psqlite3_vtab; ppCursor: PPsqlite3_vtab_cursor): Integer; cdecl;
    xClose: function(p1: Psqlite3_vtab_cursor): Integer; cdecl;
    xFilter: function(p1: Psqlite3_vtab_cursor; idxNum: Integer; const idxStr: PUTF8Char; argc: Integer; argv: PPsqlite3_value): Integer; cdecl;
    xNext: function(p1: Psqlite3_vtab_cursor): Integer; cdecl;
    xEof: function(p1: Psqlite3_vtab_cursor): Integer; cdecl;
    xColumn: function(p1: Psqlite3_vtab_cursor; p2: Psqlite3_context; p3: Integer): Integer; cdecl;
    xRowid: function(p1: Psqlite3_vtab_cursor; pRowid: Psqlite3_int64): Integer; cdecl;
    xUpdate: function(p1: Psqlite3_vtab; p2: Integer; p3: PPsqlite3_value; p4: Psqlite3_int64): Integer; cdecl;
    xBegin: function(pVTab: Psqlite3_vtab): Integer; cdecl;
    xSync: function(pVTab: Psqlite3_vtab): Integer; cdecl;
    xCommit: function(pVTab: Psqlite3_vtab): Integer; cdecl;
    xRollback: function(pVTab: Psqlite3_vtab): Integer; cdecl;
//    xFindFunction: function(pVtab: Psqlite3_vtab; nArg: Integer; const zName: PUTF8Char; pxFunc: PPvoid (sqlite3_context *, int, sqlite3_value **); ppArg: PPointer): Integer; cdecl;
    xFindFunction: function(pVtab: Psqlite3_vtab; nArg: Integer; const zName: PUTF8Char; pxFunc: pSQLite3xFunc; ppArg: PPointer): Integer; cdecl;
    xRename: function(pVtab: Psqlite3_vtab; const zNew: PUTF8Char): Integer; cdecl;
    xSavepoint: function(pVTab: Psqlite3_vtab; p2: Integer): Integer; cdecl;
    xRelease: function(pVTab: Psqlite3_vtab; p2: Integer): Integer; cdecl;
    xRollbackTo: function(pVTab: Psqlite3_vtab; p2: Integer): Integer; cdecl;
    xShadowName: function(const p1: PUTF8Char): Integer; cdecl;
  end;

  sqlite3_index_constraint = record
    iColumn: Integer;
    op: Byte;
    usable: Byte;
    iTermOffset: Integer;
  end;

  sqlite3_index_orderby = record
    iColumn: Integer;
    desc: Byte;
  end;

  sqlite3_index_constraint_usage = record
    argvIndex: Integer;
    omit: Byte;
  end;

  sqlite3_index_info = record
    nConstraint: Integer;
    aConstraint: Psqlite3_index_constraint;
    nOrderBy: Integer;
    aOrderBy: Psqlite3_index_orderby;
    aConstraintUsage: Psqlite3_index_constraint_usage;
    idxNum: Integer;
    idxStr: PUTF8Char;
    needToFreeIdxStr: Integer;
    orderByConsumed: Integer;
    estimatedCost: Double;
    estimatedRows: sqlite3_int64;
    idxFlags: Integer;
    colUsed: sqlite3_uint64;
  end;

  sqlite3_vtab = record
    pModule: Psqlite3_module;
    nRef: Integer;
    zErrMsg: PUTF8Char;
  end;

  sqlite3_vtab_cursor = record
    pVtab: Psqlite3_vtab;
  end;

  Psqlite3_blob = Pointer;
  PPsqlite3_blob = ^Psqlite3_blob;

  sqlite3_mutex_methods = record
    xMutexInit: function(): Integer; cdecl;
    xMutexEnd: function(): Integer; cdecl;
    xMutexAlloc: function(p1: Integer): Psqlite3_mutex; cdecl;
    xMutexFree: procedure(p1: Psqlite3_mutex); cdecl;
    xMutexEnter: procedure(p1: Psqlite3_mutex); cdecl;
    xMutexTry: function(p1: Psqlite3_mutex): Integer; cdecl;
    xMutexLeave: procedure(p1: Psqlite3_mutex); cdecl;
    xMutexHeld: function(p1: Psqlite3_mutex): Integer; cdecl;
    xMutexNotheld: function(p1: Psqlite3_mutex): Integer; cdecl;
  end;

  Psqlite3_str = Pointer;
  PPsqlite3_str = ^Psqlite3_str;
  Psqlite3_pcache = Pointer;
  PPsqlite3_pcache = ^Psqlite3_pcache;

  sqlite3_pcache_page = record
    pBuf: Pointer;
    pExtra: Pointer;
  end;

  sqlite3_pcache_methods2 = record
    iVersion: Integer;
    pArg: Pointer;
    xInit: function(p1: Pointer): Integer; cdecl;
    xShutdown: procedure(p1: Pointer); cdecl;
    xCreate: function(szPage: Integer; szExtra: Integer; bPurgeable: Integer): Psqlite3_pcache; cdecl;
    xCachesize: procedure(p1: Psqlite3_pcache; nCachesize: Integer); cdecl;
    xPagecount: function(p1: Psqlite3_pcache): Integer; cdecl;
    xFetch: function(p1: Psqlite3_pcache; key: Cardinal; createFlag: Integer): Psqlite3_pcache_page; cdecl;
    xUnpin: procedure(p1: Psqlite3_pcache; p2: Psqlite3_pcache_page; discard: Integer); cdecl;
    xRekey: procedure(p1: Psqlite3_pcache; p2: Psqlite3_pcache_page; oldKey: Cardinal; newKey: Cardinal); cdecl;
    xTruncate: procedure(p1: Psqlite3_pcache; iLimit: Cardinal); cdecl;
    xDestroy: procedure(p1: Psqlite3_pcache); cdecl;
    xShrink: procedure(p1: Psqlite3_pcache); cdecl;
  end;

  sqlite3_pcache_methods = record
    pArg: Pointer;
    xInit: function(p1: Pointer): Integer; cdecl;
    xShutdown: procedure(p1: Pointer); cdecl;
    xCreate: function(szPage: Integer; bPurgeable: Integer): Psqlite3_pcache; cdecl;
    xCachesize: procedure(p1: Psqlite3_pcache; nCachesize: Integer); cdecl;
    xPagecount: function(p1: Psqlite3_pcache): Integer; cdecl;
    xFetch: function(p1: Psqlite3_pcache; key: Cardinal; createFlag: Integer): Pointer; cdecl;
    xUnpin: procedure(p1: Psqlite3_pcache; p2: Pointer; discard: Integer); cdecl;
    xRekey: procedure(p1: Psqlite3_pcache; p2: Pointer; oldKey: Cardinal; newKey: Cardinal); cdecl;
    xTruncate: procedure(p1: Psqlite3_pcache; iLimit: Cardinal); cdecl;
    xDestroy: procedure(p1: Psqlite3_pcache); cdecl;
  end;

  Psqlite3_backup = Pointer;
  PPsqlite3_backup = ^Psqlite3_backup;

  sqlite3_snapshot = record
    hidden: array [0..47] of Byte;
  end;

  sqlite3_rtree_dbl = Double;
  Psqlite3_rtree_dbl = ^sqlite3_rtree_dbl;

  sqlite3_rtree_geometry = record
    pContext: Pointer;
    nParam: Integer;
    aParam: Psqlite3_rtree_dbl;
    pUser: Pointer;
    xDelUser: procedure(p1: Pointer); cdecl;
  end;

  sqlite3_rtree_query_info = record
    pContext: Pointer;
    nParam: Integer;
    aParam: Psqlite3_rtree_dbl;
    pUser: Pointer;
    xDelUser: procedure(p1: Pointer); cdecl;
    aCoord: Psqlite3_rtree_dbl;
    anQueue: PCardinal;
    nCoord: Integer;
    iLevel: Integer;
    mxLevel: Integer;
    iRowid: sqlite3_int64;
    rParentScore: sqlite3_rtree_dbl;
    eParentWithin: Integer;
    eWithin: Integer;
    rScore: sqlite3_rtree_dbl;
    apSqlParam: PPsqlite3_value;
  end;

  PFts5Context = Pointer;
  PPFts5Context = ^PFts5Context;

  fts5_extension_function = procedure(const pApi: PFts5ExtensionApi; pFts: PFts5Context; pCtx: Psqlite3_context; nVal: Integer; apVal: PPsqlite3_value); cdecl;

  Fts5PhraseIter = record
    a: PByte;
    b: PByte;
  end;

  Fts5ExtensionApi = record
    iVersion: Integer;
    xUserData: function(p1: PFts5Context): Pointer; cdecl;
    xColumnCount: function(p1: PFts5Context): Integer; cdecl;
    xRowCount: function(p1: PFts5Context; pnRow: Psqlite3_int64): Integer; cdecl;
    xColumnTotalSize: function(p1: PFts5Context; iCol: Integer; pnToken: Psqlite3_int64): Integer; cdecl;
    xTokenize: function(p1: PFts5Context; const pText: PUTF8Char; nText: Integer; pCtx: Pointer; xToken: { TODO : Create a procedural type for this parameter }
    Pointer): Integer; cdecl;
    xPhraseCount: function(p1: PFts5Context): Integer; cdecl;
    xPhraseSize: function(p1: PFts5Context; iPhrase: Integer): Integer; cdecl;
    xInstCount: function(p1: PFts5Context; pnInst: PInteger): Integer; cdecl;
    xInst: function(p1: PFts5Context; iIdx: Integer; piPhrase: PInteger; piCol: PInteger; piOff: PInteger): Integer; cdecl;
    xRowid: function(p1: PFts5Context): sqlite3_int64; cdecl;
    xColumnText: function(p1: PFts5Context; iCol: Integer; pz: PPUTF8Char; pn: PInteger): Integer; cdecl;
    xColumnSize: function(p1: PFts5Context; iCol: Integer; pnToken: PInteger): Integer; cdecl;
    xQueryPhrase: function(p1: PFts5Context; iPhrase: Integer; pUserData: Pointer; p4: { TODO : Create a procedural type for this parameter }
    Pointer): Integer; cdecl;
    xSetAuxdata: function(p1: PFts5Context; pAux: Pointer; xDelete: { TODO : Create a procedural type for this parameter }
    Pointer): Integer; cdecl;
    xGetAuxdata: function(p1: PFts5Context; bClear: Integer): Pointer; cdecl;
    xPhraseFirst: function(p1: PFts5Context; iPhrase: Integer; p3: PFts5PhraseIter; p4: PInteger; p5: PInteger): Integer; cdecl;
    xPhraseNext: procedure(p1: PFts5Context; p2: PFts5PhraseIter; piCol: PInteger; piOff: PInteger); cdecl;
    xPhraseFirstColumn: function(p1: PFts5Context; iPhrase: Integer; p3: PFts5PhraseIter; p4: PInteger): Integer; cdecl;
    xPhraseNextColumn: procedure(p1: PFts5Context; p2: PFts5PhraseIter; piCol: PInteger); cdecl;
  end;

  PFts5Tokenizer = Pointer;
  PPFts5Tokenizer = ^PFts5Tokenizer;

  fts5_tokenizer = record
    xCreate: function(p1: Pointer; azArg: PPUTF8Char; nArg: Integer; ppOut: PPFts5Tokenizer): Integer; cdecl;
    xDelete: procedure(p1: PFts5Tokenizer); cdecl;
    xTokenize: function(p1: PFts5Tokenizer; pCtx: Pointer; flags: Integer; const pText: PUTF8Char; nText: Integer; xToken: { TODO : Create a procedural type for this parameter }
    Pointer): Integer; cdecl;
  end;

  fts5_api = record
    iVersion: Integer;
    xCreateTokenizer: function(pApi: Pfts5_api; const zName: PUTF8Char; pContext: Pointer; pTokenizer: Pfts5_tokenizer; xDestroy: { TODO : Create a procedural type for this parameter }
    Pointer): Integer; cdecl;
    xFindTokenizer: function(pApi: Pfts5_api; const zName: PUTF8Char; ppContext: PPointer; pTokenizer: Pfts5_tokenizer): Integer; cdecl;
    xCreateFunction: function(pApi: Pfts5_api; const zName: PUTF8Char; pContext: Pointer; xFunction: fts5_extension_function; xDestroy: { TODO : Create a procedural type for this parameter }
    Pointer): Integer; cdecl;
  end;


//  sqlite3_loadext_entry = function(db: Psqlite3; pzErrMsg: PPUTF8Char; const pThunk: Psqlite3_api_routines): Integer; cdecl;

function sqlite3_libversion(): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_libversion';

function sqlite3_sourceid(): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_sourceid';

function sqlite3_libversion_number(): Integer; cdecl;
  external bj name _PU + 'sqlite3_libversion_number';

function sqlite3_compileoption_used(const zOptName: PUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_compileoption_used';

function sqlite3_compileoption_get(N: Integer): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_compileoption_get';

function sqlite3_threadsafe(): Integer; cdecl;
  external bj name _PU + 'sqlite3_threadsafe';

function sqlite3_close(p1: Psqlite3): Integer; cdecl;
  external bj name _PU + 'sqlite3_close';

function sqlite3_close_v2(p1: Psqlite3): Integer; cdecl;
  external bj name _PU + 'sqlite3_close_v2';

type
  sqlite3_exec_callback = function(p1: Pointer; p2: Integer; p3: PPUTF8Char; p4: PPUTF8ChaR): Integer; cdecl;

function sqlite3_exec(p1: Psqlite3; const sql: PUTF8Char; callback: sqlite3_exec_callback; p4: Pointer; errmsg: PPUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_exec';

function sqlite3_initialize(): Integer; cdecl;
  external bj name _PU + 'sqlite3_initialize';

function sqlite3_shutdown(): Integer; cdecl;
  external bj name _PU + 'sqlite3_shutdown';

function sqlite3_os_init(): Integer; cdecl;
  external bj name _PU + 'sqlite3_os_init';

function sqlite3_os_end(): Integer; cdecl;
  external bj name _PU + 'sqlite3_os_end';

function sqlite3_config(p1: Integer): Integer varargs; cdecl;
  external bj name _PU + 'sqlite3_config';

function sqlite3_db_config(p1: Psqlite3; op: Integer): Integer varargs; cdecl;
  external bj name _PU + 'sqlite3_db_config';

function sqlite3_extended_result_codes(p1: Psqlite3; onoff: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_extended_result_codes';

function sqlite3_last_insert_rowid(p1: Psqlite3): sqlite3_int64; cdecl;
  external bj name _PU + 'sqlite3_last_insert_rowid';

procedure sqlite3_set_last_insert_rowid(p1: Psqlite3; p2: sqlite3_int64); cdecl;
  external bj name _PU + 'sqlite3_set_last_insert_rowid';

function sqlite3_changes(p1: Psqlite3): Integer; cdecl;
  external bj name _PU + 'sqlite3_changes';

function sqlite3_changes64(p1: Psqlite3): sqlite3_int64; cdecl;
  external bj name _PU + 'sqlite3_changes64';

function sqlite3_total_changes(p1: Psqlite3): Integer; cdecl;
  external bj name _PU + 'sqlite3_total_changes';

function sqlite3_total_changes64(p1: Psqlite3): sqlite3_int64; cdecl;
  external bj name _PU + 'sqlite3_total_changes64';

procedure sqlite3_interrupt(p1: Psqlite3); cdecl;
  external bj name _PU + 'sqlite3_interrupt';

function sqlite3_is_interrupted(p1: Psqlite3): Integer; cdecl;
  external bj name _PU + 'sqlite3_is_interrupted';
function sqlite3_complete(const sql: PUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_complete';

function sqlite3_complete16(const sql: Pointer): Integer; cdecl;
  external bj name _PU + 'sqlite3_complete16';

type
  sqlite3_busy_handler_ = function(p1: Pointer; p2: Integer): Integer; cdecl;

function sqlite3_busy_handler(p1: Psqlite3; p2: sqlite3_busy_handler_; p3: Pointer): Integer; cdecl;
  external bj name _PU + 'sqlite3_busy_handler';

function sqlite3_busy_timeout(p1: Psqlite3; ms: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_busy_timeout';

function sqlite3_get_table(db: Psqlite3; const zSql: PUTF8Char; pazResult: PPPUTF8Char; pnRow: PInteger; pnColumn: PInteger; pzErrmsg: PPUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_get_table';

procedure sqlite3_free_table(result: PPUTF8Char); cdecl;
  external bj name _PU + 'sqlite3_free_table';

function sqlite3_mprintf(const p1: PUTF8Char): PUTF8Char varargs; cdecl;
  external bj name _PU + 'sqlite3_mprintf';

function sqlite3_vmprintf(const p1: PUTF8Char; p2: Pointer): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_vmprintf';

function sqlite3_snprintf(p1: Integer; p2: PUTF8Char; const p3: PUTF8Char): PUTF8Char varargs; cdecl;
  external bj name _PU + 'sqlite3_snprintf';

function sqlite3_vsnprintf(p1: Integer; p2: PUTF8Char; const p3: PUTF8Char; p4: Pointer): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_vsnprintf';

function sqlite3_malloc(p1: Integer): Pointer; cdecl;
  external bj name _PU + 'sqlite3_malloc';

function sqlite3_malloc64(p1: sqlite3_uint64): Pointer; cdecl;
  external bj name _PU + 'sqlite3_malloc64';

function sqlite3_realloc(p1: Pointer; p2: Integer): Pointer; cdecl;
  external bj name _PU + 'sqlite3_realloc';

function sqlite3_realloc64(p1: Pointer; p2: sqlite3_uint64): Pointer; cdecl;
  external bj name _PU + 'sqlite3_realloc64';

procedure sqlite3_free(p1: Pointer); cdecl;
  external bj name _PU + 'sqlite3_free';

function sqlite3_msize(p1: Pointer): sqlite3_uint64; cdecl;
  external bj name _PU + 'sqlite3_msize';

function sqlite3_memory_used(): sqlite3_int64; cdecl;
  external bj name _PU + 'sqlite3_memory_used';

function sqlite3_memory_highwater(resetFlag: Integer): sqlite3_int64; cdecl;
  external bj name _PU + 'sqlite3_memory_highwater';

procedure sqlite3_randomness(N: Integer; P: Pointer); cdecl;
  external bj name _PU + 'sqlite3_randomness';

type
  sqlite3_set_authorizer_xAuth = function(p1: Pointer; p2: Integer; const p3: PUTF8Char; const p4: PUTF8Char; const p5: PUTF8Char; const p6: PUTF8Char): Integer; cdecl;

function sqlite3_set_authorizer(p1: Psqlite3; xAuth: sqlite3_set_authorizer_xAuth; pUserData: Pointer): Integer; cdecl;
  external bj name _PU + 'sqlite3_set_authorizer';

type
  sqlite3_trace_xTrace = procedure(p1: Pointer; const p2: PUTF8Char); cdecl;

function sqlite3_trace(p1: Psqlite3; xTrace: sqlite3_trace_xTrace; p3: Pointer): Pointer; cdecl;
  external bj name _PU + 'sqlite3_trace';

type
  sqlite3_profile_xProfile = procedure(p1: Pointer; const p2: PUTF8Char; p3: sqlite3_uint64); cdecl;

function sqlite3_profile(p1: Psqlite3; xProfile: sqlite3_profile_xProfile; p3: Pointer): Pointer; cdecl;
  external bj name _PU + 'sqlite3_profile';

type
  sqlite3_trace_v2_xCallback = function(p1: Cardinal; p2: Pointer; p3: Pointer; p4: Pointer): Integer; cdecl;

function sqlite3_trace_v2(p1: Psqlite3; uMask: Cardinal; xCallback: sqlite3_trace_v2_xCallback; pCtx: Pointer): Integer; cdecl;
  external bj name _PU + 'sqlite3_trace_v2';

type
  sqlite3_progress_handler_ = function(p1: Pointer): Integer; cdecl;

procedure sqlite3_progress_handler(p1: Psqlite3; p2: Integer; p3: sqlite3_progress_handler_; p4: Pointer); cdecl;
  external bj name _PU + 'sqlite3_progress_handler';

function sqlite3_open(const filename: PUTF8Char; ppDb: PPsqlite3): Integer; cdecl;
  external bj name _PU + 'sqlite3_open';

function sqlite3_open16(const filename: Pointer; ppDb: PPsqlite3): Integer; cdecl;
  external bj name _PU + 'sqlite3_open16';

function sqlite3_open_v2(const filename: PUTF8Char; ppDb: PPsqlite3; flags: Integer; const zVfs: PUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_open_v2';

function sqlite3_uri_parameter(z: sqlite3_filename; const zParam: PUTF8Char): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_uri_parameter';

function sqlite3_uri_boolean(z: sqlite3_filename; const zParam: PUTF8Char; bDefault: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_uri_boolean';

function sqlite3_uri_int64(p1: sqlite3_filename; const p2: PUTF8Char; p3: sqlite3_int64): sqlite3_int64; cdecl;
  external bj name _PU + 'sqlite3_uri_int64';

function sqlite3_uri_key(z: sqlite3_filename; N: Integer): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_uri_key';

function sqlite3_filename_database(p1: sqlite3_filename): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_filename_database';

function sqlite3_filename_journal(p1: sqlite3_filename): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_filename_journal';

function sqlite3_filename_wal(p1: sqlite3_filename): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_filename_wal';

function sqlite3_database_file_object(const p1: PUTF8Char): Psqlite3_file; cdecl;
  external bj name _PU + 'sqlite3_database_file_object';

function sqlite3_create_filename(const zDatabase: PUTF8Char; const zJournal: PUTF8Char; const zWal: PUTF8Char; nParam: Integer; azParam: PPUTF8Char): sqlite3_filename; cdecl;
  external bj name _PU + 'sqlite3_create_filename';

procedure sqlite3_free_filename(p1: sqlite3_filename); cdecl;
  external bj name _PU + 'sqlite3_free_filename';

function sqlite3_errcode(db: Psqlite3): Integer; cdecl;
  external bj name _PU + 'sqlite3_errcode';

function sqlite3_extended_errcode(db: Psqlite3): Integer; cdecl;
  external bj name _PU + 'sqlite3_extended_errcode';

function sqlite3_errmsg(p1: Psqlite3): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_errmsg';

function sqlite3_errmsg16(p1: Psqlite3): Pointer; cdecl;
  external bj name _PU + 'sqlite3_errmsg16';

function sqlite3_errstr(p1: Integer): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_errstr';

function sqlite3_error_offset(db: Psqlite3): Integer; cdecl;
  external bj name _PU + 'sqlite3_error_offset';

function sqlite3_limit(p1: Psqlite3; id: Integer; newVal: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_limit';

function sqlite3_prepare(db: Psqlite3; const zSql: PUTF8Char; nByte: Integer; ppStmt: PPsqlite3_stmt; pzTail: PPUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_prepare';

function sqlite3_prepare_v2(db: Psqlite3; const zSql: PUTF8Char; nByte: Integer; ppStmt: PPsqlite3_stmt; pzTail: PPUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_prepare_v2';

function sqlite3_prepare_v3(db: Psqlite3; const zSql: PUTF8Char; nByte: Integer; prepFlags: Cardinal; ppStmt: PPsqlite3_stmt; pzTail: PPUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_prepare_v3';

function sqlite3_prepare16(db: Psqlite3; const zSql: Pointer; nByte: Integer; ppStmt: PPsqlite3_stmt; pzTail: PPointer): Integer; cdecl;
  external bj name _PU + 'sqlite3_prepare16';

function sqlite3_prepare16_v2(db: Psqlite3; const zSql: Pointer; nByte: Integer; ppStmt: PPsqlite3_stmt; pzTail: PPointer): Integer; cdecl;
  external bj name _PU + 'sqlite3_prepare16_v2';

function sqlite3_prepare16_v3(db: Psqlite3; const zSql: Pointer; nByte: Integer; prepFlags: Cardinal; ppStmt: PPsqlite3_stmt; pzTail: PPointer): Integer; cdecl;
  external bj name _PU + 'sqlite3_prepare16_v3';

function sqlite3_sql(pStmt: Psqlite3_stmt): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_sql';

function sqlite3_expanded_sql(pStmt: Psqlite3_stmt): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_expanded_sql';

function sqlite3_stmt_readonly(pStmt: Psqlite3_stmt): Integer; cdecl;
  external bj name _PU + 'sqlite3_stmt_readonly';

function sqlite3_stmt_isexplain(pStmt: Psqlite3_stmt): Integer; cdecl;
  external bj name _PU + 'sqlite3_stmt_isexplain';

function sqlite3_stmt_busy(p1: Psqlite3_stmt): Integer; cdecl;
  external bj name _PU + 'sqlite3_stmt_busy';

type
  sqlite3_bind_blob_ = procedure(p1: Pointer); cdecl;

function sqlite3_bind_blob(p1: Psqlite3_stmt; p2: Integer; const p3: Pointer; n: Integer; p5: sqlite3_bind_blob_): Integer; cdecl;
  external bj name _PU + 'sqlite3_bind_blob';

type
  sqlite3_bind_blob64_ = procedure(p1: Pointer); cdecl;

function sqlite3_bind_blob64(p1: Psqlite3_stmt; p2: Integer; const p3: Pointer; p4: sqlite3_uint64; p5: sqlite3_bind_blob64_): Integer; cdecl;
  external bj name _PU + 'sqlite3_bind_blob64';

function sqlite3_bind_double(p1: Psqlite3_stmt; p2: Integer; p3: Double): Integer; cdecl;
  external bj name _PU + 'sqlite3_bind_double';

function sqlite3_bind_int(p1: Psqlite3_stmt; p2: Integer; p3: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_bind_int';

function sqlite3_bind_int64(p1: Psqlite3_stmt; p2: Integer; p3: sqlite3_int64): Integer; cdecl;
  external bj name _PU + 'sqlite3_bind_int64';

function sqlite3_bind_null(p1: Psqlite3_stmt; p2: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_bind_null';

type
  sqlite3_bind_text_ = procedure(p1: Pointer); cdecl;

function sqlite3_bind_text(p1: Psqlite3_stmt; p2: Integer; const p3: PUTF8Char; p4: Integer; p5: sqlite3_bind_text_): Integer; cdecl;
  external bj name _PU + 'sqlite3_bind_text';

type
  sqlite3_bind_text16_ = procedure(p1: Pointer); cdecl;

function sqlite3_bind_text16(p1: Psqlite3_stmt; p2: Integer; const p3: Pointer; p4: Integer; p5: sqlite3_bind_text16_): Integer; cdecl;
  external bj name _PU + 'sqlite3_bind_text16';

type
  sqlite3_bind_text64_ = procedure(p1: Pointer); cdecl;

function sqlite3_bind_text64(p1: Psqlite3_stmt; p2: Integer; const p3: PUTF8Char; p4: sqlite3_uint64; p5: sqlite3_bind_text64_; encoding: Byte): Integer; cdecl;
  external bj name _PU + 'sqlite3_bind_text64';

function sqlite3_bind_value(p1: Psqlite3_stmt; p2: Integer; const p3: Psqlite3_value): Integer; cdecl;
  external bj name _PU + 'sqlite3_bind_value';

type
  sqlite3_bind_pointer_ = procedure(p1: Pointer); cdecl;

function sqlite3_bind_pointer(p1: Psqlite3_stmt; p2: Integer; p3: Pointer; const p4: PUTF8Char; p5: sqlite3_bind_pointer_): Integer; cdecl;
  external bj name _PU + 'sqlite3_bind_pointer';

function sqlite3_bind_zeroblob(p1: Psqlite3_stmt; p2: Integer; n: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_bind_zeroblob';

function sqlite3_bind_zeroblob64(p1: Psqlite3_stmt; p2: Integer; p3: sqlite3_uint64): Integer; cdecl;
  external bj name _PU + 'sqlite3_bind_zeroblob64';

function sqlite3_bind_parameter_count(p1: Psqlite3_stmt): Integer; cdecl;
  external bj name _PU + 'sqlite3_bind_parameter_count';

function sqlite3_bind_parameter_name(p1: Psqlite3_stmt; p2: Integer): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_bind_parameter_name';

function sqlite3_bind_parameter_index(p1: Psqlite3_stmt; const zName: PUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_bind_parameter_index';

function sqlite3_clear_bindings(pStmt: Psqlite3_stmt): Integer; cdecl;
  external bj name _PU + 'sqlite3_clear_bindings';

function sqlite3_column_count(pStmt: Psqlite3_stmt): Integer; cdecl;
  external bj name _PU + 'sqlite3_column_count';

function sqlite3_column_name(p1: Psqlite3_stmt; N: Integer): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_column_name';

function sqlite3_column_name16(p1: Psqlite3_stmt; N: Integer): Pointer; cdecl;
  external bj name _PU + 'sqlite3_column_name16';

function sqlite3_column_database_name(p1: Psqlite3_stmt; p2: Integer): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_column_database_name';

function sqlite3_column_database_name16(p1: Psqlite3_stmt; p2: Integer): PWideChar; cdecl;
  external bj name _PU + 'sqlite3_column_database_name16';

function sqlite3_column_table_name(p1: Psqlite3_stmt; p2: Integer): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_column_table_name';

function sqlite3_column_table_name16(p1: Psqlite3_stmt; p2: Integer): PWideChar; cdecl;
  external bj name _PU + 'sqlite3_column_table_name16';

function sqlite3_column_origin_name(p1: Psqlite3_stmt; p2: Integer): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_column_origin_name';

function sqlite3_column_origin_name16(p1: Psqlite3_stmt; p2: Integer): PWideChar; cdecl;
  external bj name _PU + 'sqlite3_column_origin_name16';

function sqlite3_column_decltype(p1: Psqlite3_stmt; p2: Integer): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_column_decltype';

function sqlite3_column_decltype16(p1: Psqlite3_stmt; p2: Integer): Pointer; cdecl;
  external bj name _PU + 'sqlite3_column_decltype16';

function sqlite3_step(p1: Psqlite3_stmt): Integer; cdecl;
  external bj name _PU + 'sqlite3_step';

function sqlite3_data_count(pStmt: Psqlite3_stmt): Integer; cdecl;
  external bj name _PU + 'sqlite3_data_count';

function sqlite3_column_blob(p1: Psqlite3_stmt; iCol: Integer): Pointer; cdecl;
  external bj name _PU + 'sqlite3_column_blob';

function sqlite3_column_double(p1: Psqlite3_stmt; iCol: Integer): Double; cdecl;
  external bj name _PU + 'sqlite3_column_double';

function sqlite3_column_int(p1: Psqlite3_stmt; iCol: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_column_int';

function sqlite3_column_int64(p1: Psqlite3_stmt; iCol: Integer): sqlite3_int64; cdecl;
  external bj name _PU + 'sqlite3_column_int64';

//function sqlite3_column_text(p1: Psqlite3_stmt; iCol: Integer): PByte; cdecl;
function sqlite3_column_text(p1: Psqlite3_stmt; iCol: Integer): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_column_text';

function sqlite3_column_text16(p1: Psqlite3_stmt; iCol: Integer): Pointer; cdecl;
  external bj name _PU + 'sqlite3_column_text16';

function sqlite3_column_value(p1: Psqlite3_stmt; iCol: Integer): Psqlite3_value; cdecl;
  external bj name _PU + 'sqlite3_column_value';

function sqlite3_column_bytes(p1: Psqlite3_stmt; iCol: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_column_bytes';

function sqlite3_column_bytes16(p1: Psqlite3_stmt; iCol: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_column_bytes16';

function sqlite3_column_type(p1: Psqlite3_stmt; iCol: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_column_type';

function sqlite3_finalize(pStmt: Psqlite3_stmt): Integer; cdecl;
  external bj name _PU + 'sqlite3_finalize';

function sqlite3_reset(pStmt: Psqlite3_stmt): Integer; cdecl;
  external bj name _PU + 'sqlite3_reset';

type
  sqlite3_create_function_xFunc = procedure(p1: Psqlite3_context; p2: Integer; p3: PPsqlite3_value); cdecl;

type
  sqlite3_create_function_xStep = procedure(p1: Psqlite3_context; p2: Integer; p3: PPsqlite3_value); cdecl;

type
  sqlite3_create_function_xFinal = procedure(p1: Psqlite3_context); cdecl;

function sqlite3_create_function(db: Psqlite3; const zFunctionName: PUTF8Char; nArg: Integer; eTextRep: Integer; pApp: Pointer; xFunc: sqlite3_create_function_xFunc; xStep: sqlite3_create_function_xStep; xFinal: sqlite3_create_function_xFinal): Integer; cdecl;
  external bj name _PU + 'sqlite3_create_function';

type
  sqlite3_create_function16_xFunc = procedure(p1: Psqlite3_context; p2: Integer; p3: PPsqlite3_value); cdecl;

type
  sqlite3_create_function16_xStep = procedure(p1: Psqlite3_context; p2: Integer; p3: PPsqlite3_value); cdecl;

type
  sqlite3_create_function16_xFinal = procedure(p1: Psqlite3_context); cdecl;

function sqlite3_create_function16(db: Psqlite3; const zFunctionName: Pointer; nArg: Integer; eTextRep: Integer; pApp: Pointer; xFunc: sqlite3_create_function16_xFunc; xStep: sqlite3_create_function16_xStep; xFinal: sqlite3_create_function16_xFinal): Integer; cdecl;
  external bj name _PU + 'sqlite3_create_function16';

type
  sqlite3_create_function_v2_xFunc = procedure(p1: Psqlite3_context; p2: Integer; p3: PPsqlite3_value); cdecl;

type
  sqlite3_create_function_v2_xStep = procedure(p1: Psqlite3_context; p2: Integer; p3: PPsqlite3_value); cdecl;

type
  sqlite3_create_function_v2_xFinal = procedure(p1: Psqlite3_context); cdecl;

type
  sqlite3_create_function_v2_xDestroy = procedure(p1: Pointer); cdecl;

function sqlite3_create_function_v2(db: Psqlite3; const zFunctionName: PUTF8Char; nArg: Integer; eTextRep: Integer; pApp: Pointer; xFunc: sqlite3_create_function_v2_xFunc; xStep: sqlite3_create_function_v2_xStep; xFinal: sqlite3_create_function_v2_xFinal; xDestroy: sqlite3_create_function_v2_xDestroy): Integer; cdecl;
  external bj name _PU + 'sqlite3_create_function_v2';

type
  sqlite3_create_window_function_xStep = procedure(p1: Psqlite3_context; p2: Integer; p3: PPsqlite3_value); cdecl;

type
  sqlite3_create_window_function_xFinal = procedure(p1: Psqlite3_context); cdecl;

type
  sqlite3_create_window_function_xValue = procedure(p1: Psqlite3_context); cdecl;

type
  sqlite3_create_window_function_xInverse = procedure(p1: Psqlite3_context; p2: Integer; p3: PPsqlite3_value); cdecl;

type
  sqlite3_create_window_function_xDestroy = procedure(p1: Pointer); cdecl;

function sqlite3_create_window_function(db: Psqlite3; const zFunctionName: PUTF8Char; nArg: Integer; eTextRep: Integer; pApp: Pointer; xStep: sqlite3_create_window_function_xStep; xFinal: sqlite3_create_window_function_xFinal; xValue: sqlite3_create_window_function_xValue; xInverse: sqlite3_create_window_function_xInverse; xDestroy: sqlite3_create_window_function_xDestroy): Integer; cdecl;
  external bj name _PU + 'sqlite3_create_window_function';

function sqlite3_aggregate_count(pCtx: Psqlite3_context): Integer; cdecl;
  external bj name _PU + 'sqlite3_aggregate_count';

function sqlite3_expired(p1: Psqlite3_stmt): Integer; cdecl;
  external bj name _PU + 'sqlite3_expired';

function sqlite3_transfer_bindings(p1: Psqlite3_stmt; p2: Psqlite3_stmt): Integer; cdecl;
  external bj name _PU + 'sqlite3_transfer_bindings';

function sqlite3_global_recover(): Integer; cdecl;
  external bj name _PU + 'sqlite3_global_recover';

procedure sqlite3_thread_cleanup(); cdecl;
  external bj name _PU + 'sqlite3_thread_cleanup';

type
  sqlite3_memory_alarm_ = procedure(p1: Pointer; p2: sqlite3_int64; p3: Integer); cdecl;

function sqlite3_memory_alarm(p1: sqlite3_memory_alarm_; p2: Pointer; p3: sqlite3_int64): Integer; cdecl;
  external bj name _PU + 'sqlite3_memory_alarm';

function sqlite3_value_blob(pVal: Psqlite3_value): Pointer; cdecl;
  external bj name _PU + 'sqlite3_value_blob';

function sqlite3_value_double(p1: Psqlite3_value): Double; cdecl;
  external bj name _PU + 'sqlite3_value_double';

function sqlite3_value_int(p1: Psqlite3_value): Integer; cdecl;
  external bj name _PU + 'sqlite3_value_int';

function sqlite3_value_int64(p1: Psqlite3_value): sqlite3_int64; cdecl;
  external bj name _PU + 'sqlite3_value_int64';

function sqlite3_value_pointer(p1: Psqlite3_value; const p2: PUTF8Char): Pointer; cdecl;
  external bj name _PU + 'sqlite3_value_pointer';

function sqlite3_value_text(p1: Psqlite3_value): PByte; cdecl;
  external bj name _PU + 'sqlite3_value_text';

function sqlite3_value_text16(p1: Psqlite3_value): Pointer; cdecl;
  external bj name _PU + 'sqlite3_value_text16';

function sqlite3_value_text16le(p1: Psqlite3_value): Pointer; cdecl;
  external bj name _PU + 'sqlite3_value_text16le';

function sqlite3_value_text16be(p1: Psqlite3_value): Pointer; cdecl;
  external bj name _PU + 'sqlite3_value_text16be';

function sqlite3_value_bytes(p1: Psqlite3_value): Integer; cdecl;
  external bj name _PU + 'sqlite3_value_bytes';

function sqlite3_value_bytes16(p1: Psqlite3_value): Integer; cdecl;
  external bj name _PU + 'sqlite3_value_bytes16';

function sqlite3_value_type(p1: Psqlite3_value): Integer; cdecl;
  external bj name _PU + 'sqlite3_value_type';

function sqlite3_value_numeric_type(p1: Psqlite3_value): Integer; cdecl;
  external bj name _PU + 'sqlite3_value_numeric_type';

function sqlite3_value_nochange(p1: Psqlite3_value): Integer; cdecl;
  external bj name _PU + 'sqlite3_value_nochange';

function sqlite3_value_frombind(p1: Psqlite3_value): Integer; cdecl;
  external bj name _PU + 'sqlite3_value_frombind';

function sqlite3_value_encoding(p1: Psqlite3_value): Integer; cdecl;
  external bj name _PU + 'sqlite3_value_encoding';

function sqlite3_value_subtype(p1: Psqlite3_value): Cardinal; cdecl;
  external bj name _PU + 'sqlite3_value_subtype';

function sqlite3_value_dup(const p1: Psqlite3_value): Psqlite3_value; cdecl;
  external bj name _PU + 'sqlite3_value_dup';

procedure sqlite3_value_free(p1: Psqlite3_value); cdecl;
  external bj name _PU + 'sqlite3_value_free';

function sqlite3_aggregate_context(pCtx: Psqlite3_context; nBytes: Integer): Pointer; cdecl;
  external bj name _PU + 'sqlite3_aggregate_context';

function sqlite3_user_data(p1: Psqlite3_context): Pointer; cdecl;
  external bj name _PU + 'sqlite3_user_data';

function sqlite3_context_db_handle(p1: Psqlite3_context): Psqlite3; cdecl;
  external bj name _PU + 'sqlite3_context_db_handle';

function sqlite3_get_auxdata(p1: Psqlite3_context; N: Integer): Pointer; cdecl;
  external bj name _PU + 'sqlite3_get_auxdata';

type
  sqlite3_set_auxdata_ = procedure(p1: Pointer); cdecl;

procedure sqlite3_set_auxdata(p1: Psqlite3_context; N: Integer; p3: Pointer; p4: sqlite3_set_auxdata_); cdecl;
  external bj name _PU + 'sqlite3_set_auxdata';

type
  sqlite3_result_blob_ = procedure(p1: Pointer); cdecl;

procedure sqlite3_result_blob(p1: Psqlite3_context; const p2: Pointer; p3: Integer; p4: sqlite3_result_blob_); cdecl;
  external bj name _PU + 'sqlite3_result_blob';

type
  sqlite3_result_blob64_ = procedure(p1: Pointer); cdecl;

procedure sqlite3_result_blob64(p1: Psqlite3_context; const p2: Pointer; p3: sqlite3_uint64; p4: sqlite3_result_blob64_); cdecl;
  external bj name _PU + 'sqlite3_result_blob64';

procedure sqlite3_result_double(pCtx: Psqlite3_context; Data: Double); cdecl;
  external bj name _PU + 'sqlite3_result_double';

procedure sqlite3_result_error(pCtx: Psqlite3_context; const zData: PUTF8Char; nData: Integer); cdecl;
  external bj name _PU + 'sqlite3_result_error';

procedure sqlite3_result_error16(p1: Psqlite3_context; const p2: Pointer; p3: Integer); cdecl;
  external bj name _PU + 'sqlite3_result_error16';

procedure sqlite3_result_error_toobig(p1: Psqlite3_context); cdecl;
  external bj name _PU + 'sqlite3_result_error_toobig';

procedure sqlite3_result_error_nomem(p1: Psqlite3_context); cdecl;
  external bj name _PU + 'sqlite3_result_error_nomem';

procedure sqlite3_result_error_code(p1: Psqlite3_context; p2: Integer); cdecl;
  external bj name _PU + 'sqlite3_result_error_code';

procedure sqlite3_result_int(pCtx: Psqlite3_context; Data: Integer); cdecl;
  external bj name _PU + 'sqlite3_result_int';

procedure sqlite3_result_int64(pCtx: Psqlite3_context; Data: sqlite3_int64); cdecl;
  external bj name _PU + 'sqlite3_result_int64';

procedure sqlite3_result_null(p1: Psqlite3_context); cdecl;
  external bj name _PU + 'sqlite3_result_null';

type
  sqlite3_result_text_ = procedure(p1: Pointer); cdecl;

procedure sqlite3_result_text(p1: Psqlite3_context; const p2: PUTF8Char; p3: Integer; p4: sqlite3_result_text_); cdecl;
  external bj name _PU + 'sqlite3_result_text';

type
  sqlite3_result_text64_ = procedure(p1: Pointer); cdecl;

procedure sqlite3_result_text64(p1: Psqlite3_context; const p2: PUTF8Char; p3: sqlite3_uint64; p4: sqlite3_result_text64_; encoding: Byte); cdecl;
  external bj name _PU + 'sqlite3_result_text64';

type
  sqlite3_result_text16_ = procedure(p1: Pointer); cdecl;

procedure sqlite3_result_text16(p1: Psqlite3_context; const p2: Pointer; p3: Integer; p4: sqlite3_result_text16_); cdecl;
  external bj name _PU + 'sqlite3_result_text16';

type
  sqlite3_result_text16le_ = procedure(p1: Pointer); cdecl;

procedure sqlite3_result_text16le(p1: Psqlite3_context; const p2: Pointer; p3: Integer; p4: sqlite3_result_text16le_); cdecl;
  external bj name _PU + 'sqlite3_result_text16le';

type
  sqlite3_result_text16be_ = procedure(p1: Pointer); cdecl;

procedure sqlite3_result_text16be(p1: Psqlite3_context; const p2: Pointer; p3: Integer; p4: sqlite3_result_text16be_); cdecl;
  external bj name _PU + 'sqlite3_result_text16be';

procedure sqlite3_result_value(p1: Psqlite3_context; p2: Psqlite3_value); cdecl;
  external bj name _PU + 'sqlite3_result_value';

type
  sqlite3_result_pointer_ = procedure(p1: Pointer); cdecl;

procedure sqlite3_result_pointer(p1: Psqlite3_context; p2: Pointer; const p3: PUTF8Char; p4: sqlite3_result_pointer_); cdecl;
  external bj name _PU + 'sqlite3_result_pointer';

procedure sqlite3_result_zeroblob(p1: Psqlite3_context; n: Integer); cdecl;
  external bj name _PU + 'sqlite3_result_zeroblob';

function sqlite3_result_zeroblob64(p1: Psqlite3_context; n: sqlite3_uint64): Integer; cdecl;
  external bj name _PU + 'sqlite3_result_zeroblob64';

procedure sqlite3_result_subtype(p1: Psqlite3_context; p2: Cardinal); cdecl;
  external bj name _PU + 'sqlite3_result_subtype';

type
  sqlite3_create_collation_xCompare = function(p1: Pointer; p2: Integer; const p3: Pointer; p4: Integer; const p5: Pointer): Integer; cdecl;

function sqlite3_create_collation(p1: Psqlite3; const zName: PUTF8Char; eTextRep: Integer; pArg: Pointer; xCompare: sqlite3_create_collation_xCompare): Integer; cdecl;
  external bj name _PU + 'sqlite3_create_collation';

type
  sqlite3_create_collation_v2_xCompare = function(p1: Pointer; p2: Integer; const p3: Pointer; p4: Integer; const p5: Pointer): Integer; cdecl;

type
  sqlite3_create_collation_v2_xDestroy = procedure(p1: Pointer); cdecl;

function sqlite3_create_collation_v2(p1: Psqlite3; const zName: PUTF8Char; eTextRep: Integer; pArg: Pointer; xCompare: sqlite3_create_collation_v2_xCompare; xDestroy: sqlite3_create_collation_v2_xDestroy): Integer; cdecl;
  external bj name _PU + 'sqlite3_create_collation_v2';

type
  sqlite3_create_collation16_xCompare = function(p1: Pointer; p2: Integer; const p3: Pointer; p4: Integer; const p5: Pointer): Integer; cdecl;

function sqlite3_create_collation16(p1: Psqlite3; const zName: Pointer; eTextRep: Integer; pArg: Pointer; xCompare: sqlite3_create_collation16_xCompare): Integer; cdecl;
  external bj name _PU + 'sqlite3_create_collation16';

type
  sqlite3_collation_needed_ = procedure(p1: Pointer; p2: Psqlite3; eTextRep: Integer; const p4: PUTF8Char); cdecl;

function sqlite3_collation_needed(p1: Psqlite3; p2: Pointer; p3: sqlite3_collation_needed_): Integer; cdecl;
  external bj name _PU + 'sqlite3_collation_needed';

type
  sqlite3_collation_needed16_ = procedure(p1: Pointer; p2: Psqlite3; eTextRep: Integer; const p4: Pointer); cdecl;

function sqlite3_collation_needed16(p1: Psqlite3; p2: Pointer; p3: sqlite3_collation_needed16_): Integer; cdecl;
  external bj name _PU + 'sqlite3_collation_needed16';

function sqlite3_sleep(p1: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_sleep';

function sqlite3_win32_set_directory(atype: Cardinal; zValue: Pointer): Integer; cdecl;
  external bj name _PU + 'sqlite3_win32_set_directory';

function sqlite3_win32_set_directory8(atype: Cardinal; const zValue: PUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_win32_set_directory8';

function sqlite3_win32_set_directory16(atype: Cardinal; const zValue: Pointer): Integer; cdecl;
  external bj name _PU + 'sqlite3_win32_set_directory16';

function sqlite3_get_autocommit(p1: Psqlite3): Integer; cdecl;
  external bj name _PU + 'sqlite3_get_autocommit';

function sqlite3_db_handle(p1: Psqlite3_stmt): Psqlite3; cdecl;
  external bj name _PU + 'sqlite3_db_handle';

function sqlite3_db_name(db: Psqlite3; N: Integer): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_db_name';

function sqlite3_db_filename(db: Psqlite3; const zDbName: PUTF8Char): sqlite3_filename; cdecl;
  external bj name _PU + 'sqlite3_db_filename';

function sqlite3_db_readonly(db: Psqlite3; const zDbName: PUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_db_readonly';

function sqlite3_txn_state(p1: Psqlite3; const zSchema: PUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_txn_state';

function sqlite3_next_stmt(pDb: Psqlite3; pStmt: Psqlite3_stmt): Psqlite3_stmt; cdecl;
  external bj name _PU + 'sqlite3_next_stmt';

type
  sqlite3_commit_hook_ = function(p1: Pointer): Integer; cdecl;

function sqlite3_commit_hook(p1: Psqlite3; p2: sqlite3_commit_hook_; p3: Pointer): Pointer; cdecl;
  external bj name _PU + 'sqlite3_commit_hook';

type
  sqlite3_rollback_hook_ = procedure(p1: Pointer); cdecl;

function sqlite3_rollback_hook(p1: Psqlite3; p2: sqlite3_rollback_hook_; p3: Pointer): Pointer; cdecl;
  external bj name _PU + 'sqlite3_rollback_hook';

type
  sqlite3_autovacuum_pages_ = function(p1: Pointer; const p2: PUTF8Char; p3: Cardinal; p4: Cardinal; p5: Cardinal): Cardinal; cdecl;

//type
//  sqlite3_autovacuum_pages_ = procedure(p1: Pointer); cdecl;

function sqlite3_autovacuum_pages(db: Psqlite3; p2: sqlite3_autovacuum_pages_; p3: Pointer; p4: sqlite3_autovacuum_pages_): Integer; cdecl;
  external bj name _PU + 'sqlite3_autovacuum_pages';

type
  sqlite3_update_hook_ = procedure(p1: Pointer; p2: Integer; const p3: PUTF8Char; const p4: PUTF8Char; p5: sqlite3_int64); cdecl;

function sqlite3_update_hook(p1: Psqlite3; p2: sqlite3_update_hook_; p3: Pointer): Pointer; cdecl;
  external bj name _PU + 'sqlite3_update_hook';

function sqlite3_enable_shared_cache(p1: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_enable_shared_cache';

function sqlite3_release_memory(p1: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_release_memory';

function sqlite3_db_release_memory(p1: Psqlite3): Integer; cdecl;
  external bj name _PU + 'sqlite3_db_release_memory';

function sqlite3_soft_heap_limit64(N: sqlite3_int64): sqlite3_int64; cdecl;
  external bj name _PU + 'sqlite3_soft_heap_limit64';

function sqlite3_hard_heap_limit64(N: sqlite3_int64): sqlite3_int64; cdecl;
  external bj name _PU + 'sqlite3_hard_heap_limit64';

procedure sqlite3_soft_heap_limit(N: Integer); cdecl;
  external bj name _PU + 'sqlite3_soft_heap_limit';

function sqlite3_table_column_metadata(db: Psqlite3; const zDbName: PUTF8Char; const zTableName: PUTF8Char; const zColumnName: PUTF8Char; pzDataType: PPUTF8Char; pzCollSeq: PPUTF8Char; pNotNull: PInteger; pPrimaryKey: PInteger; pAutoinc: PInteger): Integer; cdecl;
  external bj name _PU + 'sqlite3_table_column_metadata';

function sqlite3_load_extension(db: Psqlite3; const zFile: PUTF8Char; const zProc: PUTF8Char; pzErrMsg: PPUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_load_extension';

function sqlite3_enable_load_extension(db: Psqlite3; onoff: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_enable_load_extension';

type
  sqlite3_auto_extension_xEntryPoint = procedure(); cdecl;

function sqlite3_auto_extension(xEntryPoint: sqlite3_auto_extension_xEntryPoint): Integer; cdecl;
  external bj name _PU + 'sqlite3_auto_extension';

type
  sqlite3_cancel_auto_extension_xEntryPoint = procedure(); cdecl;

function sqlite3_cancel_auto_extension(xEntryPoint: sqlite3_cancel_auto_extension_xEntryPoint): Integer; cdecl;
  external bj name _PU + 'sqlite3_cancel_auto_extension';

procedure sqlite3_reset_auto_extension(); cdecl;
  external bj name _PU + 'sqlite3_reset_auto_extension';

function sqlite3_create_module(db: Psqlite3; const zName: PUTF8Char; const p: Psqlite3_module; pClientData: Pointer): Integer; cdecl;
  external bj name _PU + 'sqlite3_create_module';

type
  sqlite3_create_module_v2_xDestroy = procedure(p1: Pointer); cdecl;

function sqlite3_create_module_v2(db: Psqlite3; const zName: PUTF8Char; const p: Psqlite3_module; pClientData: Pointer; xDestroy: sqlite3_create_module_v2_xDestroy): Integer; cdecl;
  external bj name _PU + 'sqlite3_create_module_v2';

function sqlite3_drop_modules(db: Psqlite3; azKeep: PPUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_drop_modules';

function sqlite3_declare_vtab(p1: Psqlite3; const zSQL: PUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_declare_vtab';

function sqlite3_overload_function(p1: Psqlite3; const zFuncName: PUTF8Char; nArg: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_overload_function';

function sqlite3_blob_open(p1: Psqlite3; const zDb: PUTF8Char; const zTable: PUTF8Char; const zColumn: PUTF8Char; iRow: sqlite3_int64; flags: Integer; ppBlob: PPsqlite3_blob): Integer; cdecl;
  external bj name _PU + 'sqlite3_blob_open';

function sqlite3_blob_reopen(p1: Psqlite3_blob; p2: sqlite3_int64): Integer; cdecl;
  external bj name _PU + 'sqlite3_blob_reopen';

function sqlite3_blob_close(p1: Psqlite3_blob): Integer; cdecl;
  external bj name _PU + 'sqlite3_blob_close';

function sqlite3_blob_bytes(p1: Psqlite3_blob): Integer; cdecl;
  external bj name _PU + 'sqlite3_blob_bytes';

function sqlite3_blob_read(p1: Psqlite3_blob; Z: Pointer; N: Integer; iOffset: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_blob_read';

function sqlite3_blob_write(p1: Psqlite3_blob; const z: Pointer; n: Integer; iOffset: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_blob_write';

function sqlite3_vfs_find(const zVfsName: PUTF8Char): Psqlite3_vfs; cdecl;
  external bj name _PU + 'sqlite3_vfs_find';

function sqlite3_vfs_register(p1: Psqlite3_vfs; makeDflt: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_vfs_register';

function sqlite3_vfs_unregister(p1: Psqlite3_vfs): Integer; cdecl;
  external bj name _PU + 'sqlite3_vfs_unregister';

function sqlite3_mutex_alloc(p1: Integer): Psqlite3_mutex; cdecl;
  external bj name _PU + 'sqlite3_mutex_alloc';

procedure sqlite3_mutex_free(p1: Psqlite3_mutex); cdecl;
  external bj name _PU + 'sqlite3_mutex_free';

procedure sqlite3_mutex_enter(p1: Psqlite3_mutex); cdecl;
  external bj name _PU + 'sqlite3_mutex_enter';

function sqlite3_mutex_try(p1: Psqlite3_mutex): Integer; cdecl;
  external bj name _PU + 'sqlite3_mutex_try';

procedure sqlite3_mutex_leave(p1: Psqlite3_mutex); cdecl;
  external bj name _PU + 'sqlite3_mutex_leave';

function sqlite3_mutex_held(p1: Psqlite3_mutex): Integer; cdecl;
  external bj name _PU + 'sqlite3_mutex_held';

function sqlite3_mutex_notheld(p1: Psqlite3_mutex): Integer; cdecl;
  external bj name _PU + 'sqlite3_mutex_notheld';

function sqlite3_db_mutex(p1: Psqlite3): Psqlite3_mutex; cdecl;
  external bj name _PU + 'sqlite3_db_mutex';

function sqlite3_file_control(p1: Psqlite3; const zDbName: PUTF8Char; op: Integer; p4: Pointer): Integer; cdecl;
  external bj name _PU + 'sqlite3_file_control';

function sqlite3_test_control(op: Integer): Integer varargs; cdecl;
  external bj name _PU + 'sqlite3_test_control';

function sqlite3_keyword_count(): Integer; cdecl;
  external bj name _PU + 'sqlite3_keyword_count';

function sqlite3_keyword_name(p1: Integer; p2: PPUTF8Char; p3: PInteger): Integer; cdecl;
  external bj name _PU + 'sqlite3_keyword_name';

function sqlite3_keyword_check(const p1: PUTF8Char; p2: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_keyword_check';

function sqlite3_str_new(p1: Psqlite3): Psqlite3_str; cdecl;
  external bj name _PU + 'sqlite3_str_new';

function sqlite3_str_finish(p1: Psqlite3_str): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_str_finish';

procedure sqlite3_str_appendf(p1: Psqlite3_str; const zFormat: PUTF8Char) varargs; cdecl;
  external bj name _PU + 'sqlite3_str_appendf';

procedure sqlite3_str_vappendf(p1: Psqlite3_str; const zFormat: PUTF8Char; p3: Pointer); cdecl;
  external bj name _PU + 'sqlite3_str_vappendf';

procedure sqlite3_str_append(p1: Psqlite3_str; const zIn: PUTF8Char; N: Integer); cdecl;
  external bj name _PU + 'sqlite3_str_append';

procedure sqlite3_str_appendall(p1: Psqlite3_str; const zIn: PUTF8Char); cdecl;
  external bj name _PU + 'sqlite3_str_appendall';

procedure sqlite3_str_appendchar(p1: Psqlite3_str; N: Integer; C: UTF8Char); cdecl;
  external bj name _PU + 'sqlite3_str_appendchar';

procedure sqlite3_str_reset(p1: Psqlite3_str); cdecl;
  external bj name _PU + 'sqlite3_str_reset';

function sqlite3_str_errcode(p1: Psqlite3_str): Integer; cdecl;
  external bj name _PU + 'sqlite3_str_errcode';

function sqlite3_str_length(p1: Psqlite3_str): Integer; cdecl;
  external bj name _PU + 'sqlite3_str_length';

function sqlite3_str_value(p1: Psqlite3_str): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_str_value';

function sqlite3_status(op: Integer; pCurrent: PInteger; pHighwater: PInteger; resetFlag: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_status';

function sqlite3_status64(op: Integer; pCurrent: Psqlite3_int64; pHighwater: Psqlite3_int64; resetFlag: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_status64';

function sqlite3_db_status(p1: Psqlite3; op: Integer; pCur: PInteger; pHiwtr: PInteger; resetFlg: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_db_status';

function sqlite3_stmt_status(p1: Psqlite3_stmt; op: Integer; resetFlg: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_stmt_status';

function sqlite3_backup_init(pDest: Psqlite3; const zDestName: PUTF8Char; pSource: Psqlite3; const zSourceName: PUTF8Char): Psqlite3_backup; cdecl;
  external bj name _PU + 'sqlite3_backup_init';

function sqlite3_backup_step(p: Psqlite3_backup; nPage: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_backup_step';

function sqlite3_backup_finish(p: Psqlite3_backup): Integer; cdecl;
  external bj name _PU + 'sqlite3_backup_finish';

function sqlite3_backup_remaining(p: Psqlite3_backup): Integer; cdecl;
  external bj name _PU + 'sqlite3_backup_remaining';

function sqlite3_backup_pagecount(p: Psqlite3_backup): Integer; cdecl;
  external bj name _PU + 'sqlite3_backup_pagecount';

type
  sqlite3_unlock_notify_xNotify = procedure(apArg: PPointer; nArg: Integer); cdecl;

function sqlite3_unlock_notify(pBlocked: Psqlite3; xNotify: sqlite3_unlock_notify_xNotify; pNotifyArg: Pointer): Integer; cdecl;
  external bj name _PU + 'sqlite3_unlock_notify';

function sqlite3_stricmp(const p1: PUTF8Char; const p2: PUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_stricmp';

function sqlite3_strnicmp(const p1: PUTF8Char; const p2: PUTF8Char; p3: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_strnicmp';

function sqlite3_strglob(const zGlob: PUTF8Char; const zStr: PUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_strglob';

function sqlite3_strlike(const zGlob: PUTF8Char; const zStr: PUTF8Char; cEsc: Cardinal): Integer; cdecl;
  external bj name _PU + 'sqlite3_strlike';

procedure sqlite3_log(iErrCode: Integer; const zFormat: PUTF8Char) varargs; cdecl;
  external bj name _PU + 'sqlite3_log';

type
  sqlite3_wal_hook_ = function(p1: Pointer; p2: Psqlite3; const p3: PUTF8Char; p4: Integer): Integer; cdecl;

function sqlite3_wal_hook(p1: Psqlite3; p2: sqlite3_wal_hook_; p3: Pointer): Pointer; cdecl;
  external bj name _PU + 'sqlite3_wal_hook';

function sqlite3_wal_autocheckpoint(db: Psqlite3; N: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_wal_autocheckpoint';

function sqlite3_wal_checkpoint(db: Psqlite3; const zDb: PUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_wal_checkpoint';

function sqlite3_wal_checkpoint_v2(db: Psqlite3; const zDb: PUTF8Char; eMode: Integer; pnLog: PInteger; pnCkpt: PInteger): Integer; cdecl;
  external bj name _PU + 'sqlite3_wal_checkpoint_v2';

function sqlite3_vtab_config(p1: Psqlite3; op: Integer): Integer varargs; cdecl;
  external bj name _PU + 'sqlite3_vtab_config';

function sqlite3_vtab_on_conflict(p1: Psqlite3): Integer; cdecl;
  external bj name _PU + 'sqlite3_vtab_on_conflict';

function sqlite3_vtab_nochange(p1: Psqlite3_context): Integer; cdecl;
  external bj name _PU + 'sqlite3_vtab_nochange';

function sqlite3_vtab_collation(p1: Psqlite3_index_info; p2: Integer): PUTF8Char; cdecl;
  external bj name _PU + 'sqlite3_vtab_collation';

function sqlite3_vtab_distinct(p1: Psqlite3_index_info): Integer; cdecl;
  external bj name _PU + 'sqlite3_vtab_distinct';

function sqlite3_vtab_in(p1: Psqlite3_index_info; iCons: Integer; bHandle: Integer): Integer; cdecl;
  external bj name _PU + 'sqlite3_vtab_in';

function sqlite3_vtab_in_first(pVal: Psqlite3_value; ppOut: PPsqlite3_value): Integer; cdecl;
  external bj name _PU + 'sqlite3_vtab_in_first';

function sqlite3_vtab_in_next(pVal: Psqlite3_value; ppOut: PPsqlite3_value): Integer; cdecl;
  external bj name _PU + 'sqlite3_vtab_in_next';

function sqlite3_vtab_rhs_value(p1: Psqlite3_index_info; p2: Integer; ppVal: PPsqlite3_value): Integer; cdecl;
  external bj name _PU + 'sqlite3_vtab_rhs_value';

function sqlite3_stmt_scanstatus(pStmt: Psqlite3_stmt; idx: Integer; iScanStatusOp: Integer; pOut: Pointer): Integer; cdecl;
  external bj name _PU + 'sqlite3_stmt_scanstatus';

function sqlite3_stmt_scanstatus_v2(pStmt: Psqlite3_stmt; idx: Integer; iScanStatusOp: Integer; flags: Integer; pOut: Pointer): Integer; cdecl;
  external bj name _PU + 'sqlite3_stmt_scanstatus_v2';

procedure sqlite3_stmt_scanstatus_reset(p1: Psqlite3_stmt); cdecl;
  external bj name _PU + 'sqlite3_stmt_scanstatus_reset';

function sqlite3_db_cacheflush(p1: Psqlite3): Integer; cdecl;
  external bj name _PU + 'sqlite3_db_cacheflush';

function sqlite3_system_errno(p1: Psqlite3): Integer; cdecl;
  external bj name _PU + 'sqlite3_system_errno';

function sqlite3_snapshot_get(db: Psqlite3; const zSchema: PUTF8Char; ppSnapshot: PPsqlite3_snapshot): Integer; cdecl;
  external bj name _PU + 'sqlite3_snapshot_get';

function sqlite3_snapshot_open(db: Psqlite3; const zSchema: PUTF8Char; pSnapshot: Psqlite3_snapshot): Integer; cdecl;
  external bj name _PU + 'sqlite3_snapshot_open';

procedure sqlite3_snapshot_free(p1: Psqlite3_snapshot); cdecl;
  external bj name _PU + 'sqlite3_snapshot_free';

function sqlite3_snapshot_cmp(p1: Psqlite3_snapshot; p2: Psqlite3_snapshot): Integer; cdecl;
  external bj name _PU + 'sqlite3_snapshot_cmp';

function sqlite3_snapshot_recover(db: Psqlite3; const zDb: PUTF8Char): Integer; cdecl;
  external bj name _PU + 'sqlite3_snapshot_recover';

function sqlite3_serialize(db: Psqlite3; const zSchema: PUTF8Char; piSize: Psqlite3_int64; mFlags: Cardinal): PByte; cdecl;
  external bj name _PU + 'sqlite3_serialize';

function sqlite3_deserialize(db: Psqlite3; const zSchema: PUTF8Char; pData: PByte; szDb: sqlite3_int64; szBuf: sqlite3_int64; mFlags: Cardinal): Integer; cdecl;
  external bj name _PU + 'sqlite3_deserialize';

type
  sqlite3_rtree_geometry_callback_xGeom = function(p1: Psqlite3_rtree_geometry; p2: Integer; p3: Psqlite3_rtree_dbl; p4: PInteger): Integer; cdecl;

function sqlite3_rtree_geometry_callback(db: Psqlite3; const zGeom: PUTF8Char; xGeom: sqlite3_rtree_geometry_callback_xGeom; pContext: Pointer): Integer; cdecl;
  external bj name _PU + 'sqlite3_rtree_geometry_callback';

type
  sqlite3_rtree_query_callback_xQueryFunc = function(p1: Psqlite3_rtree_query_info): Integer; cdecl;

type
  sqlite3_rtree_query_callback_xDestructor = procedure(p1: Pointer); cdecl;

  function sqlite3_rtree_query_callback(db: Psqlite3; const zQueryFunc: PUTF8Char; xQueryFunc: sqlite3_rtree_query_callback_xQueryFunc; pContext: Pointer; xDestructor: sqlite3_rtree_query_callback_xDestructor): Integer; cdecl;
  external bj name _PU + 'sqlite3_rtree_query_callback';

type

ESQLite3 = class(Sysutils.Exception)
  private
	  FErrorCode: Integer;
  	FErrorMessage: UTF8String;

  public
    constructor Create(const aErrorCode: Integer; const aErrorMessage: UTF8String); overload;
  	constructor Create(const aErrorCode: integer);  overload;
	  constructor Create(const aErrorMessage: UTF8String); overload;

  property ErrorCode: Integer read FErrorCode;
	property ErrorMessage: UTF8String read FErrorMessage;
end;

(*
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall ESQLite3(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall ESQLite3(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall ESQLite3(int Ident, const System::TVarRec * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall ESQLite3(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall ESQLite3(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall ESQLite3(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall ESQLite3(System::PResStringRec ResStringRec, const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop

public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~ESQLite3(void) { }
	#pragma option pop
*)

//procedure sqlite3_Destroy_AnsiString(p: Pointer); cdecl;
procedure sqlite3_Destroy_Mem(p: Pointer); cdecl;
//procedure sqlite3_Destroy_WideString(p: Pointer); cdecl;
function sqlite3_affinity(const ADeclaration: AnsiString): TSQLite3Affinity;
function sqlite3_affinity16(const ADeclaration: WideString): TSQLite3Affinity;
{
extern PACKAGE int __fastcall sqlite3_bind_params(const sqlite3_stmt_ptr pStmt, const System::TVarRec * Params, const int Params_Size);
}
function sqlite3_bind_str(const pStmt:sqlite3_stmt_ptr; const ParamIdx: Integer; Data: AnsiString): Integer;
function sqlite3_bind_str16(const pStmt:sqlite3_stmt_ptr; const ParamIdx: Integer; Data: WideString): Integer;
function sqlite3_bind_variant(const pStmt: sqlite3_stmt_ptr; const ParamIdx: Integer; const Data: Variant): Integer;
function sqlite3_bind_VarRec(const pStmt: sqlite3_stmt_ptr; const ParamIdx: Integer; const Data:TVarRec): Integer;
procedure sqlite3_exec_fast(const DB: Psqlite3; const SQL: UTF8String);
function sqlite3_is_memory_name(const DatabaseName: WideString): boolean;
function sqlite3_column_str(const  pStmt: sqlite3_stmt_ptr; const iCol: Integer): Utf8String;
function sqlite3_column_str16(const  pStmt: sqlite3_stmt_ptr; const iCol: Integer): WideString;
function decode_utf8(const Value: UTF8String): WideString;
function encode_utf8(const Value: WideString): UTF8String;
function sqlite3_result_str(const pCtx: psqlite3_context; Data: AnsiString): AnsiString;
function sqlite3_result_str16(const pCtx: psqlite3_context; Data: WideString): WideString;

  procedure sqlite3_destroy_text(p: Pointer);  cdecl;
  procedure sqlite3_destroy_text16(p: Pointer); cdecl;

  function JulianDateToDate(const AJulianDate: Double ): TDateTime;
  function JulianDateToDateTime(const aJulianDate: Double ): TDateTime;
  function SqlBufToFloatDef16(const p: pWideChar; const l: integer; const Default: Extended; const DecimalSeparator: WideChar  = WideChar($2e)):Extended;
  function JulianDateToTime(const AJulianDate: Double): TDateTime;
  function DQuotedStr(const S: Utf8string; aQuote: Char = '"'): string;
  function DQuotedStr16(const S: WideString; aQuote:WideChar = '"'): WideString;
  function sqlite3_database_type(const DatabaseName: AnsiString): TSQLite3DatabaseType;
  function sqlite3_database_type16(const DatabaseName: WideString): TSQLite3DatabaseType;
  function Check(const AErrorCode: Integer; const aDB: sqlite3_ptr): Integer; overload;
  function Check(const AErrorCode: Integer): Integer; overload;
  Function DateTimeToJulianDate(const aDateTime: TDateTime): Double;

  function ComputeCharLength(p:PChar):Cardinal;
  function LCharOf(aUTF8Str:UTF8String; lp:Integer):TUTF8Char;
  function UnicodeToUTF8(aChar:WideChar):TUTF8Char; overload;
  function VarTypeToVType(v: TVarType): Integer;
  function VariantToVarRec(const v: Variant): TVarRec;
  Function TryJulianDateToDateTime(const AValue: Double; out ADateTime: TDateTime): Boolean;

implementation

constructor ESQLite3.Create(const aErrorCode: Integer; const aErrorMessage: UTF8String);
begin
  FErrorCode := aErrorCode;
  FErrorMessage := aErrorMessage;
end;

constructor ESQLite3.Create(const aErrorCode: Integer);
begin
  FErrorCode := aErrorCode;
end;

constructor ESQLite3.Create(const aErrorMessage: Utf8String);
begin
  FErrorMessage := aErrorMessage;
end;


function JulianDateToDate(const AJulianDate: Double ): TDateTime;
begin
  JulianDateToDateTime(AJulianDate);
end;

function SqlBufToFloatDef16(const p: pWideChar; const l: integer; const Default: Extended; const DecimalSeparator: WideChar  = WideChar($2e)): Extended;
begin
  MessageDlg('Not yet implemented', mtError, [mbOK], 0);
end;

function JulianDateToTime(const AJulianDate: Double): TDateTime;
begin
  JulianDateToTime(AJulianDate);
end;


function sqlite3_database_type(const DatabaseName: AnsiString): TSQLite3DatabaseType;
begin
  Result := dtAttached;
  if DatabaseName = ':memory:' then
    Result := dtTemp;
  if (DatabaseName = 'main') or (Length(DatabaseName) = 0) then
    Result := dtMain;
end;

function sqlite3_database_type16(const DatabaseName: WideString): TSQLite3DatabaseType;
begin
  Result := dtAttached;
  if DatabaseName = ':memory:' then
    Result := dtTemp;
  if (DatabaseName = 'main') or (Length(DatabaseName) = 0) then
    Result := dtMain;
end;

function DQuotedStr(const S: UTF8String; aQuote: Char='"'): string;
var
  i, j, count: Integer;
begin
result := '' + aQuote;
count := length(s);
i := 0;
j := 0;
while i < count do begin
   i := i + 1;
   if S[i] = aQuote then begin
      result := result + copy(S, 1 + j, i - j) + aQuote;
      j := i;
      end ;
   end ;
if i <> j then
   result := result + copy(S, 1 + j, i - j);
result := result + aQuote;
end;

function DQuotedStr16(const S: WideString; aQuote:WideChar = '"'): WideString;
var
  i, j, count: Integer;
begin
result := '' + aQuote;
count := length(s);
i := 0;
j := 0;
while i < count do begin
   i := i + 1;
   if S[i] = aQuote then begin
      result := result + copy(S, 1 + j, i - j) + aQuote;
      j := i;
      end ;
   end ;
if i <> j then
   result := result + copy(S, 1 + j, i - j);
result := result + aQuote;
end;

function sqlite3_bind_str(const pStmt:sqlite3_stmt_ptr; const ParamIdx: Integer; Data: AnsiString): Integer;
begin
  Result := sqlite3_bind_text(pStmt, ParamIdx, PUTF8Char(Data), Length(Data), sqlite3_destroy_text);
end;

function sqlite3_bind_str16(const pStmt:sqlite3_stmt_ptr; const ParamIdx: Integer; Data: WideString): Integer;
begin
  Result := sqlite3_bind_text16(pStmt, ParamIdx, PWideChar(Data), Length(PUTF8Char(Data)), sqlite3_destroy_text16)
end;

function sqlite3_bind_variant(const pStmt: sqlite3_stmt_ptr; const ParamIdx: Integer; const Data: Variant): Integer;
var
  vData: pVarRec;
begin
  vData^ := VariantToVarRec(Data);
  Result := sqlite3_Bind_blob(pStmt, ParamIdx, vData, SizeOf(TVarRec)+1, SQLITE_TRANSIENT)
end;

function sqlite3_bind_VarRec(const pStmt: sqlite3_stmt_ptr; const ParamIdx: Integer; const Data:TVarRec): Integer;
var
  vData: pVarRec;
begin
  vData^ := Data;
  Result := sqlite3_Bind_blob(pStmt, ParamIdx, vData, SizeOf(Data)+1, SQLITE_TRANSIENT)
end;

function sqlite3_column_str(const  pStmt: sqlite3_stmt_ptr; const iCol: Integer): UTF8String;
begin
  Result := sqlite3_column_text(pStmt, iCol);
end;

function sqlite3_column_str16(const  pStmt: sqlite3_stmt_ptr; const iCol: Integer): WideString;
begin
  Result := PWideChar(sqlite3_column_text16(pStmt, iCol));
end;

function Check(const AErrorCode: Integer; const aDB: sqlite3_ptr): Integer;
var
  rMsg: AnsiString;
begin
  result := aErrorCode;
   if aDB = nil then
    Result := Check(AErrorCode)
  else if (AErrorCode and $FF = SQLITE_ERROR) then // possible error codes
  begin
    rMsg := sqlite3_errmsg(aDB);
    raise ESQLite3.CreateFmt('SQLite EorrCode = %d; %s', [AErrorCode, rMsg]);
  end;
end;

function Check(const AErrorCode: Integer): Integer;
begin
  result := aErrorCode;
  if (AErrorCode and $FF = SQLITE_ERROR) then // possible error codes
    raise ESQLite3.CreateFmt('SQLite EorrCode = %d', [AErrorCode]);
end;

Function DateTimeToJulianDate(const aDateTime: TDateTime): Double;
var
  day,month,year: word;
  a,y,m: longint;
begin
  DecodeDate ( aDateTime, year, month, day );
  a := (14-month) div 12;
  y := year + 4800 - a;
  m := month + (12*a) - 3;
  result := day + ((153*m+2) div 5) + (365*y)
    + (y div 4) - (y div 100) + (y div 400) - 32045.5 + frac(aDateTime);
end;

Function JulianDateToDateTime(const aJulianDate: Double): TDateTime;
begin
  if not TryJulianDateToDateTime(aJulianDate, Result) then
    raise EConvertError.CreateFmt('InvalidJulianDate', [aJulianDate]);
end;

Function TryJulianDateToDateTime(const AValue: Double; out ADateTime: TDateTime): Boolean;
var
  a,b,c,d,e,m:longint;
  day,month,year: word;
begin
  a := trunc(AValue + 32044.5);
  b := (4*a + 3) div 146097;
  c := a - (146097*b div 4);
  d := (4*c + 3) div 1461;
  e := c - (1461*d div 4);
  m := (5*e+2) div 153;
  day := e - ((153*m + 2) div 5) + 1;
  month := m + 3 - 12 *  ( m div 10 );
  year := (100*b) + d - 4800 + ( m div 10 );
  result := TryEncodeDate ( Year, Month, Day, ADateTime );
  if Result then
    ADateTime:=ADateTime+frac(AValue-0.5);
end;

function UTF8ToUCS16(const UTF8Char:TUTF8Char):TUCS16Char;
begin
  case Length(UTF8Char) of
    1:{regular single byte character (#0 is a normal char, this is UTF8Charascal ;)}
      Result := ord(UTF8Char[1]);
    2:
    Result := ((ord(UTF8Char[1]) and $1F) shl 6)
              or (ord(UTF8Char[2]) and $1F);
  else
    Result := $FFFF;
  end;
end;

function decode_utf8(const Value:UTF8String):WideString;
var
  lp, vp:Integer;
  c:TUTF8Char;
begin
  lp := 1;
  vp := 0;
  SetLength(Result, Length(Value));
  while lp <= Length(Value) do
  begin
    vp := vp + 1;
    c := LCharOf(Value, lp);
    Result[vp] := WideChar(UTF8ToUCS16(c));
    lp := lp + Length(c);
  end;
  SetLength(Result, vp);
end;

function LCharOf(aUTF8Str:UTF8String; lp:Integer):TUTF8Char;
begin
  if lp > Length(aUTF8Str) then
  begin
    Result := '';
    Exit;
  end;
  while(lp > 0) and ((Ord(aUTF8Str[lp]) and $F0) in [$80..$B0]) do
  begin
    Dec(lp);
  end;
  if lp = 0 then
  begin
    Result := '';
    Exit;
  end;
  Move(aUTF8Str[lp], Result[1], SizeOf(TUTF8Char) - 1);
  SetLength(Result, ComputeCharLength(@Result[1]));
end;

function ComputeCharLength(p:PChar):Cardinal;
begin
  if ord(p^)< $C0
  then
{regular single byte character (#0 is a normal char, this is UTF8Charascal ;)}
    Result:=1
  else if ((ord(p^) and $E0) = $C0)
  then
    if (ord(p[1]) and $C0) = $80 then
      Result:=2
    else
      Result:=1
  else if ((ord(p^) and $F0) = $E0)
  then
    if ((ord(p[1]) and $C0) = $80)
      and ((ord(p[2]) and $C0) = $80)
    then
      Result:=3
    else
        Result:=1
  else if ((ord(p^) and $F8) = $F0)
  then
    if ((ord(p[1]) and $C0) = $80)
    and ((ord(p[2]) and $c0) = $80)
    and ((ord(p[3]) and $C0) = $80)
    then
      Result:=4
    else
      Result:=1
  else
    Result:=1
end;

function UnicodeToUTF8(aChar:WideChar):TUTF8Char;
var
  c:TUCS16Char absolute aChar;
begin
  case c of
    0..$7f:
      begin
        Result[1]:=char(c);
        SetLength(Result,1);
      end;
    $80..$7ff:
      begin
        Result[1]:=char($c0 or (c shr 6));
        Result[2]:=char($80 or (c and $3f));
        SetLength(Result,2);
      end;
  else
    SetLength(Result, 0);
  end;
end;

function encode_utf8(const Value: WideString): UTF8String;
var
  i:Integer;
begin
  Result := '';
  for i := 1 to Length(Value) do
  begin
    Result := Result + UnicodeToUTF8(Value[i])
  end;
end;

function VarTypeToVType(v: TVarType): Integer;
begin
  Result := vtVariant;
  v := v and VarTypeMask;

  case v of
    varSingle,
    varDouble:   Result := vtExtended;
    varCurrency: Result := vtCurrency;
    varOleStr:   Result := vtWideString;
    varDispatch: Result := vtInterface;
    varBoolean:  Result := vtBoolean;
    varVariant:  Result := vtVariant;
    varSmallint,
    varShortInt,
    varByte,
    varWord,
    varLongWord,
    varInteger:  Result := vtInteger;
    varInt64:    Result := vtInt64;
    varString:   Result := vtString;
    {$IFDEF FPC}
    varDecimal:  Result := vtInteger;
    varQWord:    Result := vtQWord;
    {$ENDIF}
  end;
end;

function VariantToVarRec(const v: Variant): TVarRec;
begin
  Result.VType := VarTypeToVType(v.VarType);
  case Result.VType of
    vtInteger:    Result.VInteger := v;
    vtBoolean:    Result.VBoolean := v;
    vtAnsiString: Result.VAnsiString := TVarData(v).VString;
    vtCurrency:   Result.VCurrency := @TVarData(v).VCurrency;
    vtVariant:    Result.VVariant := @v;
    vtInterface:  Result.VInterface := TVarData(v).VDispatch;
    vtWideString: Result.VWideString := TVarData(v).VOleStr;
    vtInt64:      Result.VInt64 := @TVarData(v).VInt64;
    {$IFDEF FPC}
    vtChar:       Result.VChar := v;
    vtWideChar:   Result.VWideChar := v;
    vtQWord:      Result.VQWord := @TVarData(v).VQWord;
    {$ENDIF}
  end;
end;

function sqlite3_affinity(const ADeclaration: AnsiString): TSQLite3Affinity;
var
  rUCDecl: AnsiString;
begin
  Result := afNumeric;
  rUCDecl := UpperCase(ADeclaration);
  if Pos('INT', rUCDecl) > 0 then
  begin
    Result := afInteger;
    Exit;
  end;
  if (Pos('CHAR', rUCDecl) > 0) or
    (Pos('CLOB', rUCDecl) > 0) or
    (Pos('TEXT', rUCDecl) > 0) then
  begin
    Result := afText;
    Exit;
  end;
  if Pos('BLOB', rUCDecl) > 0 then
  begin
    Result := afBlob;
    Exit;
  end;
  if (Pos('REAL', rUCDecl) > 0) or
    (Pos('FLOA', rUCDecl) > 0) or
    (Pos('DOUB', rUCDecl) > 0) then
  begin
    Result := afText;
    Exit;
  end;
  if (rUCDecl = 'NUMERIC') or
    (rUCDecl = 'DECIMAL') or
    (rUCDecl = 'BOOLEAN') or
    (rUCDecl = 'DATE') or
    (rUCDecl = 'DATETIME') then
  begin
    Result := afNumeric;
  end;
end;

function sqlite3_affinity16(const ADeclaration: WideString): TSQLite3Affinity;
begin
  Result := sqlite3_affinity(encode_utf8(ADeclaration));
end;

procedure sqlite3_Destroy_Mem(p: Pointer);
begin
  Dispose(p);
end;


procedure sqlite3_destroy_text(p: Pointer);
begin
  p := PAnsiChar('');
end;

procedure sqlite3_Destroy_text16(p: Pointer);
begin
  p := PWideChar(WideString(''));
end;

function sqlite3_result_str(const pCtx: psqlite3_context; Data: AnsiString): AnsiString;
begin
  sqlite3_result_text(pCtx, PUTF8Char(Data), Length(Data), sqlite3_destroy_text);
  Result := Data;
end;

function sqlite3_result_str16(const pCtx: psqlite3_context; Data: WideString): WideString;
begin
  sqlite3_result_text16(pCtx, PWideChar(Data), Length(PUTF8Char(Data)),sqlite3_destroy_text16);
  Result := Data;
end;

function sqlite3_is_memory_name(const DatabaseName: WideString): boolean;
begin
  Result := False;
  if LowerCase(encode_utf8(DatabaseName)) = ':memory:' then
    Result := True;
end;


procedure sqlite3_exec_fast(const DB: Psqlite3; const SQL: UTF8String);
var
  rPSQL: PUtf8Char;
  rMsg: PUTF8Char;
begin
  if not  Assigned(DB) then
    raise ESQLite3.Create(SQLITE_ERROR);
  rPSQL := PUTF8Char(SQL);
  sqlite3_exec(DB, rPSQL, nil, nil, @rMsg);
  if rMsg <> nil then
    raise ESQLite3.Create(rMsg);
end;

end.
