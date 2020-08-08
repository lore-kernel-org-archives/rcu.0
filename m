Return-Path: <SRS0=sv12=BS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D26AC433E0
	for <rcu@archiver.kernel.org>; Sat,  8 Aug 2020 02:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E194D2177B
	for <rcu@archiver.kernel.org>; Sat,  8 Aug 2020 02:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cUedCzUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgHHCKy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgHHCKy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 7 Aug 2020 22:10:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3688C061756;
        Fri,  7 Aug 2020 19:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=dAc45tHUZg/nA18kqJXnyW3iWQd/66a54f+Y05m+B4M=; b=cUedCzUVuG/kdcYUB1LvFSU407
        db62UF1AmSSOaTKZgCLiqYvGMoT4022iaa3WsY1YgYWNBPy/yWqwZwnlc2yDgg4Q/nd+6/sOOA2eS
        p2VmSw3Nats5kSNswVWnDDvvv09PIUSOvMf1bWT5n1HrvwQvdop9tbVDDsQQAopV4WDyE8ucGXNcJ
        bfCj2GfIfcDaxkSM+6SY/ifXpX809XezL1UX4oX9HdUuVGneaA7g1h02mPD4D9cY71XSnBaCJZc29
        ny9XPuB46xQZaiYYUnAVq8ZHpHcy96pRaRYrUCP3Ai0TP9XxaDEgrZxqYsN7WCgFxvlv7mQaeWltj
        vgXnt4Vg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4EJm-000702-Vl; Sat, 08 Aug 2020 02:10:43 +0000
Subject: Re: [PATCH v4 5/5] docs: Update RCU's hotplug requirements with a bit
 about design
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        neeraju@codeaurora.org, "Paul E. McKenney" <paulmck@kernel.org>,
        peterz@infradead.org, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        vineethrp@gmail.com
References: <20200807170722.2897328-1-joel@joelfernandes.org>
 <20200807170722.2897328-6-joel@joelfernandes.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4b8646fd-7644-bd8a-54ad-d0cb80b04317@infradead.org>
Date:   Fri, 7 Aug 2020 19:10:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807170722.2897328-6-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi--

On 8/7/20 10:07 AM, Joel Fernandes (Google) wrote:
> RCU's hotplug design will help understand the requirements an RCU
> implementation needs to fullfill, such as dead-lock avoidance.
> 
> The rcu_barrier() section of the "Hotplug CPU" section already talks
> about deadlocks, however the description of what else can deadlock other
> than rcu_barrier is rather incomplete.
> 
> This commit therefore continues the section by describing how RCU's
> design handles CPU hotplug in a deadlock-free way.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  .../RCU/Design/Requirements/Requirements.rst  | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> index 16c64a2eff93..0a4148b9f743 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -1940,6 +1940,28 @@ deadlock. Furthermore, ``rcu_barrier()`` blocks CPU-hotplug operations
>  during its execution, which results in another type of deadlock when
>  invoked from a CPU-hotplug notifier.
>  
> +Also, RCU's implementation avoids serious deadlocks which could occur due to
> +interaction between hotplug, timers and grace period processing. It does so by
> +maintaining its own bookkeeping of every CPU's hotplug state, independent of
> +the various CPU masks and by reporting quiescent states at explicit points.  It
> +may come across as a surprise, but the force quiescent state loop (FQS) does
> +not report quiescent states for offline CPUs and is not required to.
> +
> +For an offline CPU, the quiescent state will be reported in either of:
> +1. During CPU offlining, using RCU's hotplug notifier (``rcu_report_dead()``).

                        note, uses (), which is good:                      ()

> +2. During grace period initialization (``rcu_gp_init``) if it detected a race

      add for consistency & readability:    rcu_gp_init()

> +   with CPU offlining, or a race with a task unblocking on a node which
> +   previously had all of its CPUs offlined.
> +
> +The CPU onlining path (``rcu_cpu_starting``) does not need to a report

      ditto:                rcu_cpu_starting()

> +quiescent state for an offline CPU in fact it would trigger a warning if a

Missing something; maybe like so:

                   for an offline CPU; in fact

> +quiescent state was not already reported for that CPU.
> +
> +During the checking/modification of RCU's hotplug bookkeeping, the
> +corresponding CPU's leaf node lock is held. This avoids race conditions between
> +RCU's hotplug notifier hooks, grace period initialization code and the FQS loop
> +which can concurrently refer to or modify the bookkeeping.
> +
>  Scheduler and RCU
>  ~~~~~~~~~~~~~~~~~
>  
> 

cheers.
-- 
~Randy

