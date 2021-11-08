Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0FEC433F5
	for <rcu@archiver.kernel.org>; Mon,  8 Nov 2021 11:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8757761181
	for <rcu@archiver.kernel.org>; Mon,  8 Nov 2021 11:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbhKHLpb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 8 Nov 2021 06:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239319AbhKHLpa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 8 Nov 2021 06:45:30 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2001CC061570
        for <rcu@vger.kernel.org>; Mon,  8 Nov 2021 03:42:46 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id b31-20020a4a98e2000000b002bce352296cso5778269ooj.1
        for <rcu@vger.kernel.org>; Mon, 08 Nov 2021 03:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t0CLCOJqTl97SWBVXsn+FLxAY1FZRpeC0I3mqMnmY7M=;
        b=YeQ9YEBX0/EP2xCb4Fta2SNFU7V+AoXW9wHVW96D2JLtRlaqyRxueKtSfWfueRA0Zy
         /mTnyskH/Ya3wSfbksZ5oTVSCRUsfZVQERTE9AKK1I8uceYm2F+AA2nvNKCTSSqjeOil
         egnAujjAzh6v6qasb5a2o5w1Hl5eEyjfng94BvfTRjUl8eYBK5BA4jcF9jqTACjn+k0B
         FE2npDNJWFqx4z5dbvMylRmamqqzBhH/13RNLjYYikMHx5iU5Ydg/E0V0afws/pVN/+h
         R4IUvfifL9C5AtMnTmxRdr/Li5RKVaHc35GvaUSJ3MOg29MpzfwuNkpS6XuusFt3z7Kt
         nMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t0CLCOJqTl97SWBVXsn+FLxAY1FZRpeC0I3mqMnmY7M=;
        b=Aq5IYoIgCuAUYlXrH8eTd7gzrEvzKDZN756GE3VuMx49+Kz7a00UsNq6ol/wSScmm9
         nNWpP0u89Vey4V8ICX8OlEG3WTNtccj9lSOGfK22pdVMnUqIEfyFghFpDmh70EZyLIzt
         ONiOZXErM1fGYy0NT4+cvNNffrB2orAsrr/koubQrhSVR9ZGJLuwYCQkU/WupCMTR6ZJ
         0AuoYjVHleJAZRydi1pYXCudkNhxrVigsFua2aNPx6SHzFj6Y3krQy7HzWX3kLqRr6H1
         6OU8+XTrhpFobFXxD9Dfx1vMuOjeXVcNcO0Z+BE9YQFqCHxbau5kFSeR83Z9uPuztuWs
         7bgg==
X-Gm-Message-State: AOAM53278R/EywNigdLvK9RnxRLNq1I7jhpmfX5QgAy7MtqFGCKQT0OX
        kyW5mzy0AyPtmd2Cz6IYdRaZZ0sMCV4tbglWVhOSnw==
X-Google-Smtp-Source: ABdhPJwMq0zCvcdOH8Kk+ghhIqH6+gsgQtW4xZS7m3AB5AtS+GQRFYGvZUE6VWhUikati0pKXGYi3h7bHwumcPWQAHc=
X-Received: by 2002:a4a:b385:: with SMTP id p5mr21194703ooo.21.1636371764628;
 Mon, 08 Nov 2021 03:42:44 -0800 (PST)
MIME-Version: 1.0
References: <20211101103158.3725704-1-jun.miao@windriver.com>
 <96f9d669-b9da-f387-199e-e6bf36081fbd@windriver.com> <CA+KHdyU98uHkf1VKbvFs0wcXz7SaizENRXn4BEpKJhe+KmXZuw@mail.gmail.com>
 <baa768a3-aacf-ba3a-8d20-0abc78eca2f7@windriver.com> <CA+KHdyUEtBQjh61Xx+4a-AS0+z18CW1W5GzaRVsihuy=PUpUxA@mail.gmail.com>
 <20211103181315.GT880162@paulmck-ThinkPad-P17-Gen-1> <20211103212117.GA631708@paulmck-ThinkPad-P17-Gen-1>
 <309b8284-1c31-7cc4-eb40-ba6d8d136c09@windriver.com> <20211104012843.GD641268@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20211104012843.GD641268@paulmck-ThinkPad-P17-Gen-1>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 8 Nov 2021 12:42:33 +0100
Message-ID: <CACT4Y+bih9gX2+XvRh3q7XYe8rbgCDF5=5eMV8cxBimvPLQtug@mail.gmail.com>
Subject: Re: [PATCH] rcu: avoid alloc_pages() when recording stack
To:     paulmck@kernel.org, kasan-dev <kasan-dev@googlegroups.com>
Cc:     Jun Miao <jun.miao@windriver.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        qiang.zhang1211@gmail.com, RCU <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, miaojun0823@163.com,
        ryabinin.a.a@gmail.com, Alexander Potapenko <glider@google.com>,
        jianwei.hu@windriver.com, melver@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 4 Nov 2021 at 02:28, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Nov 04, 2021 at 09:09:24AM +0800, Jun Miao wrote:
> >
> > On 11/4/21 5:21 AM, Paul E. McKenney wrote:
> > > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > >
> > > On Wed, Nov 03, 2021 at 11:13:15AM -0700, Paul E. McKenney wrote:
> > > > On Wed, Nov 03, 2021 at 02:55:48PM +0100, Uladzislau Rezki wrote:
> > > > > On Wed, Nov 3, 2021 at 7:51 AM Jun Miao <jun.miao@windriver.com> =
wrote:
> > > > > >
> > > > > > On 11/2/21 10:53 PM, Uladzislau Rezki wrote:
> > > > > > > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > > > > > >
> > > > > > > > Add KASAN maintainers
> > > > > > > >
> > > > > > > > On 11/1/21 6:31 PM, Jun Miao wrote:
> > > > > > > > > The default kasan_record_aux_stack() calls stack_depot_sa=
ve() with GFP_NOWAIT,
> > > > > > > > > which in turn can then call alloc_pages(GFP_NOWAIT, ...).=
  In general, however,
> > > > > > > > > it is not even possible to use either GFP_ATOMIC nor GFP_=
NOWAIT in certain
> > > > > > > > > non-preemptive contexts/RT kernel including raw_spin_lock=
s (see gfp.h and ab00db216c9c7).
> > > > > > > > >
> > > > > > > > > Fix it by instructing stackdepot to not expand stack stor=
age via alloc_pages()
> > > > > > > > > in case it runs out by using kasan_record_aux_stack_noall=
oc().
> > > > > > > > >
> > > > > > > > > Jianwei Hu reported:
> > > > > > > > >     BUG: sleeping function called from invalid context at=
 kernel/locking/rtmutex.c:969
> > > > > > > > >     in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid=
: 15319, name: python3
> > > > > > > > >     INFO: lockdep is turned off.
> > > > > > > > >     irq event stamp: 0
> > > > > > > > >     hardirqs last  enabled at (0): [<0000000000000000>] 0=
x0
> > > > > > > > >     hardirqs last disabled at (0): [<ffffffff856c8b13>] c=
opy_process+0xaf3/0x2590
> > > > > > > > >     softirqs last  enabled at (0): [<ffffffff856c8b13>] c=
opy_process+0xaf3/0x2590
> > > > > > > > >     softirqs last disabled at (0): [<0000000000000000>] 0=
x0
> > > > > > > > >     CPU: 6 PID: 15319 Comm: python3 Tainted: G        W  =
O 5.15-rc7-preempt-rt #1
> > > > > > > > >     Hardware name: Supermicro SYS-E300-9A-8C/A2SDi-8C-HLN=
4F, BIOS 1.1b 12/17/2018
> > > > > > > > >     Call Trace:
> > > > > > > > >      show_stack+0x52/0x58
> > > > > > > > >      dump_stack+0xa1/0xd6
> > > > > > > > >      ___might_sleep.cold+0x11c/0x12d
> > > > > > > > >      rt_spin_lock+0x3f/0xc0
> > > > > > > > >      rmqueue+0x100/0x1460
> > > > > > > > >      rmqueue+0x100/0x1460
> > > > > > > > >      mark_usage+0x1a0/0x1a0
> > > > > > > > >      ftrace_graph_ret_addr+0x2a/0xb0
> > > > > > > > >      rmqueue_pcplist.constprop.0+0x6a0/0x6a0
> > > > > > > > >       __kasan_check_read+0x11/0x20
> > > > > > > > >       __zone_watermark_ok+0x114/0x270
> > > > > > > > >       get_page_from_freelist+0x148/0x630
> > > > > > > > >       is_module_text_address+0x32/0xa0
> > > > > > > > >       __alloc_pages_nodemask+0x2f6/0x790
> > > > > > > > >       __alloc_pages_slowpath.constprop.0+0x12d0/0x12d0
> > > > > > > > >       create_prof_cpu_mask+0x30/0x30
> > > > > > > > >       alloc_pages_current+0xb1/0x150
> > > > > > > > >       stack_depot_save+0x39f/0x490
> > > > > > > > >       kasan_save_stack+0x42/0x50
> > > > > > > > >       kasan_save_stack+0x23/0x50
> > > > > > > > >       kasan_record_aux_stack+0xa9/0xc0
> > > > > > > > >       __call_rcu+0xff/0x9c0
> > > > > > > > >       call_rcu+0xe/0x10
> > > > > > > > >       put_object+0x53/0x70
> > > > > > > > >       __delete_object+0x7b/0x90
> > > > > > > > >       kmemleak_free+0x46/0x70
> > > > > > > > >       slab_free_freelist_hook+0xb4/0x160
> > > > > > > > >       kfree+0xe5/0x420
> > > > > > > > >       kfree_const+0x17/0x30
> > > > > > > > >       kobject_cleanup+0xaa/0x230
> > > > > > > > >       kobject_put+0x76/0x90
> > > > > > > > >       netdev_queue_update_kobjects+0x17d/0x1f0
> > > > > > > > >       ... ...
> > > > > > > > >       ksys_write+0xd9/0x180
> > > > > > > > >       __x64_sys_write+0x42/0x50
> > > > > > > > >       do_syscall_64+0x38/0x50
> > > > > > > > >       entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > > > > > >
> > > > > > > > > Fixes: 84109ab58590 ("rcu: Record kvfree_call_rcu() call =
stack for KASAN")
> > > > > > > > > Fixes: 26e760c9a7c8 ("rcu: kasan: record and print call_r=
cu() call stack")
> > > > > > > > > Reported-by: Jianwei Hu <jianwei.hu@windriver.com>
> > > > > > > > > Signed-off-by: Jun Miao <jun.miao@windriver.com>
> > > > > > > > > ---
> > > > > > > > >     kernel/rcu/tree.c | 4 ++--
> > > > > > > > >     1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > > > index 8270e58cd0f3..2c1034580f15 100644
> > > > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > > > @@ -3026,7 +3026,7 @@ __call_rcu(struct rcu_head *head, r=
cu_callback_t func)
> > > > > > > > >         head->func =3D func;
> > > > > > > > >         head->next =3D NULL;
> > > > > > > > >         local_irq_save(flags);
> > > > > > > > > -     kasan_record_aux_stack(head);
> > > > > > > > > +     kasan_record_aux_stack_noalloc(head);
> > > > > > > > >         rdp =3D this_cpu_ptr(&rcu_data);
> > > > > > > > >
> > > > > > > > >         /* Add the callback to our list. */
> > > > > > > > > @@ -3591,7 +3591,7 @@ void kvfree_call_rcu(struct rcu_hea=
d *head, rcu_callback_t func)
> > > > > > > > >                 return;
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > -     kasan_record_aux_stack(ptr);
> > > > > > > > > +     kasan_record_aux_stack_noalloc(ptr);
> > > > > > > > >         success =3D add_ptr_to_bulk_krc_lock(&krcp, &flag=
s, ptr, !head);
> > > > > > > > >         if (!success) {
> > > > > > > > >                 run_page_cache_worker(krcp);
> > > > > > > Yep an allocation is tricky here. This change looks correct t=
o me at
> > > > > > > least from the point that it does not allocate.
> > > > > > >
> > > > > > > --
> > > > > > > Uladzislau Rezki
> > > > > > Thanks your approval. Could you like to give me a review?
> > > > > >
> > > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > I have queued it for review and testing, thank you both!  I do have
> > > > some remaining concerns about this code being starved for memory.  =
I am
> > > > wondering if the code needs to check the interrupt state.  And perh=
aps
> > > > also whether locks are held.  I of course will refrain from sending
> > > > this to mainline until these concerns are resolved.
> > > >
> > > > Marco, Dmitry, thoughts?
> > > Well, the compiler does have an opinion:
> > >
> > > kernel/rcu/tree.c: In function =E2=80=98__call_rcu=E2=80=99:
> > > kernel/rcu/tree.c:3029:2: error: implicit declaration of function =E2=
=80=98kasan_record_aux_stack_noalloc=E2=80=99; did you mean =E2=80=98kasan_=
record_aux_stack=E2=80=99? [-Werror=3Dimplicit-function-declaration]
> > >   3029 |  kasan_record_aux_stack_noalloc(head);
> > >        |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >        |  kasan_record_aux_stack
> > >
> > > I get the same message after merging in current mainline.
> > >
> > > I have therefore dropped this patch for the time being.
> > >
> > >                                                          Thanx, Paul
> > Hi Paul E,
> > The kasan_record_aux_stack_noalloc() is just introduce to linux-next no=
w,
> > and marking "Notice: this object is not reachable from any branch." in
> > commit.
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/include/linux/kasan.h?h=3Dnext-20211029&id=3D2f64acf6b653d01fbdc92a693f=
12bbf71a205926
>
> That would explain it!  Feel free to resend once the functionality is
> more generally available.

+kasan-dev@googlegroups.com mailing list

I found the full commit with kasan_record_aux_stack_noalloc() implementatio=
n:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?h=3Dnext-20211029&id=3D2f64acf6b653d01fbdc92a693f12bbf71a205926

but it calls kasan_save_stack() with second bool argument, and
kasan_save_stack() accepts only 1 argument:
https://elixir.bootlin.com/linux/latest/source/mm/kasan/common.c#L33
so I am lost and can't comment on any of the Paul's questions re
interrupts/spinlocks.

When re-sending this, please add kasan-dev@ mailing list and add links
to the dependencies.

Thanks
