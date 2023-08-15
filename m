Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DD0C0015E
	for <rcu@archiver.kernel.org>; Tue, 15 Aug 2023 05:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjHOFoH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Aug 2023 01:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjHOFmU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Aug 2023 01:42:20 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6837E45
        for <rcu@vger.kernel.org>; Mon, 14 Aug 2023 22:42:02 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bd0a0a675dso4317935a34.2
        for <rcu@vger.kernel.org>; Mon, 14 Aug 2023 22:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692078122; x=1692682922;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=euDlbME/xsJ/Q9L3D0lBoYvRI7PonDdG7EsC14A1HPI=;
        b=aRDsZ9gnycYhYk96GEK45t6Bxj+btNTlxeT2yvgUrlJBE0udSVrl5R/0dH6JxqI7zz
         X0n6Rpj6gMq11A2vpZUl92fiNbiEXME5JhR4ze6gJECsZ1lvtaDNwDYqVUrpRKgcYP88
         iqVv63HfWAb9dk1rEbI3RoUtWXKXNYqT2VlwzR7su5kZZeVYH4tmggVDqrn7A4m8F26B
         ucAnVWdkHV5Dmt2FSP5u6ub17RKtUq8bH2WkcSEk30MDRB5hgKalZ1GLxHFn1VYRGAK7
         GksKBF67tzI5I80S4M5NqLtzHE17Z62Z2zMLCs+utrXTICqdl6uRiupffee4yLZ12V1B
         3KPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692078122; x=1692682922;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=euDlbME/xsJ/Q9L3D0lBoYvRI7PonDdG7EsC14A1HPI=;
        b=dngqvIGofM+LYHHRziSog2vLAhn9w2L56A9R9cprL7FawmMnHQItT4B5T3FhnD1ZnQ
         PpST+YqlnlQkKLL0glGBxMEqFdovFeG5GmjrWAF+tWjhF0HuWo131YLPCUZb/etttgCi
         lY/wv51SjSVEdHkEk3tbqhIRGsSyZKC87+ILlACBNzkintCrWH0Fw7r4Zaaksgtk2AnG
         eCmiut2/Ezaaj/Ul6ICo3Z0wsV7bIxOmd20ESzUbSDHuVpLhyZaMhJmBy4REAJb1abJa
         LXjMqsTF4r9q49sq9XnJK4242O5ZAIo1kcsSgxu0jzB86DtnsPAdp+htr+A+sGPjL3mL
         n2Dg==
X-Gm-Message-State: AOJu0YxFy2U8t/rolOI2AJeSRFh3gj+HybGZ0lkZjfZSMmJdrT7T2Wmr
        ZlIjl7jW1gENXD449KHP15hmZx9/1/2+QuWIvmg=
X-Google-Smtp-Source: AGHT+IHRC4ybUP4GRBR6orV3FAe5KNvj7Rna3ZhttnDGAlzmoUuebDBlxz8dQkvsBk1ItqeS0iLW6GSdygJdY6vxLgE=
X-Received: by 2002:a9d:6a10:0:b0:6bc:c9e6:30b7 with SMTP id
 g16-20020a9d6a10000000b006bcc9e630b7mr11995664otn.26.1692078122031; Mon, 14
 Aug 2023 22:42:02 -0700 (PDT)
MIME-Version: 1.0
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Tue, 15 Aug 2023 13:41:49 +0800
Message-ID: <CALm+0cXrCHAPHEOrLyn6ms551mAo=RyHTLUhzOLfRK4ZVMp4jQ@mail.gmail.com>
Subject: rcutorture: Sleeping function called from invalid context
To:     "Paul E. McKenney" <paulmck@kernel.org>, thunder.leizhen@huawei.com
Cc:     rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Paul

when running the rcutorture test with rcutorture.object_debug=1 in
PREEMPT_RT kernel.

BUG: sleeping function called from invalid context at
kernel/locking/spinlock_rt.c:48
[    3.116503] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid:
1, name: swapper/0
[    3.116503] preempt_count: 1, expected: 0
[    3.116503] RCU nest depth: 1, expected: 1
[    3.116503] 3 locks held by swapper/0/1:
[    3.116503]  #0: ffffffff8f862d80 (fullstop_mutex){+.+.}-{4:4}, at:
torture_init_begin+0x24/0xa0
[    3.116503]  #1: ffffffff8f7b1400 (rcu_read_lock){....}-{1:3}, at:
rcu_torture_init+0x20b9/0x2380
[    3.116503]  #2: ffffffff8f89fa20 (vmap_area_lock){+.+.}-{3:3}, at:
find_vmap_area+0x21/0x90
[    3.116503] irq event stamp: 571506
[    3.116503] hardirqs last  enabled at (571505):
[<ffffffff8d422ff5>] __call_rcu_common+0x3a5/0xdc0
[    3.116503] hardirqs last disabled at (571506):
[<ffffffff900487f7>] rcu_torture_init+0x22b7/0x2380
[    3.116503] softirqs last  enabled at (406916):
[<ffffffff8d2e91f2>] __local_bh_enable_ip+0x132/0x170
[    3.116503] softirqs last disabled at (406910):
[<ffffffff8e658e79>] inet_register_protosw+0x9/0x190
[    3.116503] Preemption disabled at:
[    3.116503] [<ffffffff9004865a>] rcu_torture_init+0x211a/0x2380
[    3.116503] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W
   6.5.0-rc4-rt2-yocto-preempt-rt+ #7
[    3.116503] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[    3.116503] Call Trace:
[    3.116503]  <TASK>
[    3.116503]  dump_stack_lvl+0x68/0xb0
[    3.116503]  dump_stack+0x14/0x20
[    3.116503]  __might_resched+0x221/0x2f0
[    3.116503]  rt_spin_lock+0x60/0x130
[    3.116503]  ? find_vmap_area+0x21/0x90
[    3.116503]  find_vmap_area+0x21/0x90
[    3.116503]  vmalloc_dump_obj+0x25/0xa0
[    3.116503]  mem_dump_obj+0x22/0x90
[    3.116503]  __call_rcu_common+0x920/0xdc0
[    3.116503]  ? __pfx_rcu_torture_err_cb+0x10/0x10
[    3.116503]  ? __pfx___call_rcu_common+0x10/0x10
[    3.116503]  ? rcu_torture_init+0x22b7/0x2380
[    3.116503]  ? debug_smp_processor_id+0x1b/0x30
[    3.116503]  ? rcu_is_watching+0x3e/0xc0
[    3.116503]  call_rcu_hurry+0x14/0x20
[    3.116503]  rcu_torture_init+0x2186/0x2380
[    3.116503]  ? __pfx_rcu_torture_init+0x10/0x10
[    3.116503]  ? __pfx_rt_mutex_slowunlock+0x10/0x10
[    3.116503]  ? __pfx_irq_debugfs_init+0x10/0x10
[    3.116503]  ? __pfx_rcu_torture_leak_cb+0x10/0x10
[    3.116503]  ? rt_spin_unlock+0x50/0xa0
[    3.116503]  ? add_device_randomness+0xb1/0xe0
[    3.116503]  ? __pfx_rcu_torture_leak_cb+0x10/0x10
[    3.116503]  ? __pfx_rcu_torture_init+0x10/0x10
[    3.116503]  do_one_initcall+0xd8/0x430
[    3.116503]  ? __pfx_do_one_initcall+0x10/0x10
[    3.116503]  ? __kasan_check_read+0x15/0x20
[    3.116503]  kernel_init_freeable+0x3a0/0x670
[    3.116503]  ? rt_spin_unlock+0x50/0xa0
[    3.116503]  ? __pfx_kernel_init+0x10/0x10
[    3.116503]  kernel_init+0x23/0x160
[    3.116503]  ? __pfx_kernel_init+0x10/0x10
[    3.116503]  ret_from_fork+0x40/0x60
[    3.116503]  ? __pfx_kernel_init+0x10/0x10
[    3.116503]  ret_from_fork_asm+0x1b/0x30
[    3.116503]  </TASK>
[    3.116503]  non-slab/vmalloc memory


as described by Lei Zhen:

v2 --> v3:
1. I made statistics about the source of 'rhp'. kmem_valid_obj() accounts for
   more than 97.5%, and vmalloc accounts for less than 1%. So change call
   mem_dump_obj() to call kmem_dump_obj() can meet debugging requirements and
   avoid the potential deadlock risk of vmalloc_dump_obj().
-               mem_dump_obj(rhp);
+               if (kmem_valid_obj(rhp))
+                       kmem_dump_obj(rhp);

   The discussion about vmap_area_lock deadlock in v2:
   https://lkml.org/lkml/2022/11/11/493

so whether mem_dump_obj() should also be replaced by kmem_dump_obj() in
__call_rcu_common(),  since the call_rcu() can be called in interrupt context,
this may issue recursive spin vmap_area_lock  lock calls.

Any thoughts ?

Thanks
Zqiang
