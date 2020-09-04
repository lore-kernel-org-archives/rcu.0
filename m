Return-Path: <SRS0=JZbX=CN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE98FC43461
	for <rcu@archiver.kernel.org>; Fri,  4 Sep 2020 02:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E60D2067C
	for <rcu@archiver.kernel.org>; Fri,  4 Sep 2020 02:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6Hzl95j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgIDCQR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 3 Sep 2020 22:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgIDCQQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 3 Sep 2020 22:16:16 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7ABC061244;
        Thu,  3 Sep 2020 19:16:16 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w186so5133883qkd.1;
        Thu, 03 Sep 2020 19:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R9CM21x6anhSMxronhQvhfxFyLXI9NYoskh4SnvB43Q=;
        b=U6Hzl95jyWGaPU/SqZ4QXrFMpBXvj+ry27WGxa5lcw6+ijeffdPtWKLc7qjm72Qbdf
         LMBfTaEIYrP0KN83BwoPM+fKkoQ+BTyQLHhif7KHWYmyneyngqm7hAcvpN0gWLwc2kaZ
         84N8wEILCWWRfn8eGD7GuSJL00Vgm23x6gzfyp/04yoGXKIURjNzLmImQRhVdAfgkJRI
         sqLgiursZjn0jWC3KYrBzjC3yH41HysAgFP3JAVdmNvaqhRCApUvu++mlHXyHdHt+9B1
         3Yg2mXQhpl1p40EOL0nC/BsK5W4dDUGSXjw1eZsjPEgfaxOVL7WcV1j/NGy2MyjjGMpa
         HKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R9CM21x6anhSMxronhQvhfxFyLXI9NYoskh4SnvB43Q=;
        b=fbUtXXctZsW2hX2rjxcmSO7RsBYroQfdLWqtMfewBeGyGyIAoxw1Qx0dfSIcVIS+Y/
         urL7dmZHL3t6ZvvcR4PM2Tudg1qTT3lSNXMdES6RH/O9WdRTMWFWZRglmMkyGwK2fXuM
         /Ap93QEX17+8M2dUeO83loa3HVN/tk6g9tOTtcKv3uFzL7J4eDWfq2EwSz6RbUd+b77n
         M0OwsHp/TzqMsmHXEn2TO5Tssq9j/j+at2XKFuZfiNuVaP1SKaw90wmbTEgzcg9nkb+b
         a/H0/TFKZWEDgzQtSbGDLNtyP/3bDCejIEWTwuTY4rxXG2aGmnEu7t4ip07HmI8koLd4
         8vvg==
X-Gm-Message-State: AOAM531/OMXIAhiouC7bC0RlIACD92zGfsnzAs4kn9e3sjl2bqA16EMW
        VRo2cSSkhTATiIxDATh8mKg=
X-Google-Smtp-Source: ABdhPJyoBbk9JAbgraG8/e6wNucA85RMVFDP2Lkk0vRcRBDTQQSSwQ23Sow9s0L/ib3Ik8ebjh1/bg==
X-Received: by 2002:ae9:c015:: with SMTP id u21mr6459642qkk.268.1599185775889;
        Thu, 03 Sep 2020 19:16:15 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v185sm3693968qki.26.2020.09.03.19.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 19:16:15 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id D935727C0054;
        Thu,  3 Sep 2020 22:16:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 03 Sep 2020 22:16:13 -0400
X-ME-Sender: <xms:bKNRX0xF6iqPuCn7GjvBn2jHfZR5iiulkXMRgrLNlQVWNzReE-qk9Q>
    <xme:bKNRX4TlB9IpPjPtyQOMXGjbJdxekW-lmHENmsKdY0Lj9sp9HSfjORWd1yvpGbJMl
    GVSH3vx385rweOOOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegvddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphephedvrdduheehrdduud
    durdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtd
    eigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehf
    ihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:bKNRX2WpoYq6ZzQ9tpPVIJUzo0eC2vdX-kjwMiY-UDmd9Nh527ye0Q>
    <xmx:bKNRXyhKBUnZFck9I3CP62XZLtiUJm89zLxEMr_Dasuk6PkQJwcrfQ>
    <xmx:bKNRX2BHBCEWt0ygtxRYhCQKdlzgRN2yoGPb9La3UXkq8AFiR84sGA>
    <xmx:baNRX-6qfyBK-31DQ-idUTqeOzBUKCLJ8bTRUAyQi9BZ0CbKQl1T74aNQkY>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5792F3280064;
        Thu,  3 Sep 2020 22:16:12 -0400 (EDT)
Date:   Fri, 4 Sep 2020 10:16:10 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH tip/core/rcu 2/4] smp: Add source and destination CPUs to
 __call_single_data
Message-ID: <20200904021610.GA7922@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200831181356.GA1224@paulmck-ThinkPad-P72>
 <20200831181417.1378-2-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831181417.1378-2-paulmck@kernel.org>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Mon, Aug 31, 2020 at 11:14:15AM -0700, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit adds a destination CPU to __call_single_data, and is inspired
> by an earlier commit by Peter Zijlstra.  This version adds #ifdef to
> permit use by 32-bit systems and supplying the destination CPU for all
> smp_call_function*() requests, not just smp_call_function_single().
> 
> If need be, 32-bit systems could be accommodated by shrinking the flags
> field to 16 bits (the atomic_t variant is currently unused) and by
> providing only eight bits for CPU on such systems.
> 
> It is not clear that the addition of the fields to __call_single_node
> are really needed.
> 
> Link: https://lore.kernel.org/lkml/20200615164048.GC2531@hirez.programming.kicks-ass.net/
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  include/linux/smp.h       | 3 +++
>  include/linux/smp_types.h | 3 +++
>  kernel/smp.c              | 2 ++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/include/linux/smp.h b/include/linux/smp.h
> index 80d557e..9f13966 100644
> --- a/include/linux/smp.h
> +++ b/include/linux/smp.h
> @@ -26,6 +26,9 @@ struct __call_single_data {
>  		struct {
>  			struct llist_node llist;
>  			unsigned int flags;
> +#ifdef CONFIG_64BIT
> +			u16 src, dst;
> +#endif
>  		};
>  	};
>  	smp_call_func_t func;
> diff --git a/include/linux/smp_types.h b/include/linux/smp_types.h
> index 364b3ae..2e8461a 100644
> --- a/include/linux/smp_types.h
> +++ b/include/linux/smp_types.h
> @@ -61,6 +61,9 @@ struct __call_single_node {
>  		unsigned int	u_flags;
>  		atomic_t	a_flags;
>  	};
> +#ifdef CONFIG_64BIT
> +	u16 src, dst;
> +#endif
>  };
>  
>  #endif /* __LINUX_SMP_TYPES_H */
> diff --git a/kernel/smp.c b/kernel/smp.c
> index d0ae8eb..a47382d 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -375,6 +375,7 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
>  
>  	csd->func = func;
>  	csd->info = info;
> +	csd->dst = cpu;

Would this and the next modification cause compile errors with
CONFIG_64BIT = n? I saw you add #ifdef guard in the next patch, so maybe
move those two into next patch (of course, if they trigger compile
errors)

Regards,
Boqun

>  
>  	err = generic_exec_single(cpu, csd);
>  
> @@ -540,6 +541,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
>  			csd->flags |= CSD_TYPE_SYNC;
>  		csd->func = func;
>  		csd->info = info;
> +		csd->dst = cpu;
>  		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
>  			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
>  	}
> -- 
> 2.9.5
> 
