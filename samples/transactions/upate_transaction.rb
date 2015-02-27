transaction =  Paymill::Transaction.find('tran_023d3b5769321c649435')
transaction.description = 'My updated transaction description'
transaction.update
