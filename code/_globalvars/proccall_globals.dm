// All these vars are related to proc call protection
// If you add more of these, for the love of fuck, protect them

/// Who is currently calling procs
GLOBAL_VAR(AdminProcCaller)
GLOBAL_PROTECT(AdminProcCaller)
/// How many procs have been called
GLOBAL_VAR_INIT(AdminProcCallCount, 0)
GLOBAL_PROTECT(AdminProcCallCount)
/// UID of the admin who last called
GLOBAL_VAR(LastAdminCalledTargetUID)
GLOBAL_PROTECT(LastAdminCalledTargetUID)
/// Last target to have a proc called on it
GLOBAL_VAR(LastAdminCalledTarget)
GLOBAL_PROTECT(LastAdminCalledTarget)
/// Last proc called
GLOBAL_VAR(LastAdminCalledProc)
GLOBAL_PROTECT(LastAdminCalledProc)
/// List to handle proc call spam prevention
GLOBAL_LIST_EMPTY(AdminProcCallSpamPrevention)
GLOBAL_PROTECT(AdminProcCallSpamPrevention)
