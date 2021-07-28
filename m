Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E028C4338F
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 18:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B8460EBD
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 18:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhG1Sqy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jul 2021 14:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhG1Sqx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jul 2021 14:46:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9AED60525;
        Wed, 28 Jul 2021 18:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627498012;
        bh=NKJbhxmMOqMCPTL76obCjz7j4ZD4POIz1bmbEEYmy0c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SklSWf6nsk3JCyTbApZ4qejIXiE0wmxjoRe6DT9XgcXFl0qKBP4WydO9Sej8+kDUE
         POcBogujKoIf/SDs7hFTHc5U9eGNmvO3bzSxTYH2PR8hb4bNGyDyG0KlvR7gRhWRlB
         EWVwAVD1DL932OQkUxLFmrMMCDrrEN4S16DoL/FXeVUc77sitgDVZjCvWkGRYnruNr
         dmhxzLPPVOYfl6VQl7efcTuhdYuz/9ZnZXjCZ3WElTg4xeWJzaUHAK+/ozRwaIds0G
         7T/+t42oNJgrvngT3oesVyiNcMc+1g3jIO4/73CFq2C2tE8i2bj9RJ1Uxczyu5MMSs
         jS69xWB7Z3ung==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BE40E5C048D; Wed, 28 Jul 2021 11:46:51 -0700 (PDT)
Date:   Wed, 28 Jul 2021 11:46:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and updates
Message-ID: <20210728184651.GJ4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org>
 <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wjwZzi=Lqsre8C8C4YJiVQNdNnco7jkLq=ohePSPA9JCA@mail.gmail.com>
 <1810346528.8990.1627495925037.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1810346528.8990.1627495925037.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 28, 2021 at 02:12:05PM -0400, Mathieu Desnoyers wrote:
> ----- On Jul 28, 2021, at 1:58 PM, Linus Torvalds torvalds@linux-foundation.org wrote:
> 
> > On Wed, Jul 28, 2021 at 10:37 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>
> >> +/*
> >> + * Increment the current CPU's rcu_data structure's ->dynticks field
> >> + * with ordering.  Return the new value.
> >> + */
> >> +static noinstr unsigned long rcu_dynticks_inc(int incby)
> >> +{
> >> +       return arch_atomic_add_return(incby, this_cpu_ptr(&rcu_data.dynticks));
> >> +}
> > 
> > Maybe inline?
> > 
> > But more I reacted to how we sadly don't have percpu atomics. They'd
> > be fairly easy to add on x86, but I guess it's not a huge deal.
> 
> Are the percpu atomics you have in mind different from what is found in
> Documentation/core-api/this_cpu_ops.rst ?
> 
> Namely this_cpu_add_return(pcp, val) in this case.
> 
> I must be missing something subtle because AFAIU those are already
> available. Those per-cpu atomics don't provide any memory ordering
> though, which may be why those are not used here.

Good point, but this code does indeed need the ordering.  It also must
support the occasional off-CPU access.

							Thanx, Paul
