module Cryptoexchange::Exchanges
  module Cryptopia
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        MARKET = Cryptopia::Market
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cryptopia::Market::API_URL}/GetTradePairs"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output['Data']
          market_pairs = []
          pairs.each do |pair|
            base, target = pair['Label'].split('/')
            market_pair = Cryptopia::Models::MarketPair.new
            market_pair.base = base
            market_pair.target = target
            market_pair.market = MARKET::NAME
            market_pairs << market_pair
          end
          market_pairs
        end
      end
    end
  end
end
