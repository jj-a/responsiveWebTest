-- bbs.sql
-- �亯�� �Խ���
 
-- ���̺� ����
create table tb_bbs(
  bbsno    number(5)       not null -- �Ϸù�ȣ -99999~99999
 ,wname    varchar2(20)    not null -- �ۼ���
 ,subject  varchar2(100)   not null -- ������
 ,content  varchar2(2000)  not null -- �۳���
 ,passwd   varchar2(10)    not null -- �ۺ�й�ȣ
 ,readcnt  number(5)       default 0 not null -- ����ȸ��
 ,regdt    date            default  sysdate -- ���ۼ���
 ,grpno    number(5)       not null  -- �� �׷��ȣ
 ,indent   number(5)       default 0 -- �鿩����
 ,ansnum   number(5)       default 0 -- �ۼ���
 ,ip       varchar2(15)    not null -- �� IP
 ,primary key(bbsno)                --bbsno �⺻Ű 
);

-- ���۾���
bbsno : max(bbsno)+1
wname, subject, content, passwd : ������Է�
default �� : readcnt, regdt, indent, ansnum
grpno : max(bbsno)+1
ip : request���ΰ�ü���� �����PC�� IP������ ������

-- ���߰� �׽�Ʈ
insert into tb_bbs(bbsno, wname, subject, content, passwd, grpno, ip)
values(
       (select nvl(max(bbsno),0)+1 from tb_bbs)
      ,'�����'
      ,'���ʽ��ڸ���'
      ,'����ȭ ���� �Ǿ����ϴ�'
      ,'1234'
      ,(select nvl(max(bbsno),0)+1 from tb_bbs)
      ,'127.0.0.1'
);

-- ���
select * from tb_bbs order by grpno desc, ansnum asc;


-- �۸��(bbsList.jsp / list()�Լ�)
select bbsno, wname, subject, readcnt, indent, regdt
from tb_bbs
order by grpno desc, ansnum asc;


-- �󼼺���(bbsRead.jsp / read()�Լ�)
select bbsno, wname, subject, content, readcnt, grpno, ip, regdt
from tb_bbs
where bbsno = ?;


-- ��ȸ�� ����
update tb_bbs
set readcnt = readcnt + 1
where bbsno = ?;

-- �亯����
1) �θ�� ���� �������� (select��)
select grpno, indent, ansnum
from tb_bbs
where bbsno=?

2) �ۼ��� ������ (update��)
update tb_bbs
set ansnum = ansnum+1
where grpno=1 and ansnum>=3

3) �亯�� �߰� (insert��)
insert into tb_bbs(bbsno,wname,subject,content,passwd,ip,grpno,indent,ansnum)
values()


-- ����
delete from tb_bbs
where passwd = ? and bbsno = ?;


-- ����
-- ��й�ȣ�� ��ġ�ϸ� �����ϰ��� �ϴ� ���� �����ͼ�
-- �������� ����ϰ�
-- �ۼ���, ����, ����, ��й�ȣ�� �����Ѵ�

1) bbsUpdate.jsp
   ��й�ȣ �Է��� �ۼ�

2) bbsUpdateForm.jsp
   ��й�ȣ�� �۹�ȣ�� ��ġ�ϴ� ���� DB ��������
   select wname, subject, content, passwd
   from tb_bbs
   where passwd = ? and bbsno = ?

3) 2)�� ������ �������� ���

4) bbsUpdateProc.jsp
   ����ڰ� �ٽ� �Է��� ������ DB���� �����ϱ�
   update tb_bbs
   set wname=?, subject=?, content=?, passwd=?,ip=?
   where bbsno=?
   ������ �Ϸ�Ǹ� ��������� �̵�

-- �˻�
-- ���� ����ȭ �ܾ �ִ� ���ڵ� �˻�
select *
from tb_bbs
where subject like '%����ȭ%';
   
   
-- ����¡
-- rownum(�ٹ�ȣ) Ȱ��

1)
select bbsno, subject, grpno, ansnum
from tb_bbs
order by grpno desc, ansnum asc;

2) rownum �߰�  -- �ٹ�ȣ���� ���ĵ�
select bbsno, subject, grpno, ansnum, rownum
from tb_bbs
order by grpno desc, ansnum asc;

3) 1)�� SQL�� ��������
select AA.bbsno, AA.subject, AA.grpno, AA.ansnum, rownum
from (
      select bbsno, subject, grpno, ansnum
      from tb_bbs
      order by grpno desc, ansnum asc
     ) AA;

4) alias ��������
select bbsno, subject, grpno, ansnum, rownum
from (
      select bbsno, subject, grpno, ansnum
      from tb_bbs
      order by grpno desc, ansnum asc
     );

5) �ٹ�ȣ 1~3 �˻�(1 ������)
select bbsno, subject, grpno, ansnum, rownum
from (
      select bbsno, subject, grpno, ansnum
      from tb_bbs
      order by grpno desc, ansnum asc
     )
where rownum >= 1 and rownum <= 3;


6) �ٹ�ȣ 4~6 �˻�(2 ������) -> �˻��ȵ�
select bbsno, subject, grpno, ansnum, rownum
from (
      select bbsno, subject, grpno, ansnum
      from tb_bbs
      order by grpno desc, ansnum asc
     )
where rownum >= 4 and rownum <= 6;   


7) �ٹ�ȣ 4~6 �˻�(2 ������)
select bbsno, subject, grpno, ansnum, rnum
from (
      select bbsno, subject, grpno, ansnum, rownum as rnum
      from (
            select bbsno, subject, grpno, ansnum
            from tb_bbs
            order by grpno desc, ansnum asc
           ) AA
     )BB     
where rnum >= 4 and rnum <= 6;     
     
     
8) alias ��������
select bbsno, subject, grpno, ansnum, rnum
from (
      select bbsno, subject, grpno, ansnum, rownum as rnum
      from (
            select bbsno, subject, grpno, ansnum
            from tb_bbs
            order by grpno desc, ansnum asc
           ) 
     )     
where rnum >= 4 and rnum <= 6; 


9) ����¡ + �˻�
   ���� '�ֵ���ũ' �˻��ؼ� 2������ ���
select bbsno, subject, grpno, ansnum, rnum
from (
      select bbsno, subject, grpno, ansnum, rownum as rnum
      from (
            select bbsno, subject, grpno, ansnum
            from tb_bbs
            where subject like '%�ֵ���ũ%'
            order by grpno desc, ansnum asc
           ) 
     )     
where rnum >= 4 and rnum <= 6;    
----------------------------------------------
-- [��� ���� ���ϱ�]
-- ��°��
�θ������  �亯����  ��ȸ�� �ۼ��� �ۼ���
�ȳ��ϼ���  (1)  
�迬��      (2)

--1)
select subject, grpno, indent, ansnum
from tb_bbs
order by grpno desc;

--2) grpno�� ������ ���ڵ带 �׷�ȭ�ϰ�
--   ������ ���Ͻÿ�
select grpno, count(grpno) as cnt
from tb_bbs
group by grpno;

--3) 2)���� ���� ������ �θ��+�ڽı� �̹Ƿ�
--   �������� -1�� �Ѵ�
select grpno, count(grpno)-1 as cnt
from tb_bbs
group by grpno;

-- 4) 3)�� �������̺� ���������ؼ�
--    ���� �θ�� ���� ��������
select BB.bbsno, BB.subject, AA.grpno, AA.cnt
from (
      select grpno, count(grpno)-1 as cnt
      from tb_bbs
      group by grpno
     ) AA join tb_bbs BB
on AA.grpno = BB.grpno
where BB.indent = 0 --���� �θ��
order by grpno DESC


-- 5) bbsComment.jsp
--    ��۰����� ��� ����
--    BbsDTOŬ������ private int comment �߰��ϰ�, �� getter, setter�Լ� �߰�
    
select bbsno, subject, wname, readcnt, regdt, grpno, cnt, rnum
from (
      select bbsno, subject, wname, readcnt, regdt, grpno, cnt, rownum as rnum
      from(
           select BB.bbsno, BB.subject, BB.wname, BB.readcnt, BB.regdt, AA.grpno, AA.cnt
           from (
                 select grpno, count(grpno)-1 as cnt
                 from tb_bbs
                 group by grpno
                ) AA join tb_bbs BB
          on AA.grpno = BB.grpno
          where BB.indent = 0
          order by grpno DESC
     )
)
where rnum>=6 and rnum<=10



select bbsno, subject, wname, readcnt, regdt, grpno, cnt, rnum
from (
      select bbsno, subject, wname, readcnt, regdt, grpno, cnt, rownum as rnum
      from(
           select BB.bbsno, BB.subject, BB.wname, BB.readcnt, BB.regdt, AA.grpno, AA.cnt
           from (
                 select grpno, count(grpno)-1 as cnt
                 from tb_bbs
                 group by grpno
                ) AA join tb_bbs BB
          on AA.grpno = BB.grpno
          where BB.indent = 0
          and subject like '%��%'
          order by grpno DESC
     )
)
where rnum>=2 and rnum<=3






























