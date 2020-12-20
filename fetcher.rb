require "faraday"
require "faraday_middleware"
require "pry"

class Fetcher
  ALGORITHMS_URL = "https://leetcode.com/api/problems/algorithms/"
  GRAPHQL_URL = "https://leetcode.com/graphql"
  QUESTION_QUERY_STRING = <<~QUERY
  query questionData($titleSlug: String!) {
    question(titleSlug: $titleSlug) {
      content
      stats
      codeDefinition
      sampleTestCase
      metaData
    }
  }
  QUERY
  QUESTION_QUERY_OPERATION = "questionData"

  class PaidOnlyError < StandardError; end

  def self.run(id)
    new.run(id)
  end

  def client
    @client ||= Faraday.new do |faraday|
      faraday.request :json
      faraday.response :json, content_type: /\bjson$/
      faraday.options.timeout = 1
      faraday.adapter Faraday.default_adapter
    end
  end

  def run(id)
    id = id.to_i
    meta = algorithms["stat_status_pairs"].find do |x|
      x["stat"]["frontend_question_id"] == id
    end

    raise PaidOnlyError if meta["paid_only"]

    title_slug = meta["stat"]["question__title_slug"]
    problem = query(title_slug)
    question = problem["data"]["question"]
    {
      title: meta["stat"]["question__title"],
      title_slug: title_slug,
      content: question["content"],
      code_definition: JSON.parse(question["codeDefinition"]),
      sample_test_case: question["sampleTestCase"],
      difficulty: level_to_string(meta["difficulty"]["level"]),
      question_id: id,
      return_type: JSON.parse(question["metaData"])["return"]["type"]
    }
  end

  private

  def algorithms
    res = client.get(ALGORITHMS_URL)
    JSON.parse(res.body)
  end

  def query(title_slug)
    payload = {
      operationName: QUESTION_QUERY_OPERATION,
      variables: { titleSlug: title_slug },
      query: QUESTION_QUERY_STRING
    }
    res = client.post(GRAPHQL_URL, payload)
    res.body
  end

  def level_to_string(level)
    case level
    when 1 then "Easy"
    when 2 then "Medium"
    when 3 then "Hard"
    else
      "Unknown"
    end
  end
end
