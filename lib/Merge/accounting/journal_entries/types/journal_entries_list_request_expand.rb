# frozen_string_literal: true

module Merge
  module Accounting
    module JournalEntries
      # @type [Hash{String => String}]
      JOURNAL_ENTRIES_LIST_REQUEST_EXPAND = {
        accounting_period: "accounting_period",
        applied_payments: "applied_payments",
        applied_payments_accounting_period: "applied_payments,accounting_period",
        applied_payments_company: "applied_payments,company",
        applied_payments_company_accounting_period: "applied_payments,company,accounting_period",
        applied_payments_tracking_categories: "applied_payments,tracking_categories",
        applied_payments_tracking_categories_accounting_period: "applied_payments,tracking_categories,accounting_period",
        applied_payments_tracking_categories_company: "applied_payments,tracking_categories,company",
        applied_payments_tracking_categories_company_accounting_period: "applied_payments,tracking_categories,company,accounting_period",
        company: "company",
        company_accounting_period: "company,accounting_period",
        lines: "lines",
        lines_accounting_period: "lines,accounting_period",
        lines_applied_payments: "lines,applied_payments",
        lines_applied_payments_accounting_period: "lines,applied_payments,accounting_period",
        lines_applied_payments_company: "lines,applied_payments,company",
        lines_applied_payments_company_accounting_period: "lines,applied_payments,company,accounting_period",
        lines_applied_payments_tracking_categories: "lines,applied_payments,tracking_categories",
        lines_applied_payments_tracking_categories_accounting_period: "lines,applied_payments,tracking_categories,accounting_period",
        lines_applied_payments_tracking_categories_company: "lines,applied_payments,tracking_categories,company",
        lines_applied_payments_tracking_categories_company_accounting_period: "lines,applied_payments,tracking_categories,company,accounting_period",
        lines_company: "lines,company",
        lines_company_accounting_period: "lines,company,accounting_period",
        lines_payments: "lines,payments",
        lines_payments_accounting_period: "lines,payments,accounting_period",
        lines_payments_applied_payments: "lines,payments,applied_payments",
        lines_payments_applied_payments_accounting_period: "lines,payments,applied_payments,accounting_period",
        lines_payments_applied_payments_company: "lines,payments,applied_payments,company",
        lines_payments_applied_payments_company_accounting_period: "lines,payments,applied_payments,company,accounting_period",
        lines_payments_applied_payments_tracking_categories: "lines,payments,applied_payments,tracking_categories",
        lines_payments_applied_payments_tracking_categories_accounting_period: "lines,payments,applied_payments,tracking_categories,accounting_period",
        lines_payments_applied_payments_tracking_categories_company: "lines,payments,applied_payments,tracking_categories,company",
        lines_payments_applied_payments_tracking_categories_company_accounting_period: "lines,payments,applied_payments,tracking_categories,company,accounting_period",
        lines_payments_company: "lines,payments,company",
        lines_payments_company_accounting_period: "lines,payments,company,accounting_period",
        lines_payments_tracking_categories: "lines,payments,tracking_categories",
        lines_payments_tracking_categories_accounting_period: "lines,payments,tracking_categories,accounting_period",
        lines_payments_tracking_categories_company: "lines,payments,tracking_categories,company",
        lines_payments_tracking_categories_company_accounting_period: "lines,payments,tracking_categories,company,accounting_period",
        lines_tracking_categories: "lines,tracking_categories",
        lines_tracking_categories_accounting_period: "lines,tracking_categories,accounting_period",
        lines_tracking_categories_company: "lines,tracking_categories,company",
        lines_tracking_categories_company_accounting_period: "lines,tracking_categories,company,accounting_period",
        payments: "payments",
        payments_accounting_period: "payments,accounting_period",
        payments_applied_payments: "payments,applied_payments",
        payments_applied_payments_accounting_period: "payments,applied_payments,accounting_period",
        payments_applied_payments_company: "payments,applied_payments,company",
        payments_applied_payments_company_accounting_period: "payments,applied_payments,company,accounting_period",
        payments_applied_payments_tracking_categories: "payments,applied_payments,tracking_categories",
        payments_applied_payments_tracking_categories_accounting_period: "payments,applied_payments,tracking_categories,accounting_period",
        payments_applied_payments_tracking_categories_company: "payments,applied_payments,tracking_categories,company",
        payments_applied_payments_tracking_categories_company_accounting_period: "payments,applied_payments,tracking_categories,company,accounting_period",
        payments_company: "payments,company",
        payments_company_accounting_period: "payments,company,accounting_period",
        payments_tracking_categories: "payments,tracking_categories",
        payments_tracking_categories_accounting_period: "payments,tracking_categories,accounting_period",
        payments_tracking_categories_company: "payments,tracking_categories,company",
        payments_tracking_categories_company_accounting_period: "payments,tracking_categories,company,accounting_period",
        tracking_categories: "tracking_categories",
        tracking_categories_accounting_period: "tracking_categories,accounting_period",
        tracking_categories_company: "tracking_categories,company",
        tracking_categories_company_accounting_period: "tracking_categories,company,accounting_period"
      }.frozen
    end
  end
end
