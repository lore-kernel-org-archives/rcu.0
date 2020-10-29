Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB62C2D0A3
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 20:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177192076D
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 20:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604003638;
	bh=i5JSP3Ju+n/u07BQSPYOWy3h0OR7adt0iTAk9czs5W4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=m+Z0OFJFXmQBNLmQWUGWAtyzvQPt0Ns+IL9m1M/m6p4k/v8idIXIZfFty6Z+qScW5
	 37ssHFvHXQJnnyU9BRpqdUQc9G8PSSgGR8WdwmlUWnraJZmmQBUG7hwpdRa74qb78G
	 L4axrW/7EpAXoQM/vfnVpeA8rSaL+kL4Fver9TVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgJ2Ud5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 16:33:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgJ2Ud5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 16:33:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 487AA2072E;
        Thu, 29 Oct 2020 20:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604003636;
        bh=i5JSP3Ju+n/u07BQSPYOWy3h0OR7adt0iTAk9czs5W4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qZz8/dRFMW+toKDcbQCiKfJI020I1ImK3PGiwcZqSUpYw7P8M1qUPQ52IVHa2xfrc
         AJzhh8zvUDD5cQYlqF1XMemGG6sHg7iqfEFHH7LMWzQwzdYu4rjCp/ork/EHXRsG2J
         2r3W2NQYQ4ASN8Xlxjb5SqM3cnDlfmevqpn2guUI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D9CE235225DF; Thu, 29 Oct 2020 13:33:55 -0700 (PDT)
Date:   Thu, 29 Oct 2020 13:33:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 16/16] rcu/tree: Use delayed work instead of hrtimer to
 refill the cache
Message-ID: <20201029203355.GO3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201029165019.14218-1-urezki@gmail.com>
 <20201029165019.14218-16-urezki@gmail.com>
 <20201029194724.GN3249@paulmck-ThinkPad-P72>
 <20201029201342.GA24122@pc636>
 <20201029202241.GA24399@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201029202241.GA24399@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 29, 2020 at 09:22:41PM +0100, Uladzislau Rezki wrote:
> On Thu, Oct 29, 2020 at 09:13:42PM +0100, Uladzislau Rezki wrote:
> > On Thu, Oct 29, 2020 at 12:47:24PM -0700, Paul E. McKenney wrote:
> > > On Thu, Oct 29, 2020 at 05:50:19PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > A CONFIG_PREEMPT_COUNT is unconditionally enabled, thus a page
> > > > can be obtained directly from a kvfree_rcu() path. To distinguish
> > > > that and take a decision the preemptable() macro is used when it
> > > > is save to enter allocator.
> > > > 
> > > > It means that refilling a cache is not important from timing point
> > > > of view. Switch to a delayed work, so the actual work is queued from
> > > > the timer interrupt with 1 jiffy delay. An immediate placing a task
> > > > on a current CPU can lead to rq->lock double lock. That is why a
> > > > delayed method is in place.
> > > > 
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > 
> > > Thank you, Uladzislau!
> > > 
> > > I applied this on top of v5.10-rc1 and got the following from the
> > > single-CPU builds:
> > > 
> > >   SYNC    include/config/auto.conf.cmd
> > >   DESCEND  objtool
> > >   CC      kernel/bounds.s
> > >   CALL    scripts/atomic/check-atomics.sh
> > >   UPD     include/generated/bounds.h
> > >   CC      arch/x86/kernel/asm-offsets.s
> > > In file included from ./include/asm-generic/atomic-instrumented.h:20:0,
> > >                  from ./include/linux/atomic.h:82,
> > >                  from ./include/linux/crypto.h:15,
> > >                  from arch/x86/kernel/asm-offsets.c:9:
> > > ./include/linux/pagemap.h: In function ‘__page_cache_add_speculative’:
> > > ./include/linux/build_bug.h:30:34: error: called object is not a function or function pointer
> > >  #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
> > >                                  ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > ./include/linux/mmdebug.h:45:25: note: in expansion of macro ‘BUILD_BUG_ON_INVALID’
> > >  #define VM_BUG_ON(cond) BUILD_BUG_ON_INVALID(cond)
> > >                          ^~~~~~~~~~~~~~~~~~~~
> > > ./include/linux/pagemap.h:207:2: note: in expansion of macro ‘VM_BUG_ON’
> > >   VM_BUG_ON(preemptible())
> > >   ^~~~~~~~~
> > > scripts/Makefile.build:117: recipe for target 'arch/x86/kernel/asm-offsets.s' failed
> > > make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1
> > > Makefile:1199: recipe for target 'prepare0' failed
> > > make: *** [prepare0] Error 2
> > > 
> > > I vaguely recall something like this showing up in the previous series
> > > and that we did something or another to address it.  Could you please
> > > check against the old series at -rcu branch dev.2020.10.22a?  (I verified
> > > that the old series does run correctly in the single-CPU scenarios.)
> > > 
> > I see the same build error. Will double check if we have similar in the
> > previous series also. It looks like the error is caused by the Thomas series.
> > 
> > Will check!
> > 
> OK. Found it:
> 
> urezki@pc638:~/data/coding/linux.git$ git diff
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index cbfbe2bcca75..7dd3523093db 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -204,7 +204,7 @@ void release_pages(struct page **pages, int nr);
>  static inline int __page_cache_add_speculative(struct page *page, int count)
>  {
>  #ifdef CONFIG_TINY_RCU
> -       VM_BUG_ON(preemptible())
> +       VM_BUG_ON(preemptible());
>         /*
>          * Preempt must be disabled here - we rely on rcu_read_lock doing
>          * this for us.
> urezki@pc638:~/data/coding/linux.git$
> 
> I guess we had some extra patch that fixes a kernel compilation for !SMP
> case. Will check dev.2020.10.22a.

I guess I am blind today!

And yes, that semicolon is in the corresponding commit in -tip.

So, an important safety tip:  When forward porting, start from the
commits that have been tested rather than from the original series
of patches.  ;-)

							Thanx, Paul
