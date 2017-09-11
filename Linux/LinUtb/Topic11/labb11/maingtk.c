/**
* @file maingtk.c
*/

#include <stdlib.h>
#include <stdio.h>
#include <gtk/gtk.h>
#include <string.h>
#include "headers/libresistance.h"
#include "headers/libpower.h"
#include "headers/libcomponent.h"
#include "electrolibui.h"

static GtkGrid* _mainGrid;
static char* _voltage = "0";
static char _connectionType = 'S';
static char* _numberOfComponents = "1";
static char** _resistanceValueList = NULL;

/**
* @brief Initializes the resistance array and wires it up with the UI components
*
* Initializes the resistance array and wires it up with the UI components. This function also handles the change when different number of components are selected.
* @param currentNumberOfComponents The number of components selected
* @param oldNumberOfComponents The number of components selected before
* @param resistanceList The array with the resistance value pointers. The function handles all memory allocation and releasing of memory.
* @param mainGrid The grid where this should be added
* @param entryChangedFuncPtr The function to handle the event when a resistance value is changed
* @return void
**/
static void initResistanceListSection(int currentNumberOfComponents, int oldNumberOfComponents, char*** resistanceList, GtkGrid* mainGrid, void (*entryChangedFuncPtr) (GtkEditable *editable, gpointer)) {
    printDebugText("MainGrid address %p", mainGrid);
    
    printDebugText("Init resistance list section");
    int i = 0;
    printDebugText("Old number of components was %d, new one is %d", oldNumberOfComponents, currentNumberOfComponents);
    while(i < oldNumberOfComponents){
        printDebugText("Free all items");
        if((*resistanceList)[i] != NULL) {
            printDebugText("Is not null");
            (*resistanceList)[i] = NULL;
        }
        i = i + 1;
    }
    if(*resistanceList != NULL) {
        printDebugText("Resistance list is not NULL");
        free(*resistanceList);
        *resistanceList = NULL;
    }

    printDebugText("Malloc to be done");
    *resistanceList = malloc(sizeof(char*)*currentNumberOfComponents);
    printDebugText("Malloc done");
    i = 0;
    while(i < currentNumberOfComponents){
        printDebugText("Init each resistance item %d", i);

        printDebugText("After resistancelist");
        (*resistanceList)[i] = malloc(sizeof(char)*20);
        printDebugText("Allocation done");
        (*resistanceList)[i] = "0";
        printDebugText("Default 0 done");
        i = i + 1;
    }
    printDebugText("All resistance items are initialized");
    addInputSections(currentNumberOfComponents, oldNumberOfComponents, mainGrid, entryChangedFuncPtr);
}

/**
* @brief Sets the resistance value for an index
*
* Sets the resistance value for an index
* @param index The index to update
* @param value The value to set
* @return void
**/
static void setResistanceItemValue(int index, char* value) {
    _resistanceValueList[index-1] = value;
}

static void resistanceListItemChanged (GtkEditable *editable,
               gpointer     user_data) {
    if(user_data != NULL){
        char* value = gtk_editable_get_chars(editable, 0,-1);
        printDebugText("Resistance value with index %d was set to: %s\n", user_data, value);
        setResistanceItemValue(user_data, value);
    }
}

/**
* @brief Sets the connection type
*
* Sets the connection type, can be either S or P
* @param connectionType Can either be S or P
* @return void
**/
static void setConnectionType(char connectionType) {
    _connectionType = connectionType;
    printDebugText("Connection type changed to %c", _connectionType);
}

/**
* @brief Gets the connection type
*
* Gets the connection type
* @return char
**/
static char getConnectionType() {
    return _connectionType;
}


/**
* @brief Sets voltage value
*
* Sets the value of the voltage
* @param value The value of the voltage
* @return void
**/
static void setVoltage(char* value){
    printDebugText("Voltage changed from %s to %s", value, _voltage);
    _voltage = value;
}

/**
* @brief Gets the voltage
*
* Gets the voltage. The voltage is stored as char* and converted on the fly by this method
* @return float
**/
static float getVoltage() {
    return atof(_voltage);
}

/**
* @brief Gets the number of components
*
* Gets the number of components
* @return int
**/
static int getNumberOfComponents(){
    return atof(_numberOfComponents);
}

/**
* @brief Sets the number of components
*
* Sets the number of components
* @param value The number of components
* @return void
**/
static void setNumberOfComponents(char* value){
    int oldNumberOfComponents = getNumberOfComponents();
    _numberOfComponents = value;
    printDebugText("Number of components before change: %d, after: %s", oldNumberOfComponents, value);
    int i = 0;
    printDebugText("All values before changing the number of components:");
    if(_resistanceValueList == NULL)
        printDebugText("Resistance is null");
    while(i < oldNumberOfComponents){
        printDebugText("Checking positions..");
        printDebugText("Position: %d had %s \n", i, _resistanceValueList[i]);
        i = i + 1;
    }
    printDebugText("MainGrid address %p", _mainGrid);
    initResistanceListSection(getNumberOfComponents(), oldNumberOfComponents, &_resistanceValueList, _mainGrid, resistanceListItemChanged);
}

/**
* @brief Gets the resistance items as a float array
*
* Get the current array of resistance values as float. This function converts to float on the fly from a char pointer array.
* @return float*
**/
static float* getResistanceItems(){
    float* resistance = malloc(getNumberOfComponents()*sizeof(float));
    int i = 0;
    while(i < getNumberOfComponents()){
        resistance[i] = atof(_resistanceValueList[i]);
        printDebugText("Value converted from: %s to: %f", _resistanceValueList[i], resistance[i]);
        i = i + 1;
    }
    return resistance;
}

/**
* @brief Event method that is fired when voltage is changed
*
* Event method that fires when voltage input textbox is changed. It updates the model data with the setVoltage method.
* @return void
**/
static void voltageChanged (GtkEditable *editable,
               gpointer     user_data) {
    setVoltage(gtk_editable_get_chars(editable, 0,-1));
}

/**
* @brief Event method that is fired when connection type is changed
*
* Event method that fires when connection type checkbox is changed. It updates the model data with the setConnectionType method.
* @return void
**/
static void connectionTypeChanged (GtkCheckButton* checkButton,
               gpointer     user_data) {
    gboolean isChecked = gtk_toggle_button_get_active (checkButton);
    if(isChecked == TRUE){
        printDebugText("Checked");
        setConnectionType('P');
    } else {
        setConnectionType('S');
    }
}

/**
* @brief Event method that is fired when number of components are changed
*
* Event method that fires when the number of component drop down list is changed. It updates the model data with the setNumberOfComponents method.
* @return void
**/
static void numberOfComponentsChanged (GtkComboBox* comboBox,
               gpointer     user_data) {
    setNumberOfComponents(gtk_combo_box_text_get_active_text (comboBox));
}

/**
* @brief Event method that is fired when window is closed
*
* Event method that fires when the window is closed. It returns FALSE if it should move on to run destroy, e.g. close the application.
* @return void
**/
static gboolean delete_event(GtkWidget *widget,
                                GdkEvent *event,
                                gpointer data)
{
    printDebugText("delete event occured");
    return FALSE;
}


/**
* @brief Event method that is fired when the application is being closed
*
* Event method that fires when the application is about to be closed.
* @return void
**/
static void destroy(GtkWidget *widget,
                    gpointer data)
{
    gtk_main_quit();
}

/**
* @brief Event method that is fired when it's time to calculate the output of the input
*
* Event method that fires when the button is clicked. This calculates the result of the electrolib functionality.
* @return void
**/
static void calculateAndPresentOutput(){
    int RESISTANCEOUTPUTLABELROW = 6;
    int VOLTAGEOUTPUTLABELROW = 7;
    int E12OUTPUTLABELROW = 8;
    float* replaceResistanceValues = calloc(3,sizeof(float));

    float totalresistance = calc_resistance(getNumberOfComponents(), getConnectionType(), getResistanceItems());
    float totalpower = calc_power_r(getVoltage(), totalresistance);
    int numberOfResistors = e_resistance(totalresistance, replaceResistanceValues);

    char formatedMessage[100];
    sprintf(formatedMessage, "Ersättningsresistance: %.1f ohm", totalresistance);
    addOutputLabel(_mainGrid, formatedMessage, 1, RESISTANCEOUTPUTLABELROW, 2);
    sprintf(formatedMessage, "Effekt: %.2f W", totalpower);
    addOutputLabel(_mainGrid, formatedMessage, 1, VOLTAGEOUTPUTLABELROW, 2);
    sprintf(formatedMessage, "Ersättningsresistans i E12-serien koppliade i serie: %.0f, %.0f, %.0f", *replaceResistanceValues, *(replaceResistanceValues+1), *(replaceResistanceValues+2));
    addOutputLabel(_mainGrid, formatedMessage, 1, E12OUTPUTLABELROW, 2);
}


/**
* @brief Starts the whole application and calls the electrolibui to present the UI in GTK
*
* Starts the whole application and calls the electrolibui to present the UI in GTK
* @return void
**/
int main(int argc, char *argv[]){
    GtkWidget *calcButton;
    GtkWidget *closeButton;

    _mainGrid = createWindowAndMainGrid(argc, argv, destroy, delete_event);

    addOutputLabel(_mainGrid, "Ange basdata: ", 1, 1, 1);
    addInputSection("Ange spänningskälla i V: ",_mainGrid, voltageChanged, 1, 2,0);
    addCheckbox("Räkna med Parallell koppling istället för Seriell",_mainGrid, connectionTypeChanged, 1, 3);
    addDropDownList(10,_mainGrid, numberOfComponentsChanged, 1,4);
    
    addOutputLabel(_mainGrid, "Komponenter och spänning: ", 2, 1, 1);
    initResistanceListSection(getNumberOfComponents(),0, &_resistanceValueList, _mainGrid, resistanceListItemChanged);
    addButton("Beräkna!", _mainGrid, calculateAndPresentOutput, 1, 5, 2);
    addButton("Avsluta", _mainGrid, destroy, 1, 9, 2);

    gtk_main();
    return 0;
}