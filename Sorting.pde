import java.util.ArrayList;
import java.util.Random;

final int INSERT_TEXTBOX_X = 300;
final int RESET_BUTTON_X = 150;
final int RANDOMIZE_BUTTON_X = 450;
final int TEXTBOX_Y = 400;
final int SELECTION_BUTTON_X = 150;
final int INSERTION_BUTTON_X = 300;
final int MERGE_BUTTON_X = 450;
final int SORT_Y = 500;
final int TEXTBOX_WIDTH = 100;
final int TEXTBOX_HEIGHT = 30;

String insertText = "";
String outputText = "";
int selected = -1;
int counter = -1;
int counter2 = -1;
int sort = -1;

ArrayList<Integer> array = new ArrayList<Integer>();
ArrayList<Integer> green = new ArrayList<Integer>();

Boolean IsSorted(ArrayList<Integer> array)
{
    for(int i = 0; i < array.size()-1; ++i)
    {
        if(array.get(i) > array.get(i+1))
        {
            return false;
        }
    }
    return true;
}

void SelectionSort()
{
    green.clear();
    // Find minimum
    int min = counter;
    for(int i = counter+1; i < array.size(); ++i)
    {
        if(array.get(i) < array.get(min)) min = i;
    }
    
    // Swap minimum
    int temp = array.get(min);
    array.set(min, array.get(counter));
    array.set(counter, temp);
    
    green.add(counter);
    green.add(min);
}

void InsertionSort()
{
    green.clear();
    // If the element is greater than the previous elements, continue
    if(array.get(counter) <= array.get(counter-1))
    {
        int temp = array.get(counter);
        // Find where the element belongs
        for(int i = 0; i < counter; ++i)
        {
            if(array.get(i) > array.get(counter))
            {
                // Insert element
                array.add(i, temp);
                green.add(i);
                break;
            }
        }
        array.remove(counter+1);
    }
    green.add(counter);
}

void MergeSort()
{
    green.clear();
    int n = array.size();
    
    // Left, middle, end of subarray
    int l = counter2;
    int m = min(counter + l - 1, n-1);  // min if n is not a power of 2
    int r = min(l + 2 * counter - 1, n-1);
    
    int a = m - l + 1;
    int b = r - m;
    int[] L = new int[a];
    int[] R = new int[b];
    
    // Copy subarray
    for(int i = 0; i < a; ++i)
    {
        L[i] = array.get(l + i);
    }
    for(int i = 0; i < b; ++i)
    {
        R[i] = array.get(m + 1 + i);
    }
    
    // Merge subarrays
    int i = 0;
    int j = 0;
    int k = l;
    
    while(i < a && j < b)
    {
        if(L[i] <= R[j])
        {
            green.add(k);
            array.set(k++, L[i++]);
        }
        else
        {
            green.add(k);
            array.set(k++, R[j++]);
        }
    }
    
    while(i < a)
    {
        green.add(k);
        array.set(k++, L[i++]);
    }
    
    while(j < b)
    {
        green.add(k);
        array.set(k++, R[j++]);
    }
}


void setup()
{
    size(800, 600);
    frameRate(30);
}
void draw()
{
    background(240);
    textSize(12);
    
    if(counter == -1)
    {
        // Insert Textbox
        if(array.size() < 35)
        {
            fill(0);
            text("Insert (0 to 300)", INSERT_TEXTBOX_X, TEXTBOX_Y-10);
            fill(255);
            rect(INSERT_TEXTBOX_X, TEXTBOX_Y, TEXTBOX_WIDTH, TEXTBOX_HEIGHT);
            fill(0);
            text(insertText, INSERT_TEXTBOX_X+10, TEXTBOX_Y + TEXTBOX_HEIGHT-10);
            if(selected == 0)
            {
                line(insertText.length() * 7 + INSERT_TEXTBOX_X + 10,TEXTBOX_Y + 7, insertText.length() * 7 + INSERT_TEXTBOX_X + 10, TEXTBOX_Y + TEXTBOX_HEIGHT - 7);
            }
            
            // Output Textbox
            textSize(16);
            text(outputText, 300, 450);
        }
        
        // Reset Button
        textSize(12);
        fill(225);
        rect(RESET_BUTTON_X, TEXTBOX_Y, TEXTBOX_WIDTH, TEXTBOX_HEIGHT);
        fill(0);
        text("Reset", RESET_BUTTON_X+35, TEXTBOX_Y + TEXTBOX_HEIGHT-10);
        
        // Randomize Button
        fill(225);
        rect(RANDOMIZE_BUTTON_X, TEXTBOX_Y, TEXTBOX_WIDTH, TEXTBOX_HEIGHT);
        fill(0);
        text("Randomize!", RANDOMIZE_BUTTON_X+15, TEXTBOX_Y + TEXTBOX_HEIGHT-10);
        
        // Selection Sort Button
        fill(225);
        rect(SELECTION_BUTTON_X, SORT_Y, TEXTBOX_WIDTH, TEXTBOX_HEIGHT);
        fill(0);
        text("Selection Sort", SELECTION_BUTTON_X+10, SORT_Y + TEXTBOX_HEIGHT-10);
        
        // Insertion Sort Button
        fill(225);
        rect(INSERTION_BUTTON_X, SORT_Y, TEXTBOX_WIDTH, TEXTBOX_HEIGHT);
        fill(0);
        
        // Merge Sort Button
        text("Insertion Sort", INSERTION_BUTTON_X+10, SORT_Y + TEXTBOX_HEIGHT-10);
        fill(225);
        rect(MERGE_BUTTON_X, SORT_Y, TEXTBOX_WIDTH, TEXTBOX_HEIGHT);
        fill(0);
        text("Merge Sort", MERGE_BUTTON_X+20, SORT_Y + TEXTBOX_HEIGHT-10);
    }
    if(array.size() > 0)
    {
        // Selection Sort
        if(sort == 0 && -1 < counter && counter < array.size())
        {
            SelectionSort();
            delay(100);
            ++counter;
        }
        // Insertion Sort
        else if(sort == 1 && -1 < counter && counter < array.size())
        {
            InsertionSort();
            delay(100);
            ++counter;
        }
        // Merge Sort
        if(sort == 2 && -1 < counter && counter < array.size())
        {
            MergeSort();
            delay(100);
            counter2 += 2 * counter;
            if(counter2 >= array.size())
            {
                counter *= 2;
                counter2 = 0;
            }
        }
        else if(counter >= array.size())
        {
            counter = -1;
            counter2 = -1;
            sort = -1;
            green.clear();
        }
    }
    
    // Bars
    for(int i = 0; i < array.size(); ++i)
    {
        fill(0);
        rect(20 * i + 50, 300-array.get(i), 20, array.get(i));
        fill(255);
        rect(20 * i + 51, 300-array.get(i), 18, array.get(i));
        
        fill(0);
        if(i % 2 == 0)
        {
            text(array.get(i), 20 * i + 50, 315);
        }
        else
        {
            text(array.get(i), 20 * i + 50, 327);
        }
    }
    for(int j: green)
    {
        fill(0, 255, 0);
        rect(20 * j + 51, 300-array.get(j), 18, array.get(j));
    }
}
void mousePressed()
{
    if(counter == -1)
    {
        if(INSERT_TEXTBOX_X <= mouseX  && mouseX <= INSERT_TEXTBOX_X + TEXTBOX_WIDTH
        && TEXTBOX_Y <= mouseY && mouseY <= TEXTBOX_Y + TEXTBOX_HEIGHT)
        {
            selected = 0;
        }
        else if(RESET_BUTTON_X <= mouseX  && mouseX <= RESET_BUTTON_X + TEXTBOX_WIDTH
        && TEXTBOX_Y <= mouseY && mouseY <= TEXTBOX_Y + TEXTBOX_HEIGHT)
        {
            array.clear();
        }
        else if(RANDOMIZE_BUTTON_X <= mouseX  && mouseX <= RANDOMIZE_BUTTON_X + TEXTBOX_WIDTH
        && TEXTBOX_Y <= mouseY && mouseY <= TEXTBOX_Y + TEXTBOX_HEIGHT)
        {
            Random rand = new Random();
            array.clear();
            for(int i = 0; i < 35; ++i)
            {
                array.add(rand.nextInt(300)+1);
            }
        }
        else if(!IsSorted(array))
        {
            if(SELECTION_BUTTON_X <= mouseX  && mouseX <= SELECTION_BUTTON_X + TEXTBOX_WIDTH
            && SORT_Y <= mouseY && mouseY <= SORT_Y + TEXTBOX_HEIGHT)
            {
                sort = 0;
                counter = 0;
            }
            else if(INSERTION_BUTTON_X <= mouseX  && mouseX <= INSERTION_BUTTON_X + TEXTBOX_WIDTH
            && SORT_Y <= mouseY && mouseY <= SORT_Y + TEXTBOX_HEIGHT)
            {
                sort = 1;
                counter = 1;
            }
            else if(MERGE_BUTTON_X <= mouseX  && mouseX <= MERGE_BUTTON_X + TEXTBOX_WIDTH
            && SORT_Y <= mouseY && mouseY <= SORT_Y + TEXTBOX_HEIGHT)
            {
                sort = 2;
                counter = 1;
                counter2 = 0;
            }
        }
    }
}

void keyPressed()
{
    if(selected == 0 && counter == -1 && array.size() < 35)
    {
        if(key == '\n')
        {
            outputText = "";
            try
            {
                if(0 > Integer.parseInt(insertText) || Integer.parseInt(insertText) > 300)
                    {
                        outputText = "Invalid input.";
                    }
                else
                {
                    array.add(Integer.parseInt(insertText));
                    outputText = insertText + " inserted.";
                }
            }
            catch(Exception e)
            {
                outputText = "Invalid input.";
            }
            insertText = "";
        }
        else if(key == '\b' && insertText.length() > 0)
        {
            insertText = insertText.substring(0, insertText.length()-1);
        }
        else if(insertText.length() < 4)
        {
            insertText = insertText + key;
        }
    }
}
