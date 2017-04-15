/*
 * linumtest.c
 *
 *  Created on: Mar 4, 2015
 *  Revised: August 25 2015
 *  Author: Sven Rönnbäck
 */
#include "linumtest.h"
#include <math.h>
#include <libpower.h>
#include <libresistance.h>
#include <libcomponent.h>
#include <glib.h>
#include <assert.h>
#include <glib.h>
#include <glib/gprintf.h>

//#ifndef calc_resistance
//#define calc_resistance calc_resistans
//#endif

#define S_CHAR 'S'
#define P_CHAR 'P'

/** @brief Tests the Power functions
 *         asserts if invalid results.
 *         Following functions are tested:
 *         	float calc_power_r(float volt, float resistance);
 *         	float calc_power_i(float volt, float current);
 *
 *
 *  @return Returns true if functions passed test, and false if one test fails.
 */
gboolean bTestPowerFunctions( void)
{
	gboolean bRet=(1>0);					// sets boolean variable to true.
	float f=0.0;

	f=calc_power_r(10.0f,1.0f);
	bRet &=(f==100.0f);

	f= calc_power_r(-10.0f,1.0f);
	bRet &=(f==100.0f);

	f = calc_power_i(10.0f,10.0f);
	bRet &=(f == 100.0f);

	f=calc_power_i(-10.0f,-5.0f);
	bRet &=(f==50.0f);

	return bRet;
}


gboolean bSumFloats( float *pf,int iLen, float fExpectedSum)
{
	gboolean bRet = (1>0);

	bRet &=(pf!=0);
	float fSum = calc_resistance(iLen,S_CHAR,pf);
	bRet &= ((fSum-fExpectedSum)<0.05f);
	bRet &=(iLen>=0 && iLen<=3);
	/*
	if(1>0){
		int i;

		g_printf("\tResistances E12: ");
		for (i=0;i<iLen;i++){
			g_printf("%.1f",pf[i]);
			g_printf((i<iLen-1)?"+":"=");
		}
		for (;i<iLen;i++){
			g_printf(" #");
			bRet &=(pf[i]==0.0);
		}
		g_printf("%.1f   Expected Sum:%.1f\n",fSum, fExpectedSum);
	}
	*/
	return bRet;
}


/** @brief Tests the Component functions
 *         asserts if invalid results.
 *         Following function is tested:
 *         int count = e_resistance(float orig_resistance, float *res_array );
 *
 *  @return Returns true if functions passed test, and false if one or more fails.
 */
gboolean bTestComponentFunction(void)
{

	float af[10];
	int iLen=0;

	gboolean bRet=1>0;						// Set boolean variable to true,  1>0
	//g_printf("Testing Component\n");

	af[0]=-1;

	iLen=e_resistance(56.0f,&af[0]);
	bRet &=bSumFloats(&af[0],iLen,56.0f);
	bRet &=(iLen==1);

	iLen=e_resistance(100.0f,&af[0]);
	bRet &=bSumFloats(&af[0],iLen,82.0f+18.0f);
	bRet &=(iLen==1);								// Checks that result is E12.

	iLen=e_resistance(1200+82+18,&af[0]);
	bRet &=bSumFloats(&af[0],iLen,1200.0f+82.0f+18.0f);
	bRet &=(iLen==2);								// Checks that result is E12.

	iLen=e_resistance(0.0f,&af[0]);
	bRet &=bSumFloats(&af[0],iLen,0.0f);
	bRet &=(iLen==0);

	return bRet;
}


/** @brief Tests Resistance functions
 *         asserts if invalid results.
 *         Following function is tested:
 *         float calc_resistance(int count, char conn, float *array);
 *
 *  @return Returns true if functions passed test, and false if one or more tests fails.
 */
gboolean bTestResistanceFunction( void)
{
	gboolean bRet=1>0;

	if(1>0){
		float af[]={10.0f,20.0f,30.0f};
		float f=calc_resistance( 3, S_CHAR, &af[0]);
		bRet &=(f==60.0f);
	}
	if(1>0){
		float af[]={30.0f,30.0f,30.0f};
		float f=calc_resistance( 3, S_CHAR, &af[0]);
		bRet &=(f==90.0f);
	}
	if(1>0){
		float af[]={30.0f,30.0f};
		float f=calc_resistance( 2, S_CHAR, &af[0]);
		bRet &=(f==60.0f);
	}
	if(1>0){
		float af[]={60.0f};
		float f=calc_resistance( 1, S_CHAR, &af[0]);
		bRet &=(f==60.0f);
	}
	if(1>0){
		float af[]={60.0f};
		float f=calc_resistance(1, P_CHAR, &af[0]);
		bRet &=(fabs(f-60.0f)<0.05f);
	}
	if(1>0){
		float af[]={30.0f,30.0f,30.0f};
		float f=calc_resistance(3,P_CHAR,&af[0]);
		bRet &=(fabs(f-10.0f)<0.05f);
	}
	if(1>0){
		float af[]={30.0f,30.0f};
		float f=calc_resistance( 2, P_CHAR, &af[0]);
		bRet &=(fabs(f-15.0f)<0.05f);
	}
	return bRet;
}


/** @brief Tests the library functions
 *
  *  @param  bShowText  Boolean variable set to true to enable log text to be printed.
 *
 *  @return Returns true if functions passed test, and false if one or more tests fails.
 *
 *
 */
gboolean bTestElectricFunctions(gboolean bShowText)
{
	gboolean bRet = 1>0;

	if(bShowText)
		g_printf("Testing component function..\n");
	bRet &=bTestComponentFunction();
	if(bShowText && bRet)
		g_printf("Component function passed tests.\n\n");

	if(bShowText)
		g_printf("Testing resistance function...\n");
	bRet &=bTestResistanceFunction();
	if(bShowText && bRet)
		g_printf("Resistance function passed tests.\n\n");

	if(bShowText)
		g_printf("Testing power functions...\n");
	bRet &=bTestPowerFunctions();
	if(bShowText && bRet)
		g_printf("Power functions passed tests.\n\n");
	if(bShowText)
		g_printf("All functions tested.\n\n");

	if(!bRet)
		g_printf("One or more of the tests failed.");
	return bRet;
}

