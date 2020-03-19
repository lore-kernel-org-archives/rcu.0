Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDE8C4332D
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 11:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF39C2070A
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 11:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Q+vMaB5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgCSLbl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Mar 2020 07:31:41 -0400
Received: from mail.efficios.com ([167.114.26.124]:45242 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgCSLbl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Mar 2020 07:31:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7F11D2770D4;
        Thu, 19 Mar 2020 07:31:39 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id e4u4qStRjov8; Thu, 19 Mar 2020 07:31:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0A76C27707A;
        Thu, 19 Mar 2020 07:31:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0A76C27707A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1584617499;
        bh=33PE+wHkowtO9q6IEzq84nL2/t8zfbrTwvP2Nousw5Y=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Q+vMaB5H1MB713ANUwit7l2CThsKP8JirEhWwLMXRUOQoM2z82UYx0bva+XRyCSJN
         QJEeysq3BzXiw2vy3R/F2QqElDa6Jt227FjVFvZUxLtTT9coZ7ToKBRByKSoLS62O4
         F7Fw+ZLVMo8dS0DZitQJ8F5J/le5WNGzGBPUwuT9LtTWBHEC+/SZ9/YQosjXVchx5K
         lxLdsMqEk1H7Fqi+71/YQuXZcfEl9OX49r6WxShirgNHb8Z7P4p190vamDSm06AcLp
         ZitDj9SyI8hDWgHc4LOcn4zsiFsgp7TVqdjQLIZQeU8pu9P/ZUFyoUzmcZp3ZI9Wor
         QyZkXBzpQwjxQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6lGsIg_VnFta; Thu, 19 Mar 2020 07:31:38 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id E90C22772C4;
        Thu, 19 Mar 2020 07:31:38 -0400 (EDT)
Date:   Thu, 19 Mar 2020 07:31:38 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>
Cc:     rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Message-ID: <1560487611.2836.1584617498827.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200319001024.GA28798@paulmck-ThinkPad-P72>
References: <20200312181618.GA21271@paulmck-ThinkPad-P72> <20200319001024.GA28798@paulmck-ThinkPad-P72>
Subject: Re: [PATCH RFC v2 tip/core/rcu 0/22] Prototype RCU usable from
 idle, exception, offline
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: Prototype RCU usable from idle, exception, offline
Thread-Index: /+aQCcRF3e2v6wZPv8fU+JWQy6IuTg==
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

----- On Mar 18, 2020, at 8:10 PM, paulmck paulmck@kernel.org wrote:

> Hello!

Hi Paul,

Thanks for pulling this together! Some comments below (based only on the
cover message),

[...]

> There are of course downsides.  The grace-period code can send IPIs to
> CPUs, even when those CPUs are in the idle loop or in nohz_full userspace.
> However, this version enlists the aid of the context-switch hooks,
> which eliminates the need for IPIs in context-switch-heavy workloads.
> It also prohibits sending of IPIs early in the grace period, which
> provides additional opportunity for the hooks to do their job.  Additional
> IPI-reduction mechanisms are under development.

I suspect that on nohz_full cpus, at least some use-cases which really care
about not receiving IPIs will not be doing that many context switches.

What are the possible approaches to have IPI-*elimination* for nohz cpus ?

> 
> The RCU tasks trace mechanism is based off of RCU tasks rather than
> SRCU because the latter is more complex and also because the latter
> uses a CPU-by-CPU approach to tracking quiescent states instead of the
> task-by-task approach that is needed.  It is in theory possible to
> mash RCU tasks trace into the Tree SRCU implementation, but there
> will need to be extremely good reasons for doing so.

I have a hard time buying the "less complexity" argument to justify the
introduction of yet another flavor of RCU when a close match already
exists (SRCU).

The other argument for this task-based RCU (rather than CPU-by-CPU as
done by SRCU) is that "a task-by-task approach is needed". What I
do not get from this explanation is why is such an approach needed ?

Also, another aspect worth discussing here is the use-cases which
need to be covered by tracing-rcu. Is this specific flavor targeting
specifically preempt-off use-cases, or is the goal here to target
use-cases which may trigger major page faults within the read-side
critical section as well ?

Note that doing task-by-task tracking of tracing-rcu rather than
cpu-by-cpu is not free: AFAIU it bloats the task struct (always)
for a use-case which is not always active. My experience with
tracepoints and asm gotos is that we need to be careful not to
slow down the common case (kernel running without any tracing
active, but tracing configured in) if we want to keep distributions
and end users building kernels with introspection facilities in
place.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
