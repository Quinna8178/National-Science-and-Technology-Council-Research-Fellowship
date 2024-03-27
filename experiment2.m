clearvars; %清除所有變數
alldata=dir('C:\Users\user\Desktop\1112_exp\*.JPG'); %讀取所有刺激圖片檔在電腦中的路徑
item_name=string({alldata.name});
ask_ID = {'請輸入受試者編號'};
dlgtitle = 'Input';
dims = [1 50];
subject_ID = str2double(cell2mat(inputdlg(ask_ID,dlgtitle,dims)));
Screen('Preference', 'SkipSyncTests', 1);
data=zeros(36,14); %建立空的矩陣data存放實驗資料(最大嘗試次為36)
data(1:end,1)=subject_ID;
if mod(subject_ID,6)==0
    condition="Individul_F";
    total_trials=36; %刺激材料數量
    data(1:end,2)=mod(subject_ID,6);
elseif mod(subject_ID,6)==1
    condition="Individul_S";
    total_trials=36;
    data(1:end,2)=mod(subject_ID,6);
elseif mod(subject_ID,6)==2
    condition="half_F";
    total_trials=2;
    data(1:end,2)=mod(subject_ID,6);
elseif mod(subject_ID,6)==3
    condition="half_S";
    total_trials=2;
    data(1:end,2)=mod(subject_ID,6);
elseif mod(subject_ID,6)==4
    condition="all_F";
    total_trials=1;
    data(1:end,2)=mod(subject_ID,6);
elseif mod(subject_ID,6)==5
    condition="all_S";
    total_trials=1;
    data(1:end,2)=mod(subject_ID,6);
end
[w0,rect]=Screen('OpenWindow',0,0);
instr_1=imread('instru_01.JPG'); %讀取指導語圖檔
instr_2=imread('instru_02.JPG'); %讀取指導語圖檔
p_instr1=Screen('MakeTexture',w0,instr_1); 
p_instr2=Screen('MakeTexture',w0,instr_2); 
Screen('DrawTexture',w0,p_instr1);
Screen('Flip',w0);
WaitSecs(.2);
KbWait;
Screen('DrawTexture',w0,p_instr2);
Screen('Flip',w0);
WaitSecs(.2);
KbWait;
q1_no = Shuffle([1:10]); %將問題階段一隨機
data(1:length(q1_no),3)=q1_no;
for i=1:length(q1_no)
    q1_item = q1_no(i); 
    q1_name=sprintf('Q1_%.2d.JPG',q1_item);
    q1_img=imread(q1_name);
    q1_trial=Screen('MakeTexture',w0,q1_img);
    Screen('DrawTexture',w0,q1_trial);
    Screen('Flip',w0);
    WaitSecs(.2);
    t1=GetSecs; %取得秒數
    keyRes=0; %預設按鍵反應為0
    while 1
        [x,y,button]=KbCheck; %確認鍵盤的按鍵反應
        t2=GetSecs; 
        if any(button) %有按鍵反應
           press=find(button);  %將按鍵反應的序號存入press中
           if press==KbName('1') %若press 等於1的序號 按鍵反應紀錄為1
              keyRes=1;
              break;
           elseif press==KbName('2') %若press 等於2的序號 按鍵反應紀錄為2
              keyRes=2;
              break;
           elseif press==KbName('3') %若press 等於3的序號 按鍵反應紀錄為3
              keyRes=3;
              break;
           elseif press==KbName('4') %若press 等於4的序號 按鍵反應紀錄為4
              keyRes=4;
              break;
           elseif press==KbName('5') %若press 等於4的序號 按鍵反應紀錄為4
              keyRes=5;
              break;
           elseif press==KbName('6') %若press 等於4的序號 按鍵反應紀錄為4
              keyRes=6;
              break;
           else %按錯鍵的反應紀錄為-99
              keyRes=-99;
              break;
           end
        end
    end
    data(i,4:5)=[t2-t1 keyRes]; 
end
WaitSecs(.2);
%學習階段
In_F = Shuffle([1:36]);
In_S = Shuffle([37:72]);
H_F = Shuffle([1:2]);
H_S = Shuffle([3:4]);
instr_3=imread('instru_03.JPG'); %讀取指導語圖檔
Advice=imread('Advice.jpg');
p_instr3=Screen('MakeTexture',w0,instr_3);  
p_advice=Screen('MakeTexture',w0,Advice);
Screen('DrawTexture',w0,p_instr3);
Screen('Flip',w0);
WaitSecs(.2);
KbWait;
if mod(subject_ID,6)==0 
    for i=1:length(In_F)
        In_F_item =In_F(i); 
        In_F_name=sprintf('01%.2d.JPG',In_F_item);
        In_F_img=imread(In_F_name);
        In_F_trial=Screen('MakeTexture',w0,In_F_img);
        Screen('DrawTexture',w0,In_F_trial);
        Screen('Flip',w0);
        data(i,6)=[In_F_item];
        WaitSecs(5);
    end
elseif mod(subject_ID,6)==1
    for i=1:length(In_S)
        In_S_item =In_S(i); 
        In_S_name=sprintf('01%.2d.JPG',In_S_item);
        In_S_img=imread(In_S_name);
        In_S_trial=Screen('MakeTexture',w0,In_S_img);
        Screen('DrawTexture',w0,In_S_trial);
        Screen('Flip',w0);
        data(i,6)=[In_S_item];
        WaitSecs(5);
    end
elseif mod(subject_ID,6)==2
        H_F_name1=sprintf('02%.2d.JPG',H_F(1));
        H_F_name2=sprintf('02%.2d.JPG',H_F(2));
        H_F_1=imread(H_F_name1);
        H_F_2=imread(H_F_name2);
        H_F_trial1=Screen('MakeTexture',w0,H_F_1);
        H_F_trial2=Screen('MakeTexture',w0,H_F_2);
        Screen('DrawTexture',w0,H_F_trial1);
        Screen('Flip',w0);
        data(1,6)=[H_F(1)];
        WaitSecs(90);
        Screen('DrawTexture',w0,p_advice);
        Screen('Flip',w0);
        WaitSecs(3);
        Screen('DrawTexture',w0,H_F_trial2);
        Screen('Flip',w0);
        data(2,6)=[H_F(2)];
        WaitSecs(90);
  
elseif mod(subject_ID,6)==3
        H_S_name1=sprintf('02%.2d.JPG',H_S(1))
        H_S_name2=sprintf('02%.2d.JPG',H_S(2))
        H_S_1=imread(H_S_name1);
        H_S_2=imread(H_S_name2);
        H_S_trial1=Screen('MakeTexture',w0,H_S_1);
        H_S_trial2=Screen('MakeTexture',w0,H_S_2);
        Screen('DrawTexture',w0,H_S_trial1);
        Screen('Flip',w0);
        data(1,6)=[H_S(1)];
        WaitSecs(90);
        Screen('DrawTexture',w0,p_advice);
        Screen('Flip',w0);
        WaitSecs(3);
        Screen('DrawTexture',w0,H_S_trial2);
        Screen('Flip',w0);
        data(2,6)=[H_S(2)];
        WaitSecs(90);
elseif mod(subject_ID,6)==4 
       A_F_img=imread('0301.JPG');
       A_F_trial=Screen('MakeTexture',w0,A_F_img);
       Screen('DrawTexture',w0,A_F_trial);
       Screen('Flip',w0);
       data(i,6)=[4];
       WaitSecs(180);
else 
       A_S_img=imread('0302.JPG');
       A_S_trial=Screen('MakeTexture',w0,A_S_img);
       Screen('DrawTexture',w0,A_S_trial);
       Screen('Flip',w0);
       data(i,6)=[5];
       WaitSecs(180);
end 
instr_4=imread('instru_04.JPG'); %讀取指導語圖檔
p_instr4=Screen('MakeTexture',w0,instr_4);  
Screen('DrawTexture',w0,p_instr4);
Screen('Flip',w0);
KbWait;
WaitSecs(.2);
%問題階段二
q2_no = Shuffle([1:10]); %將問題階段二隨機
data(1:length(q2_no),7)=q2_no;
for i=1:length(q2_no)
    q2_item = q2_no(i); 
    q2_name=sprintf('Q2_%.2d.JPG',q2_item);
    q2_img=imread(q2_name);
    q2_trial=Screen('MakeTexture',w0,q2_img);
    Screen('DrawTexture',w0,q2_trial);
    Screen('Flip',w0);
    WaitSecs(.2);
    t1=GetSecs; %取得秒數
    keyRes=0; %預設按鍵反應為0
    while 1
        [x,y,button]=KbCheck; %確認鍵盤的按鍵反應
        t2=GetSecs; 
        if any(button) %有按鍵反應
           press=find(button);  %將按鍵反應的序號存入press中
           if press==KbName('1') %若press 等於1的序號 按鍵反應紀錄為1
              keyRes=1;
              break;
           elseif press==KbName('2') %若press 等於2的序號 按鍵反應紀錄為2
              keyRes=2;
              break;
           elseif press==KbName('3') %若press 等於3的序號 按鍵反應紀錄為3
              keyRes=3;
              break;
           elseif press==KbName('4') %若press 等於4的序號 按鍵反應紀錄為4
              keyRes=4;
              break;
           elseif press==KbName('5') %若press 等於5的序號 按鍵反應紀錄為5
              keyRes=5;
              break;
           elseif press==KbName('6') %若press 等於6的序號 按鍵反應紀錄為6
              keyRes=6;
              break;
           else %按錯鍵的反應紀錄為-99
              keyRes=-99;
              break;
           end
        end
    end
    data(i,8:9)=[t2-t1 keyRes]; 
end
%看過幾則的問題
WaitSecs(.2);
instr_5=imread('instru_05.JPG'); %讀取指導語圖檔
p_instr5=Screen('MakeTexture',w0,instr_5);  
Screen('DrawTexture',w0,p_instr5);
Screen('Flip',w0);
button = 0;
while(~any(button))
    [x, y, button] = KbCheck;
    Res = find(button);
end
data(1,10)=[KbName(Res)];
WaitSecs(.2);
instr_6=imread('instru_06.JPG'); %讀取指導語圖檔
p_instr6=Screen('MakeTexture',w0,instr_6);  
Screen('DrawTexture',w0,p_instr6);
Screen('Flip',w0);
KbWait;
%再認階段
Familiar = Shuffle([1:36]);
Strange = Shuffle([37:72]);
All_test = Shuffle([Familiar(1:18) Strange(1:18)]);
for i=1:length(All_test)
    Rec_name=sprintf('01%.2d.JPG',All_test(i));
    Rec_img=imread(Rec_name);
    Rec_trial=Screen('MakeTexture',w0,Rec_img);
    Screen('DrawTexture',w0,Rec_trial);
    Screen('Flip',w0);
    WaitSecs(.2);
    t3=GetSecs; %取得秒數
    Rec_keyRes=0; %預設按鍵反應為0
    if mod(subject_ID,6)==0 | mod(subject_ID,6)==2 | mod(subject_ID,6)==4
        if All_test(i)<37
            while 1
                [x,y,button]=KbCheck; %確認鍵盤的按鍵反應
                t4=GetSecs; 
                if any(button) %有按鍵反應
                   press=find(button);  %將按鍵反應的序號存入press中
                   if press==KbName('y') %若press 等於1的序號 按鍵反應紀錄為1
                      Rec_keyRes=1;
                      Correct=1;
                      break;
                   elseif press==KbName('n') %若press 等於2的序號 按鍵反應紀錄為2
                      Rec_keyRes=2;
                      Correct=0;
                      break;
                   else %按錯鍵的反應紀錄為-99
                      Rec_keyRes=-99;
                      break;
                   end
                end
            end
        else
            while 1
                [x,y,button]=KbCheck; %確認鍵盤的按鍵反應
                t4=GetSecs; 
                if any(button) %有按鍵反應
                   press=find(button);  %將按鍵反應的序號存入press中
                   if press==KbName('y') %若press 等於1的序號 按鍵反應紀錄為1
                      Rec_keyRes=1;
                      Correct=0;
                      break;
                   elseif press==KbName('n') %若press 等於2的序號 按鍵反應紀錄為2
                      Rec_keyRes=2;
                      Correct=1;
                      break;
                   else %按錯鍵的反應紀錄為-99
                      Rec_keyRes=-99;
                      break;
                   end
                end
            end
        end
    else
        if All_test(i)<37
            while 1
                [x,y,button]=KbCheck; %確認鍵盤的按鍵反應
                t4=GetSecs; 
                if any(button) %有按鍵反應
                   press=find(button);  %將按鍵反應的序號存入press中
                   if press==KbName('y') %若press 等於1的序號 按鍵反應紀錄為1
                      Rec_keyRes=1;
                      Correct=0;
                      break;
                   elseif press==KbName('n') %若press 等於2的序號 按鍵反應紀錄為2
                      Rec_keyRes=2;
                      Correct=1;
                      break;
                   else %按錯鍵的反應紀錄為-99
                      Rec_keyRes=-99;
                      break;
                   end
                end
            end
        else
            while 1
                [x,y,button]=KbCheck; %確認鍵盤的按鍵反應
                t4=GetSecs; 
                if any(button) %有按鍵反應
                   press=find(button);  %將按鍵反應的序號存入press中
                   if press==KbName('y') %若press 等於1的序號 按鍵反應紀錄為1
                      Rec_keyRes=1;
                      Correct=1;
                      break;
                   elseif press==KbName('n') %若press 等於2的序號 按鍵反應紀錄為2
                      Rec_keyRes=2;
                      Correct=0;
                      break;
                   else %按錯鍵的反應紀錄為-99
                      Rec_keyRes=-99;
                      Correct=-1;
                      break;
                   end
                end
            end
    
        end
    end
       data(i,11:14)=[All_test(i) Rec_keyRes Correct t4-t3];
end
Variable_names={'ID','COND','Q1_NUM','Q1_RT','Q1_keyres','learn_sec','Q2_NUM','Q2_RT','Q2_keyres','Res',"Rec_item","Res_res","Rec_Correct","Rec_RT"};
Variablename_final=[Variable_names{:}];
dta_all=array2table(data,'VariableNames',Variablename_final); %利用array2table加入欄位名稱;
filename=sprintf('%.2d.csv',subject_ID);
mkdir data
directory = 'C:\Users\user\Desktop\1112_exp\data';
Final = [directory filesep filename];
writetable(dta_all,Final);
 %將dta_all輸出成csv檔
WaitSecs(0.5);
ed=imread('End.JPG'); %讀取結束圖檔
p_end=Screen('MakeTexture',w0,ed);
Screen('DrawTexture',w0,p_end);
Screen('Flip',w0);
WaitSecs(.7); %等待0.7秒後結束視窗
Screen('CloseAll');