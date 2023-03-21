Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D73BC6FD20
	for <rcu@archiver.kernel.org>; Tue, 21 Mar 2023 19:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjCUTl7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Mar 2023 15:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjCUTlx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Mar 2023 15:41:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0803B65E
        for <rcu@vger.kernel.org>; Tue, 21 Mar 2023 12:40:46 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j24so5981689wrd.0
        for <rcu@vger.kernel.org>; Tue, 21 Mar 2023 12:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679427635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ygAcJKnTKCTvVciunh9HcyMwipcH5PYmlVu4YEhebA=;
        b=Iexkp6x3yyHqDDL6OaZInLzZ93bK+l7wJcqEc9pszCs17KfJta9MRhbYNehOvs8q6D
         XKUaQuZ2obQke50TshqprcQQZw3dKHyHYgWrm/pzzQPvWpEcQSNPXDZHWw0agky2U+ps
         ogF9bsf4QHdfeveEvlewrX/zdZYyqcFn8X9/RYcrS0ujc35Kmtm0vgw9+o+KtBZvusTh
         +rf69A/3woBAMVVa67Agt4vUljhc6SgDCXli6nYiJPzMFpu8uKbrQoUXSg+t94/iROyb
         Bshdjqa2hgalSv9JjLbbPTgXk8fBP+fK4thtjwGtYVs/MJhLRADue+B62bdcQ1MLig72
         6IbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ygAcJKnTKCTvVciunh9HcyMwipcH5PYmlVu4YEhebA=;
        b=GaoqfvbxEw3Ncndqxl5U0MP0OIG/rWA846ILLKnaBLDwF5qehALKDgqXYL9E/uWZAn
         miimJbVH1slRsAj5r1ALGl76AiBMQWMGfqWe8clIGxcIycoHE94fJ35OjZAE8m3w+2SP
         +8YuUxOdCPskkaYmzwYRiwaVOn+0JOJxQ8aWJEBJQjle+9QHp+Mn98rHLKoSJdcy0//b
         DchjHab6jHiYQgA7Ca2Z5t9F2HS5G7Fah2vo2EMrBCfVZZ+sZ+qEuVXPLem0jGy6b8F2
         wyGXZYsIhhKezlpjzGi+k4xsH5fZg9p3W04E7IrFLNHX0x7fOqJUWqwIqHmG25KO6+xX
         z5gA==
X-Gm-Message-State: AO0yUKVV92C6ezPEM4/ejibvG+onycFBjodpVhtqMGqOX7cOYhq+AgZV
        e8bm5OrsZZ/tdP6x5RzITAG0Ew==
X-Google-Smtp-Source: AK7set9AnDKK/cDv2mIaY0UxRKld6XYgZwnZxOJh6imj92tih6R4SbLItZ1d4sQ/axy5Dygmp0yMFw==
X-Received: by 2002:a5d:474d:0:b0:2d4:62ed:e7cf with SMTP id o13-20020a5d474d000000b002d462ede7cfmr3301491wrs.43.1679427635199;
        Tue, 21 Mar 2023 12:40:35 -0700 (PDT)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:7a8a:d679:ba4e:61cf])
        by smtp.gmail.com with ESMTPSA id a3-20020adffb83000000b002c561805a4csm12005026wrr.45.2023.03.21.12.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:40:34 -0700 (PDT)
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
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v16 1/8] cpu/hotplug: Move idle_thread_get() to <linux/smpboot.h>
Date:   Tue, 21 Mar 2023 19:40:01 +0000
Message-Id: <20230321194008.785922-2-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230321194008.785922-1-usama.arif@bytedance.com>
References: <20230321194008.785922-1-usama.arif@bytedance.com>
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
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
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

