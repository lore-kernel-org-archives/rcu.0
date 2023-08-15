Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F871C001B0
	for <rcu@archiver.kernel.org>; Tue, 15 Aug 2023 17:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjHORsn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Aug 2023 13:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbjHORsY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Aug 2023 13:48:24 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4905AD1
        for <rcu@vger.kernel.org>; Tue, 15 Aug 2023 10:48:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so77796721fa.0
        for <rcu@vger.kernel.org>; Tue, 15 Aug 2023 10:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692121701; x=1692726501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtRRClBsbPOaEg7wxatEI6J6XmHkOuuMG+0csdoRO1U=;
        b=PEVez5hrJaH1R++6oSlkStE8xAmiQTLqa6u3ulC3WL/oackR4srhRqh+AC8mVy2OJm
         2DpaZ0ym9OPTMTNQu7bYBxUqfdO0JxehxLJDPPEe0VpPtmPHHkZ/ztivlMGDVTKhOoG+
         aSVD3j94jHmZGaBuWrQu3LRW4wRXHmZhMRWhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692121701; x=1692726501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtRRClBsbPOaEg7wxatEI6J6XmHkOuuMG+0csdoRO1U=;
        b=ERkUW/+OMsEMzYLjT4LZFkNct/2L2isF1sDlaeSaeiEPhWuMRUU0SWPC+ksYvYnVxs
         U+xoErxx00zp2U0ofNS3nd3Z0yS0zWm9gHld3PkrOUA4gJ2xK38SBXnl9HLQE3acwLuU
         B3MHuk57Jzko/IxgvwEXqcMzhJkL8BNmchy0dSTENoxLobXKARscTO71GWJWvYlmvEQP
         i0haadhqHWRNtKSrdzUGAp/4itx6CfgtY1boK5DkjaIAqCz/8yoMkN3R61PsVDkPtvmz
         MjX/Wj2RWUHFrbWqvdDe8KZnxbrrc1lAA35ahbh6AF0FQILKgbTYjppsK/e+yRQRf9P2
         orYQ==
X-Gm-Message-State: AOJu0Yz0AY85YFiPy9t8E3spen83XEhXZxa8u1Za1t2DwUXCHNO9TbIh
        60eUkKelrM7Qci2o7JTHDWs9glOBogUX8AAGkQp+h44Jgz/Rt4Uog6A=
X-Google-Smtp-Source: AGHT+IFhMmNfvTxGM0FGDII2weUA5BtxiK8GuOC9nmi7zRGd8UAnZghOXZ2jqoSoO4RrSwX8GG4728If5d892e9I6l0=
X-Received: by 2002:a05:6512:4024:b0:4f8:4b19:9533 with SMTP id
 br36-20020a056512402400b004f84b199533mr761664lfb.19.1692121701328; Tue, 15
 Aug 2023 10:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <CALm+0cXrCHAPHEOrLyn6ms551mAo=RyHTLUhzOLfRK4ZVMp4jQ@mail.gmail.com>
In-Reply-To: <CALm+0cXrCHAPHEOrLyn6ms551mAo=RyHTLUhzOLfRK4ZVMp4jQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 15 Aug 2023 13:48:10 -0400
Message-ID: <CAEXW_YRn-k1HxpAWyEqH2qp00dVyWwu=6je7f3s87Zsho=5Pog@mail.gmail.com>
Subject: Re: rcutorture: Sleeping function called from invalid context
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        thunder.leizhen@huawei.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 15, 2023 at 1:44=E2=80=AFAM Z qiang <qiang.zhang1211@gmail.com>=
 wrote:
>
> Hello, Paul
>
> when running the rcutorture test with rcutorture.object_debug=3D1 in
> PREEMPT_RT kernel.
>
> BUG: sleeping function called from invalid context at
> kernel/locking/spinlock_rt.c:48
> [    3.116503] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid:
> 1, name: swapper/0
> [    3.116503] preempt_count: 1, expected: 0
> [    3.116503] RCU nest depth: 1, expected: 1
> [    3.116503] 3 locks held by swapper/0/1:
> [    3.116503]  #0: ffffffff8f862d80 (fullstop_mutex){+.+.}-{4:4}, at:
> torture_init_begin+0x24/0xa0
> [    3.116503]  #1: ffffffff8f7b1400 (rcu_read_lock){....}-{1:3}, at:
> rcu_torture_init+0x20b9/0x2380
> [    3.116503]  #2: ffffffff8f89fa20 (vmap_area_lock){+.+.}-{3:3}, at:
> find_vmap_area+0x21/0x90
> [    3.116503] irq event stamp: 571506
> [    3.116503] hardirqs last  enabled at (571505):
> [<ffffffff8d422ff5>] __call_rcu_common+0x3a5/0xdc0
> [    3.116503] hardirqs last disabled at (571506):
> [<ffffffff900487f7>] rcu_torture_init+0x22b7/0x2380
> [    3.116503] softirqs last  enabled at (406916):
> [<ffffffff8d2e91f2>] __local_bh_enable_ip+0x132/0x170
> [    3.116503] softirqs last disabled at (406910):
> [<ffffffff8e658e79>] inet_register_protosw+0x9/0x190
> [    3.116503] Preemption disabled at:
> [    3.116503] [<ffffffff9004865a>] rcu_torture_init+0x211a/0x2380
> [    3.116503] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W
>    6.5.0-rc4-rt2-yocto-preempt-rt+ #7
> [    3.116503] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [    3.116503] Call Trace:
> [    3.116503]  <TASK>
> [    3.116503]  dump_stack_lvl+0x68/0xb0
> [    3.116503]  dump_stack+0x14/0x20
> [    3.116503]  __might_resched+0x221/0x2f0
> [    3.116503]  rt_spin_lock+0x60/0x130
> [    3.116503]  ? find_vmap_area+0x21/0x90
> [    3.116503]  find_vmap_area+0x21/0x90
> [    3.116503]  vmalloc_dump_obj+0x25/0xa0
> [    3.116503]  mem_dump_obj+0x22/0x90
> [    3.116503]  __call_rcu_common+0x920/0xdc0
> [    3.116503]  ? __pfx_rcu_torture_err_cb+0x10/0x10
> [    3.116503]  ? __pfx___call_rcu_common+0x10/0x10
> [    3.116503]  ? rcu_torture_init+0x22b7/0x2380
> [    3.116503]  ? debug_smp_processor_id+0x1b/0x30
> [    3.116503]  ? rcu_is_watching+0x3e/0xc0
> [    3.116503]  call_rcu_hurry+0x14/0x20
> [    3.116503]  rcu_torture_init+0x2186/0x2380
> [    3.116503]  ? __pfx_rcu_torture_init+0x10/0x10
> [    3.116503]  ? __pfx_rt_mutex_slowunlock+0x10/0x10
> [    3.116503]  ? __pfx_irq_debugfs_init+0x10/0x10
> [    3.116503]  ? __pfx_rcu_torture_leak_cb+0x10/0x10
> [    3.116503]  ? rt_spin_unlock+0x50/0xa0
> [    3.116503]  ? add_device_randomness+0xb1/0xe0
> [    3.116503]  ? __pfx_rcu_torture_leak_cb+0x10/0x10
> [    3.116503]  ? __pfx_rcu_torture_init+0x10/0x10
> [    3.116503]  do_one_initcall+0xd8/0x430
> [    3.116503]  ? __pfx_do_one_initcall+0x10/0x10
> [    3.116503]  ? __kasan_check_read+0x15/0x20
> [    3.116503]  kernel_init_freeable+0x3a0/0x670
> [    3.116503]  ? rt_spin_unlock+0x50/0xa0
> [    3.116503]  ? __pfx_kernel_init+0x10/0x10
> [    3.116503]  kernel_init+0x23/0x160
> [    3.116503]  ? __pfx_kernel_init+0x10/0x10
> [    3.116503]  ret_from_fork+0x40/0x60
> [    3.116503]  ? __pfx_kernel_init+0x10/0x10
> [    3.116503]  ret_from_fork_asm+0x1b/0x30
> [    3.116503]  </TASK>
> [    3.116503]  non-slab/vmalloc memory
>
>
> as described by Lei Zhen:
>
> v2 --> v3:
> 1. I made statistics about the source of 'rhp'. kmem_valid_obj() accounts=
 for
>    more than 97.5%, and vmalloc accounts for less than 1%. So change call
>    mem_dump_obj() to call kmem_dump_obj() can meet debugging requirements=
 and
>    avoid the potential deadlock risk of vmalloc_dump_obj().
> -               mem_dump_obj(rhp);
> +               if (kmem_valid_obj(rhp))
> +                       kmem_dump_obj(rhp);
>

I kind of dislike that even if it is just 1%.

Another option is, Could you do the object dump from irq_work if it is
a vmalloc address? That way there will be no vmap area lock held and
no need to use workqueue or depend on schedule. And also disable the
dump for PREEMPT_RT (since that's SWA violation).

I feel like this is a PREEMPT_RT problem and we should not make the
!PREEMPT_RT debugging less effective for their sake.

Maybe soemthing like:

if (kmem_valid_obj(rhp)) {
  kmem_dump_obj(rhp);
} else  if (!in_interrupt() &&  !IS_ENABLED(CONFIG_PREEMPT_RT) {
    mem_dump_obj(rhp);
} else if (!IS_ENABLED(CONFIG_PREEMPT_RT))  {
    // Queue an irq work to dump, drop CB list on the floor like Paul
suggested and adjust RCU
}

?

Perhaps the above can be wrapped in a helper and generically used...

>    The discussion about vmap_area_lock deadlock in v2:
>    https://lkml.org/lkml/2022/11/11/493
>
> so whether mem_dump_obj() should also be replaced by kmem_dump_obj() in
> __call_rcu_common(),  since the call_rcu() can be called in interrupt con=
text,
> this may issue recursive spin vmap_area_lock  lock calls.

That's why it could be done from irq_work.

Thoughts?

thanks,

 - Joel
