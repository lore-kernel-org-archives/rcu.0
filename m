Return-Path: <SRS0=/mld=CU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D4BC433E2
	for <rcu@archiver.kernel.org>; Fri, 11 Sep 2020 04:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E053A221E8
	for <rcu@archiver.kernel.org>; Fri, 11 Sep 2020 04:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599799038;
	bh=JoKwh3qJRTbkpXb29zLQsepECW/mXTdadxrZ5Cy/rWU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ltxBw84VuPWVHMf3fn6KNQhbXnvPQ/z921buzU2/rO4AqoorYgzmkcMrmhYgq23PK
	 oS80BgUDG2v+HrUwNYv8JZ3WsmpYIbubyihAO5VkFimkE3KTsxkLH7COW9Wn3g1qis
	 pp6tRYk9GtiNl2s48xs+VKPAGRAB8aC7Z5ayD62s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgIKEhS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 11 Sep 2020 00:37:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgIKEhK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 11 Sep 2020 00:37:10 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E00B221E7;
        Fri, 11 Sep 2020 04:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599799030;
        bh=JoKwh3qJRTbkpXb29zLQsepECW/mXTdadxrZ5Cy/rWU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sMmGkDvVrjiz4rR868arhRuUIpkNr7QfTtdszWewk1mHMDVPYU0SvtkVrIi0YzRMU
         eupPSaIYpZbxuBOIr8PKtAnDb30LSbuf09BaiTdSAt76tMNRNpjtohPHTJ5B7Fd42D
         hUmTHqi4ojct/WE85x3D9UBqtLZ8gzYnPsVgQ6nE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F09BB3522DD2; Thu, 10 Sep 2020 21:37:09 -0700 (PDT)
Date:   Thu, 10 Sep 2020 21:37:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, dipankar@in.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@redhat.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH RFC tip/core/rcu 4/4] rcu-tasks: Shorten per-grace-period
 sleep for RCU Tasks Trace
Message-ID: <20200911043709.GV29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200910201956.GA24190@paulmck-ThinkPad-P72>
 <20200910202052.5073-4-paulmck@kernel.org>
 <CAADnVQK4Rgrzq+cUKCMkr5anZF+UbHmAc7-FH4BjA23aMM03rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQK4Rgrzq+cUKCMkr5anZF+UbHmAc7-FH4BjA23aMM03rQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 10, 2020 at 08:18:01PM -0700, Alexei Starovoitov wrote:
> On Thu, Sep 10, 2020 at 1:20 PM <paulmck@kernel.org> wrote:
> >
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> >
> > The various RCU tasks flavors currently wait 100 milliseconds between each
> > grace period in order to prevent CPU-bound loops and to favor efficiency
> > over latency.  However, RCU Tasks Trace needs to have a grace-period
> > latency of roughly 25 milliseconds, which is completely infeasible given
> > the 100-millisecond per-grace-period sleep.  This commit therefore reduces
> > this sleep duration to 5 milliseconds (or one jiffy, whichever is longer)
> > in kernels built with CONFIG_TASKS_TRACE_RCU_READ_MB=y.
> 
> The commit log is either misleading or wrong?
> If I read the code correctly in CONFIG_TASKS_TRACE_RCU_READ_MB=y
> case the existing HZ/10 "paranoid sleep" is preserved.

Yes, for CONFIG_TASKS_TRACE_RCU_READ_MB=y, the previous 100-millisecond
"paranoid sleep" is preserved.  Preserving previous behavior is of course
especially important for rcupdate.rcu_task_ipi_delay, given that real-time
applications are degraded by IPIs.  And given that we are avoiding IPIs
in this case, speeding up the polling is not all that helpful.

> It's for the MB=n case it is reduced to HZ/200.

Yes, that is, to roughly 5 milliseconds for large HZ or to one jiffy
for HZ<200.  Here, we send IPIs much more aggressively, so polling
more frequently does help a lot.

> Also I don't understand why you're talking about milliseconds but
> all numbers are HZ based. HZ/10 gives different number of
> milliseconds depending on HZ.

As long as HZ is 10 or greater, HZ/10 jiffies is roughly 100 milliseconds.
In the unlikely event that HZ is less than 10, the code clamps to one
jiffy.  Since schedule_timeout_idle() sleep time is specified in jiffies,
it all works out.

							Thanx, Paul
