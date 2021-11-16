Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDC5C433EF
	for <rcu@archiver.kernel.org>; Tue, 16 Nov 2021 20:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6953B61414
	for <rcu@archiver.kernel.org>; Tue, 16 Nov 2021 20:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhKPUhD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Nov 2021 15:37:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhKPUhC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Nov 2021 15:37:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7519461037;
        Tue, 16 Nov 2021 20:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637094845;
        bh=l/dWLarqEiULV16loJz9pqYO1tl43IJkf7N+4+RSMzE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YLPy/WNNfSlbTj+TTVBESv/gmHmoJKN32uvTyYzN4V5tbpANersFwEMW/292UASzp
         wUqGPtBlKzik90k28oMg+JtiThX1F0EOxq0TZ/+mpAzpwW4ZQlUAR8n5e853LnSyu0
         cbwwvrf2jmaG8mDO/hcBe+26HrVmTD5nLH686HpU5VXl4JTr/yneopjFqXCmI3WAH3
         lFAn3RjCvqsm6QMbxA6CUTz7bhxBCI/tOPBSHmvANsEAd6vJDOmN4StThB64eqaEIK
         7ccshRwY3i9dOdGuUGHspO5aB2mZ41xJ6K2bRpJOH4/bQL7hzNno89XvIWgrFy4TW8
         vJC54KSjm1oTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 428345C0433; Tue, 16 Nov 2021 12:34:05 -0800 (PST)
Date:   Tue, 16 Nov 2021 12:34:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Jun Miao <jun.miao@intel.com>, urezki@gmail.com, elver@google.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, jianwei.hu@windriver.com
Subject: Re: [V2][PATCH] rcu: avoid alloc_pages() when recording stack
Message-ID: <20211116203405.GU641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1637018582-10788-1-git-send-email-jun.miao@intel.com>
 <20211116173959.osdzlvv7niyxthd6@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116173959.osdzlvv7niyxthd6@localhost.localdomain>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 16, 2021 at 05:39:59PM +0000, Juri Lelli wrote:
> Hi,
> 
> On 16/11/21 07:23, Jun Miao wrote:
> > The default kasan_record_aux_stack() calls stack_depot_save() with GFP_NOWAIT,
> > which in turn can then call alloc_pages(GFP_NOWAIT, ...).  In general, however,
> > it is not even possible to use either GFP_ATOMIC nor GFP_NOWAIT in certain
> > non-preemptive contexts/RT kernel including raw_spin_locks (see gfp.h and ab00db216c9c7).
> > Fix it by instructing stackdepot to not expand stack storage via alloc_pages()
> > in case it runs out by using kasan_record_aux_stack_noalloc().
> > 
> > Jianwei Hu reported:
> > BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:969
> > in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 15319, name: python3
> > INFO: lockdep is turned off.
> > irq event stamp: 0
> >   hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> >   hardirqs last disabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
> >   softirqs last  enabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
> >   softirqs last disabled at (0): [<0000000000000000>] 0x0
> >   CPU: 6 PID: 15319 Comm: python3 Tainted: G        W  O 5.15-rc7-preempt-rt #1
> >   Hardware name: Supermicro SYS-E300-9A-8C/A2SDi-8C-HLN4F, BIOS 1.1b 12/17/2018
> >   Call Trace:
> >     show_stack+0x52/0x58
> >     dump_stack+0xa1/0xd6
> >     ___might_sleep.cold+0x11c/0x12d
> >     rt_spin_lock+0x3f/0xc0
> >     rmqueue+0x100/0x1460
> >     rmqueue+0x100/0x1460
> >     mark_usage+0x1a0/0x1a0
> >     ftrace_graph_ret_addr+0x2a/0xb0
> >     rmqueue_pcplist.constprop.0+0x6a0/0x6a0
> >      __kasan_check_read+0x11/0x20
> >      __zone_watermark_ok+0x114/0x270
> >      get_page_from_freelist+0x148/0x630
> >      is_module_text_address+0x32/0xa0
> >      __alloc_pages_nodemask+0x2f6/0x790
> >      __alloc_pages_slowpath.constprop.0+0x12d0/0x12d0
> >      create_prof_cpu_mask+0x30/0x30
> >      alloc_pages_current+0xb1/0x150
> >      stack_depot_save+0x39f/0x490
> >      kasan_save_stack+0x42/0x50
> >      kasan_save_stack+0x23/0x50
> >      kasan_record_aux_stack+0xa9/0xc0
> >      __call_rcu+0xff/0x9c0
> >      call_rcu+0xe/0x10
> >      put_object+0x53/0x70
> >      __delete_object+0x7b/0x90
> >      kmemleak_free+0x46/0x70
> >      slab_free_freelist_hook+0xb4/0x160
> >      kfree+0xe5/0x420
> >      kfree_const+0x17/0x30
> >      kobject_cleanup+0xaa/0x230
> >      kobject_put+0x76/0x90
> >      netdev_queue_update_kobjects+0x17d/0x1f0
> >      ... ...
> >      ksys_write+0xd9/0x180
> >      __x64_sys_write+0x42/0x50
> >      do_syscall_64+0x38/0x50
> >      entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > Links: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/kasan.h?id=7cb3007ce2da27ec02a1a3211941e7fe6875b642
> > Fixes: 84109ab58590 ("rcu: Record kvfree_call_rcu() call stack for KASAN")
> > Fixes: 26e760c9a7c8 ("rcu: kasan: record and print call_rcu() call stack")
> > Reported-by: Jianwei Hu <jianwei.hu@windriver.com>
> > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Jun Miao <jun.miao@intel.com>
> > ---
> 
> I gave this a quick try on RT. No splats. Nice!
> 
> Tested-by: Juri Lelli <juri.lelli@redhat.com>

Applied with Juri's Tested-by and Marco's Acked-by.  Thank you all!

							Thanx, Paul
