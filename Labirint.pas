Program filing;
uses GraphABC, Timers{, Graph3D};



var i, j, ip, jp: integer;
f:Text;
arr:array[0..24, 0..24] of integer;
kl, kr, ku, kd: integer;

procedure TimerProc;
begin
  if ((kl = 1) and (ip > 0) and (arr[ip-1, jp] = 0)) then begin arr[ip, jp] := 0; arr[ip-1, jp] := 2; ip := ip - 1; SetBrushColor(clWhite);
    FillRectangle(0,0,500,500);  end;
  if ((kr = 1) and (ip < 24) and (arr[ip+1, jp] = 0)) then begin arr[ip, jp] := 0; arr[ip+1, jp] := 2; ip := ip + 1; SetBrushColor(clWhite);
    FillRectangle(0,0,500,500); end;
  if ((ku = 1) and (jp > 0) and (arr[ip, jp-1] = 0)) then begin arr[ip, jp] := 0; arr[ip, jp-1] := 2;jp := jp - 1; SetBrushColor(clWhite);
    FillRectangle(0,0,500,500); end;
  if ((kd = 1) and (jp < 24) and (arr[ip, jp+1] = 0)) then begin arr[ip, jp] := 0; arr[ip, jp+1] := 2; jp := jp + 1; SetBrushColor(clWhite);
    FillRectangle(0,0,500,500); end;
end;
procedure TimerText;
begin
  SetGraphABCIO;
  SetFontColor(clBlack);
  SetFontSize(20);
  textout(50, 50, 'Поздравляю,Вы прошли игру.');
end;
begin
  var t := new Timer(100,TimerProc);
  var h := new Timer(100,TimerText);
  Window.Title := 'Лабиринт';
  Window.Height := 500;
  Window.Width := 500;
  //assign(f, 'F:\Nik\Labirint\labi.txt');
  assign(f, 'E:\Nik\Labirint\labi.txt');
  reset(f);
  for i := 0 to 24 do 
      for j := 0 to 24 do 
        read(f, arr[j, i]); 
  close(f);
  ip := 0;
  jp := 1;
  while arr[23, 24] < 2 do begin
    for j := 0 to 24 do begin
      for i := 0 to 24 do begin     
        if(arr[i, j] = 1) then
           begin
              SetBrushColor(clBlack);
              FillRectangle(i*20, j*20, i*20 + 20, j*20+20);
           end;
        if(arr[i, j] = 2) then
           begin
              SetBrushColor(clGreen);
              FillRectangle(i*20, j*20, i*20 + 20, j*20+20);
           end;
      end; //закрытие for j
    end;// закрытие for i
    
    OnKeyDown := k ->//Keys
  begin
    case k of
      VK_W,VK_Up:    begin ku := 1; kd := 0; end; 
      VK_S,VK_Down:  begin kd := 1; ku := 0; end;
      VK_A,VK_Left:  begin kl := 1; kr := 0; end;
      VK_D,VK_Right: begin kr := 1; kl := 0; end;
    end;  
  end;
  OnKeyUp := k ->
  begin
    case k of
      VK_W,VK_Up:    ku := 0;
      VK_S,VK_Down:  kd := 0;
      VK_A,VK_Left:  kl := 0;
      VK_D,VK_Right: kr := 0;
    end;  
    SetBrushColor(clWhite);
    FillRectangle(0,0,500,500);
    t.Start;
    Sleep(100);
  end;    //Closing keys
  
  end;//закрытие while
  h.Start;
  Sleep(3000);
  //View3D.SubTitle := 'Ну все, теперь прямая дорога к ОГЭ';
end.
   