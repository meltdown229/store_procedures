DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_BALANCE`(IN STORE_ID INT)
BEGIN
DECLARE done INT DEFAULT FALSE;
  DECLARE idValue, amount_value INT;
  DECLARE total INT DEFAULT 0;
  DECLARE cur1 CURSOR FOR SELECT id, AMOUNT FROM CURRENT_ACCOUNT WHERE idStore = STORE_ID;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;
  read_loop: LOOP
    FETCH cur1 INTO idValue, amount_value;
    
    IF done THEN
      LEAVE read_loop;
    END IF;
	SET total = total + amount_value;
    UPDATE CURRENT_ACCOUNT SET BALANCE = total WHERE id = idValue;
  END LOOP;

  CLOSE cur1;

  END$$
DELIMITER ;
