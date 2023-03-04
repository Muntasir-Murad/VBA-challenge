Attribute VB_Name = "Module1"
Sub AlphabeticalTesting():

    For Each ws In Worksheets
    
        Dim WorksheetName As String
       
        Dim i, j, TickCount, LastRowofA, LastRowofI As Long
      
        Dim PercentChange, GreatestIncrease, GreatestDecrease, GreatestVolume As Double
       
    
        
        'WorksheetName
        WorksheetName = ws.Name
        
        'column headers
        ws.Cells(1, 9).Value = "Ticker"
        ws.Cells(1, 10).Value = "Yearly Change"
        ws.Cells(1, 11).Value = "Percent Change"
        ws.Cells(1, 12).Value = "Total Stock Volume"
        ws.Cells(1, 16).Value = "Ticker"
        ws.Cells(1, 17).Value = "Value"
        ws.Cells(2, 15).Value = "Greatest % Increase"
        ws.Cells(3, 15).Value = "Greatest % Decrease"
        ws.Cells(4, 15).Value = "Greatest Total Volume"
        
        'Set Ticker Counter to first row
        TickCount = 2
        
        'Set start row to 2
        j = 2
        
        'Find the last active cell in column A
        LastRowofA = ws.Cells(Rows.Count, 1).End(xlUp).Row
       
        
            'Loop through all rows
            For i = 2 To LastRowofA
            
                'Check if ticker name changed
                If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
                
                
                'Write ticker value in column I
                
                ws.Cells(TickCount, 9).Value = ws.Cells(i, 1).Value
                
                'Calculate and write Yearly Change in column J
                
                ws.Cells(TickCount, 10).Value = ws.Cells(i, 6).Value - ws.Cells(j, 3).Value
                
                    'Conditional formating
                    If ws.Cells(TickCount, 10).Value < 0 Then
                
                    'Set cell background color to red
                    ws.Cells(TickCount, 10).Interior.ColorIndex = 3
                
                    Else
                
                    'Set cell background color to green
                    ws.Cells(TickCount, 10).Interior.ColorIndex = 4
                
                    End If
                    
                    'Calculate and write percent change in column K
                    
                    PercentChange = ((ws.Cells(i, 6).Value - ws.Cells(j, 3).Value) / ws.Cells(j, 3).Value)
                    
                    'Percent formating
                    ws.Cells(TickCount, 11).Value = Format(PercentChange, "Percent")
                    
                   
                    
                'Calculate total volume in column L
                
                ws.Cells(TickCount, 12).Value = WorksheetFunction.Sum(Range(ws.Cells(j, 7), ws.Cells(i, 7)))
                
                'Increase TickCount by 1
                TickCount = TickCount + 1
                
                'Set new start row of the ticker block
                j = i + 1
                
                End If
            
            Next i
            
        'Find last cell in column I
        LastRowofI = ws.Cells(Rows.Count, 9).End(xlUp).Row
       
        
     
        GreatestVolume = ws.Cells(2, 12).Value
        GreatestIncrease = ws.Cells(2, 11).Value
        GreatestDecrease = ws.Cells(2, 11).Value
        
            
            For i = 2 To LastRowofI
            
                'copy ticker to p column
                If ws.Cells(i, 12).Value > GreatestVolume Then
                GreatestVolume = ws.Cells(i, 12).Value
                ws.Cells(4, 16).Value = ws.Cells(i, 9).Value
                
                Else
                
                GreatestVolume = GreatestVolume
                
                End If
                
              
                If ws.Cells(i, 11).Value > GreatestIncrease Then
                GreatestIncrease = ws.Cells(i, 11).Value
                ws.Cells(2, 16).Value = ws.Cells(i, 9).Value
                
                Else
                
                GreatestIncrease = GreatestIncrease
                
                End If
                
                
                If ws.Cells(i, 11).Value < GreatestDecrease Then
                GreatestDecrease = ws.Cells(i, 11).Value
                ws.Cells(3, 16).Value = ws.Cells(i, 9).Value
                
                Else
                
                GreatestDecrease = GreatestDecrease
                
                End If
                
            'Write summary results in ws.Cells
            ws.Cells(2, 17).Value = Format(GreatestIncrease, "Percent")
            ws.Cells(3, 17).Value = Format(GreatestDecrease, "Percent")
            ws.Cells(4, 17).Value = Format(GreatestVolume, "Scientific")
            
            Next i
            
        'Adjust column width automatically
        Worksheets(WorksheetName).Columns("A:Z").AutoFit
            
    Next ws
        
End Sub

