describe "Wallet directive", ->
  controller = null
  $scope = null
  elm = null

  beforeEach ->
    module('app.services')
    module('directives.wallet')

  beforeEach inject(($rootScope, $compile, TransactionModel, WalletModel, CurrencyModel) ->
    $scope = $rootScope.$new()

    @currency = CurrencyModel.getFromIso 'GBP'

    @transactions = [
      new TransactionModel(10, true)
      new TransactionModel(3, false)
      new TransactionModel(5, true)
    ]

    @wallet = new WalletModel(@currency, @transactions)

    $scope.theWallet = @wallet

    elm = angular.element('<wallet wallet="theWallet">')
    $compile(elm)($scope)
    $scope.$digest()
  )

  it "shows formated wallet balance", ->
    total = elm.find('.balance')
    expect(total.length).toBe 1
    expect(total.text()).toBe '12.00'

  it "shows all transactions", ->
    total = elm.find('[transaction-tr-item]')
    expect(total.length).toBe 3
