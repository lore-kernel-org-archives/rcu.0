Return-Path: <SRS0=4XKx=DI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5227FC4727E
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 16:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4AC120848
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601569719;
	bh=06LQkY9IlXJfgXC7Wh55LnpusDxLGBsMuKUUmE57yVs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=WMJ2LM//NBsLM1c5awvcx2VZlGlWWL6bVCB+MU+f2SR9BSUyW0/jDhbqbwUznydvI
	 DukK045pz2exmGRLklwVMPECSv0FdCxj07O+B8tOfx6um65DjpRTkITxp4sAMwBB5K
	 J4kgP9u0STWV+0LYq8Ym3fOY7THqysxQ7F6/t/w4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbgJAQ2i (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Oct 2020 12:28:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730534AbgJAQ2g (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Oct 2020 12:28:36 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC16620759;
        Thu,  1 Oct 2020 16:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601569715;
        bh=06LQkY9IlXJfgXC7Wh55LnpusDxLGBsMuKUUmE57yVs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bFiZqfthdzJPwxRJ/8lWpAEhyiI9OHzQre5d0GNAvkSaw3gnif2i6tyB6dRkUJCfu
         mLk/+M6OpQHO/xqk/+N631yxHroEfDsrEDdwNeIKxIzkIKFAfiQyVdPmrlJdSZt0NC
         SGc8lNPCxxAgGKriqJkw5z6DzqYnN3prL2Ta1XKU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6E92D3522B33; Thu,  1 Oct 2020 09:28:35 -0700 (PDT)
Date:   Thu, 1 Oct 2020 09:28:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 14/15] rcu/tree: Allocate a page when caller
 is preemptible
Message-ID: <20201001162835.GE29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
 <20200928233102.24265-14-paulmck@kernel.org>
 <20200929120756.GC2277@dhcp22.suse.cz>
 <20200930015327.GX29330@paulmck-ThinkPad-P72>
 <20200930084139.GN2277@dhcp22.suse.cz>
 <20200930232154.GA29330@paulmck-ThinkPad-P72>
 <20201001090220.GA22560@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001090220.GA22560@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 01, 2020 at 11:02:20AM +0200, Michal Hocko wrote:
> On Wed 30-09-20 16:21:54, Paul E. McKenney wrote:

[ . . . ]

Hit "send" too soon, apologies...

> > ------------------------------------------------------------------------
> > 
> > commit 490b638d7c241ac06cee168ccf8688bb8b872478
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Wed Sep 30 16:16:39 2020 -0700
> > 
> >     kvfree_rcu(): Switch from kmalloc/kfree to __get_free_page/free_page.
> >     
> >     The advantages of using kmalloc() and kfree() are a possible small speedup
> >     on CONFIG_SLAB=y systems, avoiding the allocation-side cast, and use of
> >     more-familiar API members.  The advantages of using __get_free_page()
> >     and free_page() are a possible reduction in fragmentation and direct
> >     access to the buddy allocator.
> >     
> >     To help settle the question as to which to use, this commit switches
> >     from kmalloc() and kfree() to __get_free_page() and free_page().
> >     
> >     Suggested-by: Michal Hocko <mhocko@suse.com>
> >     Suggested-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Yes, looks good to me. I am not entirely sure about the fragmentation
> argument. It really depends on the SL.B allocator internals. The same
> applies for the potential speed up. I would be even surprised if the
> SLAB was faster in average considering it has to use the page allocator
> as well. So to me the primary motivation would be "use the right tool
> for the purpose".

Very well, I will update the commit message, and thank you!

							Thanx, Paul

> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 2886e81..242f0f0 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3225,7 +3225,8 @@ static void kfree_rcu_work(struct work_struct *work)
> >  				bkvhead[i] = NULL;
> >  			krc_this_cpu_unlock(krcp, flags);
> >  
> > -			kfree(bkvhead[i]);
> > +			if (bkvhead[i])
> > +				free_page((unsigned long)bkvhead[i]);
> >  
> >  			cond_resched_tasks_rcu_qs();
> >  		}
> > @@ -3378,7 +3379,7 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> >  		bnode = get_cached_bnode(*krcp);
> >  		if (!bnode && can_alloc_page) {
> >  			krc_this_cpu_unlock(*krcp, *flags);
> > -			bnode = kmalloc(PAGE_SIZE, gfp);
> > +			bnode = (struct kvfree_rcu_bulk_data *)__get_free_page(gfp);
> >  			*krcp = krc_this_cpu_lock(flags);
> >  		}
> >  
> 
> -- 
> Michal Hocko
> SUSE Labs
