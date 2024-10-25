/**
 * @description Finds tests with pressActionKey call
 * @kind problem
 * @id javascript/functions-transitively-called-by-tests
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
* Holds if the given function is exported from a module.
*/
predicate isPressActionKeyPressed(Function f) {
  exists(Module m | m.getAnExportedValue(_).getAFunctionValue().getFunction() = f) and
  f.getName() = "pressActionKey"
}

from Function test
where isTest(test) and
      isPressActionKeyPressed(test)
select test, "has pressActionKey call"