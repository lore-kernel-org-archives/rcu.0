Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548A6C433E6
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 18:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F243164EB4
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 18:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbhBRSvd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Feb 2021 13:51:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232148AbhBRRBa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Feb 2021 12:01:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 144A664EAD;
        Thu, 18 Feb 2021 17:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613667613;
        bh=C2Q2A6xK2pXxBF2R4D9s6R+6WKEgFr9lF8/c0g3uuTo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gdGgjuAP7wg2mwleIKannzSuJ2Vsmzd7pgMNW1JflyOiquYEv0GRqGhvAx9137H4W
         zt/215TF1JthzqZW72Kl71pt+hBmrCReBFWLjMklA9sFwJwCnmif8UHum7AcidfQZY
         CXVZ/Yy6VlrV/TSLfeOsIvM1ggR38kbylsmj/iLCrMXZQf3UhIiLhtdnk7TTIXgrQe
         nAQtWbfPfpbBk6vQWBsn1IL2SiFDulZHp58RIhq53y5tAkBWSxsoCA5sF4rtDCPO4u
         BUW1wUMH3nUQgGYVAn9KTzhFdNF8Esq9JBX03NMcY3h9gMLpBbcUbgqzxqBvkMy0KJ
         tc/R7wEa9xTXA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BC19B35226A0; Thu, 18 Feb 2021 09:00:12 -0800 (PST)
Date:   Thu, 18 Feb 2021 09:00:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Sangmoon Kim <sangmoon.kim@samsung.com>,
        neeraju <neeraju@codeaurora.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rcu/tree: Add a trace event for RCU stall warnings
Message-ID: <20210218170012.GS2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <bf80e296-14bf-6f36-8952-416829d30e5a@codeaurora.org>
 <CGME20210218130056epcas1p21e5b2e873f8c3cb0aa6953473d4c416c@epcas1p2.samsung.com>
 <20210218125224.23739-1-sangmoon.kim@samsung.com>
 <1181485573.26616.1613657821155.JavaMail.zimbra@efficios.com>
 <20210218150628.GN2743@paulmck-ThinkPad-P72>
 <1315011925.26877.1613663453242.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1315011925.26877.1613663453242.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Feb 18, 2021 at 10:50:53AM -0500, Mathieu Desnoyers wrote:
> ----- On Feb 18, 2021, at 10:06 AM, paulmck paulmck@kernel.org wrote:
> 
> > On Thu, Feb 18, 2021 at 09:17:01AM -0500, Mathieu Desnoyers wrote:
> >> ----- On Feb 18, 2021, at 7:52 AM, Sangmoon Kim sangmoon.kim@samsung.com wrote:
> >> 
> >> >> -----Original Message-----
> >> >> From: neeraju=codeaurora.org@mg.codeaurora.org
> >> >> <neeraju=codeaurora.org@mg.codeaurora.org>
> >> >> Sent: Thursday, February 18, 2021 3:18 AM
> >> >> 
> >> >> Hi Sangmoon,
> >> >> 
> >> >> On 2/17/2021 7:19 PM, Sangmoon Kim wrote:
> >> >> >> -----Original Message-----
> >> >> >> From: Paul E. McKenney <paulmck@kernel.org>
> >> >> >> Sent: Wednesday, February 17, 2021 2:50 AM
> >> >> >>
> >> >> >> On Mon, Feb 15, 2021 at 05:53:25PM +0900, Sangmoon Kim wrote:
> >> >> >>> The event allows us to trace the RCU stall when
> >> >> >>> sysctl_panic_on_rcu_stall is disabled.
> >> >> >>>
> >> >> >>> The first parameter is the name of RCU flavour like other trace
> >> >> >>> events. The second one shows us which function detected stalls.
> >> >> >>>
> >> >> >>> The RCU stall is mainly caused by external factors such as interrupt
> >> >> >>> handling or task scheduling or something else. Therefore, this event
> >> >> >>> uses TRACE_EVENT macro, not dedicated one, so that someone interested
> >> >> >>> in the RCU stall can use it without CONFIG_RCU_TRACE.
> >> >> >>>
> >> >> >>> Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
> >> >> >>
> >> >> >> The patch looks plausible, but I have to ask...  Why not instead just
> >> >> >> get the existing information out of the console log?
> >> >> >>
> >> >> >> 							Thanx, Paul
> >> >> >
> >> >> > This can provide a trigger point for the RCU stall warning.
> >> >> > If a module in the kernel wants to trace the stall for debugging purposes,
> >> >> > there is a cost of continuing to parse the console log.
> >> >> > This tracepoint is useful because it is hard to pay these costs
> >> >> > especially on mobile devices.
> >> >> >
> >> >> > Thanks,
> >> >> > Sangmoon
> >> >> >
> >> >> 
> >> >> So, the idea here is to register to these trace events from kernel
> >> >> module and use that for debugging? Just curious what debugging action
> >> >> module does on these traces, as they have limited information
> >> >> about the stall, compared to console stall warnings, which gives a
> >> >> much more detailed information about stall.
> >> >> 
> >> >> 
> >> >> Thanks
> >> >> Neeraj
> >> > 
> >> > Hi Neeraj,
> >> > 
> >> > Yes, a module can log the stall occurence using the trace, although
> >> > there is no detailed information. If the kernel panic occurs for some
> >> > reasons, the debugging report generated by the module can include that
> >> > RCU stall warning has occurred before.
> >> > 
> >> > In addition, it's just an idea now, when a trace event happens, the
> >> > module can store the console log including detailed information, or may
> >> > also obtain CPU/task information by parsing the console log.
> >> 
> >> Adding a new tracepoint is not just about what is extracted by this specific
> >> tracepoint, but rather how it can be analyzed when combined with all other
> >> relevant
> >> tracepoints.
> >> 
> >> For instance, if we have this added RCU stall warning added, here is how it can
> >> be
> >> used with the upcoming LTTng 2.13, which implements the "event notification"
> >> triggers
> >> feature:
> >> 
> >> 1) Setup "flight recorder" (snapshot) tracing to trace into a circular ring
> >> buffer,
> >>    enabling the following tracepoints:
> >>    - kernel activity (meaning all other RCU event, scheduling, irq, workqueues,
> >>    ...),
> >>    - this new RCU stall warning event.
> >> 
> >> 2) Add a "callstack-kernel" context to the RCU stall warning event. This will
> >> sample
> >>    the kernel stack when the event is hit. This will provide information similar to
> >>    the stack trace gathered into the console log on OOPS.
> >> 
> >> 3) Enable a trigger waiting on the RCU stall warning tracepoint to be hit. On
> >> this
> >>    trigger, actions can be associated, such as capturing a snapshot or waking up
> >>    an external user-space process to perform specific actions.
> >> 
> >> So you end up with a snapshot containing the sequence of events leading to the
> >> RCU stall warning, with a kernel stack trace of the context causing the stall
> >> warning to be emitted.
> >> 
> >> I would argue that this information is more complete than just the stack trace
> >> extracted through the console log.
> > 
> > I am not so sure about that.  RCU CPU stall warnings dump quite a bit more
> > than a stack trace to the console.  Which is why I am concerned about the
> > proverbial camel's nose in the tent.  ;-)
> > 
> > So Sangmoon, what is it that you really need for this to be useful to you?
> > 
> > Or am I missing your point?  (Either Mathieu's or Sangmoon's.)
> 
> Well there is a tracepoint to dump the console's content into the tracing buffers
> as well, so technically this existing RCU stall warning information could be extracted
> into a trace as well.
> 
> AFAIU, what the new "rcu stall warning" tracepoint provides is an easy way to hook on a specific
> event to trigger trace capture, without requiring to parse the console log continuously,
> and a way to know when the stall warning happens in time within the trace time-line.
> 
> That being said, there may be use-cases for extracting more details about the RCU stall
> as tracepoint event fields to make it more convenient, but it does not appear to be
> necessary considered that the console can be saved into trace buffers as well.

OK, I will bite.  ;-)

Can the saving of console into trace buffers be easily enabled and
disabled within the code?  If so, does enabling and disabling nest?

							Thanx, Paul
