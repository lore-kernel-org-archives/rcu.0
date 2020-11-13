Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6044CC388F7
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 17:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12198221EB
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 17:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+E3WoS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgKMR54 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 12:57:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:54392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgKMR5z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 12:57:55 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F5A6208D5;
        Fri, 13 Nov 2020 17:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605290274;
        bh=SPs6ifdr8H4sMKD7ax8Sx6hzwFG4f+SmdudJwla/AAk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l+E3WoS3zzxVRAuAt1Dro8+KxAduqsliRUf/i4u9RcbveIlUEvlzRAYv0H4v0t5TM
         S7TXa5flyp+i/Gg7uImRgq36p+Cxphb4t0TdcayxoIm3j1qD6DL8Kja1+NAfJSMLEL
         VS9Y3NA3dfrIXdyc1vkm5e3GlMNmW+r3b8mWsX9M=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4C48D35212DC; Fri, 13 Nov 2020 09:57:54 -0800 (PST)
Date:   Fri, 13 Nov 2020 09:57:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20201113175754.GA6273@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201111133813.GA81547@elver.google.com>
 <20201111130543.27d29462@gandalf.local.home>
 <20201111182333.GA3249@paulmck-ThinkPad-P72>
 <20201111183430.GN517454@elver.google.com>
 <20201111192123.GB3249@paulmck-ThinkPad-P72>
 <20201111202153.GT517454@elver.google.com>
 <20201112001129.GD3249@paulmck-ThinkPad-P72>
 <CANpmjNNyZs6NrHPmomC4=9MPEvCy1bFA5R2pRsMhG7=c3LhL_Q@mail.gmail.com>
 <20201112161439.GA2989297@elver.google.com>
 <20201112175406.GF3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112175406.GF3249@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 12, 2020 at 09:54:06AM -0800, Paul E. McKenney wrote:
> On Thu, Nov 12, 2020 at 05:14:39PM +0100, Marco Elver wrote:

[ . . . ]

> > | [  334.160218] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 15s!
> 
> It might be instructive to cause this code to provoke a backtrace.
> I suggest adding something like "trigger_single_cpu_backtrace(cpu)"
> in kernel/workqueue.c's function named wq_watchdog_timer_fn()
> somewhere within its "if" statement that is preceded with the "did we
> stall?" comment.  Or just search for "BUG: workqueue lockup - pool"
> within kernel/workqueue.c.

And I did get a small but unexpected gift of time, so here is an
(untested) patch.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 437935e..f3d4ff7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5792,6 +5792,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 			pr_cont_pool_info(pool);
 			pr_cont(" stuck for %us!\n",
 				jiffies_to_msecs(jiffies - pool_ts) / 1000);
+			trigger_single_cpu_backtrace(cpu);
 		}
 	}
 
