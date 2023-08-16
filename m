Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97035C04A6A
	for <rcu@archiver.kernel.org>; Wed, 16 Aug 2023 02:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbjHPCOB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Aug 2023 22:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241217AbjHPCNo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Aug 2023 22:13:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443CDC1
        for <rcu@vger.kernel.org>; Tue, 15 Aug 2023 19:13:43 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-26b10e52ef8so2874265a91.2
        for <rcu@vger.kernel.org>; Tue, 15 Aug 2023 19:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692152023; x=1692756823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wrbweJgWRLFzcuIvyk5c1MhBmzt3N/h+BBQb1qhskU=;
        b=a/iFDhL5jPAcG7KrKiA6T6FpazCsO/rB5Z4ada97Fs9QVbTkySPCkWJxJ7tjghhELm
         tzCEi+GyklNmVPUE7zBdJSEqN4cRGymQhc9L78lx0vXvNqYTMVHSXcb65djflLPKML71
         ZFmcFlX1hynmekMgs8LLo7GQ+rJZ991Cm/QAi7HZrhcpdqRSABsBgdgxcqg4/4WeJzG4
         RWfiGpu10+3cmFuNg+GTysE1XTwNg00NGtc8RxvrEoaxaIV9AcAZgkIZQHQccjbFVmF4
         8Rqsjw+DN63SKrUkE93g1zLRTskHdwIJsxNIuLst0OJtWrfajbA6AKRQm9vMCt7zIIFv
         +MSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692152023; x=1692756823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wrbweJgWRLFzcuIvyk5c1MhBmzt3N/h+BBQb1qhskU=;
        b=ikmOBJxqpawzAdZhpwMOG5S1qy9nWTaSEY9ewGvkTNf/QJ4qBjiUTZbPHM8M0cUl/n
         ALW4vlIN99MsO1dULjBiKPih47IKgURgdl9wD5iXXZ8e0qcZMaAdGx9385rJhNpNxw0a
         btW/6mSsHymP62v8PqE8r4X9pXqXs0tpr/uhGjtGj0h/SLPY/6n1/pqyCU+ybr+DAo8P
         bZlSMBDU6KCPIVL3vmGJU6H1GrSy0/kCE3yDE7A/+EsPGYnIziPsDDc+XeKoi46zIWZr
         tZKiGKAtba0hLree98gomi7odV+YT+VBuazEqGcDVPZPr8cyTygpJ6iDh6RfYmDF2tw7
         1NLg==
X-Gm-Message-State: AOJu0Yw01J/UqfHX0/IdecVfg2qjJRNttPosO5k2uvBAnBS6+FmoBMQo
        1hlUG9a2vUvoQlIiUCGJ2N+n5LtRzsp8ZPHNa9+OBBPzcgU=
X-Google-Smtp-Source: AGHT+IHfumdRMIdnvOQGYUsAS4JbQEgDECUptQ/X0uzGmyg8iA5MDZqa/wGnmrGHaW1bG2G553rcYYrOoXNmS6/71eY=
X-Received: by 2002:a17:90b:3b89:b0:267:fe44:86c3 with SMTP id
 pc9-20020a17090b3b8900b00267fe4486c3mr308793pjb.31.1692152022623; Tue, 15 Aug
 2023 19:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <CALm+0cXrCHAPHEOrLyn6ms551mAo=RyHTLUhzOLfRK4ZVMp4jQ@mail.gmail.com>
 <CAEXW_YRn-k1HxpAWyEqH2qp00dVyWwu=6je7f3s87Zsho=5Pog@mail.gmail.com>
In-Reply-To: <CAEXW_YRn-k1HxpAWyEqH2qp00dVyWwu=6je7f3s87Zsho=5Pog@mail.gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Wed, 16 Aug 2023 10:13:30 +0800
Message-ID: <CALm+0cUuX=Fgswq2L_+tN=kzZ+xEaC6tkbGf2r71SmnAhnKqSg@mail.gmail.com>
Subject: Re: rcutorture: Sleeping function called from invalid context
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        thunder.leizhen@huawei.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

>
> On Tue, Aug 15, 2023 at 1:44=E2=80=AFAM Z qiang <qiang.zhang1211@gmail.co=
m> wrote:
> >
> > Hello, Paul
> >
> > when running the rcutorture test with rcutorture.object_debug=3D1 in
> > PREEMPT_RT kernel.
> >
> > BUG: sleeping function called from invalid context at
> > kernel/locking/spinlock_rt.c:48
> > [    3.116503] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid:
> > 1, name: swapper/0
> > [    3.116503] preempt_count: 1, expected: 0
> > [    3.116503] RCU nest depth: 1, expected: 1
> > [    3.116503] 3 locks held by swapper/0/1:
> > [    3.116503]  #0: ffffffff8f862d80 (fullstop_mutex){+.+.}-{4:4}, at:
> > torture_init_begin+0x24/0xa0
> > [    3.116503]  #1: ffffffff8f7b1400 (rcu_read_lock){....}-{1:3}, at:
> > rcu_torture_init+0x20b9/0x2380
> > [    3.116503]  #2: ffffffff8f89fa20 (vmap_area_lock){+.+.}-{3:3}, at:
> > find_vmap_area+0x21/0x90
> > [    3.116503] irq event stamp: 571506
> > [    3.116503] hardirqs last  enabled at (571505):
> > [<ffffffff8d422ff5>] __call_rcu_common+0x3a5/0xdc0
> > [    3.116503] hardirqs last disabled at (571506):
> > [<ffffffff900487f7>] rcu_torture_init+0x22b7/0x2380
> > [    3.116503] softirqs last  enabled at (406916):
> > [<ffffffff8d2e91f2>] __local_bh_enable_ip+0x132/0x170
> > [    3.116503] softirqs last disabled at (406910):
> > [<ffffffff8e658e79>] inet_register_protosw+0x9/0x190
> > [    3.116503] Preemption disabled at:
> > [    3.116503] [<ffffffff9004865a>] rcu_torture_init+0x211a/0x2380
> > [    3.116503] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W
> >    6.5.0-rc4-rt2-yocto-preempt-rt+ #7
> > [    3.116503] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> > [    3.116503] Call Trace:
> > [    3.116503]  <TASK>
> > [    3.116503]  dump_stack_lvl+0x68/0xb0
> > [    3.116503]  dump_stack+0x14/0x20
> > [    3.116503]  __might_resched+0x221/0x2f0
> > [    3.116503]  rt_spin_lock+0x60/0x130
> > [    3.116503]  ? find_vmap_area+0x21/0x90
> > [    3.116503]  find_vmap_area+0x21/0x90
> > [    3.116503]  vmalloc_dump_obj+0x25/0xa0
> > [    3.116503]  mem_dump_obj+0x22/0x90
> > [    3.116503]  __call_rcu_common+0x920/0xdc0
> > [    3.116503]  ? __pfx_rcu_torture_err_cb+0x10/0x10
> > [    3.116503]  ? __pfx___call_rcu_common+0x10/0x10
> > [    3.116503]  ? rcu_torture_init+0x22b7/0x2380
> > [    3.116503]  ? debug_smp_processor_id+0x1b/0x30
> > [    3.116503]  ? rcu_is_watching+0x3e/0xc0
> > [    3.116503]  call_rcu_hurry+0x14/0x20
> > [    3.116503]  rcu_torture_init+0x2186/0x2380
> > [    3.116503]  ? __pfx_rcu_torture_init+0x10/0x10
> > [    3.116503]  ? __pfx_rt_mutex_slowunlock+0x10/0x10
> > [    3.116503]  ? __pfx_irq_debugfs_init+0x10/0x10
> > [    3.116503]  ? __pfx_rcu_torture_leak_cb+0x10/0x10
> > [    3.116503]  ? rt_spin_unlock+0x50/0xa0
> > [    3.116503]  ? add_device_randomness+0xb1/0xe0
> > [    3.116503]  ? __pfx_rcu_torture_leak_cb+0x10/0x10
> > [    3.116503]  ? __pfx_rcu_torture_init+0x10/0x10
> > [    3.116503]  do_one_initcall+0xd8/0x430
> > [    3.116503]  ? __pfx_do_one_initcall+0x10/0x10
> > [    3.116503]  ? __kasan_check_read+0x15/0x20
> > [    3.116503]  kernel_init_freeable+0x3a0/0x670
> > [    3.116503]  ? rt_spin_unlock+0x50/0xa0
> > [    3.116503]  ? __pfx_kernel_init+0x10/0x10
> > [    3.116503]  kernel_init+0x23/0x160
> > [    3.116503]  ? __pfx_kernel_init+0x10/0x10
> > [    3.116503]  ret_from_fork+0x40/0x60
> > [    3.116503]  ? __pfx_kernel_init+0x10/0x10
> > [    3.116503]  ret_from_fork_asm+0x1b/0x30
> > [    3.116503]  </TASK>
> > [    3.116503]  non-slab/vmalloc memory
> >
> >
> > as described by Lei Zhen:
> >
> > v2 --> v3:
> > 1. I made statistics about the source of 'rhp'. kmem_valid_obj() accoun=
ts for
> >    more than 97.5%, and vmalloc accounts for less than 1%. So change ca=
ll
> >    mem_dump_obj() to call kmem_dump_obj() can meet debugging requiremen=
ts and
> >    avoid the potential deadlock risk of vmalloc_dump_obj().
> > -               mem_dump_obj(rhp);
> > +               if (kmem_valid_obj(rhp))
> > +                       kmem_dump_obj(rhp);
> >
>
> I kind of dislike that even if it is just 1%.
>
> Another option is, Could you do the object dump from irq_work if it is
> a vmalloc address? That way there will be no vmap area lock held and
> no need to use workqueue or depend on schedule. And also disable the
> dump for PREEMPT_RT (since that's SWA violation).
>

Hello Joel

Actually I want to know, is it necessary to dump the information of vmalloc


>
> I feel like this is a PREEMPT_RT problem and we should not make the
> !PREEMPT_RT debugging less effective for their sake.
>
> Maybe soemthing like:
>
> if (kmem_valid_obj(rhp)) {
>   kmem_dump_obj(rhp);
> } else  if (!in_interrupt() &&  !IS_ENABLED(CONFIG_PREEMPT_RT) {
>     mem_dump_obj(rhp);
> } else if (!IS_ENABLED(CONFIG_PREEMPT_RT))  {
>     // Queue an irq work to dump, drop CB list on the floor like Paul
> suggested and adjust RCU
> }

I did something like this earlier:

https://lore.kernel.org/lkml/20221118003441.3980437-1-qiang1.zhang@intel.co=
m/

Thanks
Zqiang

>
> ?
>
> Perhaps the above can be wrapped in a helper and generically used...
>
> >    The discussion about vmap_area_lock deadlock in v2:
> >    https://lkml.org/lkml/2022/11/11/493
> >
> > so whether mem_dump_obj() should also be replaced by kmem_dump_obj() in
> > __call_rcu_common(),  since the call_rcu() can be called in interrupt c=
ontext,
> > this may issue recursive spin vmap_area_lock  lock calls.
>
> That's why it could be done from irq_work.
>
> Thoughts?
>
> thanks,
>
>  - Joel
