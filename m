Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7A1C56202
	for <rcu@archiver.kernel.org>; Mon, 23 Nov 2020 16:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F7620665
	for <rcu@archiver.kernel.org>; Mon, 23 Nov 2020 16:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbgKWQ2R (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:28:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732677AbgKWQ2R (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 23 Nov 2020 11:28:17 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7106E20644;
        Mon, 23 Nov 2020 16:28:14 +0000 (UTC)
Date:   Mon, 23 Nov 2020 11:28:12 -0500
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
Message-ID: <20201123112812.19e918b3@gandalf.local.home>
In-Reply-To: <20201123152720.GA2177956@elver.google.com>
References: <CANpmjNNyZs6NrHPmomC4=9MPEvCy1bFA5R2pRsMhG7=c3LhL_Q@mail.gmail.com>
        <20201112161439.GA2989297@elver.google.com>
        <20201112175406.GF3249@paulmck-ThinkPad-P72>
        <20201113175754.GA6273@paulmck-ThinkPad-P72>
        <20201117105236.GA1964407@elver.google.com>
        <20201117182915.GM1437@paulmck-ThinkPad-P72>
        <20201118225621.GA1770130@elver.google.com>
        <20201118233841.GS1437@paulmck-ThinkPad-P72>
        <20201119125357.GA2084963@elver.google.com>
        <20201120142734.75af5cd6@gandalf.local.home>
        <20201123152720.GA2177956@elver.google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, 23 Nov 2020 16:27:20 +0100
Marco Elver <elver@google.com> wrote:

> On Fri, Nov 20, 2020 at 02:27PM -0500, Steven Rostedt wrote:
> > On Thu, 19 Nov 2020 13:53:57 +0100
> > Marco Elver <elver@google.com> wrote:
> >   
> > > Running tests again, along with the function tracer
> > > Running tests on all trace events:
> > > Testing all events: 
> > > BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 12s!  
> > 
> > The below patch might be noisy, but can you add it to the kernel that
> > crashes and see if a particular event causes the issue?
> > 
> > [ note I didn't even compile test. I hope it works ;) ]
> > 
> > Perhaps run it a couple of times to see if it crashes on the same set of
> > events each time.  
> 
> Thanks! I have attached the logs of 2 runs. I think one problem here is
> that the enabling of an event doesn't immediately trigger the problem,
> so it's hard to say which one caused it.
> 

I noticed:


[  237.650900] enabling event benchmark_event

In both traces. Could you disable CONFIG_TRACEPOINT_BENCHMARK and see if
the issue goes away. That event kicks off a thread that spins in a tight
loop for some time and could possibly cause some issues.

It still shouldn't break things, we can narrow it down if it is the culprit.

-- Steve
