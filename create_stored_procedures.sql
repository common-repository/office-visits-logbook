DELIMITER $$
DROP PROCEDURE IF EXISTS `wp_dragonvisitzyx987_getDepartmentList`$$
CREATE PROCEDURE `wp_dragonvisitzyx987_getDepartmentList`(
   IN pagenumber int,
   IN amountperpage int,
   IN myoffset int, 
   IN mysortby varchar(200),
   IN myorder varchar(200),  
   IN searchwords varchar(200),   
   IN departmentstatus int,
   OUT departmenttotalquantity int
)
BEGIN
   declare total int default 0;
   declare whereclause varchar(255) default ''; 
   declare orderbyclause varchar(10000) default '';
   
   set @searchwords = CONCAT('%', searchwords, '%');
   set @amountperpage = amountperpage;
   set @myoffset = myoffset;
   
   set @departmentstatus = 0;
   set @departmentstatus2 = 1;
   if departmentstatus = -1 then set @departmentstatus = 0; set @departmentstatus2 = 1; end if;
   if departmentstatus = 0 then set @departmentstatus = 0; set @departmentstatus2 = 0; end if;
   if departmentstatus = 1 then set @departmentstatus = 1; set @departmentstatus2 = 1; end if;
   
    if searchwords = '' then SET @statement = concat( 'Select count(*) into @departmenttotalquantity from ', ' wp_dragonvisitzyx987_department WHERE status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @departmentstatus, @departmentstatus2;
       DEALLOCATE PREPARE stmt;    
    end if;            
    if searchwords != '' then SET @statement = concat( 'Select count(*) into @departmenttotalquantity from ', ' wp_dragonvisitzyx987_department WHERE name like ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @departmentstatus, @departmentstatus2;
       DEALLOCATE PREPARE stmt;
    end if;  
    
   SET departmenttotalquantity = @departmenttotalquantity;
   
--  ==========================================================================================================================
    
    if myorder = 'asc' && mysortby = 'id' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_department WHERE status IN (?,?) order by id ASC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @departmentstatus, @departmentstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_department WHERE name like ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @departmentstatus, @departmentstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'name' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_department WHERE status IN (?,?) order by name ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @departmentstatus, @departmentstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'name' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_department WHERE name like ? AND status IN (?,?) order by name ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @departmentstatus, @departmentstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
     --   ---------------------------------------------

    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_department WHERE status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @departmentstatus, @departmentstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_department WHERE name like ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @departmentstatus, @departmentstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
    if myorder = 'desc' && mysortby = 'id' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_department WHERE status IN (?,?) order by id DESC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @departmentstatus, @departmentstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_department WHERE name like ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @departmentstatus, @departmentstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'name' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_department WHERE status IN (?,?) order by name DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @departmentstatus, @departmentstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'name' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_department WHERE name like ? AND status IN (?,?) order by name DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @departmentstatus, @departmentstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
     
    --   ---------------------------------------------

    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_department WHERE status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @departmentstatus, @departmentstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_department WHERE name like ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @departmentstatus, @departmentstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
END  $$
DROP PROCEDURE IF EXISTS `wp_dragonvisitzyx987_getLogList`$$
CREATE PROCEDURE `wp_dragonvisitzyx987_getLogList`(
   IN pagenumber int,
   IN amountperpage int,
   IN myoffset int, 
   IN mysortby varchar(200),
   IN myorder varchar(200),  
   IN searchwords varchar(200),   
   IN searchtype varchar(200),
   IN processname varchar(200),
   IN userid int,      
   IN logstatus int,
   OUT logtotalquantity int
)
BEGIN
   declare total int default 0;
   declare whereclause varchar(255) default ''; 
   declare orderbyclause varchar(10000) default '';
   
   set @searchwords = CONCAT('%', searchwords, '%');
   set @searchtype = searchtype;
   set @processname = processname;
   set @userid = userid;   
   set @amountperpage = amountperpage;
   set @myoffset = myoffset;
   
   set @logstatus = 0;
   set @logstatus2 = 1;
   if logstatus = -1 then set @logstatus = 0; set @logstatus2 = 1; end if;
   if logstatus = 0 then set @logstatus = 0; set @logstatus2 = 0; end if;
   if logstatus = 1 then set @logstatus = 1; set @logstatus2 = 1; end if;
   
    if searchwords = '' && searchtype = '' && processname = '' && userid <= 0 then SET @statement = concat( 'Select count(*) into @logtotalquantity from ', ' wp_dragonvisitzyx987_log WHERE status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @logstatus, @logstatus2;
       DEALLOCATE PREPARE stmt;    
    end if;            
    if searchwords != '' && searchtype = '' && processname = '' && userid <= 0 then SET @statement = concat( 'Select count(*) into @logtotalquantity from ', ' wp_dragonvisitzyx987_log WHERE description like ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @logstatus, @logstatus2;
       DEALLOCATE PREPARE stmt;
    end if;  
    
    --  -------------------------
	if searchwords = '' && searchtype != '' && processname = '' && userid <= 0 then SET @statement = concat( 'Select count(*) into @logtotalquantity from ', ' wp_dragonvisitzyx987_log WHERE `type` = ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchtype, @logstatus, @logstatus2;
       DEALLOCATE PREPARE stmt;    
    end if;            
    if searchwords != '' && searchtype != '' && processname = '' && userid <= 0 then SET @statement = concat( 'Select count(*) into @logtotalquantity from ', ' wp_dragonvisitzyx987_log WHERE `type` = ? AND description like ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchtype, @searchwords, @logstatus, @logstatus2;
       DEALLOCATE PREPARE stmt;
    end if; 
    
    
    --   ####################################################################
 
     if searchwords = '' && searchtype = '' && processname != '' && userid <= 0 then SET @statement = concat( 'Select count(*) into @logtotalquantity from ', ' wp_dragonvisitzyx987_log WHERE processname = ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @processname, @logstatus, @logstatus2;
       DEALLOCATE PREPARE stmt;    
    end if;            
    if searchwords != '' && searchtype = '' && processname != '' && userid <= 0 then SET @statement = concat( 'Select count(*) into @logtotalquantity from ', ' wp_dragonvisitzyx987_log WHERE processname = ? AND description like ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @processname, @searchwords, @logstatus, @logstatus2;
       DEALLOCATE PREPARE stmt;
    end if;  
    
    --  -------------------------
	if searchwords = '' && searchtype != '' && processname != '' && userid <= 0 then SET @statement = concat( 'Select count(*) into @logtotalquantity from ', ' wp_dragonvisitzyx987_log WHERE processname = ? AND `type` = ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @processname, @searchtype, @logstatus, @logstatus2;
       DEALLOCATE PREPARE stmt;    
    end if;            
    if searchwords != '' && searchtype != '' && processname != '' && userid <= 0 then SET @statement = concat( 'Select count(*) into @logtotalquantity from ', ' wp_dragonvisitzyx987_log WHERE processname = ? AND `type` = ? AND description like ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @processname, @searchtype, @searchwords, @logstatus, @logstatus2;
       DEALLOCATE PREPARE stmt;
    end if; 
    
    -- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&   
	-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
         
	if searchwords = '' && searchtype = '' && processname = '' && userid > 0 then SET @statement = concat( 'Select count(*) into @logtotalquantity from ', ' wp_dragonvisitzyx987_log WHERE userid = ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @logstatus, @logstatus2;
       DEALLOCATE PREPARE stmt;    
    end if;            
    if searchwords != '' && searchtype = '' && processname = '' && userid > 0 then SET @statement = concat( 'Select count(*) into @logtotalquantity from ', ' wp_dragonvisitzyx987_log WHERE userid = ? AND description like ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @searchwords, @logstatus, @logstatus2;
       DEALLOCATE PREPARE stmt;
    end if;  
    
    --  -------------------------
	if searchwords = '' && searchtype != '' && processname = '' && userid > 0 then SET @statement = concat( 'Select count(*) into @logtotalquantity from ', ' wp_dragonvisitzyx987_log WHERE userid = ? AND `type` = ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @searchtype, @logstatus, @logstatus2;
       DEALLOCATE PREPARE stmt;    
    end if;            
    if searchwords != '' && searchtype != '' && processname = '' && userid > 0 then SET @statement = concat( 'Select count(*) into @logtotalquantity from ', ' wp_dragonvisitzyx987_log WHERE userid = ? AND `type` = ? AND description like ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @searchtype, @searchwords, @logstatus, @logstatus2;
       DEALLOCATE PREPARE stmt;
    end if; 
    
    
    --   ####################################################################
 
	if searchwords = '' && searchtype = '' && processname != '' && userid > 0 then SET @statement = concat( 'Select count(*) into @logtotalquantity from ', ' wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @processname, @logstatus, @logstatus2;
       DEALLOCATE PREPARE stmt;    
    end if;            
    if searchwords != '' && searchtype = '' && processname != '' && userid > 0 then SET @statement = concat( 'Select count(*) into @logtotalquantity from ', ' wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND description like ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @processname, @searchwords, @logstatus, @logstatus2;
       DEALLOCATE PREPARE stmt;
    end if;  
    
    --  -------------------------
	if searchwords = '' && searchtype != '' && processname != '' && userid > 0 then SET @statement = concat( 'Select count(*) into @logtotalquantity from ', ' wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND `type` = ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @processname, @searchtype, @logstatus, @logstatus2;
       DEALLOCATE PREPARE stmt;    
    end if;            
    if searchwords != '' && searchtype != '' && processname != '' && userid > 0 then SET @statement = concat( 'Select count(*) into @logtotalquantity from ', ' wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND `type` = ? AND description like ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @processname, @searchtype, @searchwords, @logstatus, @logstatus2;
       DEALLOCATE PREPARE stmt;
    end if;
         
   SET logtotalquantity = @logtotalquantity;
   
--  ==========================================================================================================================
--  ==========================================================================================================================
    
    if myorder = 'asc' && mysortby = 'id' && searchwords = '' && searchtype = '' && processname = '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE status IN (?,?) order by id ASC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @logstatus, @logstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && searchwords != '' && searchtype = '' && processname = '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE description like ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'type' && searchwords = '' && searchtype = '' && processname = '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE status IN (?,?) order by `type` ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'type' && searchwords != '' && searchtype = '' && processname = '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE description like ? AND status IN (?,?) order by `type` ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
     --   ---------------------------------------------

    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords = '' && searchtype = '' && processname = '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords != '' && searchtype = '' && processname = '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE description like ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
    if myorder = 'desc' && mysortby = 'id' && searchwords = '' && searchtype = '' && processname = '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE status IN (?,?) order by id DESC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @logstatus, @logstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && searchwords != '' && searchtype = '' && processname = '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE description like ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'type' && searchwords = '' && searchtype = '' && processname = '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE status IN (?,?) order by `type` DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'type' && searchwords != '' && searchtype = '' && processname = '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE description like ? AND status IN (?,?) order by `type` DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
     
    --   ---------------------------------------------

    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords = '' && searchtype = '' && processname = '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords != '' && searchtype = '' && processname = '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE description like ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
    --  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	if myorder = 'asc' && mysortby = 'id' && searchwords = '' && searchtype != '' && processname = '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE `type` = ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && searchwords != '' && searchtype != '' && processname = '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE `type` = ? AND description like ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'type' && searchwords = '' && searchtype != '' && processname = '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE `type` = ? AND status IN (?,?) order by `type` ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'type' && searchwords != '' && searchtype != '' && processname = '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE `type` = ? AND description like ? AND status IN (?,?) order by `type` ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
     --   ---------------------------------------------

    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords = '' && searchtype != '' && processname = '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE `type` = ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords != '' && searchtype != '' && processname = '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE `type` = ? AND description like ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
    if myorder = 'desc' && mysortby = 'id' && searchwords = '' && searchtype != '' && processname = '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE `type` = ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && searchwords != '' && searchtype != '' && processname = '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE `type` = ? AND description like ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'type' && searchwords = '' && searchtype != '' && processname = '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE `type` = ? AND status IN (?,?) order by `type` DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'type' && searchwords != '' && searchtype != '' && processname = '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE `type` = ? AND description like ? AND status IN (?,?) order by `type` DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
     
    --   ---------------------------------------------

    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords = '' && searchtype != '' && processname = '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE `type` = ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords != '' && searchtype != '' && processname = '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE `type` = ? AND description like ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
    -- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2
    
    
	if myorder = 'asc' && mysortby = 'id' && searchwords = '' && searchtype = '' && processname != '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @processname, @logstatus, @logstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && searchwords != '' && searchtype = '' && processname != '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND description like ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @processname, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'type' && searchwords = '' && searchtype = '' && processname != '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND status IN (?,?) order by `type` ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @processname, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'type' && searchwords != '' && searchtype = '' && processname != '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND description like ? AND status IN (?,?) order by `type` ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @processname, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
     --   ---------------------------------------------

    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords = '' && searchtype = '' && processname != '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @processname, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords != '' && searchtype = '' && processname != '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND description like ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @processname, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
    if myorder = 'desc' && mysortby = 'id' && searchwords = '' && searchtype = '' && processname != '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @processname, @logstatus, @logstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && searchwords != '' && searchtype = '' && processname != '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND description like ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @processname, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'type' && searchwords = '' && searchtype = '' && processname != '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND status IN (?,?) order by `type` DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @processname, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'type' && searchwords != '' && searchtype = '' && processname != '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND description like ? AND status IN (?,?) order by `type` DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @processname, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
     
    --   ---------------------------------------------

    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords = '' && searchtype = '' && processname != '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @processname, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords != '' && searchtype = '' && processname != '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND description like ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @processname, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
    --  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	if myorder = 'asc' && mysortby = 'id' && searchwords = '' && searchtype != '' && processname != '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND `type` = ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @processname, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && searchwords != '' && searchtype != '' && processname != '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND `type` = ? AND description like ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @processname, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'type' && searchwords = '' && searchtype != '' && processname != '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND `type` = ? AND status IN (?,?) order by `type` ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @processname, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'type' && searchwords != '' && searchtype != '' && processname != '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND `type` = ? AND description like ? AND status IN (?,?) order by `type` ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @processname, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
     --   ---------------------------------------------

    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords = '' && searchtype != '' && processname != '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND `type` = ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @processname, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords != '' && searchtype != '' && processname != '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND `type` = ? AND description like ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @processname, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
    if myorder = 'desc' && mysortby = 'id' && searchwords = '' && searchtype != '' && processname != '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND `type` = ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @processname, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && searchwords != '' && searchtype != '' && processname != '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND `type` = ? AND description like ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @processname, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'type' && searchwords = '' && searchtype != '' && processname != '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND `type` = ? AND status IN (?,?) order by `type` DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @processname, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'type' && searchwords != '' && searchtype != '' && processname != '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND `type` = ? AND description like ? AND status IN (?,?) order by `type` DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @processname, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
     
    --   ---------------------------------------------

    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords = '' && searchtype != '' && processname != '' && userid <= 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND `type` = ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @processname, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords != '' && searchtype != '' && processname != '' && userid <= 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE processname = ? AND `type` = ? AND description like ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @processname, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
    --    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    --    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    --    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    --    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
        
	if myorder = 'asc' && mysortby = 'id' && searchwords = '' && searchtype = '' && processname = '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @logstatus, @logstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && searchwords != '' && searchtype = '' && processname = '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND description like ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'type' && searchwords = '' && searchtype = '' && processname = '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND status IN (?,?) order by `type` ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'type' && searchwords != '' && searchtype = '' && processname = '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND description like ? AND status IN (?,?) order by `type` ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
     --   ---------------------------------------------

    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords = '' && searchtype = '' && processname = '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords != '' && searchtype = '' && processname = '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND description like ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
    if myorder = 'desc' && mysortby = 'id' && searchwords = '' && searchtype = '' && processname = '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @logstatus, @logstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && searchwords != '' && searchtype = '' && processname = '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND description like ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'type' && searchwords = '' && searchtype = '' && processname = '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND status IN (?,?) order by `type` DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'type' && searchwords != '' && searchtype = '' && processname = '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND description like ? AND status IN (?,?) order by `type` DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
     
    --   ---------------------------------------------

    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords = '' && searchtype = '' && processname = '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords != '' && searchtype = '' && processname = '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND description like ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
    --  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	if myorder = 'asc' && mysortby = 'id' && searchwords = '' && searchtype != '' && processname = '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND `type` = ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && searchwords != '' && searchtype != '' && processname = '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND `type` = ? AND description like ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'type' && searchwords = '' && searchtype != '' && processname = '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND `type` = ? AND status IN (?,?) order by `type` ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'type' && searchwords != '' && searchtype != '' && processname = '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND `type` = ? AND description like ? AND status IN (?,?) order by `type` ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
     --   ---------------------------------------------

    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords = '' && searchtype != '' && processname = '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND `type` = ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords != '' && searchtype != '' && processname = '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND `type` = ? AND description like ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
    if myorder = 'desc' && mysortby = 'id' && searchwords = '' && searchtype != '' && processname = '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND `type` = ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && searchwords != '' && searchtype != '' && processname = '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND `type` = ? AND description like ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'type' && searchwords = '' && searchtype != '' && processname = '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND `type` = ? AND status IN (?,?) order by `type` DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'type' && searchwords != '' && searchtype != '' && processname = '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND `type` = ? AND description like ? AND status IN (?,?) order by `type` DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
     
    --   ---------------------------------------------

    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords = '' && searchtype != '' && processname = '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND `type` = ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords != '' && searchtype != '' && processname = '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND `type` = ? AND description like ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
    -- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2    
    
	if myorder = 'asc' && mysortby = 'id' && searchwords = '' && searchtype = '' && processname != '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @processname, @logstatus, @logstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && searchwords != '' && searchtype = '' && processname != '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND description like ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @processname, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'type' && searchwords = '' && searchtype = '' && processname != '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND status IN (?,?) order by `type` ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @processname, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'type' && searchwords != '' && searchtype = '' && processname != '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND description like ? AND status IN (?,?) order by `type` ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @processname, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
     --   ---------------------------------------------

    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords = '' && searchtype = '' && processname != '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @processname, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords != '' && searchtype = '' && processname != '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND description like ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @processname, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
    if myorder = 'desc' && mysortby = 'id' && searchwords = '' && searchtype = '' && processname != '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @processname, @logstatus, @logstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && searchwords != '' && searchtype = '' && processname != '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND description like ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @processname, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'type' && searchwords = '' && searchtype = '' && processname != '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND status IN (?,?) order by `type` DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @processname, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'type' && searchwords != '' && searchtype = '' && processname != '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND description like ? AND status IN (?,?) order by `type` DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @processname, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
     
    --   ---------------------------------------------

    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords = '' && searchtype = '' && processname != '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @processname, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords != '' && searchtype = '' && processname != '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND description like ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @processname, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
    --  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	if myorder = 'asc' && mysortby = 'id' && searchwords = '' && searchtype != '' && processname != '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND `type` = ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @processname, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && searchwords != '' && searchtype != '' && processname != '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND `type` = ? AND description like ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @processname, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'type' && searchwords = '' && searchtype != '' && processname != '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND `type` = ? AND status IN (?,?) order by `type` ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @processname, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'type' && searchwords != '' && searchtype != '' && processname != '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND `type` = ? AND description like ? AND status IN (?,?) order by `type` ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @processname, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
     --   ---------------------------------------------

    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords = '' && searchtype != '' && processname != '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND `type` = ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @processname, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords != '' && searchtype != '' && processname != '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND `type` = ? AND description like ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @processname, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
    if myorder = 'desc' && mysortby = 'id' && searchwords = '' && searchtype != '' && processname != '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND `type` = ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @processname, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && searchwords != '' && searchtype != '' && processname != '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND `type` = ? AND description like ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @processname, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'type' && searchwords = '' && searchtype != '' && processname != '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND `type` = ? AND status IN (?,?) order by `type` DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @processname, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'type' && searchwords != '' && searchtype != '' && processname != '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND `type` = ? AND description like ? AND status IN (?,?) order by `type` DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @processname, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
     
    --   ---------------------------------------------

    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords = '' && searchtype != '' && processname != '' && userid > 0 then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND `type` = ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userid, @processname, @searchtype, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords != '' && searchtype != '' && processname != '' && userid > 0 then SET @statement = 'SELECT * from wp_dragonvisitzyx987_log WHERE userid = ? AND processname = ? AND `type` = ? AND description like ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userid, @processname, @searchtype, @searchwords, @logstatus, @logstatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    
END  $$
DROP PROCEDURE IF EXISTS `wp_dragonvisitzyx987_getRoleList`$$
CREATE PROCEDURE `wp_dragonvisitzyx987_getRoleList`(
   IN pagenumber int,
   IN amountperpage int,
   IN myoffset int, 
   IN mysortby varchar(200),
   IN myorder varchar(200),  
   IN searchwords varchar(200),   
   IN rolestatus int,
   OUT roletotalquantity int
)
BEGIN
   declare total int default 0;
   declare whereclause varchar(255) default ''; 
   declare orderbyclause varchar(10000) default '';
   
   set @searchwords = CONCAT('%', searchwords, '%');
   set @amountperpage = amountperpage;
   set @myoffset = myoffset;
   
   set @rolestatus = 0;
   set @rolestatus2 = 1;
   if rolestatus = -1 then set @rolestatus = 0; set @rolestatus2 = 1; end if;
   if rolestatus = 0 then set @rolestatus = 0; set @rolestatus2 = 0; end if;
   if rolestatus = 1 then set @rolestatus = 1; set @rolestatus2 = 1; end if;
   
    if searchwords = '' then SET @statement = concat( 'Select count(*) into @roletotalquantity from ', ' wp_dragonvisitzyx987_role WHERE status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @rolestatus, @rolestatus2;
       DEALLOCATE PREPARE stmt;    
    end if;            
    if searchwords != '' then SET @statement = concat( 'Select count(*) into @roletotalquantity from ', ' wp_dragonvisitzyx987_role WHERE name like ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @rolestatus, @rolestatus2;
       DEALLOCATE PREPARE stmt;
    end if;  
    
   SET roletotalquantity = @roletotalquantity;
   
--  ==========================================================================================================================
    
    if myorder = 'asc' && mysortby = 'id' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_role WHERE status IN (?,?) order by id ASC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @rolestatus, @rolestatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_role WHERE name like ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @rolestatus, @rolestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'name' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_role WHERE status IN (?,?) order by name ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @rolestatus, @rolestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'name' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_role WHERE name like ? AND status IN (?,?) order by name ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @rolestatus, @rolestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
     --   ---------------------------------------------

    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_role WHERE status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @rolestatus, @rolestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_role WHERE name like ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @rolestatus, @rolestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
    if myorder = 'desc' && mysortby = 'id' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_role WHERE status IN (?,?) order by id DESC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @rolestatus, @rolestatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_role WHERE name like ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @rolestatus, @rolestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'name' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_role WHERE status IN (?,?) order by name DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @rolestatus, @rolestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'name' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_role WHERE name like ? AND status IN (?,?) order by name DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @rolestatus, @rolestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
     
    --   ---------------------------------------------

    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_role WHERE status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @rolestatus, @rolestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_role WHERE name like ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @rolestatus, @rolestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
END  $$
DROP PROCEDURE IF EXISTS `wp_dragonvisitzyx987_getVisitList`$$
CREATE PROCEDURE `wp_dragonvisitzyx987_getVisitList`(
   IN pagenumber int,
   IN amountperpage int,
   IN myoffset int, 
   IN mysortby varchar(200),
   IN myorder varchar(200), 
   IN wpprefix varchar(200), 
   IN userid int,
   IN visittypeid int,
   IN searchname varchar(200),
   IN searchvisitreason varchar(200), 
   IN fromdate date,
   IN todate date,    
   IN visitstatus int,
   OUT visittotalquantity int
)
BEGIN
   declare total int default 0;
   declare whereclause varchar(255) default ''; 
   declare orderbyclause varchar(10000) default '';
   
   set @userid = userid;
   set @visittypeid = visittypeid;
   
   set @searchname = CONCAT('%', searchname, '%');
   set @searchvisitreason = CONCAT('%', searchvisitreason, '%');
   
   set @pagenumber= pagenumber;
   set @amountperpage = amountperpage;
   set @myoffset = myoffset; 
 
   set @fromdate = '1000-01-01';
   set @todate = '9999-12-31';
   if fromdate > '1000-01-01' then set @fromdate = fromdate; end if;
   if todate > '1000-01-01' && todate < '9999-12-31' then set @todate = todate; end if; 
   
   set @visitstatus = 0;
   set @visitstatus2 = 1;
   if visitstatus = -1 then set @visitstatus = 0; set @visitstatus2 = 1; end if;
   if visitstatus = 0 then set @visitstatus = 0; set @visitstatus2 = 0; end if;
   if visitstatus = 1 then set @visitstatus = 1; set @visitstatus2 = 1; end if;

   set @wp_prefix = wpprefix;
   
   set @querypart_count1 =  concat('SELECT count(*) into @visittotalquantity  '
                    ,     ' FROM wp_dragonvisitzyx987_visit AS a '
                    ,     ' left join wp_dragonvisitzyx987_users AS c '								
                    ,     ' ON a.userid = c.userid '
                    ,     ' left join '
                    ,     @wp_prefix
                    ,     'usermeta e '								
                    ,     " ON a.userid = e.user_id AND e.meta_key = 'first_name' "
                    ,     ' left join '
                    ,     @wp_prefix
                    ,     'usermeta e2 '								
                    ,     " ON a.userid = e2.user_id AND e2.meta_key = 'last_name' "
                    ,     ' left join wp_dragonvisitzyx987_type AS y '
                    ,     ' on a.visittypeid = y.id '
                    ,     ' where c.status = 1 AND a.status IN (?,?)  '
                    );
    
    set @querypart_result1 =  concat("SELECT a.*, y.name as visittypename, CASE WHEN y.id IS NULL THEN 0 ELSE FORMAT(time_to_sec(timediff(concat(a.visitdate, ' ' ,a.timeout), concat(a.visitdate, ' ' ,a.timein) )) / 3600, 2) END as 'hours' "
                    ,     " , concat(IFNULL(e.meta_value,''),' ',IFNULL(e2.meta_value,'')) as username, concat(IFNULL(c.firstname,''),' ',IFNULL(c.lastname,'')) as username2  "
                    ,     ' FROM wp_dragonvisitzyx987_visit AS a '
                    ,     ' left join wp_dragonvisitzyx987_users AS c '								
                    ,     ' ON a.userid = c.userid '
                    ,     ' left join '
                    ,     @wp_prefix
                    ,     'usermeta e '								
                    ,     " ON a.userid = e.user_id AND e.meta_key = 'first_name' "
                    ,     ' left join '
                    ,     @wp_prefix
                    ,     'usermeta e2 '								
                    ,     " ON a.userid = e2.user_id AND e2.meta_key = 'last_name' "
                    ,     ' left join wp_dragonvisitzyx987_type AS y '
                    ,     ' on a.visittypeid = y.id '
                    ,     ' where c.status = 1 AND a.status IN (?,?) '
                    );
    
    set  @querypart2 = '';
    if searchname != '' then set @querypart2 = ' AND a.visitorname LIKE ? '; end if;
    
    set  @querypart3 = '';
    if searchvisitreason != '' then set @querypart3 = ' AND a.visitreason LIKE ? '; end if;    
 
    set  @querypart4 = '';
	
    set  @querypart5 = '';
	if visittypeid > 0 then set @querypart5 = ' AND a.visittypeid = ? '; end if;
    
    set  @querypart6 = '';
    if userid > 0 then set @querypart6 = ' AND a.userid = ? '; end if;   
    
    set  @querypart7 =  ' AND a.visitdate >= ? AND a.visitdate <= ?  ';
    set  @querypart8 = '';
      
    if searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @fromdate, @todate;
       DEALLOCATE PREPARE stmt;    
    end if;
    if searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @userid, @fromdate, @todate;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @fromdate, @todate;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @userid, @fromdate, @todate;
       DEALLOCATE PREPARE stmt;    
    end if;   


    if searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @fromdate, @todate;
       DEALLOCATE PREPARE stmt;    
    end if;
    if searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @userid, @fromdate, @todate;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @fromdate, @todate;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate;
       DEALLOCATE PREPARE stmt;    
    end if;    
	
	
    if searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @fromdate, @todate;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @userid, @fromdate, @todate;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @fromdate, @todate;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @userid, @fromdate, @todate;
       DEALLOCATE PREPARE stmt;    
    end if;
    

    if searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @fromdate, @todate;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @userid, @fromdate, @todate;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @fromdate, @todate;
       DEALLOCATE PREPARE stmt;    
    end if;
    if searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate;
       DEALLOCATE PREPARE stmt;    
    end if;    
	  
    --      ///////////////////////////////////////////////////////
   
	
   SET visittotalquantity = @visittotalquantity;
   
   if visittotalquantity > 0 && amountperpage > 0 &&  pagenumber > CEIL(visittotalquantity/amountperpage) then set @myoffset = (CEIL(visittotalquantity/amountperpage) - 1) * @amountperpage;  end if;
--  ==========================================================================================================================
--  ==========================================================================================================================

    if myorder = 'asc' && mysortby = 'id' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.id ASC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by a.id ASC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @userid, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then
       SET @querypart8 = ' order by a.id ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'id' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by a.id ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	
    
    if myorder = 'asc' && mysortby = 'id' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
	   SET @querypart8 = ' order by a.id ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'asc' && mysortby = 'id' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then  
       SET @querypart8 = ' order by a.id ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'asc' && mysortby = 'id' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then  
       SET @querypart8 = ' order by a.id ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'id' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by a.id ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	
	
    if myorder = 'asc' && mysortby = 'id' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.id ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'id' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by a.id ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'id' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.id ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if myorder = 'asc' && mysortby = 'id' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then
	   SET @querypart8 = ' order by a.id ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    

    if myorder = 'asc' && mysortby = 'id' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.id ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'asc' && mysortby = 'id' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by a.id ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'id' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.id ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'asc' && mysortby = 'id' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by a.id ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
    --   ---------------------------------------------
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'userid' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.userid ASC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userid' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by a.userid ASC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @userid, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userid' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then
       SET @querypart8 = ' order by a.userid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'userid' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by a.userid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if; 


    if myorder = 'asc' && mysortby = 'userid' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
	   SET @querypart8 = ' order by a.userid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'asc' && mysortby = 'userid' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then  
       SET @querypart8 = ' order by a.userid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'asc' && mysortby = 'userid' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then  
       SET @querypart8 = ' order by a.userid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'userid' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by a.userid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	

    if myorder = 'asc' && mysortby = 'userid' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.userid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'userid' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by a.userid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'userid' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.userid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if myorder = 'asc' && mysortby = 'userid' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then
	   SET @querypart8 = ' order by a.userid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    

    if myorder = 'asc' && mysortby = 'userid' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.userid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'asc' && mysortby = 'userid' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by a.userid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'userid' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.userid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'asc' && mysortby = 'userid' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by a.userid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    
    --   ---------------------------------------------
    --   ---------------------------------------------

    if myorder = 'asc' && mysortby = 'visitdate' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitdate ASC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'visitdate' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visitdate ASC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @userid, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'visitdate' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then
       SET @querypart8 = ' order by visitdate ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'visitdate' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visitdate ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	

    if myorder = 'asc' && mysortby = 'visitdate' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
	   SET @querypart8 = ' order by visitdate ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'asc' && mysortby = 'visitdate' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then  
       SET @querypart8 = ' order by visitdate ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'asc' && mysortby = 'visitdate' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then  
       SET @querypart8 = ' order by visitdate ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'visitdate' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visitdate ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	

    if myorder = 'asc' && mysortby = 'visitdate' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitdate ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'visitdate' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visitdate ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'visitdate' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitdate ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if myorder = 'asc' && mysortby = 'visitdate' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then
	   SET @querypart8 = ' order by visitdate ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    

    if myorder = 'asc' && mysortby = 'visitdate' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitdate ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'asc' && mysortby = 'visitdate' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visitdate ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'visitdate' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitdate ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'asc' && mysortby = 'visitdate' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visitdate ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
	
    --   ---------------------------------------------
    --   ---------------------------------------------

    if myorder = 'asc' && mysortby = 'visittypeid' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visittypeid ASC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'visittypeid' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visittypeid ASC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @userid, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'visittypeid' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then
       SET @querypart8 = ' order by visittypeid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'visittypeid' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visittypeid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	

    if myorder = 'asc' && mysortby = 'visittypeid' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
	   SET @querypart8 = ' order by visittypeid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'asc' && mysortby = 'visittypeid' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then  
       SET @querypart8 = ' order by visittypeid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'asc' && mysortby = 'visittypeid' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then  
       SET @querypart8 = ' order by visittypeid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'visittypeid' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visittypeid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	

    if myorder = 'asc' && mysortby = 'visittypeid' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visittypeid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'visittypeid' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visittypeid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'visittypeid' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by visittypeid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if myorder = 'asc' && mysortby = 'visittypeid' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then
	   SET @querypart8 = ' order by visittypeid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    

    if myorder = 'asc' && mysortby = 'visittypeid' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visittypeid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'asc' && mysortby = 'visittypeid' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visittypeid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'visittypeid' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by visittypeid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'asc' && mysortby = 'visittypeid' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visittypeid ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   	
	
    --   ---------------------------------------------
    --   ---------------------------------------------

    if myorder = 'asc' && mysortby = 'visitorname' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitorname ASC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'visitorname' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visitorname ASC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @userid, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'visitorname' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then
       SET @querypart8 = ' order by visitorname ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'visitorname' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visitorname ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	

    if myorder = 'asc' && mysortby = 'visitorname' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
	   SET @querypart8 = ' order by visitorname ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'asc' && mysortby = 'visitorname' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then  
       SET @querypart8 = ' order by visitorname ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'asc' && mysortby = 'visitorname' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then  
       SET @querypart8 = ' order by visitorname ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'visitorname' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visitorname ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	

    if myorder = 'asc' && mysortby = 'visitorname' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitorname ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'visitorname' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visitorname ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'visitorname' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitorname ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if myorder = 'asc' && mysortby = 'visitorname' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then
	   SET @querypart8 = ' order by visitorname ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    

    if myorder = 'asc' && mysortby = 'visitorname' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitorname ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'asc' && mysortby = 'visitorname' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visitorname ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'asc' && mysortby = 'visitorname' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitorname ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'asc' && mysortby = 'visitorname' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visitorname ASC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;	
	
	
	
	

    --  ===================================================================  BEGIN OF ORDER DESC ========================================
 
    if myorder = 'desc' && mysortby = 'id' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.id DESC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by a.id DESC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @userid, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then
       SET @querypart8 = ' order by a.id DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'id' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by a.id DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	
	
    if myorder = 'desc' && mysortby = 'id' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
	   SET @querypart8 = ' order by a.id DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'desc' && mysortby = 'id' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then  
       SET @querypart8 = ' order by a.id DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'desc' && mysortby = 'id' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then  
       SET @querypart8 = ' order by a.id DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'id' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by a.id DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	
	
    if myorder = 'desc' && mysortby = 'id' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.id DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'id' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by a.id DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'id' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.id DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if myorder = 'desc' && mysortby = 'id' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then
	   SET @querypart8 = ' order by a.id DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    

    if myorder = 'desc' && mysortby = 'id' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.id DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'id' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by a.id DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'id' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.id DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'desc' && mysortby = 'id' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by a.id DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    
    --   ---------------------------------------------
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'userid' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.userid DESC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userid' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by a.userid DESC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @userid, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userid' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then
       SET @querypart8 = ' order by a.userid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'userid' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by a.userid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	
	
    if myorder = 'desc' && mysortby = 'userid' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
	   SET @querypart8 = ' order by a.userid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'desc' && mysortby = 'userid' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then  
       SET @querypart8 = ' order by a.userid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'desc' && mysortby = 'userid' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then  
       SET @querypart8 = ' order by a.userid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'userid' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by a.userid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	
	
    if myorder = 'desc' && mysortby = 'userid' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.userid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'userid' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by a.userid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'userid' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.userid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if myorder = 'desc' && mysortby = 'userid' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then
	   SET @querypart8 = ' order by a.userid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    
    

    if myorder = 'desc' && mysortby = 'userid' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.userid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'desc' && mysortby = 'userid' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by a.userid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'userid' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by a.userid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'desc' && mysortby = 'userid' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by a.userid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    
    --   ---------------------------------------------
    --   ---------------------------------------------

    if myorder = 'desc' && mysortby = 'visitdate' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitdate DESC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'visitdate' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visitdate DESC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @userid, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'visitdate' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then
       SET @querypart8 = ' order by visitdate DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'visitdate' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visitdate DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	

    if myorder = 'desc' && mysortby = 'visitdate' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
	   SET @querypart8 = ' order by visitdate DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'desc' && mysortby = 'visitdate' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then  
       SET @querypart8 = ' order by visitdate DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'desc' && mysortby = 'visitdate' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then  
       SET @querypart8 = ' order by visitdate DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'visitdate' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visitdate DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	
	
    if myorder = 'desc' && mysortby = 'visitdate' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitdate DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'visitdate' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visitdate DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'visitdate' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitdate DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if myorder = 'desc' && mysortby = 'visitdate' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then
	   SET @querypart8 = ' order by visitdate DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    
    
    if myorder = 'desc' && mysortby = 'visitdate' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitdate DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'desc' && mysortby = 'visitdate' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visitdate DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'visitdate' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitdate DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'desc' && mysortby = 'visitdate' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visitdate DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	
    
    --   ---------------------------------------------
    --   ---------------------------------------------

    if myorder = 'desc' && mysortby = 'visittypeid' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visittypeid DESC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'visittypeid' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visittypeid DESC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @userid, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'visittypeid' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then
       SET @querypart8 = ' order by visittypeid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'visittypeid' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visittypeid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	

    if myorder = 'desc' && mysortby = 'visittypeid' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
	   SET @querypart8 = ' order by visittypeid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'desc' && mysortby = 'visittypeid' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then  
       SET @querypart8 = ' order by visittypeid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'desc' && mysortby = 'visittypeid' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then  
       SET @querypart8 = ' order by visittypeid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'visittypeid' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visittypeid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	
	
    if myorder = 'desc' && mysortby = 'visittypeid' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visittypeid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'visittypeid' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visittypeid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'visittypeid' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by visittypeid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if myorder = 'desc' && mysortby = 'visittypeid' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then
	   SET @querypart8 = ' order by visittypeid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    
    
    if myorder = 'desc' && mysortby = 'visittypeid' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visittypeid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'desc' && mysortby = 'visittypeid' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visittypeid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'visittypeid' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by visittypeid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'desc' && mysortby = 'visittypeid' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visittypeid DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if; 

    
    --   ---------------------------------------------
    --   ---------------------------------------------

    if myorder = 'desc' && mysortby = 'visitorname' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitorname DESC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'visitorname' && searchname = '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visitorname DESC LIMIT ? OFFSET ? ';
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @visitstatus, @visitstatus2, @userid, @fromdate, @todate, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'visitorname' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then
       SET @querypart8 = ' order by visitorname DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'visitorname' && searchname = '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visitorname DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	

    if myorder = 'desc' && mysortby = 'visitorname' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
	   SET @querypart8 = ' order by visitorname DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'desc' && mysortby = 'visitorname' && searchname = '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then  
       SET @querypart8 = ' order by visitorname DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'desc' && mysortby = 'visitorname' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then  
       SET @querypart8 = ' order by visitorname DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'visitorname' && searchname = '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visitorname DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
	
	
    if myorder = 'desc' && mysortby = 'visitorname' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitorname DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'visitorname' && searchname != '' && searchvisitreason = '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visitorname DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'visitorname' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitorname DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if myorder = 'desc' && mysortby = 'visitorname' && searchname != '' && searchvisitreason = '' && visittypeid > 0 && userid > 0 then
	   SET @querypart8 = ' order by visitorname DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    
    
    if myorder = 'desc' && mysortby = 'visitorname' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitorname DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;   
    if myorder = 'desc' && mysortby = 'visitorname' && searchname != '' && searchvisitreason != '' && visittypeid <= 0 && userid > 0 then 
       SET @querypart8 = ' order by visitorname DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if myorder = 'desc' && mysortby = 'visitorname' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid <= 0 then 
       SET @querypart8 = ' order by visitorname DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
    if myorder = 'desc' && mysortby = 'visitorname' && searchname != '' && searchvisitreason != '' && visittypeid > 0 && userid > 0 then 
       SET @querypart8 = ' order by visitorname DESC LIMIT ? OFFSET ? ';
       SET @statement = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5, @querypart6, @querypart7, @querypart8);
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @visitstatus, @visitstatus2, @searchname, @searchvisitreason, @visittypeid, @userid, @fromdate, @todate, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if; 

END  $$
DROP PROCEDURE IF EXISTS `wp_dragonvisitzyx987_getTypecategoryList`$$
CREATE PROCEDURE `wp_dragonvisitzyx987_getTypecategoryList`(
   IN pagenumber int,
   IN amountperpage int,
   IN myoffset int, 
   IN mysortby varchar(200),
   IN myorder varchar(200),  
   IN searchwords varchar(200),   
   IN typecategorystatus int,
   OUT typecategorytotalquantity int
)
BEGIN
   declare total int default 0;
   declare whereclause varchar(255) default ''; 
   declare orderbyclause varchar(10000) default '';
   
   set @searchwords = CONCAT('%', searchwords, '%');
   set @amountperpage = amountperpage;
   set @myoffset = myoffset;
   
   set @typecategorystatus = 0;
   set @typecategorystatus2 = 1;
   if typecategorystatus = -1 then set @typecategorystatus = 0; set @typecategorystatus2 = 1; end if;
   if typecategorystatus = 0 then set @typecategorystatus = 0; set @typecategorystatus2 = 0; end if;
   if typecategorystatus = 1 then set @typecategorystatus = 1; set @typecategorystatus2 = 1; end if;
   
    if searchwords = '' then SET @statement = concat( 'Select count(*) into @typecategorytotalquantity from ', ' wp_dragonvisitzyx987_typecategory WHERE status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @typecategorystatus, @typecategorystatus2;
       DEALLOCATE PREPARE stmt;    
    end if;            
    if searchwords != '' then SET @statement = concat( 'Select count(*) into @typecategorytotalquantity from ', ' wp_dragonvisitzyx987_typecategory WHERE name like ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @typecategorystatus, @typecategorystatus2;
       DEALLOCATE PREPARE stmt;
    end if;  
    
   SET typecategorytotalquantity = @typecategorytotalquantity;
   
--  ==========================================================================================================================
    
    if myorder = 'asc' && mysortby = 'id' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_typecategory WHERE status IN (?,?) order by id ASC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @typecategorystatus, @typecategorystatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_typecategory WHERE name like ? AND status IN (?,?) order by id ASC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @typecategorystatus, @typecategorystatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'name' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_typecategory WHERE status IN (?,?) order by name ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @typecategorystatus, @typecategorystatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'name' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_typecategory WHERE name like ? AND status IN (?,?) order by name ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @typecategorystatus, @typecategorystatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
     --   ---------------------------------------------

    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_typecategory WHERE status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @typecategorystatus, @typecategorystatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_typecategory WHERE name like ? AND status IN (?,?) order by createtimeutc ASC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @typecategorystatus, @typecategorystatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
    if myorder = 'desc' && mysortby = 'id' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_typecategory WHERE status IN (?,?) order by id DESC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @typecategorystatus, @typecategorystatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_typecategory WHERE name like ? AND status IN (?,?) order by id DESC LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @typecategorystatus, @typecategorystatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'name' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_typecategory WHERE status IN (?,?) order by name DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @typecategorystatus, @typecategorystatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'name' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_typecategory WHERE name like ? AND status IN (?,?) order by name DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @typecategorystatus, @typecategorystatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
     
    --   ---------------------------------------------

    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords = '' then SET @sqlv = "SELECT * from wp_dragonvisitzyx987_typecategory WHERE status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @typecategorystatus, @typecategorystatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords != '' then SET @statement = 'SELECT * from wp_dragonvisitzyx987_typecategory WHERE name like ? AND status IN (?,?) order by createtimeutc DESC,id LIMIT ? OFFSET ?'; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @typecategorystatus, @typecategorystatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
END  $$
DROP PROCEDURE IF EXISTS `wp_dragonvisitzyx987_getTypeList`$$
CREATE PROCEDURE `wp_dragonvisitzyx987_getTypeList`(
   IN pagenumber int,
   IN amountperpage int,
   IN myoffset int, 
   IN mysortby varchar(200),
   IN myorder varchar(200),  
   IN searchwords varchar(200),   
   IN typestatus int,
   OUT typetotalquantity int
)
BEGIN
   declare total int default 0;
   declare whereclause varchar(255) default ''; 
   declare orderbyclause varchar(10000) default '';
   
   set @searchwords = CONCAT('%', searchwords, '%');
   set @amountperpage = amountperpage;
   set @myoffset = myoffset;
   
   set @typestatus = 0;
   set @typestatus2 = 1;
   if typestatus = -1 then set @typestatus = 0; set @typestatus2 = 1; end if;
   if typestatus = 0 then set @typestatus = 0; set @typestatus2 = 0; end if;
   if typestatus = 1 then set @typestatus = 1; set @typestatus2 = 1; end if;
   
    if searchwords = '' then SET @statement = concat( 'Select count(*) into @typetotalquantity from ', ' wp_dragonvisitzyx987_type WHERE status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @typestatus, @typestatus2;
       DEALLOCATE PREPARE stmt;    
    end if;            
    if searchwords != '' then SET @statement = concat( 'Select count(*) into @typetotalquantity from ', ' wp_dragonvisitzyx987_type WHERE name like ? AND status IN (?,?)' ); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @typestatus, @typestatus2;
       DEALLOCATE PREPARE stmt;
    end if;  
    
   SET typetotalquantity = @typetotalquantity;
   
--  ==========================================================================================================================
    
    if myorder = 'asc' && mysortby = 'id' && searchwords = '' then SET @sqlv = "SELECT t.*,tc.name 'typecategoryname' from wp_dragonvisitzyx987_type t left join wp_dragonvisitzyx987_typecategory tc ON t.typecategoryid = tc.id  WHERE t.status IN (?,?) order by t.id ASC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @typestatus, @typestatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && searchwords != '' then SET @statement = "SELECT t.*,tc.name 'typecategoryname' from wp_dragonvisitzyx987_type t left join wp_dragonvisitzyx987_typecategory tc ON t.typecategoryid = tc.id WHERE t.name like ? AND t.status IN (?,?) order by t.id ASC LIMIT ? OFFSET ?"; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @typestatus, @typestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'name' && searchwords = '' then SET @sqlv = "SELECT t.*,tc.name 'typecategoryname' from wp_dragonvisitzyx987_type t left join wp_dragonvisitzyx987_typecategory tc ON t.typecategoryid = tc.id WHERE t.status IN (?,?) order by t.name ASC,t.id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @typestatus, @typestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'name' && searchwords != '' then SET @statement = "SELECT t.*,tc.name 'typecategoryname' from wp_dragonvisitzyx987_type t left join wp_dragonvisitzyx987_typecategory tc ON t.typecategoryid = tc.id WHERE t.name like ? AND t.status IN (?,?) order by t.name ASC,t.id LIMIT ? OFFSET ?"; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @typestatus, @typestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
     --   ---------------------------------------------

    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords = '' then SET @sqlv = "SELECT t.*,tc.name 'typecategoryname' from wp_dragonvisitzyx987_type t left join wp_dragonvisitzyx987_typecategory tc ON t.typecategoryid = tc.id WHERE t.status IN (?,?) order by t.createtimeutc ASC,t.id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @typestatus, @typestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'createtimeutc' && searchwords != '' then SET @statement = "SELECT t.*,tc.name 'typecategoryname' from wp_dragonvisitzyx987_type t left join wp_dragonvisitzyx987_typecategory tc ON t.typecategoryid = tc.id WHERE t.name like ? AND t.status IN (?,?) order by t.createtimeutc ASC,t.id LIMIT ? OFFSET ?"; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @typestatus, @typestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;    
    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
    if myorder = 'desc' && mysortby = 'id' && searchwords = '' then SET @sqlv = "SELECT t.*,tc.name 'typecategoryname' from wp_dragonvisitzyx987_type t left join wp_dragonvisitzyx987_typecategory tc ON t.typecategoryid = tc.id WHERE t.status IN (?,?) order by t.id DESC LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @typestatus, @typestatus2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && searchwords != '' then SET @statement = "SELECT t.*,tc.name 'typecategoryname' from wp_dragonvisitzyx987_type t left join wp_dragonvisitzyx987_typecategory tc ON t.typecategoryid = tc.id WHERE t.name like ? AND t.status IN (?,?) order by t.id DESC LIMIT ? OFFSET ?"; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @typestatus, @typestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;
    end if;    
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'name' && searchwords = '' then SET @sqlv = "SELECT t.*,tc.name 'typecategoryname' from wp_dragonvisitzyx987_type t left join wp_dragonvisitzyx987_typecategory tc ON t.typecategoryid = tc.id WHERE t.status IN (?,?) order by t.name DESC,t.id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @typestatus, @typestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'name' && searchwords != '' then SET @statement = "SELECT t.*,tc.name 'typecategoryname' from wp_dragonvisitzyx987_type t left join wp_dragonvisitzyx987_typecategory tc ON t.typecategoryid = tc.id WHERE t.name like ? AND t.status IN (?,?) order by t.name DESC,t.id LIMIT ? OFFSET ?"; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @typestatus, @typestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
     
    --   ---------------------------------------------

    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords = '' then SET @sqlv = "SELECT t.*,tc.name 'typecategoryname' from wp_dragonvisitzyx987_type t left join wp_dragonvisitzyx987_typecategory tc ON t.typecategoryid = tc.id WHERE t.status IN (?,?) order by t.createtimeutc DESC,t.id LIMIT ? OFFSET ?";
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @typestatus, @typestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'createtimeutc' && searchwords != '' then SET @statement = "SELECT t.*,tc.name 'typecategoryname' from wp_dragonvisitzyx987_type t left join wp_dragonvisitzyx987_typecategory tc ON t.typecategoryid = tc.id WHERE t.name like ? AND t.status IN (?,?) order by t.createtimeutc DESC,t.id LIMIT ? OFFSET ?"; 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @searchwords, @typestatus, @typestatus2, @amountperpage, @myoffset;
       DEALLOCATE PREPARE stmt;    
    end if;
END  $$
DROP PROCEDURE IF EXISTS `wp_dragonvisitzyx987_getUserList`$$
CREATE PROCEDURE `wp_dragonvisitzyx987_getUserList`(
   IN pagenumber int,
   IN amountperpage int,
   IN myoffset int, 
   IN mysortby varchar(200),
   IN myorder varchar(200),  
   IN userid int,
   IN searchuserfullname varchar(200),  
   IN searchemail varchar(200),   
   IN reportto int,   
   IN canreadinadminpage int,   
   IN cancreateinadminpage int,
   IN caneditinadminpage int,
   IN canactivateinadminpage int,
   IN candeactivateinadminpage int,
   IN roleid int,
   IN departmentid int,
   IN userstatus int,
   OUT usertotalquantity int
)
BEGIN
   declare total int default 0;
   declare whereclause varchar(255) default ''; 
   declare orderbyclause varchar(10000) default '';
   
   set @userid = userid;
   set @searchuserfullname = CONCAT('%', searchuserfullname, '%');
   set @searchemail = CONCAT('%', searchemail, '%');
   set @amountperpage = amountperpage;
   set @myoffset = myoffset;

   set @reportto = reportto;
   set @canreadinadminpage = canreadinadminpage;
   set @cancreateinadminpage = cancreateinadminpage;
   set @caneditinadminpage = caneditinadminpage;
   set @canactivateinadminpage = canactivateinadminpage;
   set @candeactivateinadminpage = candeactivateinadminpage;
   set @roleid = roleid;
   set @departmentid = departmentid;
 
   set @canreadinadminpage = 0;
   set @canreadinadminpage2 = 1;
   if canreadinadminpage = -1 then set @canreadinadminpage = 0; set @canreadinadminpage2 = 1; end if;
   if canreadinadminpage = 0 then set @canreadinadminpage = 0; set @canreadinadminpage2 = 0; end if;
   if canreadinadminpage = 1 then set @canreadinadminpage = 1; set @canreadinadminpage2 = 1; end if;
   
   set @cancreateinadminpage = 0;
   set @cancreateinadminpage2 = 1;
   if cancreateinadminpage = -1 then set @cancreateinadminpage = 0; set @cancreateinadminpage2 = 1; end if;
   if cancreateinadminpage = 0 then set @cancreateinadminpage = 0; set @cancreateinadminpage2 = 0; end if;
   if cancreateinadminpage = 1 then set @cancreateinadminpage = 1; set @cancreateinadminpage2 = 1; end if;   
   
   set @caneditinadminpage = 0;
   set @caneditinadminpage2 = 1;
   if caneditinadminpage = -1 then set @caneditinadminpage = 0; set @caneditinadminpage2 = 1; end if;
   if caneditinadminpage = 0 then set @caneditinadminpage = 0; set @caneditinadminpage2 = 0; end if;
   if caneditinadminpage = 1 then set @caneditinadminpage = 1; set @caneditinadminpage2 = 1; end if; 
   
   set @canactivateinadminpage = 0;
   set @canactivateinadminpage2 = 1;
   if canactivateinadminpage = -1 then set @canactivateinadminpage = 0; set @canactivateinadminpage2 = 1; end if;
   if canactivateinadminpage = 0 then set @canactivateinadminpage = 0; set @canactivateinadminpage2 = 0; end if;
   if canactivateinadminpage = 1 then set @canactivateinadminpage = 1; set @canactivateinadminpage2 = 1; end if;   
   
   set @candeactivateinadminpage = 0;
   set @candeactivateinadminpage2 = 1;
   if candeactivateinadminpage = -1 then set @candeactivateinadminpage = 0; set @candeactivateinadminpage2 = 1; end if;
   if candeactivateinadminpage = 0 then set @candeactivateinadminpage = 0; set @candeactivateinadminpage2 = 0; end if;
   if candeactivateinadminpage = 1 then set @candeactivateinadminpage = 1; set @candeactivateinadminpage2 = 1; end if;
 
   set @userstatus = 0;
   set @userstatus2 = 1;
   if userstatus = -1 then set @userstatus = 0; set @userstatus2 = 1; end if;
   if userstatus = 0 then set @userstatus = 0; set @userstatus2 = 0; end if;
   if userstatus = 1 then set @userstatus = 1; set @userstatus2 = 1; end if;

   set @querypart_count1 =  concat("Select count(*) into @usertotalquantity from  wp_dragonvisitzyx987_users a WHERE a.status IN (?,?) "
                         , " AND a.canreadinadminpage IN (?,?)  "
                         , " AND a.cancreateinadminpage IN (?,?)  "
                         , " AND a.caneditinadminpage IN (?,?)  "
                         , " AND a.canactivateinadminpage IN (?,?)  "
                         , " AND a.candeactivateinadminpage IN (?,?)  "
   );

	set  @querypart1 = "";
	if userid > 0 then set @querypart1 = " AND userid = ?  "; end if;
 
	set @querypart_count1 =  concat(@querypart_count1, @querypart1);


    set @querypart_result1 = concat("Select a.*,r.name 'rolename',d.name 'departmentname' from  wp_dragonvisitzyx987_users a "
                      , " LEFT JOIN  wp_dragonvisitzyx987_role r "
                      , " ON a.roleid = r.id "
                      , " LEFT JOIN  wp_dragonvisitzyx987_department d "
                      , " ON a.departmentid = d.id "
                      , " WHERE a.status IN (?,?)  "                      
                      , " AND a.canreadinadminpage IN (?,?)  "
                      , " AND a.cancreateinadminpage IN (?,?)  "
                      , " AND a.caneditinadminpage IN (?,?)  "
                      , " AND a.canactivateinadminpage IN (?,?)  "
                      , " AND a.candeactivateinadminpage IN (?,?)  "
    
    );
    set @querypart_result1 =  concat(@querypart_result1, @querypart1);
     
	set  @querypart2 = "";
	if searchuserfullname != '' then set @querypart2 = " AND concat(a.firstname, ' ', a.lastname) like ?  "; end if;
    
 	set  @querypart3 = "";
	if searchemail != '' then set @querypart3 = " AND a.email like ?  "; end if;    

	set  @querypart4 = "";
	if reportto > 0 then set @querypart4 = " AND a.reportto = ?  "; end if;  

	set  @querypart5 = "";
	if roleid > 0 then set @querypart10 = " AND a.roleid = ?  "; end if;
    
	set  @querypart6 = "";
	if departmentid > 0 then set @querypart11 = " AND a.departmentid = ?  "; end if;
    
    if reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2;
       DEALLOCATE PREPARE stmt;    
    end if; 
    if reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname;
       DEALLOCATE PREPARE stmt;    
    end if;
    if reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail;
       DEALLOCATE PREPARE stmt;    
    end if;    
 --   ------------------------------------   
    if reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname;
       DEALLOCATE PREPARE stmt;    
    end if; 
     if reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
    
    --    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&  2  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    
     if reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if; 
    if reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;
    if reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;    
 --   ------------------------------------   
    if reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if; 
     if reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
    
    --    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&   3   &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&   
    
      if reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @roleid;
       DEALLOCATE PREPARE stmt;    
    end if; 
    if reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @roleid;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @roleid;
       DEALLOCATE PREPARE stmt;    
    end if;
    if reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @roleid;
       DEALLOCATE PREPARE stmt;    
    end if;    
 --   ------------------------------------   
    if reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @roleid;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @roleid;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @roleid;
       DEALLOCATE PREPARE stmt;    
    end if; 
     if reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @roleid;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
    
    --    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&   4    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    
    
       if reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @roleid, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if; 
    if reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @roleid, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @roleid, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;
    if reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @roleid, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;    
 --   ------------------------------------   
    if reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @roleid, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @roleid, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @roleid, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if; 
     if reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @roleid, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
    
    --    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&    5    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&   
    
      if reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto;
       DEALLOCATE PREPARE stmt;    
    end if; 
    if reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto;
       DEALLOCATE PREPARE stmt;    
    end if;
    if reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto;
       DEALLOCATE PREPARE stmt;    
    end if;    
 --   ------------------------------------   
    if reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto;
       DEALLOCATE PREPARE stmt;    
    end if; 
     if reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
    
    --    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&   6    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    
        if reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if; 
    if reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;
    if reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;    
 --   ------------------------------------   
    if reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if; 
     if reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
    
    --    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&    7   &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&  
    
        if reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @roleid;
       DEALLOCATE PREPARE stmt;    
    end if; 
    if reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @roleid;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @roleid;
       DEALLOCATE PREPARE stmt;    
    end if;
    if reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @roleid;
       DEALLOCATE PREPARE stmt;    
    end if;    
 --   ------------------------------------   
    if reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @roleid;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @roleid;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @roleid;
       DEALLOCATE PREPARE stmt;    
    end if; 
     if reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @roleid;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
    
    --    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&   8    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    
        if reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @roleid, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if; 
    if reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @roleid, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @roleid, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;
    if reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @roleid, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;    
 --   ------------------------------------   
    if reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @roleid, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;    
    if reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @roleid, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if;     
     if reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @roleid, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if; 
     if reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then SET @statement = concat(@querypart_count1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6); 
       PREPARE stmt FROM @statement;
       EXECUTE stmt using @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @roleid, @departmentid;
       DEALLOCATE PREPARE stmt;    
    end if; 
    
    
    --    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&    
    
    
   SET usertotalquantity = @usertotalquantity;
   
--  ==========================================================================================================================
    
    if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
      if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 

    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
      if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
      if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    
    --    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   2    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
     if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
      if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 

    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
      if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
      if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    
    --    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    3    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
      if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 

    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
      if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
      if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    
    --    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    4    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
     if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
      if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 

    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
      if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'id' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userid' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
      if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userfullname' && reportto <= 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    
    --    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   5    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
        if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
      if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 

    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
      if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
      if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    
    --    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     6   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
         if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
      if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 

    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
      if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
      if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid <= 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    
    --    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   7    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
         if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
      if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 

    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
      if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
      if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid <= 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @roleid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    
    --    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   8    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    
          if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
    if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
      if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'asc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) ASC LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 

    
    --  ===================================================================  BEGIN OF ORDER DESC ========================================
    
      if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'id' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.id desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
    if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userid' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by a.userid desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
    --   ---------------------------------------------
    
      if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
    if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
    if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;  
    if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid > 0 && userid <= 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @searchuserfullname, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if; 
    
   
	if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
	if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname = '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail = '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;    
	if myorder = 'desc' && mysortby = 'userfullname' && reportto > 0 && roleid > 0 && departmentid > 0 && userid > 0 && searchuserfullname != '' && searchemail != '' then 
	   set  @querypart7 = "  order by concat(a.firstname, ' ', a.lastname) desc LIMIT ? OFFSET ? ";
       SET @sqlv = concat(@querypart_result1, @querypart2, @querypart3, @querypart4, @querypart5 ,@querypart6, @querypart7);
	   PREPARE stmt2 FROM @sqlv;
	   EXECUTE stmt2 USING @userstatus, @userstatus2, @canreadinadminpage, @canreadinadminpage2, @cancreateinadminpage, @cancreateinadminpage2, @caneditinadminpage, @caneditinadminpage2, @canactivateinadminpage, @canactivateinadminpage2, @candeactivateinadminpage, @candeactivateinadminpage2, @userid, @searchuserfullname, @searchemail, @reportto, @roleid, @departmentid, @amountperpage, @myoffset; 
       DEALLOCATE PREPARE stmt2;
    end if;
END  $$
DELIMITER ;
--  -------------------------------------------