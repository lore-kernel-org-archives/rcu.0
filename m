Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8732EC433E9
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 18:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ABE164EB8
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 18:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbhBRSvi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Feb 2021 13:51:38 -0500
Received: from mail.efficios.com ([167.114.26.124]:42142 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbhBRR5Y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Feb 2021 12:57:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F360129CBB5;
        Thu, 18 Feb 2021 12:56:39 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oUT7F8VVIHeq; Thu, 18 Feb 2021 12:56:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7328229CE29;
        Thu, 18 Feb 2021 12:56:39 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7328229CE29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1613670999;
        bh=EmgeRRKdAfsZDuYNKsi4+NSJbSwMwrWmNnBmpeohHVM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=gMtwiTEYUe4rxpUpDSHrpu3WR9P4bgoUXsVkCrrCQIw331QP4XlpTG9u5xh65UsUI
         lLGJ/Zr7nnJjejrCTttD2oZo7FEzCbAUFGNdL1uw7Dfe3hy1O4q79r1C3BGv8BhNxm
         +7UAzi0nNe1Yz27U/60JECWSQoOUmiMcKzI5XaRkwo1sxkCGs8oj3jYTDC1A1Wbuki
         EhXKLvQDZfzUQ7u1SU2OTwYc928wggQgHEg/Mv3t9scJLe4XTKT3kQGRBECnirEU84
         xO57Sca6Zcie1akT0/0L7dqUkhKxBvjyMbVJl0VvxvoOXQoR+GCORHIiaQrCFV9SxW
         8l+Zc8l1XJhdg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o6ix_IGElFg0; Thu, 18 Feb 2021 12:56:39 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 567F229CCD5;
        Thu, 18 Feb 2021 12:56:39 -0500 (EST)
Date:   Thu, 18 Feb 2021 12:56:39 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>
Cc:     Sangmoon Kim <sangmoon.kim@samsung.com>,
        neeraju <neeraju@codeaurora.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, rostedt <rostedt@goodmis.org>
Message-ID: <797905837.27189.1613670999218.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210218170012.GS2743@paulmck-ThinkPad-P72>
References: <bf80e296-14bf-6f36-8952-416829d30e5a@codeaurora.org> <CGME20210218130056epcas1p21e5b2e873f8c3cb0aa6953473d4c416c@epcas1p2.samsung.com> <20210218125224.23739-1-sangmoon.kim@samsung.com> <1181485573.26616.1613657821155.JavaMail.zimbra@efficios.com> <20210218150628.GN2743@paulmck-ThinkPad-P72> <1315011925.26877.1613663453242.JavaMail.zimbra@efficios.com> <20210218170012.GS2743@paulmck-ThinkPad-P72>
Subject: Re: [PATCH] rcu/tree: Add a trace event for RCU stall warnings
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Topic: rcu/tree: Add a trace event for RCU stall warnings
Thread-Index: fQyGXpOuoYkA8kZowaGMZd4rb0vCkw==
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

----- On Feb 18, 2021, at 12:00 PM, paulmck paulmck@kernel.org wrote:

> On Thu, Feb 18, 2021 at 10:50:53AM -0500, Mathieu Desnoyers wrote:
>> ----- On Feb 18, 2021, at 10:06 AM, paulmck paulmck@kernel.org wrote:
>> 
>> > On Thu, Feb 18, 2021 at 09:17:01AM -0500, Mathieu Desnoyers wrote:
>> >> ----- On Feb 18, 2021, at 7:52 AM, Sangmoon Kim sangmoon.kim@samsung.com wrote:
>> >> 
>> >> >> -----Original Message-----
>> >> >> From: neeraju=codeaurora.org@mg.codeaurora.org
>> >> >> <neeraju=codeaurora.org@mg.codeaurora.org>
>> >> >> Sent: Thursday, February 18, 2021 3:18 AM
>> >> >> 
>> >> >> Hi Sangmoon,
>> >> >> 
>> >> >> On 2/17/2021 7:19 PM, Sangmoon Kim wrote:
>> >> >> >> -----Original Message-----
>> >> >> >> From: Paul E. McKenney <paulmck@kernel.org>
>> >> >> >> Sent: Wednesday, February 17, 2021 2:50 AM
>> >> >> >>
>> >> >> >> On Mon, Feb 15, 2021 at 05:53:25PM +0900, Sangmoon Kim wrote:
>> >> >> >>> The event allows us to trace the RCU stall when
>> >> >> >>> sysctl_panic_on_rcu_stall is disabled.
>> >> >> >>>
>> >> >> >>> The first parameter is the name of RCU flavour like other trace
>> >> >> >>> events. The second one shows us which function detected stalls.
>> >> >> >>>
>> >> >> >>> The RCU stall is mainly caused by external factors such as interrupt
>> >> >> >>> handling or task scheduling or something else. Therefore, this event
>> >> >> >>> uses TRACE_EVENT macro, not dedicated one, so that someone interested
>> >> >> >>> in the RCU stall can use it without CONFIG_RCU_TRACE.
>> >> >> >>>
>> >> >> >>> Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
>> >> >> >>
>> >> >> >> The patch looks plausible, but I have to ask...  Why not instead just
>> >> >> >> get the existing information out of the console log?
>> >> >> >>
>> >> >> >> 							Thanx, Paul
>> >> >> >
>> >> >> > This can provide a trigger point for the RCU stall warning.
>> >> >> > If a module in the kernel wants to trace the stall for debugging purposes,
>> >> >> > there is a cost of continuing to parse the console log.
>> >> >> > This tracepoint is useful because it is hard to pay these costs
>> >> >> > especially on mobile devices.
>> >> >> >
>> >> >> > Thanks,
>> >> >> > Sangmoon
>> >> >> >
>> >> >> 
>> >> >> So, the idea here is to register to these trace events from kernel
>> >> >> module and use that for debugging? Just curious what debugging action
>> >> >> module does on these traces, as they have limited information
>> >> >> about the stall, compared to console stall warnings, which gives a
>> >> >> much more detailed information about stall.
>> >> >> 
>> >> >> 
>> >> >> Thanks
>> >> >> Neeraj
>> >> > 
>> >> > Hi Neeraj,
>> >> > 
>> >> > Yes, a module can log the stall occurence using the trace, although
>> >> > there is no detailed information. If the kernel panic occurs for some
>> >> > reasons, the debugging report generated by the module can include that
>> >> > RCU stall warning has occurred before.
>> >> > 
>> >> > In addition, it's just an idea now, when a trace event happens, the
>> >> > module can store the console log including detailed information, or may
>> >> > also obtain CPU/task information by parsing the console log.
>> >> 
>> >> Adding a new tracepoint is not just about what is extracted by this specific
>> >> tracepoint, but rather how it can be analyzed when combined with all other
>> >> relevant
>> >> tracepoints.
>> >> 
>> >> For instance, if we have this added RCU stall warning added, here is how it can
>> >> be
>> >> used with the upcoming LTTng 2.13, which implements the "event notification"
>> >> triggers
>> >> feature:
>> >> 
>> >> 1) Setup "flight recorder" (snapshot) tracing to trace into a circular ring
>> >> buffer,
>> >>    enabling the following tracepoints:
>> >>    - kernel activity (meaning all other RCU event, scheduling, irq, workqueues,
>> >>    ...),
>> >>    - this new RCU stall warning event.
>> >> 
>> >> 2) Add a "callstack-kernel" context to the RCU stall warning event. This will
>> >> sample
>> >>    the kernel stack when the event is hit. This will provide information similar to
>> >>    the stack trace gathered into the console log on OOPS.
>> >> 
>> >> 3) Enable a trigger waiting on the RCU stall warning tracepoint to be hit. On
>> >> this
>> >>    trigger, actions can be associated, such as capturing a snapshot or waking up
>> >>    an external user-space process to perform specific actions.
>> >> 
>> >> So you end up with a snapshot containing the sequence of events leading to the
>> >> RCU stall warning, with a kernel stack trace of the context causing the stall
>> >> warning to be emitted.
>> >> 
>> >> I would argue that this information is more complete than just the stack trace
>> >> extracted through the console log.
>> > 
>> > I am not so sure about that.  RCU CPU stall warnings dump quite a bit more
>> > than a stack trace to the console.  Which is why I am concerned about the
>> > proverbial camel's nose in the tent.  ;-)
>> > 
>> > So Sangmoon, what is it that you really need for this to be useful to you?
>> > 
>> > Or am I missing your point?  (Either Mathieu's or Sangmoon's.)
>> 
>> Well there is a tracepoint to dump the console's content into the tracing
>> buffers
>> as well, so technically this existing RCU stall warning information could be
>> extracted
>> into a trace as well.
>> 
>> AFAIU, what the new "rcu stall warning" tracepoint provides is an easy way to
>> hook on a specific
>> event to trigger trace capture, without requiring to parse the console log
>> continuously,
>> and a way to know when the stall warning happens in time within the trace
>> time-line.
>> 
>> That being said, there may be use-cases for extracting more details about the
>> RCU stall
>> as tracepoint event fields to make it more convenient, but it does not appear to
>> be
>> necessary considered that the console can be saved into trace buffers as well.
> 
> OK, I will bite.  ;-)
> 
> Can the saving of console into trace buffers be easily enabled and
> disabled within the code? If so, does enabling and disabling nest?

OK I think I get your point: when this tracing facility is not in use, you
don't want to spam the console with those printouts. And when tracing is in
use, you would want that information collected.

Well one way do achieve this would be to use the TRACE_EVENT_FN() family of
tracepoint events for this new rcu stall warning event. It takes register/unregister
callback functions as parameter. See the sys_enter/sys_exit events as examples.
syscall_regfunc and syscall_unregfunc implement the reference counting you are
referring to.

The downside of this approach though in the context of extracting RCU CPU stalls
warnings through the console is that when tracing of those stalls is enabled, the
console gets spammed with those messages as a side-effect, which may be unwanted.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
