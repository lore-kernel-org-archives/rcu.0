Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1E4C2D0E4
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 19:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30FF9221FB
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 19:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbgKTT1i (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 14:27:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729489AbgKTT1i (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 14:27:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2C75221F1;
        Fri, 20 Nov 2020 19:27:35 +0000 (UTC)
Date:   Fri, 20 Nov 2020 14:27:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] kfence: Avoid stalling work queue task without
 allocations
Message-ID: <20201120142734.75af5cd6@gandalf.local.home>
In-Reply-To: <20201119125357.GA2084963@elver.google.com>
References: <20201111202153.GT517454@elver.google.com>
        <20201112001129.GD3249@paulmck-ThinkPad-P72>
        <CANpmjNNyZs6NrHPmomC4=9MPEvCy1bFA5R2pRsMhG7=c3LhL_Q@mail.gmail.com>
        <20201112161439.GA2989297@elver.google.com>
        <20201112175406.GF3249@paulmck-ThinkPad-P72>
        <20201113175754.GA6273@paulmck-ThinkPad-P72>
        <20201117105236.GA1964407@elver.google.com>
        <20201117182915.GM1437@paulmck-ThinkPad-P72>
        <20201118225621.GA1770130@elver.google.com>
        <20201118233841.GS1437@paulmck-ThinkPad-P72>
        <20201119125357.GA2084963@elver.google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 19 Nov 2020 13:53:57 +0100
Marco Elver <elver@google.com> wrote:

> Running tests again, along with the function tracer
> Running tests on all trace events:
> Testing all events: 
> BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 12s!

The below patch might be noisy, but can you add it to the kernel that
crashes and see if a particular event causes the issue?

[ note I didn't even compile test. I hope it works ;) ]

Perhaps run it a couple of times to see if it crashes on the same set of
events each time.

-- Steve

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 98d194d8460e..eb1dd9cf77a9 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -773,6 +773,8 @@ static void remove_event_file_dir(struct trace_event_file *file)
 	kmem_cache_free(file_cachep, file);
 }
 
+static int spam;
+
 /*
  * __ftrace_set_clr_event(NULL, NULL, NULL, set) will set/unset all events.
  */
@@ -808,6 +810,8 @@ __ftrace_set_clr_event_nolock(struct trace_array *tr, const char *match,
 		if (event && strcmp(event, name) != 0)
 			continue;
 
+		if (spam)
+			printk("%s event %s\n", set ? "enabling" : "disabling", name);
 		ret = ftrace_event_enable_disable(file, set);
 
 		/*
@@ -3647,6 +3651,7 @@ static __init void event_trace_self_tests(void)
 	pr_info("Running tests on all trace events:\n");
 	pr_info("Testing all events: ");
 
+	spam = 1;
 	ret = __ftrace_set_clr_event(tr, NULL, NULL, NULL, 1);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error enabling all events\n");
@@ -3661,6 +3666,7 @@ static __init void event_trace_self_tests(void)
 		pr_warn("error disabling all events\n");
 		return;
 	}
+	spam = 0;
 
 	pr_cont("OK\n");
 }
