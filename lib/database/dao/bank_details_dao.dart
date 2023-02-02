import 'package:floor/floor.dart';
import 'package:flutter_room_database_and_share_preferance/database/entity/bank_details.dart';

@dao
abstract class BankDetailsDao{

  @Query('SELECT * FROM BankDetails')
  Future<List<BankDetails>> getAllBanks();

  @Query('SELECT * FROM BankDetails')
  Stream<List<BankDetails>> getAllBanksAsStream();

  @insert
  Future<void> saveBankDetails(List<BankDetails> bankDetails);

  @insert
  Future<void> saveBankDetail(BankDetails bankDetails);

  /*@Query("SELECT * FROM bank_details")
  fun getAllBanks(): List<BankDetails>

  @Insert(onConflict = OnConflictStrategy.REPLACE)
  @WorkerThread
  fun saveBankDetails(bankDetails: ArrayList<BankDetails>)

  @Update(onConflict = OnConflictStrategy.REPLACE)
  @WorkerThread
  fun updateBankDetails(bankDetails: ArrayList<BankDetails>)

  @Query("DELETE FROM bank_details")
  fun deleteAll()

  suspend fun insertOrUpdate(bankDetails: ArrayList<BankDetails>){
  val dataList = getAllBanks()
  if(dataList.isEmpty())
  saveBankDetails(bankDetails)
  else{
  deleteAll()
  saveBankDetails(bankDetails)
  }
  }

  @Query("Select * from bank_details where bank_name LIKE '%'||:stringQuery||'%'")
  fun searchBankByName(stringQuery:String):List<BankDetails>*/

}