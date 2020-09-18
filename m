Return-Path: <SRS0=xZUe=C3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DC7C43463
	for <rcu@archiver.kernel.org>; Fri, 18 Sep 2020 22:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B152068E
	for <rcu@archiver.kernel.org>; Fri, 18 Sep 2020 22:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600467330;
	bh=E5JKXqiDmun1+oTjYUTLAStPF2gHvSooZGuOGfFiGQA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=HPUy1y9Nz0pp8ETf4vRf89YqtM+6bt2auL8zqB5mSoV2vxpuXE8WqVSYGF0pipzIg
	 cgIKnE9+iSVScBLgN9Vi/ncR5+oQqW+XIIaLQQGUaLZ142WjwHBSn27tbdWe/XZeYO
	 AiZY4TmiUYEWTGwYJ1rIcWrYHGg7YnXyTL8ydgZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgIRWP3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIRWP3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 18 Sep 2020 18:15:29 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27B8C21481;
        Fri, 18 Sep 2020 22:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600467329;
        bh=E5JKXqiDmun1+oTjYUTLAStPF2gHvSooZGuOGfFiGQA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JJFm0VxhNtdTjkxfX05cAR8JOyLbe7IG8ov6BPxX5eHXTXguwQusWMIWrT6RGGJAZ
         AxbPkLf8NaCXBE4dRzr2Dc1YFgZAx9RSw+TYk5vq6goBpFKQ/70WQj3cpeyxeWj6rk
         cdk1l8gr7MvT+v5Fd/PAmCX3mxLkF7q5Pu/K6X70=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F06373523242; Fri, 18 Sep 2020 15:15:28 -0700 (PDT)
Date:   Fri, 18 Sep 2020 15:15:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 0/4] kvfree_rcu() and _LOCK_NESTING/_PREEMPT_RT
Message-ID: <20200918221528.GX29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200918194817.48921-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918194817.48921-1-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 18, 2020 at 09:48:13PM +0200, Uladzislau Rezki (Sony) wrote:
> Hello, folk!
> 
> This is another iteration of fixing kvfree_rcu() issues related
> to CONFIG_PROVE_RAW_LOCK_NESTING and CONFIG_PREEMPT_RT configs.
> 
> The first discussion is here https://lkml.org/lkml/2020/8/9/195.
> 
> - As an outcome of it, there was a proposal from Peter, instead of
> using a speciall "lock-less" flag it is better to move lock-less
> access to the pcplist to the separate function.
> 
> - To add a special worker thread that does prefetching of pages
> if a per-cpu page cache is depleted(what is absolutely normal). 
> 
> As usual, thank you for paying attention to it and your help!
> 
> Uladzislau Rezki (Sony) (4):
>   rcu/tree: Add a work to allocate pages from regular context
>   mm: Add __rcu_alloc_page_lockless() func.
>   rcu/tree: use __rcu_alloc_page_lockless() func.
>   rcu/tree: Use schedule_delayed_work() instead of WQ_HIGHPRI queue

Thank you, Uladzislau!

I have pulled this into -rcu for review and testing.  I have not yet
assigned it to an intended release.

							Thanx, Paul

>  include/linux/gfp.h |  1 +
>  kernel/rcu/tree.c   | 90 ++++++++++++++++++++++++---------------------
>  mm/page_alloc.c     | 82 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 132 insertions(+), 41 deletions(-)
> 
> -- 
> 2.20.1
> 
