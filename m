Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1B0C64EBC
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 19:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D152C22240
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 19:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbgKTTQp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 14:16:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732258AbgKTTQn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 14:16:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 308AD22240;
        Fri, 20 Nov 2020 19:16:41 +0000 (UTC)
Date:   Fri, 20 Nov 2020 14:16:39 -0500
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
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: linux-next: stall warnings and deadlock on Arm64 (was: [PATCH]
 kfence: Avoid stalling...)
Message-ID: <20201120141639.3896a3c8@gandalf.local.home>
In-Reply-To: <20201120181737.GA3301774@elver.google.com>
References: <20201118225621.GA1770130@elver.google.com>
        <20201118233841.GS1437@paulmck-ThinkPad-P72>
        <20201119125357.GA2084963@elver.google.com>
        <20201119151409.GU1437@paulmck-ThinkPad-P72>
        <20201119170259.GA2134472@elver.google.com>
        <20201119184854.GY1437@paulmck-ThinkPad-P72>
        <20201119193819.GA2601289@elver.google.com>
        <20201119213512.GB1437@paulmck-ThinkPad-P72>
        <20201120141928.GB3120165@elver.google.com>
        <20201120102613.3d18b90e@gandalf.local.home>
        <20201120181737.GA3301774@elver.google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, 20 Nov 2020 19:17:37 +0100
Marco Elver <elver@google.com> wrote:

> > > +++ b/kernel/rcu/Makefile
> > > @@ -3,6 +3,13 @@
> > >  # and is generally not a function of system call inputs.
> > >  KCOV_INSTRUMENT := n
> > >  
> > > +ifdef CONFIG_FUNCTION_TRACER
> > > +CFLAGS_REMOVE_update.o = $(CC_FLAGS_FTRACE)
> > > +CFLAGS_REMOVE_sync.o = $(CC_FLAGS_FTRACE)
> > > +CFLAGS_REMOVE_srcutree.o = $(CC_FLAGS_FTRACE)
> > > +CFLAGS_REMOVE_tree.o = $(CC_FLAGS_FTRACE)
> > > +endif
> > > +  
> > 
> > Can you narrow it down further? That is, do you really need all of the
> > above to stop the stalls?  
> 
> I tried to reduce it to 1 or combinations of 2 files only, but that
> didn't work.

I'm curious if this would help at all?


diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2a52f42f64b6..d020ecefd151 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1094,7 +1094,7 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
  * if the current CPU is not in its idle loop or is in an interrupt or
  * NMI handler, return true.
  */
-bool rcu_is_watching(void)
+notrace bool rcu_is_watching(void)
 {
 	bool ret;
 
Although I don't see it in the recursion list.

-- Steve
