Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219AEC41513
	for <rcu@archiver.kernel.org>; Wed, 16 Aug 2023 12:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245142AbjHPM0X (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Aug 2023 08:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245149AbjHPM0D (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Aug 2023 08:26:03 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD23D26BA
        for <rcu@vger.kernel.org>; Wed, 16 Aug 2023 05:26:01 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76d70d17ab8so36362685a.1
        for <rcu@vger.kernel.org>; Wed, 16 Aug 2023 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692188761; x=1692793561;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4q+/AWfRruw+pUaTshZu5HhU1JzCSSh9ho7N/WhCAOc=;
        b=CZaHN99qKgnzLx7F6ynYXTMXrwYpMLMxhAzNAMHjttJosRHXM4H6QNJlpBkx27RliW
         +3rbjVQ7+UEO8XZI5ohPdw4jUsw66UuSGbVvTKih0JBsrOF+C6XEl6EpmrRkPQ+C6Rtm
         Bwie9sNe09D/nBp9RuLAlidw2Py/ADDwH7PHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692188761; x=1692793561;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4q+/AWfRruw+pUaTshZu5HhU1JzCSSh9ho7N/WhCAOc=;
        b=e58oWDZTHQwFWRfe5AkNn0w+vZx30oVvjHZDrvSVGTYLzkNI2DOEKqABmTdK3cUUjA
         LjRkwL3dROkLQdCq5MlCQSn/5mwg+nC69xMa6K7HmsIdEo83uOu4h/nEac0vmRG0LGkB
         6zfE9OEu1+MmPIVAFttQw35oDVVD7ejyLAKHVuodkw4QN9pEh8qwkqEtaIEFrZKrGo1W
         C9SC1tVaDecNH46tqlNAG/P0VGnBM78yRSaxy3caZIoOOUxs3fcgHZ0MM+hXGPoXuoB1
         tQcOHqEHB2ndWoZJiYlhtrSAouPhcP7sfitJVUZ7+yT+pAZpBY9dShQdz2dR4cnv0WGh
         3nTw==
X-Gm-Message-State: AOJu0Yx/3jeJ1b6oDSaY9saooYXJu6JCKjbPOeQTF91WNfmkDFlN6jI/
        yK5nZvGLVpvD/rKSQLDzVIJUuw==
X-Google-Smtp-Source: AGHT+IEtBqahOiB2k6fkOKNKHd+vM+NbLVxPSekoPLQPPvs1+zdLlATfNN4A+FOUSDWSd/BTo7uMwg==
X-Received: by 2002:a05:620a:248d:b0:76d:2764:f3b3 with SMTP id i13-20020a05620a248d00b0076d2764f3b3mr1938276qkn.56.1692188760621;
        Wed, 16 Aug 2023 05:26:00 -0700 (PDT)
Received: from smtpclient.apple ([45.88.220.68])
        by smtp.gmail.com with ESMTPSA id cx17-20020a05620a51d100b007682757a65esm4374754qkb.45.2023.08.16.05.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 05:25:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: rcutorture: Sleeping function called from invalid context
Date:   Wed, 16 Aug 2023 08:25:49 -0400
Message-Id: <E930E069-2566-4B98-99D4-440DE2AC6FAF@joelfernandes.org>
References: <CALm+0cWehH6Ff4ADVv7mRWDk5=CjYxPWi9OtQXh5j=UZrp9+Zw@mail.gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        thunder.leizhen@huawei.com, rcu@vger.kernel.org
In-Reply-To: <CALm+0cWehH6Ff4ADVv7mRWDk5=CjYxPWi9OtQXh5j=UZrp9+Zw@mail.gmail.com>
To:     Z qiang <qiang.zhang1211@gmail.com>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Aug 16, 2023, at 5:30 AM, Z qiang <qiang.zhang1211@gmail.com> wrote:
>=20
> =EF=BB=BF
>>=20
>>=20
>>>=20
>>>> On Tue, Aug 15, 2023 at 1:44=E2=80=AFAM Z qiang <qiang.zhang1211@gmail.=
com> wrote:
>>>>>=20
>>>>> Hello, Paul
>>>>>=20
>>>>> when running the rcutorture test with rcutorture.object_debug=3D1 in
>>>>> PREEMPT_RT kernel.
>>>>>=20
>>>>> BUG: sleeping function called from invalid context at
>>>>> kernel/locking/spinlock_rt.c:48
>>>>> [    3.116503] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid:
>>>>> 1, name: swapper/0
>>>>> [    3.116503] preempt_count: 1, expected: 0
>>>>> [    3.116503] RCU nest depth: 1, expected: 1
>>>>> [    3.116503] 3 locks held by swapper/0/1:
>>>>> [    3.116503]  #0: ffffffff8f862d80 (fullstop_mutex){+.+.}-{4:4}, at:=

>>>>> torture_init_begin+0x24/0xa0
>>>>> [    3.116503]  #1: ffffffff8f7b1400 (rcu_read_lock){....}-{1:3}, at:
>>>>> rcu_torture_init+0x20b9/0x2380
>>>>> [    3.116503]  #2: ffffffff8f89fa20 (vmap_area_lock){+.+.}-{3:3}, at:=

>>>>> find_vmap_area+0x21/0x90
>>>>> [    3.116503] irq event stamp: 571506
>>>>> [    3.116503] hardirqs last  enabled at (571505):
>>>>> [<ffffffff8d422ff5>] __call_rcu_common+0x3a5/0xdc0
>>>>> [    3.116503] hardirqs last disabled at (571506):
>>>>> [<ffffffff900487f7>] rcu_torture_init+0x22b7/0x2380
>>>>> [    3.116503] softirqs last  enabled at (406916):
>>>>> [<ffffffff8d2e91f2>] __local_bh_enable_ip+0x132/0x170
>>>>> [    3.116503] softirqs last disabled at (406910):
>>>>> [<ffffffff8e658e79>] inet_register_protosw+0x9/0x190
>>>>> [    3.116503] Preemption disabled at:
>>>>> [    3.116503] [<ffffffff9004865a>] rcu_torture_init+0x211a/0x2380
>>>>> [    3.116503] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W
>>>>>   6.5.0-rc4-rt2-yocto-preempt-rt+ #7
>>>>> [    3.116503] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
>>>>> BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
>>>>> [    3.116503] Call Trace:
>>>>> [    3.116503]  <TASK>
>>>>> [    3.116503]  dump_stack_lvl+0x68/0xb0
>>>>> [    3.116503]  dump_stack+0x14/0x20
>>>>> [    3.116503]  __might_resched+0x221/0x2f0
>>>>> [    3.116503]  rt_spin_lock+0x60/0x130
>>>>> [    3.116503]  ? find_vmap_area+0x21/0x90
>>>>> [    3.116503]  find_vmap_area+0x21/0x90
>>>>> [    3.116503]  vmalloc_dump_obj+0x25/0xa0
>>>>> [    3.116503]  mem_dump_obj+0x22/0x90
>>>>> [    3.116503]  __call_rcu_common+0x920/0xdc0
>>>>> [    3.116503]  ? __pfx_rcu_torture_err_cb+0x10/0x10
>>>>> [    3.116503]  ? __pfx___call_rcu_common+0x10/0x10
>>>>> [    3.116503]  ? rcu_torture_init+0x22b7/0x2380
>>>>> [    3.116503]  ? debug_smp_processor_id+0x1b/0x30
>>>>> [    3.116503]  ? rcu_is_watching+0x3e/0xc0
>>>>> [    3.116503]  call_rcu_hurry+0x14/0x20
>>>>> [    3.116503]  rcu_torture_init+0x2186/0x2380
>>>>> [    3.116503]  ? __pfx_rcu_torture_init+0x10/0x10
>>>>> [    3.116503]  ? __pfx_rt_mutex_slowunlock+0x10/0x10
>>>>> [    3.116503]  ? __pfx_irq_debugfs_init+0x10/0x10
>>>>> [    3.116503]  ? __pfx_rcu_torture_leak_cb+0x10/0x10
>>>>> [    3.116503]  ? rt_spin_unlock+0x50/0xa0
>>>>> [    3.116503]  ? add_device_randomness+0xb1/0xe0
>>>>> [    3.116503]  ? __pfx_rcu_torture_leak_cb+0x10/0x10
>>>>> [    3.116503]  ? __pfx_rcu_torture_init+0x10/0x10
>>>>> [    3.116503]  do_one_initcall+0xd8/0x430
>>>>> [    3.116503]  ? __pfx_do_one_initcall+0x10/0x10
>>>>> [    3.116503]  ? __kasan_check_read+0x15/0x20
>>>>> [    3.116503]  kernel_init_freeable+0x3a0/0x670
>>>>> [    3.116503]  ? rt_spin_unlock+0x50/0xa0
>>>>> [    3.116503]  ? __pfx_kernel_init+0x10/0x10
>>>>> [    3.116503]  kernel_init+0x23/0x160
>>>>> [    3.116503]  ? __pfx_kernel_init+0x10/0x10
>>>>> [    3.116503]  ret_from_fork+0x40/0x60
>>>>> [    3.116503]  ? __pfx_kernel_init+0x10/0x10
>>>>> [    3.116503]  ret_from_fork_asm+0x1b/0x30
>>>>> [    3.116503]  </TASK>
>>>>> [    3.116503]  non-slab/vmalloc memory
>>>>>=20
>>>>>=20
>>>>> as described by Lei Zhen:
>>>>>=20
>>>>> v2 --> v3:
>>>>> 1. I made statistics about the source of 'rhp'. kmem_valid_obj() accou=
nts for
>>>>>   more than 97.5%, and vmalloc accounts for less than 1%. So change ca=
ll
>>>>>   mem_dump_obj() to call kmem_dump_obj() can meet debugging requiremen=
ts and
>>>>>   avoid the potential deadlock risk of vmalloc_dump_obj().
>>>>> -               mem_dump_obj(rhp);
>>>>> +               if (kmem_valid_obj(rhp))
>>>>> +                       kmem_dump_obj(rhp);
>>>>>=20
>>>=20
>>> I kind of dislike that even if it is just 1%.
>>>=20
>>> Another option is, Could you do the object dump from irq_work if it is
>>> a vmalloc address? That way there will be no vmap area lock held and
>>> no need to use workqueue or depend on schedule. And also disable the
>>> dump for PREEMPT_RT (since that's SWA violation).
>>=20
>>>=20
>>=20
>> Hello Joel
>>=20
>> Actually I want to know, is it necessary to dump the information of vmall=
oc

I see. That is worth looking into..

>>=20
>>=20
>>>=20
>>> I feel like this is a PREEMPT_RT problem and we should not make the
>>> !PREEMPT_RT debugging less effective for their sake.
>>>=20
>>> Maybe soemthing like:
>>>=20
>>> if (kmem_valid_obj(rhp)) {
>>>  kmem_dump_obj(rhp);
>>> } else  if (!in_interrupt() &&  !IS_ENABLED(CONFIG_PREEMPT_RT) {
>>>    mem_dump_obj(rhp);
>>> } else if (!IS_ENABLED(CONFIG_PREEMPT_RT))  {
>>>    // Queue an irq work to dump, drop CB list on the floor like Paul
>>> suggested and adjust RCU
>>> }
>>=20
>> I did something like this earlier:
>>=20
>> https://lore.kernel.org/lkml/20221118003441.3980437-1-qiang1.zhang@intel.=
com/

Cool.

>>=20
>>>=20
>>> ?
>>>=20
>>> Perhaps the above can be wrapped in a helper and generically used...
>>>=20
>>>>   The discussion about vmap_area_lock deadlock in v2:
>>>>   https://lkml.org/lkml/2022/11/11/493
>>>>=20
>>>> so whether mem_dump_obj() should also be replaced by kmem_dump_obj() in=

>>>> __call_rcu_common(),  since the call_rcu() can be called in interrupt c=
ontext,
>>>> this may issue recursive spin vmap_area_lock  lock calls.
>>>=20
>>> That's why it could be done from irq_work.
>>>=20
>>> Thoughts?
>=20
> Even with irq_work to dump vmalloc info also need held vmap_area_lock spin=
lock,
> need to make sure that the vm_struct object is not freed

This is true, I realized only after just sending my email. The trick I was r=
eferring
to was avoidance of deadlocks for irq disabled spin locks but this one is no=
t.

So perhaps WQ it is then.. or dropping vmalloc debug..

- Joel

>=20
> Thanks
> Zqiang
>=20
>>>=20
>>> thanks,
>>>=20
>>> - Joel
