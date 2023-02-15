Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661A2C636D4
	for <rcu@archiver.kernel.org>; Wed, 15 Feb 2023 14:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjBOOzH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Feb 2023 09:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjBOOzB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Feb 2023 09:55:01 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E7D39CCB
        for <rcu@vger.kernel.org>; Wed, 15 Feb 2023 06:54:32 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bu23so19413196wrb.8
        for <rcu@vger.kernel.org>; Wed, 15 Feb 2023 06:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKydoXD7DOLwoETiq1rVpdNfhGCr3/VFLGt4p4rSeXA=;
        b=hceQhhwWr1f7FagWsyZzNcBZmbVIP5OsxIHYJcXaYD/J/Q7I26e/dUdp/xuuGbSkQJ
         Z1qGwNRkGt4p30gy8YpfDwILmLyxZrlBX3CqoFXhW43tR/dxW9GDDPsibinx4GROooJ6
         a6+ZWH74IaiAVz2y8cQC+aCaZcHFQLiKSORlFpff73D24PLDeJqCV16qvlFJGrkDEbov
         AMZWZo413nAzLPloJj5ZR331G+o2Zx5YzVKTb7Z5q4MnJbG0HOeYJWqo7D2qTlV/TLTv
         eNvlpQ1C/saz9isQ7J0rdwzMfVDOeplNT4Gg3Ee2AqBJ58LccYbudMPLhF9tm2KFukOS
         xrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKydoXD7DOLwoETiq1rVpdNfhGCr3/VFLGt4p4rSeXA=;
        b=JHBjUF6wrdWRkGrlidZ5lhsyXDXRFUeYfS8L2VphlWLhy74xBsZuMImIMiVMJ1LTKY
         9Y76bwrxE46ZspiVS9f3+87khEp55zvlD97MT8f1v7GEmzaakrZnSh9SwVijUiipSn2L
         P7ftww7MWpvBonk4cNoNO2KhekjHceIiWKNOmJONxLSpw9Ok/ikC1PI5oDt+Wg5K9HHP
         iV6UbQXAgDMeCAj+XuOaw1i97t9tOolrp75bVGS4DZxJR4CcZDJ1Mv+N+F3G2HX26fGE
         GTxJRdCNlKfcJqqnIIl1V9wqoOGFwK30S/6jS+sQaLul/g8/doiJW3TkEuoEf8WFpW64
         /CHw==
X-Gm-Message-State: AO0yUKUW4nn3w7Lg/1D8BfIuHsCUnJ8En3s/gKcBZYOWftgSc+3LS/bx
        XV9dpb1xZcSUMocKhgBdQI0nuw==
X-Google-Smtp-Source: AK7set860Rew0tYEOZBESqpmpyGt2v7Hl1tSKNM8QidgJEbU+BU+JoCxhBj+fZDORe++V3Ea+1V2NQ==
X-Received: by 2002:a5d:6448:0:b0:2c5:581d:5a1d with SMTP id d8-20020a5d6448000000b002c5581d5a1dmr1567680wrw.43.1676472870810;
        Wed, 15 Feb 2023 06:54:30 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:8487:6a9a:3a67:11aa])
        by smtp.gmail.com with ESMTPSA id t13-20020adfe44d000000b002c557f82e27sm8495508wrm.99.2023.02.15.06.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 06:54:30 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, kim.phillips@amd.com
Cc:     arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v9 2/8] cpu/hotplug: Move idle_thread_get() to <linux/smpboot.h>
Date:   Wed, 15 Feb 2023 14:54:19 +0000
Message-Id: <20230215145425.420125-3-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215145425.420125-1-usama.arif@bytedance.com>
References: <20230215145425.420125-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

Instead of relying purely on the special-case wrapper in bringup_cpu()
to pass the idle thread to __cpu_up(), expose idle_thread_get() so that
the architecture code can obtain it directly when necessary.

This will be useful when the existing __cpu_up() is split into multiple
phases, only *one* of which will actually need the idle thread.

If the architecture code is to register its new pre-bringup states with
the cpuhp core, having a special-case wrapper to pass extra arguments is
non-trivial and it's easier just to let the arch register its function
pointer to be invoked with the standard API.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 include/linux/smpboot.h | 7 +++++++
 kernel/smpboot.h        | 2 --
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/smpboot.h b/include/linux/smpboot.h
index 9d1bc65d226c..3862addcaa34 100644
--- a/include/linux/smpboot.h
+++ b/include/linux/smpboot.h
@@ -5,6 +5,13 @@
 #include <linux/types.h>
 
 struct task_struct;
+
+#ifdef CONFIG_GENERIC_SMP_IDLE_THREAD
+struct task_struct *idle_thread_get(unsigned int cpu);
+#else
+static inline struct task_struct *idle_thread_get(unsigned int cpu) { return NULL; }
+#endif
+
 /* Cookie handed to the thread_fn*/
 struct smpboot_thread_data;
 
diff --git a/kernel/smpboot.h b/kernel/smpboot.h
index 34dd3d7ba40b..60c609318ad6 100644
--- a/kernel/smpboot.h
+++ b/kernel/smpboot.h
@@ -5,11 +5,9 @@
 struct task_struct;
 
 #ifdef CONFIG_GENERIC_SMP_IDLE_THREAD
-struct task_struct *idle_thread_get(unsigned int cpu);
 void idle_thread_set_boot_cpu(void);
 void idle_threads_init(void);
 #else
-static inline struct task_struct *idle_thread_get(unsigned int cpu) { return NULL; }
 static inline void idle_thread_set_boot_cpu(void) { }
 static inline void idle_threads_init(void) { }
 #endif
-- 
2.25.1

