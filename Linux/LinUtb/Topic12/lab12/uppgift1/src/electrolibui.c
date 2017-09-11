#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <gtk/gtk.h>
#include "electrolibui.h"

/**
* @brief Prints a text with a given colour and a list of arguments
*
* A wrapper around printf that simplifies printing out test result text in different colours.
* @param text The text message to print out
* @param args The arguments for the text output, it's a va_list so provide it in the same way as for a printf call
* @return void
**/
void printDebugText(const char* text, ...){   
    const char* newLine = "\n";
    const char* greenColour = "\x1b[32m";
    const char* resetColour = "\x1b[0m";

    va_list args;
    va_start( args, text );
    printf(greenColour);
    vprintf(text, args );
    va_end( args );
    printf(newLine);
    printf(resetColour);
}

void addInputSection(char *text, GtkGrid *grid, void (*entryChangedFuncPtr) (GtkEditable *editable, gpointer),
                            int col, int row, int* index) {
    GtkGrid *childGrid;
    GtkWidget *label;
    GtkWidget *textBox;

    childGrid = gtk_grid_new();
    label = gtk_label_new_with_mnemonic(text);
    textBox = gtk_entry_new();
    if(entryChangedFuncPtr != NULL){
        g_signal_connect(textBox, "changed", G_CALLBACK(entryChangedFuncPtr), index);
    }
    
    gtk_grid_attach_next_to(childGrid, label, NULL, GTK_POS_RIGHT,1,1);
    gtk_grid_attach_next_to(childGrid, textBox, label, GTK_POS_RIGHT,1,1);
    gtk_grid_attach(grid, childGrid, col, row, 1, 1);
    gtk_widget_show(childGrid);
    gtk_widget_show(textBox);
    gtk_widget_show(label);
}

void addInputSections(int numberOfComponents, int oldNumberOfComponents, GtkGrid* mainGrid, void (*entryChangedFuncPtr) (GtkEditable *editable, gpointer)){
    
    printDebugText("MainGrid address %p", mainGrid);
    
    printDebugText("Number of components is %d and old ones are %d", numberOfComponents, oldNumberOfComponents);
    GtkGrid* resistanceListGrid = gtk_grid_get_child_at(mainGrid, 2, 2);
    printDebugText("Resistance main grid fetched");
    if(resistanceListGrid != NULL){
        gtk_container_remove(mainGrid, resistanceListGrid);
        printDebugText("Was not empty, will be removed");
    }
    printDebugText("Resistance main grid removed if it existed");
    resistanceListGrid = gtk_grid_new();
    printDebugText("A new resistance list grid created");
    gtk_grid_attach(mainGrid, resistanceListGrid, 2, 2, 1, 1);
    printDebugText("The new resistance list grid added to main grid");
    
    int i = 1;
    while(i <= numberOfComponents) {
        printDebugText("Adding output section %d", i);
        int* index = malloc(sizeof(int));
        index = i;
        addInputSection("Komponent:", resistanceListGrid, entryChangedFuncPtr, 1, i, index);
        i = i + 1;
    }

    gtk_widget_show(resistanceListGrid);
}

void addOutputLabel(GtkGrid *grid, char* text, int col, int row, int width) {
    GtkWidget* label = gtk_grid_get_child_at(grid, col, row);
    if(label == NULL){
        label = gtk_label_new(NULL);
        gtk_label_set_xalign(GTK_LABEL(label), 0);
        gtk_grid_attach(grid,label,col,row,width,1);
        gtk_widget_show(label);
    }

    const char *format = "<b>\%s</b>";
    char *markup;
        
    markup = g_markup_printf_escaped (format, text);
    gtk_label_set_markup (GTK_LABEL (label), markup);
    g_free (markup);
}

void addCheckbox(char *text, GtkGrid *grid, void (*entryChangedFuncPtr) (GtkCheckButton *editable, gpointer), int col, int row){
    GtkWidget* checkBox = gtk_check_button_new_with_label ("Räkna med Parallell koppling \n istället för Seriell");

    g_signal_connect(checkBox, "toggled", G_CALLBACK(entryChangedFuncPtr), NULL);

    gtk_grid_attach(grid, checkBox, col, row, 1, 1);
    gtk_widget_show(checkBox);
}

void addDropDownList(int numberOfElements, GtkGrid *grid, void (*entryChangedFuncPtr) (GtkComboBox *editable, gpointer),
                            int col, int row){
    GtkWidget* comboBoxWithText = gtk_combo_box_text_new_with_entry ();
    int i = 1;
    while(i <= numberOfElements){
        char *numberAsChar = malloc(20);
        sprintf(numberAsChar, "%d", i);
        gtk_combo_box_text_append (comboBoxWithText, numberAsChar, numberAsChar);
        i = i + 1;
    }

    gtk_combo_box_set_active_id (comboBoxWithText,"1");

    g_signal_connect(comboBoxWithText, "changed", G_CALLBACK(entryChangedFuncPtr), NULL);

    gtk_grid_attach(grid, comboBoxWithText, col, row, 1, 1);
    gtk_widget_show(comboBoxWithText);
}

GtkGrid* createWindowAndMainGrid(int argc, char *argv[], void (*destroyFuncPtr) (GtkWidget *widget, gpointer), void (*deleteEventFuncPtr) (GtkWidget *widget, GdkEvent *event, gpointer data)){
    GtkWidget *window;
    GtkGrid* mainGrid;

    gtk_init(&argc, &argv);
    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);

    g_signal_connect(window, "delete-event", G_CALLBACK(deleteEventFuncPtr), NULL);
    g_signal_connect(window, "destroy", G_CALLBACK(destroyFuncPtr), NULL);
    
    mainGrid = gtk_grid_new();

    gtk_container_add(GTK_CONTAINER(window),mainGrid);
    gtk_widget_show(window);
    gtk_widget_show(mainGrid);
    return mainGrid;
}

void addButton(char *text, GtkGrid *grid, void (*buttonFuncPtr) (GtkButton *button, gpointer), int col, int row, int width){
    GtkWidget* button = gtk_button_new_with_label(text);

    g_signal_connect(button, "clicked", G_CALLBACK(buttonFuncPtr), NULL);
    gtk_grid_attach(grid, button, col, row, width, 1);
    gtk_widget_show(button);
}
