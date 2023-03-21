Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74789C76195
	for <rcu@archiver.kernel.org>; Tue, 21 Mar 2023 19:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCUTl6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Mar 2023 15:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjCUTly (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Mar 2023 15:41:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA1D57D12
        for <rcu@vger.kernel.org>; Tue, 21 Mar 2023 12:40:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o7so14888073wrg.5
        for <rcu@vger.kernel.org>; Tue, 21 Mar 2023 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679427636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuLu3HGQcjaytP31qHwhZDi8gSxR4JzJz3SEvAV55zo=;
        b=f2Jpe6Q2tY3Gz7GXpj/6SRsTP1/2EY+sStePEHknHyPHUxW7vMGCIi3haEE+eKVzV4
         QxHXFaOm6A1jMa600e1jsjRZ2Hl+D9DQQr0Bgolx3k08dShHr+eiu/5y5bB7KAzrD99x
         A74GnQ92Y32buwVyIEdp5aKzgQ5tEvOHrd2SrkqmqfwKv5ICTLu1GPaPjiJWttr7ilx+
         alkfHz7qtXfU5Ad++n6WadIP8+htGhANDetMan0r+uogeKgOQPqKmkn1HZV9RBV3Hruu
         ulLcOvl51E6Y2+nBPbaRyk0hBhtVT36fUx02Y/ymgMI+7vPPdXEEA4Fw6J7ivKsDukgV
         I7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuLu3HGQcjaytP31qHwhZDi8gSxR4JzJz3SEvAV55zo=;
        b=AeHFLyKZjQ6sZFRd+91DoBQB1CZmBTnZhPgAKQs+dH1AWBy+VCfhbb4ybqA7g8I1Wi
         PviEjDWHaHt5b55lXKRqaUS5gTxcyNypnd6EKD9sihXsbcrACHktrdrRV1no8dV+bLK4
         1YCL6mMcKV8u1nfLaEp4nObY/NHuGXD30vJTvVKaFXshT7kOd0NBRGq41YwMNH93rCZQ
         4E/5unya0KIIVywtfZllP7DTMpOGg3t6RfYztuznCj+8p+c7ixd7IqwWyt4LfcsKmeTD
         TCqXH3bauw1pPBUZVoGxyJZpusI8y7H0Hu14g/fhG0SeB7CyKgRwx5noyyw93nI0f1iW
         JmQw==
X-Gm-Message-State: AO0yUKW4U43kpUTLvpuqj302ckcqbpE29JtEU1CmS5jGiT1TwKg+2Sa3
        T873FXbpK9/zT7N6MwlDBFNBIQ==
X-Google-Smtp-Source: AK7set93rDqxKz1jhUQJozmEtQd/brdxwmcmaY7jZxYpsAisVpj5CU3ge1o6x++mwbpFoVM5MS90fA==
X-Received: by 2002:a5d:538c:0:b0:2d0:d73a:7671 with SMTP id d12-20020a5d538c000000b002d0d73a7671mr3066653wrv.22.1679427636150;
        Tue, 21 Mar 2023 12:40:36 -0700 (PDT)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:7a8a:d679:ba4e:61cf])
        by smtp.gmail.com with ESMTPSA id a3-20020adffb83000000b002c561805a4csm12005026wrr.45.2023.03.21.12.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:40:35 -0700 (PDT)
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
        gpiccoli@igalia.com, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v16 2/8] cpu/hotplug: Reset task stack state in _cpu_up()
Date:   Tue, 21 Mar 2023 19:40:02 +0000
Message-Id: <20230321194008.785922-3-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230321194008.785922-1-usama.arif@bytedance.com>
References: <20230321194008.785922-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

Commit dce1ca0525bf ("sched/scs: Reset task stack state in bringup_cpu()")
ensured that the shadow call stack and KASAN poisoning were removed from
a CPU's stack each time that CPU is brought up, not just once.

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

