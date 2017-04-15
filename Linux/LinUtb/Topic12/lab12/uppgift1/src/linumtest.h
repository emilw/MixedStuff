/*
 * linumtest.h
 *
 *  Created on: Mar 4, 2015
 *  Revised: August 25 2015
 *      Author: Sven Rönnbäck
 */

#ifndef LINUMTEST_H_
#define LINUMTEST_H_
#include <gtk/gtk.h>
#include <glib.h>

/** @brief Tests the library functions implemented in Tema 6
 *
 *  @param  bShowText  Boolean variable set to true to enable log text to be printed.
 *  @return Returns true if all library functions passed test.
 */
gboolean bTestElectricFunctions( gboolean bShowText);

/** @brief Tests the Power functions
 *
 *  @return Returns true if functions passed test, and false if one or more tests fails.
 */
gboolean bTestPowerFunctions(void);

/** @brief Tests the component functions
 *
 *  @return Returns true if functions passed test, and false if one or more tests fails.
 */
gboolean bTestComponentFunction(void);


/** @brief Tests all library functions
 *
 *  @return Returns true if functions passed test, and false if one or more tests fails.
 */
gboolean bTestResistanceFunction(void);



#endif /* LINUMTEST_H_ */
