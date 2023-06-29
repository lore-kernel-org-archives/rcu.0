Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E56EB64D9
	for <rcu@archiver.kernel.org>; Thu, 29 Jun 2023 14:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjF2OUx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Jun 2023 10:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjF2OUo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Jun 2023 10:20:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3196610F8
        for <rcu@vger.kernel.org>; Thu, 29 Jun 2023 07:20:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBABC61558
        for <rcu@vger.kernel.org>; Thu, 29 Jun 2023 14:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E76BC433C8;
        Thu, 29 Jun 2023 14:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688048442;
        bh=mYdc0uF+M1eKCnwEaFZdDUgfLW2kY5Uz4xG0IO0yJBE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mYRGu1dBHv8r3CTx1Sd63uPyCHrEmTYwTzgQH9WQ9nMYZBMsf8HiGpCSSe+/UHMWb
         iHK1fqJl3HusJpdH8zcKo4NI8OP6tmMeLAaYMDYJuxRR4oaB4i4DygZXgOZXqXd/wA
         2UZ3EDOzzd17xeHoZkmf3jIePGzQwHMH66pkSPmZBbAGHvwWvRxOMjqJcwE4Fr3V3C
         xmjOJ27z+XAl7S+WCzdoN3FvbXll6pIOBCQLhyKHtG3gVaHcNxbBN+06x8r/QULK5E
         SMUcC4RZrLXY4qwJ7d6FnJZUZpJbRT8D/WCpcKpSdzyArV7ggk0skAXWKQ9zr8VtZb
         ovz3x4MV4pW0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B588ACE0367; Thu, 29 Jun 2023 07:20:41 -0700 (PDT)
Date:   Thu, 29 Jun 2023 07:20:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Vernet <void@manifault.com>,
        Hou Tao <houtao@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
        rcu@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 12/13] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
Message-ID: <6f3af3f6-5aeb-40c2-b4ab-612d824ca33b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
 <20230628015634.33193-13-alexei.starovoitov@gmail.com>
 <6f8e0e91-44b4-4d0e-8df3-c1e765653255@paulmck-laptop>
 <CAADnVQJq+NA0denwyr56jYz73n5BnkKF_GtY0zpwqsSvCrGs6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJq+NA0denwyr56jYz73n5BnkKF_GtY0zpwqsSvCrGs6Q@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 28, 2023 at 08:52:12PM -0700, Alexei Starovoitov wrote:
> On Wed, Jun 28, 2023 at 10:57 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Jun 27, 2023 at 06:56:33PM -0700, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Introduce bpf_mem_[cache_]free_rcu() similar to kfree_rcu().
> > > Unlike bpf_mem_[cache_]free() that links objects for immediate reuse into
> > > per-cpu free list the _rcu() flavor waits for RCU grace period and then moves
> > > objects into free_by_rcu_ttrace list where they are waiting for RCU
> > > task trace grace period to be freed into slab.
> > >
> > > The life cycle of objects:
> > > alloc: dequeue free_llist
> > > free: enqeueu free_llist
> > > free_rcu: enqueue free_by_rcu -> waiting_for_gp
> > > free_llist above high watermark -> free_by_rcu_ttrace
> > > after RCU GP waiting_for_gp -> free_by_rcu_ttrace
> > > free_by_rcu_ttrace -> waiting_for_gp_ttrace -> slab
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > >  include/linux/bpf_mem_alloc.h |   2 +
> > >  kernel/bpf/memalloc.c         | 129 +++++++++++++++++++++++++++++++++-
> > >  2 files changed, 128 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
> > > index 3929be5743f4..d644bbb298af 100644
> > > --- a/include/linux/bpf_mem_alloc.h
> > > +++ b/include/linux/bpf_mem_alloc.h
> > > @@ -27,10 +27,12 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
> > >  /* kmalloc/kfree equivalent: */
> > >  void *bpf_mem_alloc(struct bpf_mem_alloc *ma, size_t size);
> > >  void bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr);
> > > +void bpf_mem_free_rcu(struct bpf_mem_alloc *ma, void *ptr);
> > >
> > >  /* kmem_cache_alloc/free equivalent: */
> > >  void *bpf_mem_cache_alloc(struct bpf_mem_alloc *ma);
> > >  void bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr);
> > > +void bpf_mem_cache_free_rcu(struct bpf_mem_alloc *ma, void *ptr);
> > >  void bpf_mem_cache_raw_free(void *ptr);
> > >  void *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags);
> > >
> > > diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> > > index 40524d9454c7..3081d06a434c 100644
> > > --- a/kernel/bpf/memalloc.c
> > > +++ b/kernel/bpf/memalloc.c
> > > @@ -101,6 +101,15 @@ struct bpf_mem_cache {
> > >       bool draining;
> > >       struct bpf_mem_cache *tgt;
> > >
> > > +     /* list of objects to be freed after RCU GP */
> > > +     struct llist_head free_by_rcu;
> > > +     struct llist_node *free_by_rcu_tail;
> > > +     struct llist_head waiting_for_gp;
> > > +     struct llist_node *waiting_for_gp_tail;
> > > +     struct rcu_head rcu;
> > > +     atomic_t call_rcu_in_progress;
> > > +     struct llist_head free_llist_extra_rcu;
> > > +
> > >       /* list of objects to be freed after RCU tasks trace GP */
> > >       struct llist_head free_by_rcu_ttrace;
> > >       struct llist_head waiting_for_gp_ttrace;
> > > @@ -344,6 +353,69 @@ static void free_bulk(struct bpf_mem_cache *c)
> > >       do_call_rcu_ttrace(tgt);
> > >  }
> > >
> > > +static void __free_by_rcu(struct rcu_head *head)
> > > +{
> > > +     struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
> > > +     struct bpf_mem_cache *tgt = c->tgt;
> > > +     struct llist_node *llnode;
> > > +
> > > +     llnode = llist_del_all(&c->waiting_for_gp);
> > > +     if (!llnode)
> > > +             goto out;
> > > +
> > > +     llist_add_batch(llnode, c->waiting_for_gp_tail, &tgt->free_by_rcu_ttrace);
> > > +
> > > +     /* Objects went through regular RCU GP. Send them to RCU tasks trace */
> > > +     do_call_rcu_ttrace(tgt);
> > > +out:
> > > +     atomic_set(&c->call_rcu_in_progress, 0);
> > > +}
> > > +
> > > +static void check_free_by_rcu(struct bpf_mem_cache *c)
> > > +{
> > > +     struct llist_node *llnode, *t;
> > > +     unsigned long flags;
> > > +
> > > +     /* drain free_llist_extra_rcu */
> > > +     if (unlikely(!llist_empty(&c->free_llist_extra_rcu))) {
> > > +             inc_active(c, &flags);
> > > +             llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra_rcu))
> > > +                     if (__llist_add(llnode, &c->free_by_rcu))
> > > +                             c->free_by_rcu_tail = llnode;
> > > +             dec_active(c, flags);
> > > +     }
> > > +
> > > +     if (llist_empty(&c->free_by_rcu))
> > > +             return;
> > > +
> > > +     if (atomic_xchg(&c->call_rcu_in_progress, 1)) {
> > > +             /*
> > > +              * Instead of kmalloc-ing new rcu_head and triggering 10k
> > > +              * call_rcu() to hit rcutree.qhimark and force RCU to notice
> > > +              * the overload just ask RCU to hurry up. There could be many
> > > +              * objects in free_by_rcu list.
> > > +              * This hint reduces memory consumption for an artifical
> > > +              * benchmark from 2 Gbyte to 150 Mbyte.
> > > +              */
> > > +             rcu_request_urgent_qs_task(current);
> >
> > I have been going back and forth on whether rcu_request_urgent_qs_task()
> > needs to throttle calls to itself, for example, to pay attention to only
> > one invocation per jiffy.  The theory here is that RCU's state machine
> > normally only advances about once per jiffy anyway.
> >
> > The main risk of *not* throttling is if several CPUs were to invoke
> > rcu_request_urgent_qs_task() in tight loops while those same CPUs were
> > undergoing interrupt storms, which would result in heavy lock contention
> > in __rcu_irq_enter_check_tick().  This is not exactly a common-case
> > scenario, but on the other hand, if you are having this degree of trouble,
> > should RCU really be adding lock contention to your troubles?
> 
> I see spin_lock in __rcu_irq_enter_check_tick(), but I didn't observe
> it in practice even when I was calling rcu_request_urgent_qs_task()
> in multiple places through bpf_mem_alloc.
> I left it only in one place (this patch),
> because it was enough to 'hurry up the RCU' and make the difference.
> rdp = this_cpu_ptr(&rcu_data); is percpu, so I'm not sure why
> you think that the contention is possible.
> I think we should avoid extra logic either in RCU or in bpf_mem_alloc
> to keep the code simple, since contention is hypothetical at this point.
> I've tried preempt and no preempt configs. With and without debug.

Thank you for checking.

The trick in __rcu_irq_enter_check_tick() is this:

	raw_spin_lock_rcu_node(rdp->mynode);

This is not acquiring a per-CPU lock, but rather the lock on the
leaf rcu_node structure, which by default is shared by 16 CPUs.
So if there was a moderate interrupt storm on several of the CPUs
sharing a given leaf rcu_node structure while there were frequnt calls
to rcu_request_urgent_qs_task()), you could see lock contention, and
possibly rather heavy lock contention.

But it would need to be a moderate interrupt storm, that is, enough
to force contention on that lock, but not enough to prevent the CPU
from executing rcu_request_urgent_qs_task() frequently enough to force
__rcu_irq_enter_check_tick() to acquire that lock almost every time.

So, given that this is likely to be quite difficult (and perhaps even
impossible) to trigger, I am happy to leave this alone unless/until
it becomes a problem.  At that point, the problem might be solved by
adjusting the new callers (who might or might not be in BPF), in which
case the code could remain the same.  Or rcu_request_urgent_qs_task()
might prove necessary at that point.

But I figured that I should at least let you guys know of this
possibility.

Yes, I am paranoid.  Which is why RCU works at all.  ;-)

							Thanx, Paul
