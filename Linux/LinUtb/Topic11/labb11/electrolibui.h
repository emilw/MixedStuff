/**
* @file electrolibui.h
*/


#ifndef ELECTROLIBUI
#define ELECTROLIBUI

/**
* @brief Central function for printing debug information.
*
* Central function for printing debug information
* @param text The text to print
* @param ... Send in any number of paramters, similar as formating for printf
* @return void
**/
void printDebugText(const char* text, ...);

/**
* @brief Add an input section with label and text input
*
* Generates a pair of a label and text input. The label prints out what to fill into the text box
* @param text The text to use in the label that describes what to fill into the text input field
* @param grid A GtkGrid object that will be the parent grid of the input section
* @param entyChangedFuncPtr The event function that should handle every time a user types in a character in the text box.
* @param col The column number where the input section should be placed
* @param row The row number where the input section should be placed
* @param index The id for the input section, this can be used for identification in the event function provided in the entryFunctionPtr
* @return void
**/
void addInputSection(char *text, GtkGrid *grid, void (*entryChangedFuncPtr) (GtkEditable *editable, gpointer), int col, int row, int* index);

/**
* @brief Adds a set of input sections, typicaly when it's needed to present a list of values or similar
*
* Generates a set of input section, typically when it's needed to bind an array of values to ui input
* @param numberOfComponents The new number of components to be used
* @param oldNumberOfComponents The number of components used since before, this was the value set before it was changed to numberOfComponents
* @param mainGrid The grid to attach the input sections to
* @param entryChangedFuncPtr The function that should handle the input changes. The index is the identifier to be used in the event function to determine what array position to update etc.
* @return void
**/
void addInputSections(int numberOfComponents, int oldNumberOfComponents, GtkGrid* mainGrid, void (*entryChangedFuncPtr) (GtkEditable *editable, gpointer));

/**
* @brief Adds an output label that is used to communicate information to the end user.
*
* This function generates an output label that displays the text with bold text
* @param grid The grid where the output section should be generated
* @param text The text to print out
* @param col The column position where the output label should be generated
* @param row The row number where the output label should be generated
* @param width How many columns the output section should span
* @return void
**/
void addOutputLabel(GtkGrid *grid, char* text, int col, int row, int width);

/**
* @brief Adds an check box with an including text that describes what the check box does.
*
* This function generates a check box and a descriptive text that says what the check box does
* @param text The explanation of what the check box does
* @param grid The grid where the output section should be generated
* @param entryChangedFucPtr The function that handle the event when a user checks or un-checks the check box
* @param col The column position where the output label should be generated
* @param row The row number where the output label should be generated
* @return void
**/
void addCheckbox(char *text, GtkGrid *grid, void (*entryChangedFuncPtr) (GtkCheckButton *editable, gpointer), int col, int row);

/**
* @brief Adds a drop down list generating input items up to the numberOfElements parameter
*
* Generates a drop down list with integer numbers as elements. Items are generated from 1 to numberOfElements 
* @param grid The grid where the output section should be generated
* @param entryChangedFucPtr The function that handle the event when a user selects an item in the list
* @param col The column position where the output label should be generated
* @param row The row number where the output label should be generated
* @return void
**/
void addDropDownList(int numberOfElements, GtkGrid *grid, void (*entryChangedFuncPtr) (GtkComboBox *editable, gpointer),
                            int col, int row);

/**
* @brief Creates a window and a corresponding grid, the grid is returned for further ui element creation
*
* Generates a window and a grid, the grid is the boilerplate for further ui elements to be added. This is the bootstrap method to wire up the main GTK functionality
* @param argc The number of arguments, this should be taken from the command arguments in main(...)
* @param argv[] The arguments, this should be taken from the command arguments in main(...)
* @param destroyFuncPtr The function that handle the kills the application
* @param deleteEventFuncPtr The function that is called when the window is closed
* @return GtkGrid* Returns the grid that should be used when adding new ui elements.
**/
GtkGrid* createWindowAndMainGrid(int argc, char *argv[], void (*destroyFuncPtr) (GtkWidget *widget, gpointer), void (*deleteEventFuncPtr) (GtkWidget *widget, GdkEvent *event, gpointer data));

/**
* @brief Adds a button with corresponding text
*
* Add a button with the corresponding text, click event and position in the grid
* @param text The text on the button
* @param grid The grid where the button should be generated
* @param entryChangedFucPtr The function that handle the event when a user clicks the button
* @param col The column position where the output label should be generated
* @param row The row number where the output label should be generated
* @param width How many columns the button should span
* @return void
**/
void addButton(char *text, GtkGrid *grid, void (*buttonFuncPtr) (GtkButton *button, gpointer), int col, int row, int width);
#endif