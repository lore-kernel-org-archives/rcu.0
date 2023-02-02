Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BF9C636D3
	for <rcu@archiver.kernel.org>; Thu,  2 Feb 2023 21:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjBBV5Y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Feb 2023 16:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjBBV5L (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Feb 2023 16:57:11 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F1268AD0
        for <rcu@vger.kernel.org>; Thu,  2 Feb 2023 13:56:33 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t7so3002684wrp.5
        for <rcu@vger.kernel.org>; Thu, 02 Feb 2023 13:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGUMPbv5ehkWjyJkrcI0+C5Cz30zQDLH70pUeAdBLkQ=;
        b=2M4JOPBXhf4n8GQQdyrzHe3qWIJaL7f9plv5S3ltmqAiKFtsvcGXGUTC2Zuij3BMbs
         HhlEqG9+INFdfdUkReFlmvH2JPZMrNCztu3WfOAY+06RdcFUOlBB41XvMs68Ya736yK2
         nOZn1J7hYgH42tp/gN4crt3m2pxOLEjJAusMRXcc680eWWrSJLJMCjmPufzsVttIRkCW
         9QkU3r7GppcN34bu8GaPenanJDgtpVPDONSrvDRiSQXJXkEZApH8tlqbG9jFp0sxPyy2
         H0xXvJvm2qthioHCwmimhIU+Q9Nh8Kc7h/9OaMxXMAdSlKwy88YLZFA1gae6hbRvVar+
         bsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGUMPbv5ehkWjyJkrcI0+C5Cz30zQDLH70pUeAdBLkQ=;
        b=qmMkdFVtjmIsPvX0beHs3s8j1GlfPKN5k9GAKT8jKyZYm4lqMlAVJmgCwiW/MbVyEX
         N2OkEX2Qpp4NfQ22GddSk6DaqzSKkoVj9fgmqB09D3EqRgHG5+Q/+16aMufVTftGjSz1
         zyOy+cIFcdGiPDdR1TmIispltauD3bhag30DZYDtF3hwjwr72mOhfcwYQQSXdp6HoSPd
         eWuDlV2z5XU7CEM+d4P1l2fhZRHBdNo6qxTRl6G/RtZtvRuh1Ce8dbpvI54W5CCRR9Nf
         vUjT2XxYqW5GvBaKKY333QujDhGeVUbaqp27Vv3fZuVH7OX0j57Z3KRLElH6XCRdbmzg
         hc+w==
X-Gm-Message-State: AO0yUKWyO4lf2V3vU4IHsDe1o9gj1koN/G7xgw0obbbzne3qC+mGLG+8
        tJOM3rpp7AClY8yescPLqNpC1w==
X-Google-Smtp-Source: AK7set/CDswZdmTsSZsErF7V63uar9uvceQgDgLkLPtGwcWkpo8b1nJ0th3Lj0DuhHf/pnavpwsO/g==
X-Received: by 2002:a5d:6c6d:0:b0:2bf:d6f9:23d6 with SMTP id r13-20020a5d6c6d000000b002bfd6f923d6mr7783377wrz.45.1675374992316;
        Thu, 02 Feb 2023 13:56:32 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:98fe:e4ee:fc7e:cd71])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d6d08000000b00297dcfdc90fsm506078wrq.24.2023.02.02.13.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 13:56:31 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, arjan@linux.intel.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v6 02/11] cpu/hotplug: Move idle_thread_get() to <linux/smpboot.h>
Date:   Thu,  2 Feb 2023 21:56:16 +0000
Message-Id: <20230202215625.3248306-3-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202215625.3248306-1-usama.arif@bytedance.com>
References: <20230202215625.3248306-1-usama.arif@bytedance.com>
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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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

