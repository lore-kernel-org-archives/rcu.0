Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254C4C433DB
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 18:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB98364EB4
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 18:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhBRSvs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Feb 2021 13:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhBRSn5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Feb 2021 13:43:57 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F097AC061574
        for <rcu@vger.kernel.org>; Thu, 18 Feb 2021 10:43:15 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id o16so2558189ljj.11
        for <rcu@vger.kernel.org>; Thu, 18 Feb 2021 10:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=200FNsCxb93MvH3nPzcASfDg9Hi20LT7YeQYBtjO9Cw=;
        b=FFFGjK2LCnNS6SEevGvRsFEReADKsE1snnXHhmnmHsFnsP9vewn05k5rDz+aB5ipMB
         T4l6HAukkfWZYC/gyuiMQaMQ0h5akmJ/NZrrXzAVh5ru27/+7f1vREQ+RkodozRg3ygi
         zMduSNColv2YgMC58Ov7Z7NIG64GKLFgYrID5iVydp1yfB//GlUu7QbERHGx9udC+ozD
         KoCqZW6BpYgRN2W6Py7OUo8k5LXEQpxdxpHkCjC6GDPCn4f1K5fE3RnIzcsbQ89hr5zX
         OvkqL3/iT4jAEvU/RGzdvmuAn34+trNjPdgs+M1iT5XGenc37otIBvSSRSp2DLOxrxNg
         t6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=200FNsCxb93MvH3nPzcASfDg9Hi20LT7YeQYBtjO9Cw=;
        b=Ajbu4w6Q5a/gqdJ4ZglxOLhWll2JTKE1OnWuFBk43XqxeLyP9ntTdbGZ8NBYn+74/z
         uZhYafNwz/3g0PawGTQkzJeI+qCqAivHfY8uUW1wp4zCBtqZhjMN4VCxk+ocGFGc5M7Z
         mLwFXjeCyNUCpud9m12HECCAnRqgkq8wyWttHh9IMG88MWF91DfppjL+jYqh56iJ5Og3
         DE8hkWvqV2Sw7C+Ah9YxG/Lvdu1fBzvR8GfPOPu5uyrqkfxO3Z5L4VWoemRcCfmVNxGj
         ZcMYTpOR0Z1gw/YAekpNEDRuN48RxBfDASn6CP2YvgKplF0sZlaLAKDaUq67MEF5qi8C
         JK9w==
X-Gm-Message-State: AOAM533JMrHIa1FpbVPJE4sLjZnrl9ITqMsJeaWUBuW7n5oe+5VOtd++
        kyDlmpa2do/8bOrUt4WjA6o=
X-Google-Smtp-Source: ABdhPJxZin29uSy5X1JvEIqpvaJ60tHD/nozVolDWoqOMpegC1SnX9W9ofxLU+wEgMow9ojLZXvJPA==
X-Received: by 2002:a2e:9b8b:: with SMTP id z11mr3184417lji.331.1613673794372;
        Thu, 18 Feb 2021 10:43:14 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id l1sm680353lfj.103.2021.02.18.10.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 10:43:13 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 18 Feb 2021 19:43:11 +0100
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck <paulmck@kernel.org>,
        Sangmoon Kim <sangmoon.kim@samsung.com>,
        neeraju <neeraju@codeaurora.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rcu/tree: Add a trace event for RCU stall warnings
Message-ID: <20210218184311.GA35337@pc638.lan>
References: <bf80e296-14bf-6f36-8952-416829d30e5a@codeaurora.org>
 <CGME20210218130056epcas1p21e5b2e873f8c3cb0aa6953473d4c416c@epcas1p2.samsung.com>
 <20210218125224.23739-1-sangmoon.kim@samsung.com>
 <1181485573.26616.1613657821155.JavaMail.zimbra@efficios.com>
 <20210218150628.GN2743@paulmck-ThinkPad-P72>
 <1315011925.26877.1613663453242.JavaMail.zimbra@efficios.com>
 <20210218165839.GA35220@pc638.lan>
 <291172556.27144.1613669054413.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <291172556.27144.1613669054413.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Feb 18, 2021 at 12:24:14PM -0500, Mathieu Desnoyers wrote:
> ----- On Feb 18, 2021, at 11:58 AM, Uladzislau Rezki urezki@gmail.com wrote:
> 
> > On Thu, Feb 18, 2021 at 10:50:53AM -0500, Mathieu Desnoyers wrote:
> >> ----- On Feb 18, 2021, at 10:06 AM, paulmck paulmck@kernel.org wrote:
> >> 
> >> > On Thu, Feb 18, 2021 at 09:17:01AM -0500, Mathieu Desnoyers wrote:
> >> >> ----- On Feb 18, 2021, at 7:52 AM, Sangmoon Kim sangmoon.kim@samsung.com wrote:
> >> >> 
> >> >> >> -----Original Message-----
> >> >> >> From: neeraju=codeaurora.org@mg.codeaurora.org
> >> >> >> <neeraju=codeaurora.org@mg.codeaurora.org>
> >> >> >> Sent: Thursday, February 18, 2021 3:18 AM
> >> >> >> 
> >> >> >> Hi Sangmoon,
> >> >> >> 
> >> >> >> On 2/17/2021 7:19 PM, Sangmoon Kim wrote:
> >> >> >> >> -----Original Message-----
> >> >> >> >> From: Paul E. McKenney <paulmck@kernel.org>
> >> >> >> >> Sent: Wednesday, February 17, 2021 2:50 AM
> >> >> >> >>
> >> >> >> >> On Mon, Feb 15, 2021 at 05:53:25PM +0900, Sangmoon Kim wrote:
> >> >> >> >>> The event allows us to trace the RCU stall when
> >> >> >> >>> sysctl_panic_on_rcu_stall is disabled.
> >> >> >> >>>
> >> >> >> >>> The first parameter is the name of RCU flavour like other trace
> >> >> >> >>> events. The second one shows us which function detected stalls.
> >> >> >> >>>
> >> >> >> >>> The RCU stall is mainly caused by external factors such as interrupt
> >> >> >> >>> handling or task scheduling or something else. Therefore, this event
> >> >> >> >>> uses TRACE_EVENT macro, not dedicated one, so that someone interested
> >> >> >> >>> in the RCU stall can use it without CONFIG_RCU_TRACE.
> >> >> >> >>>
> >> >> >> >>> Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
> >> >> >> >>
> >> >> >> >> The patch looks plausible, but I have to ask...  Why not instead just
> >> >> >> >> get the existing information out of the console log?
> >> >> >> >>
> >> >> >> >> 							Thanx, Paul
> >> >> >> >
> >> >> >> > This can provide a trigger point for the RCU stall warning.
> >> >> >> > If a module in the kernel wants to trace the stall for debugging purposes,
> >> >> >> > there is a cost of continuing to parse the console log.
> >> >> >> > This tracepoint is useful because it is hard to pay these costs
> >> >> >> > especially on mobile devices.
> >> >> >> >
> >> >> >> > Thanks,
> >> >> >> > Sangmoon
> >> >> >> >
> >> >> >> 
> >> >> >> So, the idea here is to register to these trace events from kernel
> >> >> >> module and use that for debugging? Just curious what debugging action
> >> >> >> module does on these traces, as they have limited information
> >> >> >> about the stall, compared to console stall warnings, which gives a
> >> >> >> much more detailed information about stall.
> >> >> >> 
> >> >> >> 
> >> >> >> Thanks
> >> >> >> Neeraj
> >> >> > 
> >> >> > Hi Neeraj,
> >> >> > 
> >> >> > Yes, a module can log the stall occurence using the trace, although
> >> >> > there is no detailed information. If the kernel panic occurs for some
> >> >> > reasons, the debugging report generated by the module can include that
> >> >> > RCU stall warning has occurred before.
> >> >> > 
> >> >> > In addition, it's just an idea now, when a trace event happens, the
> >> >> > module can store the console log including detailed information, or may
> >> >> > also obtain CPU/task information by parsing the console log.
> >> >> 
> >> >> Adding a new tracepoint is not just about what is extracted by this specific
> >> >> tracepoint, but rather how it can be analyzed when combined with all other
> >> >> relevant
> >> >> tracepoints.
> >> >> 
> >> >> For instance, if we have this added RCU stall warning added, here is how it can
> >> >> be
> >> >> used with the upcoming LTTng 2.13, which implements the "event notification"
> >> >> triggers
> >> >> feature:
> >> >> 
> >> >> 1) Setup "flight recorder" (snapshot) tracing to trace into a circular ring
> >> >> buffer,
> >> >>    enabling the following tracepoints:
> >> >>    - kernel activity (meaning all other RCU event, scheduling, irq, workqueues,
> >> >>    ...),
> >> >>    - this new RCU stall warning event.
> >> >> 
> >> >> 2) Add a "callstack-kernel" context to the RCU stall warning event. This will
> >> >> sample
> >> >>    the kernel stack when the event is hit. This will provide information similar to
> >> >>    the stack trace gathered into the console log on OOPS.
> >> >> 
> >> >> 3) Enable a trigger waiting on the RCU stall warning tracepoint to be hit. On
> >> >> this
> >> >>    trigger, actions can be associated, such as capturing a snapshot or waking up
> >> >>    an external user-space process to perform specific actions.
> >> >> 
> >> >> So you end up with a snapshot containing the sequence of events leading to the
> >> >> RCU stall warning, with a kernel stack trace of the context causing the stall
> >> >> warning to be emitted.
> >> >> 
> >> >> I would argue that this information is more complete than just the stack trace
> >> >> extracted through the console log.
> >> > 
> >> > I am not so sure about that.  RCU CPU stall warnings dump quite a bit more
> >> > than a stack trace to the console.  Which is why I am concerned about the
> >> > proverbial camel's nose in the tent.  ;-)
> >> > 
> >> > So Sangmoon, what is it that you really need for this to be useful to you?
> >> > 
> >> > Or am I missing your point?  (Either Mathieu's or Sangmoon's.)
> >> 
> >> Well there is a tracepoint to dump the console's content into the tracing
> >> buffers
> >> as well, so technically this existing RCU stall warning information could be
> >> extracted
> >> into a trace as well.
> >> 
> >> AFAIU, what the new "rcu stall warning" tracepoint provides is an easy way to
> >> hook on a specific
> >> event to trigger trace capture, without requiring to parse the console log
> >> continuously,
> >> and a way to know when the stall warning happens in time within the trace
> >> time-line.
> >> 
> >> That being said, there may be use-cases for extracting more details about the
> >> RCU stall
> >> as tracepoint event fields to make it more convenient, but it does not appear to
> >> be
> >> necessary considered that the console can be saved into trace buffers as well.
> >> 
> > Could you please clarify how the kernel ring-buffer can also be routed over
> > trace buffer?
> > Probably i am not aware of if it is possible on latest kernel.
> 
> This can be done by enabling the "printk console" tracepoint. See the call to
> trace_console_rcuidle() in kernel/printk/printk.c. The tracepoint is defined in
> include/trace/events/printk.h.
> 
OK, i see. At least "error" messages get routed:

<snip>
root@seldlx26095:/home/CORPUSERS/23060734# cat /sys/kernel/debug/tracing/trace_pipe 
     kworker/4:0-9693    [004] d..1 627080.409625: console: [627080.402633] cp210x ttyUSB0: failed set request 0x7 status: -19
     kworker/4:0-9693    [004] d..1 627080.409633: console: [627080.402642] cp210x ttyUSB0: failed set request 0x12 status: -19
     kworker/4:0-9693    [004] d..1 627080.409639: console: [627080.402647] cp210x ttyUSB0: failed set request 0x0 status: -19
<snip>

Thanks!

--
Vlad Rezki
