Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3529BC4338F
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 18:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3286101C
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 18:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhG1SXJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jul 2021 14:23:09 -0400
Received: from mail.efficios.com ([167.114.26.124]:39326 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG1SXI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jul 2021 14:23:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AE39735A877;
        Wed, 28 Jul 2021 14:23:06 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NAP0lL2hjJ48; Wed, 28 Jul 2021 14:23:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EE3F335A876;
        Wed, 28 Jul 2021 14:23:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EE3F335A876
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1627496586;
        bh=hauLVrEgwWpB0ANJV3qETO85yNuqLONWAWa6VN6nqvY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=SEA18qDI1plWvATxaKsAHGsLukzrHFz6m2RxvH05mLRSpq+l6EtVPTB0iy02t/EX/
         a5kVzQv6Dh0yLcQTZXMFyGx/6aobYxv5W4tr9h9hSQSSeZJvzno6pAgP2u/1297gG5
         OoWCgWi5CdkEw/sF31eXjVQVVJ4zdp6NMla+zoWNgXSn9rvWcdcCZhief/jGOwed8M
         QeTUJ7GDjmQa6KiXQ2X0ds+8NdMjnoDBmjpR4wtvv3UhCjXcikRv/eqh2HCZkWSB76
         uFIzatOvEni/7GzQEFucOVYtG4WBvJ2OnIejTjYKIBP+utqJDIFupIfDJ9LD77va1J
         OsHuZqjOop9EA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hG9UPV3k96T0; Wed, 28 Jul 2021 14:23:05 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D84B935A875;
        Wed, 28 Jul 2021 14:23:05 -0400 (EDT)
Date:   Wed, 28 Jul 2021 14:23:05 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>
Cc:     rcu <rcu@vger.kernel.org>,
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
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <2135064974.9081.1627496585724.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1> <20210721202127.2129660-4-paulmck@kernel.org> <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and
 updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4059 (ZimbraWebClient - FF90 (Linux)/8.8.15_GA_4059)
Thread-Topic: Weaken ->dynticks accesses and updates
Thread-Index: BoHMuKvfQXCwt8W17GsIqyHeJ9P0jg==
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

----- On Jul 28, 2021, at 1:37 PM, paulmck paulmck@kernel.org wrote:
[...]
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 42a0032dd99f7..c87b3a271d65b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -251,6 +251,15 @@ void rcu_softirq_qs(void)
> 	rcu_tasks_qs(current, false);
> }
> 
> +/*
> + * Increment the current CPU's rcu_data structure's ->dynticks field
> + * with ordering.  Return the new value.
> + */
> +static noinstr unsigned long rcu_dynticks_inc(int incby)
> +{
> +	return arch_atomic_add_return(incby, this_cpu_ptr(&rcu_data.dynticks));
> +}
> +

[...]

> @@ -308,7 +317,7 @@ static void rcu_dynticks_eqs_online(void)
> 
> 	if (atomic_read(&rdp->dynticks) & 0x1)
> 		return;

Can the thread be migrated at this point ? If yes, then
the check and the increment may happen on different cpu's rdps. Is
that OK ?

> -	atomic_inc(&rdp->dynticks);
> +	rcu_dynticks_inc(1);
> }

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
