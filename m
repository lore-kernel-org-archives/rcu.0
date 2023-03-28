Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4936C761A6
	for <rcu@archiver.kernel.org>; Tue, 28 Mar 2023 19:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjC1T6O (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Mar 2023 15:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjC1T6N (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 28 Mar 2023 15:58:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2A13C39
        for <rcu@vger.kernel.org>; Tue, 28 Mar 2023 12:58:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r29so13380128wra.13
        for <rcu@vger.kernel.org>; Tue, 28 Mar 2023 12:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680033482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHD5cN+9NG2teoVVuOSus5vfOKvUrEkkcqEu7E43kuM=;
        b=ZWbGy/qB9O4uIXmbnFJPzgndZVBdjQ7fRWg0uO8JRvcFhlus0uhdFK85yQMon2+hSO
         Ih2Wuad+2T/mmT1ReIQ8AzXzEN4Hxo/5h5gvFLl/p9mYvN1NUYN/NNqXtZlRqcLhiAGd
         bK4JNMc7njvwdLhuMUDHpOQImnYK+97PG5LALvKK5WqgXgLC4EzHEGyk3E8j07YoebtM
         8N/QPVWvNnKs5om6hiI2QilQDcUi29GH4R+a6NFfomkEIZ8PeFU3l5xDhAtNZYFRoo2K
         fWKRYD4KdIaWpHtqTqbLn214mh6hCmJG67hDxryH+ErkUnM+o5jnnRs7F6+DfSLVp/t8
         rY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680033482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHD5cN+9NG2teoVVuOSus5vfOKvUrEkkcqEu7E43kuM=;
        b=0JnKZdPmzjyyGiMdO6a8/shNtkbiMjRF32EGpCK0uvcpZE3ctWbxDG8sl7Bo/KM9Yf
         JHDgmM1NMTw/6q9ue2VkoKH+OO7FAJJyZd/eOc9y/ZNsOMZevC+jhULM/foU17hQjowp
         YxkNhQFXTJOcWnvMLS0Pa8MUh+JbN/DzpCU8WJEYTaN+EGoqWXkzrCJgYdqnoMANV0JN
         GpVQVXnSnzN95HPN9sYOzXdpEQ2mdLi3fcN2pQisyk12bd/YqilbyPdsOY3iGtwTiVK5
         QGYzShhWoh4R0JrYRnzAuTzRgRArjGrDabcuN7csWErSQKY7pu2rFtLVT0C6JiqM1yuG
         SK8w==
X-Gm-Message-State: AAQBX9ctldsLven+QE+3xtyHmmLd0+81FnuMpHCT0AEQiChAZsjJJYfb
        V78eTGQEBkAoI2eA/PKldc+RCA==
X-Google-Smtp-Source: AKy350a+CkM599ZmoWKEKahYxx4p6YM4cZDHr6OxnnBGr3OOYOjDokmLrgjI/ZkKjBeWoPEYwQ+P+w==
X-Received: by 2002:a05:6000:542:b0:2d1:7ade:aad with SMTP id b2-20020a056000054200b002d17ade0aadmr13593380wrf.31.1680033482442;
        Tue, 28 Mar 2023 12:58:02 -0700 (PDT)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:8445:3123:91d7:959d])
        by smtp.gmail.com with ESMTPSA id z6-20020a056000110600b002c557f82e27sm28248386wrw.99.2023.03.28.12.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 12:58:02 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, kim.phillips@amd.com,
        brgerst@gmail.com
Cc:     piotrgorski@cachyos.org, oleksandr@natalenko.name,
        arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        gpiccoli@igalia.com, David Woodhouse <dwmw@amazon.co.uk>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v17 2/8] cpu/hotplug: Reset task stack state in _cpu_up()
Date:   Tue, 28 Mar 2023 20:57:52 +0100
Message-Id: <20230328195758.1049469-3-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328195758.1049469-1-usama.arif@bytedance.com>
References: <20230328195758.1049469-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

Commit dce1ca0525bf ("sched/scs: Reset task stack state in bringup_cpu()")
ensured that the shadow call stack was reset and KASAN poisoning removed
from a CPU's stack each time that CPU is brought up, not just once.

This is not incorrect. However, with parallel bringup, an architecture
may obtain the idle thread for a new CPU from a pre-bringup stage, by
calling idle_thread_get() for itself. This would mean that the cleanup
in bringup_cpu() would be too late.

Move the SCS/KASAN cleanup to the generic _cpu_up() function instead,
which already ensures that the new CPU's stack is available, purely to
allow for early failure. This occurs when the CPU to be brought up is
in the CPUHP_OFFLINE state, which should correctly do the cleanup any
time the CPU has been taken down to the point where such is needed.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]
---
 kernel/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6c0a92ca6bb5..43e0a77f21e8 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -591,12 +591,6 @@ static int bringup_cpu(unsigned int cpu)
 	struct task_struct *idle = idle_thread_get(cpu);
 	int ret;
 
-	/*
-	 * Reset stale stack state from the last time this CPU was online.
-	 */
-	scs_task_reset(idle);
-	kasan_unpoison_task_stack(idle);
-
 	/*
 	 * Some architectures have to walk the irq descriptors to
 	 * setup the vector space for the cpu which comes online.
@@ -1383,6 +1377,12 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 			ret = PTR_ERR(idle);
 			goto out;
 		}
+
+		/*
+		 * Reset stale stack state from the last time this CPU was online.
+		 */
+		scs_task_reset(idle);
+		kasan_unpoison_task_stack(idle);
 	}
 
 	cpuhp_tasks_frozen = tasks_frozen;
-- 
2.25.1

