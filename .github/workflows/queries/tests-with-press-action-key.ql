/**
 * @description Finds tests with pressActionKey call
 * @kind problem
 * @id javascript/tests-with-press-action-key
 * @problem.severity recommendation
 */
import javascript

/**
 * Holds if a function is a test.
 */
predicate isTest(Function test) {
  exists(CallExpr describe, CallExpr it |
    describe.getCalleeName() = "describe" and
    it.getCalleeName() = "it" and
    it.getParent*() = describe and
    test = it.getArgument(1)
  )
}

/**
* Holds if `caller` contains a call to `callee`.
*/
predicate calls(Function caller, Function callee) {
  exists(DataFlow::CallNode call |
    call.getEnclosingFunction() = caller and
    call.getACallee() = callee
  )
}

/**
* Holds if function name is pressActionKey
*/
predicate isPressActionKey(Function f) {
  f.getName() = "pressActionKey"
}

from Function test, Function callee
where isTest(test) and
      calls(test,callee) and
      isPressActionKey(callee)
select test, "has pressActionKey call"