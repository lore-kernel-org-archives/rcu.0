Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA69C433DB
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 16:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF00A64EB1
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 16:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhBRQmD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:42:03 -0500
Received: from mail.efficios.com ([167.114.26.124]:57104 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbhBROR4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Feb 2021 09:17:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BD55429A545;
        Thu, 18 Feb 2021 09:17:01 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LYtNyMv0wsJm; Thu, 18 Feb 2021 09:17:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5A11E29A928;
        Thu, 18 Feb 2021 09:17:01 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5A11E29A928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1613657821;
        bh=6VdDYUTb23ogrwH5ufZ2dyDrZnkMUjuPzb0vtq8vRVE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=OIpkqRYBm++kUzHN8d/Bt9MLclgLYn5Mfv7CTsrop/WJMq/YZTXrooGq+qH7n2z/f
         1cOr2hpwOrkMgFXz5Z5/LZgLQbMlMpucxKCRlx1e7eLAMiqnthh1Hr8npWN+19C2Ky
         IBnGA7zqdZDHbnbyUt6OXFOw2DS08EYps85tSS1tAfQMyxaZKB3eLi0WfOhN+Go8l6
         C+cLXfKwc45CIpeDMrijfWbTAxNjhV3Xx82qR1LQ7asE1opyGrYYdojjM0pQAUhbim
         EGVfv6qUgNSM2SS0M0KB6irhFFdNhdpwryfuIxFclXSxvAjef2PQKWOZLX9vQ2HfPz
         8Fm/N2pLTGS/g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OI8PEyH7y2G3; Thu, 18 Feb 2021 09:17:01 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 4990B29A652;
        Thu, 18 Feb 2021 09:17:01 -0500 (EST)
Date:   Thu, 18 Feb 2021 09:17:01 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Sangmoon Kim <sangmoon.kim@samsung.com>
Cc:     neeraju@codeaurora.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        paulmck <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>
Message-ID: <1181485573.26616.1613657821155.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210218125224.23739-1-sangmoon.kim@samsung.com>
References: <bf80e296-14bf-6f36-8952-416829d30e5a@codeaurora.org> <CGME20210218130056epcas1p21e5b2e873f8c3cb0aa6953473d4c416c@epcas1p2.samsung.com> <20210218125224.23739-1-sangmoon.kim@samsung.com>
Subject: Re: [PATCH] rcu/tree: Add a trace event for RCU stall warnings
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Topic: rcu/tree: Add a trace event for RCU stall warnings
Thread-Index: x9o++fSGj1CdlHQHs9sYfvpENGUtWg==
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

----- On Feb 18, 2021, at 7:52 AM, Sangmoon Kim sangmoon.kim@samsung.com wrote:

>> -----Original Message-----
>> From: neeraju=codeaurora.org@mg.codeaurora.org
>> <neeraju=codeaurora.org@mg.codeaurora.org>
>> Sent: Thursday, February 18, 2021 3:18 AM
>> 
>> Hi Sangmoon,
>> 
>> On 2/17/2021 7:19 PM, Sangmoon Kim wrote:
>> >> -----Original Message-----
>> >> From: Paul E. McKenney <paulmck@kernel.org>
>> >> Sent: Wednesday, February 17, 2021 2:50 AM
>> >>
>> >> On Mon, Feb 15, 2021 at 05:53:25PM +0900, Sangmoon Kim wrote:
>> >>> The event allows us to trace the RCU stall when
>> >>> sysctl_panic_on_rcu_stall is disabled.
>> >>>
>> >>> The first parameter is the name of RCU flavour like other trace
>> >>> events. The second one shows us which function detected stalls.
>> >>>
>> >>> The RCU stall is mainly caused by external factors such as interrupt
>> >>> handling or task scheduling or something else. Therefore, this event
>> >>> uses TRACE_EVENT macro, not dedicated one, so that someone interested
>> >>> in the RCU stall can use it without CONFIG_RCU_TRACE.
>> >>>
>> >>> Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
>> >>
>> >> The patch looks plausible, but I have to ask...  Why not instead just
>> >> get the existing information out of the console log?
>> >>
>> >> 							Thanx, Paul
>> >
>> > This can provide a trigger point for the RCU stall warning.
>> > If a module in the kernel wants to trace the stall for debugging purposes,
>> > there is a cost of continuing to parse the console log.
>> > This tracepoint is useful because it is hard to pay these costs
>> > especially on mobile devices.
>> >
>> > Thanks,
>> > Sangmoon
>> >
>> 
>> So, the idea here is to register to these trace events from kernel
>> module and use that for debugging? Just curious what debugging action
>> module does on these traces, as they have limited information
>> about the stall, compared to console stall warnings, which gives a
>> much more detailed information about stall.
>> 
>> 
>> Thanks
>> Neeraj
> 
> Hi Neeraj,
> 
> Yes, a module can log the stall occurence using the trace, although
> there is no detailed information. If the kernel panic occurs for some
> reasons, the debugging report generated by the module can include that
> RCU stall warning has occurred before.
> 
> In addition, it's just an idea now, when a trace event happens, the
> module can store the console log including detailed information, or may
> also obtain CPU/task information by parsing the console log.

Adding a new tracepoint is not just about what is extracted by this specific
tracepoint, but rather how it can be analyzed when combined with all other relevant
tracepoints.

For instance, if we have this added RCU stall warning added, here is how it can be
used with the upcoming LTTng 2.13, which implements the "event notification" triggers
feature:

1) Setup "flight recorder" (snapshot) tracing to trace into a circular ring buffer,
   enabling the following tracepoints:
   - kernel activity (meaning all other RCU event, scheduling, irq, workqueues, ...),
   - this new RCU stall warning event.

2) Add a "callstack-kernel" context to the RCU stall warning event. This will sample
   the kernel stack when the event is hit. This will provide information similar to
   the stack trace gathered into the console log on OOPS.

3) Enable a trigger waiting on the RCU stall warning tracepoint to be hit. On this
   trigger, actions can be associated, such as capturing a snapshot or waking up
   an external user-space process to perform specific actions.

So you end up with a snapshot containing the sequence of events leading to the
RCU stall warning, with a kernel stack trace of the context causing the stall
warning to be emitted.

I would argue that this information is more complete than just the stack trace
extracted through the console log.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
