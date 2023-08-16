Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAFCC27C53
	for <rcu@archiver.kernel.org>; Wed, 16 Aug 2023 22:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347045AbjHPW6j (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Aug 2023 18:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347130AbjHPW6a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Aug 2023 18:58:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4B62D4F
        for <rcu@vger.kernel.org>; Wed, 16 Aug 2023 15:58:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45FF96301D
        for <rcu@vger.kernel.org>; Wed, 16 Aug 2023 22:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE57BC433C8;
        Wed, 16 Aug 2023 22:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692226697;
        bh=gQJRguFSaWV5FEPN8kCQDUOHiel5maAcvENgSiO/8mM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ksOHXniLPhy3bWs4oysbEhmzIru3i/x7eEIKayb1fIdKALGKXQAPCxXDxMwsus/4L
         5+U8bKwlsVGx4D+gnZYXVqnMsuuej3DH4l9GjFbNux7sEnTQYd89kcGkJ4qKHbU0IU
         VSWuhIKrh7rTRYDyL4+EqnJo6M8imIIiWrG0/tANbYAcK5fX5F4eA5hCGMICu7jMy3
         rFj3Motok+zAlyxfEtRnWXAqiKZRC+iRegUJ3cUJ3yQTAZBcILOj9DZc+anZHKxjhG
         lVfBwjAxZwtazmwOtJiL+gvrU0a6jwCSi79J5Ki981Nm60LqObB/QzOVnUdlQh+a/g
         SVqj1vgy85AJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 56643CE0593; Wed, 16 Aug 2023 15:58:17 -0700 (PDT)
Date:   Wed, 16 Aug 2023 15:58:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Z qiang <qiang.zhang1211@gmail.com>, thunder.leizhen@huawei.com,
        rcu@vger.kernel.org
Subject: Re: rcutorture: Sleeping function called from invalid context
Message-ID: <912313fc-8a73-49bc-bb3b-90f26ea92ef4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CALm+0cWehH6Ff4ADVv7mRWDk5=CjYxPWi9OtQXh5j=UZrp9+Zw@mail.gmail.com>
 <E930E069-2566-4B98-99D4-440DE2AC6FAF@joelfernandes.org>
 <95ec65cf-92d0-4a41-9f25-74a1d537933f@paulmck-laptop>
 <CAEXW_YTtmo_kcGrVo9AJ1dfNAgqUx0Fcx9=b8vzYFNbGhDS--A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTtmo_kcGrVo9AJ1dfNAgqUx0Fcx9=b8vzYFNbGhDS--A@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 16, 2023 at 12:28:49PM -0400, Joel Fernandes wrote:
> On Wed, Aug 16, 2023 at 9:41 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Aug 16, 2023 at 08:25:49AM -0400, Joel Fernandes wrote:
> > > > On Aug 16, 2023, at 5:30 AM, Z qiang <qiang.zhang1211@gmail.com> wrote:
> > > >>>> On Tue, Aug 15, 2023 at 1:44 AM Z qiang <qiang.zhang1211@gmail.com> wrote:
> > > >>>>>
> > > >>>>> Hello, Paul
> > > >>>>>
> > > >>>>> when running the rcutorture test with rcutorture.object_debug=1 in
> > > >>>>> PREEMPT_RT kernel.
> > > >>>>>
> > > >>>>> BUG: sleeping function called from invalid context at
> > > >>>>> kernel/locking/spinlock_rt.c:48
> > > >>>>> [    3.116503] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid:
> > > >>>>> 1, name: swapper/0
> > > >>>>> [    3.116503] preempt_count: 1, expected: 0
> > > >>>>> [    3.116503] RCU nest depth: 1, expected: 1
> > > >>>>> [    3.116503] 3 locks held by swapper/0/1:
> > > >>>>> [    3.116503]  #0: ffffffff8f862d80 (fullstop_mutex){+.+.}-{4:4}, at:
> > > >>>>> torture_init_begin+0x24/0xa0
> > > >>>>> [    3.116503]  #1: ffffffff8f7b1400 (rcu_read_lock){....}-{1:3}, at:
> > > >>>>> rcu_torture_init+0x20b9/0x2380
> > > >>>>> [    3.116503]  #2: ffffffff8f89fa20 (vmap_area_lock){+.+.}-{3:3}, at:
> > > >>>>> find_vmap_area+0x21/0x90
> > > >>>>> [    3.116503] irq event stamp: 571506
> > > >>>>> [    3.116503] hardirqs last  enabled at (571505):
> > > >>>>> [<ffffffff8d422ff5>] __call_rcu_common+0x3a5/0xdc0
> > > >>>>> [    3.116503] hardirqs last disabled at (571506):
> > > >>>>> [<ffffffff900487f7>] rcu_torture_init+0x22b7/0x2380
> > > >>>>> [    3.116503] softirqs last  enabled at (406916):
> > > >>>>> [<ffffffff8d2e91f2>] __local_bh_enable_ip+0x132/0x170
> > > >>>>> [    3.116503] softirqs last disabled at (406910):
> > > >>>>> [<ffffffff8e658e79>] inet_register_protosw+0x9/0x190
> > > >>>>> [    3.116503] Preemption disabled at:
> > > >>>>> [    3.116503] [<ffffffff9004865a>] rcu_torture_init+0x211a/0x2380
> > > >>>>> [    3.116503] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W
> > > >>>>>   6.5.0-rc4-rt2-yocto-preempt-rt+ #7
> > > >>>>> [    3.116503] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > > >>>>> BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> > > >>>>> [    3.116503] Call Trace:
> > > >>>>> [    3.116503]  <TASK>
> > > >>>>> [    3.116503]  dump_stack_lvl+0x68/0xb0
> > > >>>>> [    3.116503]  dump_stack+0x14/0x20
> > > >>>>> [    3.116503]  __might_resched+0x221/0x2f0
> > > >>>>> [    3.116503]  rt_spin_lock+0x60/0x130
> > > >>>>> [    3.116503]  ? find_vmap_area+0x21/0x90
> > > >>>>> [    3.116503]  find_vmap_area+0x21/0x90
> > > >>>>> [    3.116503]  vmalloc_dump_obj+0x25/0xa0
> > > >>>>> [    3.116503]  mem_dump_obj+0x22/0x90
> > > >>>>> [    3.116503]  __call_rcu_common+0x920/0xdc0
> > > >>>>> [    3.116503]  ? __pfx_rcu_torture_err_cb+0x10/0x10
> > > >>>>> [    3.116503]  ? __pfx___call_rcu_common+0x10/0x10
> > > >>>>> [    3.116503]  ? rcu_torture_init+0x22b7/0x2380
> > > >>>>> [    3.116503]  ? debug_smp_processor_id+0x1b/0x30
> > > >>>>> [    3.116503]  ? rcu_is_watching+0x3e/0xc0
> > > >>>>> [    3.116503]  call_rcu_hurry+0x14/0x20
> > > >>>>> [    3.116503]  rcu_torture_init+0x2186/0x2380
> > > >>>>> [    3.116503]  ? __pfx_rcu_torture_init+0x10/0x10
> > > >>>>> [    3.116503]  ? __pfx_rt_mutex_slowunlock+0x10/0x10
> > > >>>>> [    3.116503]  ? __pfx_irq_debugfs_init+0x10/0x10
> > > >>>>> [    3.116503]  ? __pfx_rcu_torture_leak_cb+0x10/0x10
> > > >>>>> [    3.116503]  ? rt_spin_unlock+0x50/0xa0
> > > >>>>> [    3.116503]  ? add_device_randomness+0xb1/0xe0
> > > >>>>> [    3.116503]  ? __pfx_rcu_torture_leak_cb+0x10/0x10
> > > >>>>> [    3.116503]  ? __pfx_rcu_torture_init+0x10/0x10
> > > >>>>> [    3.116503]  do_one_initcall+0xd8/0x430
> > > >>>>> [    3.116503]  ? __pfx_do_one_initcall+0x10/0x10
> > > >>>>> [    3.116503]  ? __kasan_check_read+0x15/0x20
> > > >>>>> [    3.116503]  kernel_init_freeable+0x3a0/0x670
> > > >>>>> [    3.116503]  ? rt_spin_unlock+0x50/0xa0
> > > >>>>> [    3.116503]  ? __pfx_kernel_init+0x10/0x10
> > > >>>>> [    3.116503]  kernel_init+0x23/0x160
> > > >>>>> [    3.116503]  ? __pfx_kernel_init+0x10/0x10
> > > >>>>> [    3.116503]  ret_from_fork+0x40/0x60
> > > >>>>> [    3.116503]  ? __pfx_kernel_init+0x10/0x10
> > > >>>>> [    3.116503]  ret_from_fork_asm+0x1b/0x30
> > > >>>>> [    3.116503]  </TASK>
> > > >>>>> [    3.116503]  non-slab/vmalloc memory
> > > >>>>>
> > > >>>>>
> > > >>>>> as described by Lei Zhen:
> > > >>>>>
> > > >>>>> v2 --> v3:
> > > >>>>> 1. I made statistics about the source of 'rhp'. kmem_valid_obj() accounts for
> > > >>>>>   more than 97.5%, and vmalloc accounts for less than 1%. So change call
> > > >>>>>   mem_dump_obj() to call kmem_dump_obj() can meet debugging requirements and
> > > >>>>>   avoid the potential deadlock risk of vmalloc_dump_obj().
> > > >>>>> -               mem_dump_obj(rhp);
> > > >>>>> +               if (kmem_valid_obj(rhp))
> > > >>>>> +                       kmem_dump_obj(rhp);
> > > >>>>>
> > > >>>
> > > >>> I kind of dislike that even if it is just 1%.
> > > >>>
> > > >>> Another option is, Could you do the object dump from irq_work if it is
> > > >>> a vmalloc address? That way there will be no vmap area lock held and
> > > >>> no need to use workqueue or depend on schedule. And also disable the
> > > >>> dump for PREEMPT_RT (since that's SWA violation).
> > > >>
> > > >>>
> > > >>
> > > >> Hello Joel
> > > >>
> > > >> Actually I want to know, is it necessary to dump the information of vmalloc
> > >
> > > I see. That is worth looking into..
> > >
> > > >>
> > > >>
> > > >>>
> > > >>> I feel like this is a PREEMPT_RT problem and we should not make the
> > > >>> !PREEMPT_RT debugging less effective for their sake.
> > > >>>
> > > >>> Maybe soemthing like:
> > > >>>
> > > >>> if (kmem_valid_obj(rhp)) {
> > > >>>  kmem_dump_obj(rhp);
> > > >>> } else  if (!in_interrupt() &&  !IS_ENABLED(CONFIG_PREEMPT_RT) {
> > > >>>    mem_dump_obj(rhp);
> > > >>> } else if (!IS_ENABLED(CONFIG_PREEMPT_RT))  {
> > > >>>    // Queue an irq work to dump, drop CB list on the floor like Paul
> > > >>> suggested and adjust RCU
> > > >>> }
> > > >>
> > > >> I did something like this earlier:
> > > >>
> > > >> https://lore.kernel.org/lkml/20221118003441.3980437-1-qiang1.zhang@intel.com/
> > >
> > > Cool.
> > >
> > > >>
> > > >>>
> > > >>> ?
> > > >>>
> > > >>> Perhaps the above can be wrapped in a helper and generically used...
> > > >>>
> > > >>>>   The discussion about vmap_area_lock deadlock in v2:
> > > >>>>   https://lkml.org/lkml/2022/11/11/493
> > > >>>>
> > > >>>> so whether mem_dump_obj() should also be replaced by kmem_dump_obj() in
> > > >>>> __call_rcu_common(),  since the call_rcu() can be called in interrupt context,
> > > >>>> this may issue recursive spin vmap_area_lock  lock calls.
> > > >>>
> > > >>> That's why it could be done from irq_work.
> > > >>>
> > > >>> Thoughts?
> > > >
> > > > Even with irq_work to dump vmalloc info also need held vmap_area_lock spinlock,
> > > > need to make sure that the vm_struct object is not freed
> > >
> > > This is true, I realized only after just sending my email. The trick I was referring
> > > to was avoidance of deadlocks for irq disabled spin locks but this one is not.
> > >
> > > So perhaps WQ it is then.. or dropping vmalloc debug..
> >
> > But only for PREEMPT_RT, correct?  Or does the problem also extend to
> > !PREEMPT_RT?
> 
> For vmalloc debug, it appears from this conversation that even for
> !PREEMPT_RT, we need to defer it to a later time to avoid the
> deadlock.
> 
> PREEMPT_RT adds additional complexity where now the deferred context
> needs to allow sleeping as well.
> 
> Correct me if I'm wrong, Paul, Z and Leizhen, thanks.

That sounds all too sadly accurate.  :-(

							Thanx, Paul
