Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56106C001E0
	for <rcu@archiver.kernel.org>; Tue, 15 Aug 2023 10:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjHOKHr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Aug 2023 06:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbjHOKHZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Aug 2023 06:07:25 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD30E63
        for <rcu@vger.kernel.org>; Tue, 15 Aug 2023 03:07:24 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34977c72c4aso18168545ab.2
        for <rcu@vger.kernel.org>; Tue, 15 Aug 2023 03:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692094043; x=1692698843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QBBtqf5KQVPj7uJaAXLQZWLFW1liiVoSpJEL/gw42Pk=;
        b=AZlwgHqT2l2sy6hBOuWEQG0c5AXMjD+Un+JIzVne0KVaYzyKmpCLUJ3JMNG0QEJfz7
         dzYx56KZV68Y5OMeXT8vSvOjyoXsCs9xtAntm0ECcnqIdMUE3XTDckcyJfUpZ6nW1ju+
         33A0ZGNbxf1g2UFQeOYimJ+S3nqjEjchyGZM/+eEUxzyPy1j+ntPEdT52y0k7tvr2sTQ
         yNoSRw4MvCuy2dRHpfZ2vDlLktGCGozfjsg+/VLYL+85fSFSIJy+Qk0e6n3I8FZsIoza
         DycC7337TLQNLn8etmWQXPov5XIwd8nWGKSrPj/qwsoTcewH5AI0CvxTOCnEy7sfM9bT
         ot7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692094043; x=1692698843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBBtqf5KQVPj7uJaAXLQZWLFW1liiVoSpJEL/gw42Pk=;
        b=M6V1/4XYh8DlPmpHaYkPFYj7i69fAkT+ecIhBKLXbr2F/sRiK4Cn9YkddIg9mXG1Ko
         ciq2Of9o0tiSQ8DD1AYpFpufk0vCRC94Q2vmHvtNl8+Q3rDVUANESzmV5Uy/ipFnrD6/
         251JDuyMR/6DQObChA6TOD47yKbK2bu5Itswh2nosFjrv9/zM9WqljCNjxKQ1Nx/B7LU
         KvzUpGYH2WIHLeAYMs6gXiHhivr+HolVJadBkzzmULEaWK6oNBYsEOV2lQZbLFadiLSL
         s2S+t1S+coaUabCKYvtKFMd+TAjEbNJNKcrNk730zxztejjz4MfWvjXOqnQZToEnMBba
         5WeQ==
X-Gm-Message-State: AOJu0Yzs5wJoV2eM3fIRQYgGxzZLeJ0WDn8Lr6zAn2FT0+dR/5C+ZeLZ
        A+c7ARAEc23VHKyaiiYHIKBJiAtJ5Nxrat5IbXg=
X-Google-Smtp-Source: AGHT+IHpjLmV/AXUQvfQUsVJ62iWc3DvSEAEOXGcQWxOxA6TuQATz+wIl+RLycIVDyG23iuxTfgZO+7XzuocdiaV4Sg=
X-Received: by 2002:a05:6e02:ded:b0:346:5bd7:4a16 with SMTP id
 m13-20020a056e020ded00b003465bd74a16mr12784350ilj.4.1692094043596; Tue, 15
 Aug 2023 03:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <CALm+0cXrCHAPHEOrLyn6ms551mAo=RyHTLUhzOLfRK4ZVMp4jQ@mail.gmail.com>
In-Reply-To: <CALm+0cXrCHAPHEOrLyn6ms551mAo=RyHTLUhzOLfRK4ZVMp4jQ@mail.gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Tue, 15 Aug 2023 18:07:11 +0800
Message-ID: <CALm+0cUGWCBRfB1QgfDOX0P=wCWvLUc6zD86kG7M2eF55Ad9LQ@mail.gmail.com>
Subject: Re: rcutorture: Sleeping function called from invalid context
To:     "Paul E. McKenney" <paulmck@kernel.org>, thunder.leizhen@huawei.com
Cc:     rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

>
> Hello, Paul
>
> when running the rcutorture test with rcutorture.object_debug=1 in
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
> 1. I made statistics about the source of 'rhp'. kmem_valid_obj() accounts for
>    more than 97.5%, and vmalloc accounts for less than 1%. So change call
>    mem_dump_obj() to call kmem_dump_obj() can meet debugging requirements and
>    avoid the potential deadlock risk of vmalloc_dump_obj().
> -               mem_dump_obj(rhp);
> +               if (kmem_valid_obj(rhp))
> +                       kmem_dump_obj(rhp);
>
>    The discussion about vmap_area_lock deadlock in v2:
>    https://lkml.org/lkml/2022/11/11/493
>
> so whether mem_dump_obj() should also be replaced by kmem_dump_obj() in
> __call_rcu_common(),  since the call_rcu() can be called in interrupt context,
> this may issue recursive spin vmap_area_lock  lock calls.
>
> Any thoughts ?

or diff --git a/mm/util.c b/mm/util.c
index ddfbb22dc187..fbc007adc108 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1066,10 +1066,9 @@ void mem_dump_obj(void *object)
        if (kmem_dump_obj(object))
                return;

-       if (vmalloc_dump_obj(object))
-               return;
-
-       if (virt_addr_valid(object))
+       if (is_vmalloc_addr(object))
+               type = "vmalloc memory";
+       else if (virt_addr_valid(object))
                type = "non-slab/vmalloc memory";
        else if (object == NULL)
                type = "NULL pointer";


Thanks
Zqiang



>
> Thanks
> Zqiang
