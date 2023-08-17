Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A6FC2FC14
	for <rcu@archiver.kernel.org>; Thu, 17 Aug 2023 06:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348230AbjHQGfK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 17 Aug 2023 02:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348240AbjHQGel (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 17 Aug 2023 02:34:41 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CE6270C
        for <rcu@vger.kernel.org>; Wed, 16 Aug 2023 23:34:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bcad794ad4so49656955ad.3
        for <rcu@vger.kernel.org>; Wed, 16 Aug 2023 23:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692254079; x=1692858879;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seWaPkjdw5bzbt1+h4lounGPxoCAudeab6dYx4qXf0A=;
        b=EwzrQ/vucv6FL28EVWMPbkB/aQzxpZ2bPi9lDcT5oEb6ymBIwHDqnBbuQ5SZ3qCEm8
         BLMzoskBGgFpwDp4QrARJ6FGOMCXBO89Nvlq76Q+Z+9upDQZe9OYZ/2nzVH4AYRDQEZa
         yVvK5gPxncAKXQ5W+uuU553UDGM33S/BJ59OwVXqyED2YGOb/nNlKR7+bui+5NHXAtvx
         2WHPFJAsU0f0L6eZ8qCFm2yo4MBv3rRjOJ+p09hWIjUBQUGRSzGw+zFYVxJPpGS7fsB/
         gdcwXJuXEAk3OeJb/iZsuVeLbI0uxyBSLI70+V2v+eTuTgpUltsp62J4IRDe0aOLcWmr
         Lhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692254079; x=1692858879;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seWaPkjdw5bzbt1+h4lounGPxoCAudeab6dYx4qXf0A=;
        b=eHtqHIolPGPe5ApNjbUEwxdKxgTgAXo1JoTkrZjPKal4XI2HWOfwQpnTrtMjHtYdf8
         +4Zt23dRKIujapBshcQKsem69z0R0beZo4uP8xvGRofPU+/FWLyNHfx3OB7lqxncWaWB
         Jgv1vG9HUc2sOxV++4Kqo89SxXBvcMAG8rJwv2iAp6PU4s1esobQUce3P5mB2a5coaSM
         zDf6NMgXPY/SFY2beNIZjmRGpVaC13sG7pQgE1ktY5+aI1OKtyE/rSqpJtr6b6E+iqDC
         eIIoTA7xSNYg8Nbc1R4E8mdT28nlV7T+g7UyyF8jBatp4zLa/WwxMaKCNu7Bc5sCYBzK
         6Txw==
X-Gm-Message-State: AOJu0YxNOMADj/th2Gg2ytA+9opg/ILJtxVgrtckwPb3e8xp30Qdxp8x
        TZQrQkwJF4K4uZPMZ6cVvQQ=
X-Google-Smtp-Source: AGHT+IGQXt/VsqZk/uOzeHj7LcKanGM6wfOIoL3OGOuYezGCRJKmLI8s2EBAplk1Mj07lwo4ikMi2Q==
X-Received: by 2002:a17:902:da82:b0:1bc:9c70:b955 with SMTP id j2-20020a170902da8200b001bc9c70b955mr4882447plx.28.1692254079050;
        Wed, 16 Aug 2023 23:34:39 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b001bc930d4517sm14301025plw.42.2023.08.16.23.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 23:34:38 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, qiang.zhang1211@gmail.com
Subject: [PATCH] rcu: Drop vmalloc memory info dump when double call_rcu()
Date:   Thu, 17 Aug 2023 14:34:29 +0800
Message-Id: <20230817063429.31454-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, for double invoke call_rcu(), will dump rcu_head objects
memory info, if the objects is not allocated from the slab allocator,
the vmalloc_dump_obj() will be invoke and the vmap_area_lock spinlock
need to be held, since the call_rcu() can be invoked in interrupt context,
therefore, there is a possibility of spinlock deadlock scenarios.

And in Preempt-RT kernel, the rcutorture test also trigger the following
lockdep warning:

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
preempt_count: 1, expected: 0
RCU nest depth: 1, expected: 1
3 locks held by swapper/0/1:
 #0: ffffffffb534ee80 (fullstop_mutex){+.+.}-{4:4}, at: torture_init_begin+0x24/0xa0
 #1: ffffffffb5307940 (rcu_read_lock){....}-{1:3}, at: rcu_torture_init+0x1ec7/0x2370
 #2: ffffffffb536af40 (vmap_area_lock){+.+.}-{3:3}, at: find_vmap_area+0x1f/0x70
irq event stamp: 565512
hardirqs last  enabled at (565511): [<ffffffffb379b138>] __call_rcu_common+0x218/0x940
hardirqs last disabled at (565512): [<ffffffffb5804262>] rcu_torture_init+0x20b2/0x2370
softirqs last  enabled at (399112): [<ffffffffb36b2586>] __local_bh_enable_ip+0x126/0x170
softirqs last disabled at (399106): [<ffffffffb43fef59>] inet_register_protosw+0x9/0x1d0
Preemption disabled at:
[<ffffffffb58040c3>] rcu_torture_init+0x1f13/0x2370
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.5.0-rc4-rt2-yocto-preempt-rt+ #15
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x68/0xb0
 dump_stack+0x14/0x20
 __might_resched+0x1aa/0x280
 ? __pfx_rcu_torture_err_cb+0x10/0x10
 rt_spin_lock+0x53/0x130
 ? find_vmap_area+0x1f/0x70
 find_vmap_area+0x1f/0x70
 vmalloc_dump_obj+0x20/0x60
 mem_dump_obj+0x22/0x90
 __call_rcu_common+0x5bf/0x940
 ? debug_smp_processor_id+0x1b/0x30
 call_rcu_hurry+0x14/0x20
 rcu_torture_init+0x1f82/0x2370
 ? __pfx_rcu_torture_leak_cb+0x10/0x10
 ? __pfx_rcu_torture_leak_cb+0x10/0x10
 ? __pfx_rcu_torture_init+0x10/0x10
 do_one_initcall+0x6c/0x300
 ? debug_smp_processor_id+0x1b/0x30
 kernel_init_freeable+0x2b9/0x540
 ? __pfx_kernel_init+0x10/0x10
 kernel_init+0x1f/0x150
 ret_from_fork+0x40/0x50
 ? __pfx_kernel_init+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

The statistics about the source of 'rhp', the kmem_valid_obj() accounts
for more than 97.5%, and vmalloc accounts for less than 1%, this statistic
comes from leizhen. this commit therefore drop vmalloc_dump_obj() from
mem_dump_obj() and only check whether is vmalloc address.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 include/linux/vmalloc.h |  5 -----
 mm/util.c               |  7 +++----
 mm/vmalloc.c            | 14 --------------
 3 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index c720be70c8dd..d7c4e112a4ad 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -289,10 +289,5 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 int register_vmap_purge_notifier(struct notifier_block *nb);
 int unregister_vmap_purge_notifier(struct notifier_block *nb);
 
-#if defined(CONFIG_MMU) && defined(CONFIG_PRINTK)
-bool vmalloc_dump_obj(void *object);
-#else
-static inline bool vmalloc_dump_obj(void *object) { return false; }
-#endif
 
 #endif /* _LINUX_VMALLOC_H */
diff --git a/mm/util.c b/mm/util.c
index ddfbb22dc187..fbc007adc108 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1066,10 +1066,9 @@ void mem_dump_obj(void *object)
 	if (kmem_dump_obj(object))
 		return;
 
-	if (vmalloc_dump_obj(object))
-		return;
-
-	if (virt_addr_valid(object))
+	if (is_vmalloc_addr(object))
+		type = "vmalloc memory";
+	else if (virt_addr_valid(object))
 		type = "non-slab/vmalloc memory";
 	else if (object == NULL)
 		type = "NULL pointer";
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 93cf99aba335..224af955bcb5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4271,20 +4271,6 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 }
 #endif	/* CONFIG_SMP */
 
-#ifdef CONFIG_PRINTK
-bool vmalloc_dump_obj(void *object)
-{
-	struct vm_struct *vm;
-	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
-
-	vm = find_vm_area(objp);
-	if (!vm)
-		return false;
-	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
-		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
-	return true;
-}
-#endif
 
 #ifdef CONFIG_PROC_FS
 static void *s_start(struct seq_file *m, loff_t *pos)
-- 
2.17.1

