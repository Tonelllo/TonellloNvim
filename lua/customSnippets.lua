local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
ls.add_snippets("pddl", {
    s("domain", {
        t("(define (domain "),
        i(1, "domain_name"),
        t({
            ")",
            ";remove requirements that are not needed",
            "(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)",
            "",
            "(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle",
            ")",
            "",
            "; un-comment following line if constants are needed",
            ";(:constants )",
            "",
            "(:predicates ;todo: define predicates here",
            ")",
            "",
            "",
            "(:functions ;todo: define numeric functions here",
            ")",
            "",
            ";define actions here" }),
        i(0),
        t({ "", ")" })
    }),
    s("problem", {
        t("define (problem "),
        i(1, "problem_name"),
        t(
            {
                ")",
                "(:domain "
            }
        ),
        i(2, "domain_name"),
        t({
            ")",
            "(:objects"
        }),
        i(0),
        t({
            ")",
            "",
            "(:init",
            "    ;todo: put the initial state's facts and numeric values here",
            ")",
            "",
            "(:goal (and",
            "    ;todo: put the goal condition here",
            "))",
            "",
            ")"
        })
    }),
    s("action", {
        t("(:action "),
        i(1, "action_name"),
        t({ "", ":parameters("}),
        i(0),
        t({
            ")",
            ":precondition()",
            ":effect())"
        })
    })
})
