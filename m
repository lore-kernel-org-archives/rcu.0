Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D37EE4993
	for <rcu@archiver.kernel.org>; Tue, 22 Aug 2023 19:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjHVTLK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Aug 2023 15:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjHVTLK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Aug 2023 15:11:10 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEC1137
        for <rcu@vger.kernel.org>; Tue, 22 Aug 2023 12:11:05 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so81144431fa.2
        for <rcu@vger.kernel.org>; Tue, 22 Aug 2023 12:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692731463; x=1693336263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsPKpEcjCwDFTAYOHgz1nFvcM5Y54q3MiPViP8F93Xc=;
        b=ZIWUVQagzIaAGzuNccmp98mW6aw8SBKxDym7kvHeJtmEvd05zJs4Gj4MiPn32HIU8x
         6dkxGeh7GbGgXK3CCJUonbqMMUtFuALyJtj9pvOzBP/pfC6/zZaK9JYQPeJi3+oFGg21
         PgyOBIfRCPptjYQ5EK0Adq2GuW9sqkrA4qYrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692731463; x=1693336263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsPKpEcjCwDFTAYOHgz1nFvcM5Y54q3MiPViP8F93Xc=;
        b=IDnoIVRMajryz54fbrZuZXZj6P4am4BlIEPVh8Gxlxe7dwC3ZydP5BoNpyrcUPGRq1
         OpOGHfZyDWqH7i86qJNmK0t+8Odtj21Iax2pnU24sQKRrdr3FgHO8JHzBtYmrZe1bELm
         oFYo5aRtYxPXHhH0EKntB6wRfb+F33weSY1m16zRxFpnFaJvRZWm9aXM6ppyKxKlcwyp
         hN8CwYSXXbKEbtrffU2uJG1dhMK2Ok/sZVdXitIn9iVBd+UL7y5UQgD+4M9RJVYwQERj
         Hp8DuKcd/aMYzc/RUj4ae7McvqPuV/aizLlSRxPtrAdenPEbzV4KojK67yh9Do8B6fdC
         aL1A==
X-Gm-Message-State: AOJu0Yys4KSjUDFuNg5xfsWrJqeMw5AedR5gXkcqxexOJg9wKSy+gWpz
        ay1pZqtoAZFWkAUp00R/P4/Jgn+ZrQqF1zw1L6cGFkdUGh3rEAB+
X-Google-Smtp-Source: AGHT+IGXPYXkxlKnVC+7gSqHPN4JlOKys/QR7uyCj3onrnLA86rv+rGi9XpWAbQN7oXngGKFJjOcTzyJdRvOyvOV/8c=
X-Received: by 2002:a2e:8796:0:b0:2bc:cff6:f506 with SMTP id
 n22-20020a2e8796000000b002bccff6f506mr2369889lji.0.1692731463377; Tue, 22 Aug
 2023 12:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230817063429.31454-1-qiang.zhang1211@gmail.com> <92857602-6314-4b81-ab37-ded05abdbad9@paulmck-laptop>
In-Reply-To: <92857602-6314-4b81-ab37-ded05abdbad9@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 22 Aug 2023 15:10:52 -0400
Message-ID: <CAEXW_YQkjAK_x_PNpBqJVRpoQdhH5_Dvt41nfSz760bGN-GnxQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: Drop vmalloc memory info dump when double call_rcu()
To:     paulmck@kernel.org
Cc:     Zqiang <qiang.zhang1211@gmail.com>, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 22, 2023 at 8:50=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Aug 17, 2023 at 02:34:29PM +0800, Zqiang wrote:
> > Currently, for double invoke call_rcu(), will dump rcu_head objects
> > memory info, if the objects is not allocated from the slab allocator,
> > the vmalloc_dump_obj() will be invoke and the vmap_area_lock spinlock
> > need to be held, since the call_rcu() can be invoked in interrupt conte=
xt,
> > therefore, there is a possibility of spinlock deadlock scenarios.
> >
> > And in Preempt-RT kernel, the rcutorture test also trigger the followin=
g
> > lockdep warning:
> >
> > BUG: sleeping function called from invalid context at kernel/locking/sp=
inlock_rt.c:48
> > in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper=
/0
> > preempt_count: 1, expected: 0
> > RCU nest depth: 1, expected: 1
> > 3 locks held by swapper/0/1:
> >  #0: ffffffffb534ee80 (fullstop_mutex){+.+.}-{4:4}, at: torture_init_be=
gin+0x24/0xa0
> >  #1: ffffffffb5307940 (rcu_read_lock){....}-{1:3}, at: rcu_torture_init=
+0x1ec7/0x2370
> >  #2: ffffffffb536af40 (vmap_area_lock){+.+.}-{3:3}, at: find_vmap_area+=
0x1f/0x70
> > irq event stamp: 565512
> > hardirqs last  enabled at (565511): [<ffffffffb379b138>] __call_rcu_com=
mon+0x218/0x940
> > hardirqs last disabled at (565512): [<ffffffffb5804262>] rcu_torture_in=
it+0x20b2/0x2370
> > softirqs last  enabled at (399112): [<ffffffffb36b2586>] __local_bh_ena=
ble_ip+0x126/0x170
> > softirqs last disabled at (399106): [<ffffffffb43fef59>] inet_register_=
protosw+0x9/0x1d0
> > Preemption disabled at:
> > [<ffffffffb58040c3>] rcu_torture_init+0x1f13/0x2370
> > CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.5.0-rc4-rt=
2-yocto-preempt-rt+ #15
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-g=
ea1b7a073390-prebuilt.qemu.org 04/01/2014
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x68/0xb0
> >  dump_stack+0x14/0x20
> >  __might_resched+0x1aa/0x280
> >  ? __pfx_rcu_torture_err_cb+0x10/0x10
> >  rt_spin_lock+0x53/0x130
> >  ? find_vmap_area+0x1f/0x70
> >  find_vmap_area+0x1f/0x70
> >  vmalloc_dump_obj+0x20/0x60
> >  mem_dump_obj+0x22/0x90
> >  __call_rcu_common+0x5bf/0x940
> >  ? debug_smp_processor_id+0x1b/0x30
> >  call_rcu_hurry+0x14/0x20
> >  rcu_torture_init+0x1f82/0x2370
> >  ? __pfx_rcu_torture_leak_cb+0x10/0x10
> >  ? __pfx_rcu_torture_leak_cb+0x10/0x10
> >  ? __pfx_rcu_torture_init+0x10/0x10
> >  do_one_initcall+0x6c/0x300
> >  ? debug_smp_processor_id+0x1b/0x30
> >  kernel_init_freeable+0x2b9/0x540
> >  ? __pfx_kernel_init+0x10/0x10
> >  kernel_init+0x1f/0x150
> >  ret_from_fork+0x40/0x50
> >  ? __pfx_kernel_init+0x10/0x10
> >  ret_from_fork_asm+0x1b/0x30
> >  </TASK>
> >
> > The statistics about the source of 'rhp', the kmem_valid_obj() accounts
> > for more than 97.5%, and vmalloc accounts for less than 1%, this statis=
tic
> > comes from leizhen. this commit therefore drop vmalloc_dump_obj() from
> > mem_dump_obj() and only check whether is vmalloc address.
> >
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>
> Hearing no objections, I pulled this into -rcu, but only for testing.
>
> It should either go up via mm or accumulate maintainer acks for me to
> take it, as the case may be.

I was wondering if we can opportunistically acquire the vmap_area_lock
and keep the debug some of the times (I suggested this idea in another
thread).

Thanks.
