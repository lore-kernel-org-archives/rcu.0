Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70849C43381
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 18:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9F264EB7
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 18:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhBRSve (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Feb 2021 13:51:34 -0500
Received: from mail.efficios.com ([167.114.26.124]:60776 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbhBRRZO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Feb 2021 12:25:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1538429CA09;
        Thu, 18 Feb 2021 12:24:15 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qXTbPS7lp75y; Thu, 18 Feb 2021 12:24:14 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 972DD29CA08;
        Thu, 18 Feb 2021 12:24:14 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 972DD29CA08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1613669054;
        bh=70tqMz1VANgt2xJg+kkTtlcNrvZXaVeZ+x4jiuuCpbM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=pnw4Ba+YcxDh+cOhMG+mAzVLF9AnaxmN3i3iMEPrBJ4WXlowpdkLfkiXWPcCvQH2b
         OFkTucZ/0SkWiHR+5/RJKawoj1yK95QGg1sFCENL0ez7SFnVPO2wtc3G/RA1RYPcd/
         Dy1oQ4maGTr2cNZLyoQaL1wESx22p4bsUzLq9c2Hw/01RVz630HYJCy+7u41wl9tnh
         r0EDLkQyMHqa5u7fiAoy+JzEh5LrdVfgcR3N2oViRBekmxnGcw1omHbq76O+Uc7G8T
         dYPAoEM5e/zFkOYko5EoykLSYQ1yNFKTebvI91ROqIviNJ4eFwuDTRL6Mw0aOWRpyw
         eqXIclKr9ZRHQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HWVRn1C5nN77; Thu, 18 Feb 2021 12:24:14 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 8688229C47A;
        Thu, 18 Feb 2021 12:24:14 -0500 (EST)
Date:   Thu, 18 Feb 2021 12:24:14 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     paulmck <paulmck@kernel.org>,
        Sangmoon Kim <sangmoon.kim@samsung.com>,
        neeraju <neeraju@codeaurora.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, rostedt <rostedt@goodmis.org>
Message-ID: <291172556.27144.1613669054413.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210218165839.GA35220@pc638.lan>
References: <bf80e296-14bf-6f36-8952-416829d30e5a@codeaurora.org> <CGME20210218130056epcas1p21e5b2e873f8c3cb0aa6953473d4c416c@epcas1p2.samsung.com> <20210218125224.23739-1-sangmoon.kim@samsung.com> <1181485573.26616.1613657821155.JavaMail.zimbra@efficios.com> <20210218150628.GN2743@paulmck-ThinkPad-P72> <1315011925.26877.1613663453242.JavaMail.zimbra@efficios.com> <20210218165839.GA35220@pc638.lan>
Subject: Re: [PATCH] rcu/tree: Add a trace event for RCU stall warnings
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Topic: rcu/tree: Add a trace event for RCU stall warnings
Thread-Index: ajuS+ApIUNVC/iOUSm5gY33pOX/MJg==
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

----- On Feb 18, 2021, at 11:58 AM, Uladzislau Rezki urezki@gmail.com wrote:

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
>> 
> Could you please clarify how the kernel ring-buffer can also be routed over
> trace buffer?
> Probably i am not aware of if it is possible on latest kernel.

This can be done by enabling the "printk console" tracepoint. See the call to
trace_console_rcuidle() in kernel/printk/printk.c. The tracepoint is defined in
include/trace/events/printk.h.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
