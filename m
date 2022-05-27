Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14BCC433F5
	for <rcu@archiver.kernel.org>; Fri, 27 May 2022 00:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiE0AjX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 26 May 2022 20:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiE0AjV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 26 May 2022 20:39:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA60FE5287
        for <rcu@vger.kernel.org>; Thu, 26 May 2022 17:39:19 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c2so2834618plh.2
        for <rcu@vger.kernel.org>; Thu, 26 May 2022 17:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OcUKE1tnQCraEmbECNTKRJIAh9ahq139b+/s4gYRfbw=;
        b=aopA26RxLMKhv67U5C7voSi4o/EtAevxJ7AEqpDDV8jcg/KI6fGSOCwEtz9AfonayD
         /kMyy+UFkBZKHPsiZpZ+P2R3yyF9AcusACvBcAHarSAxMLKogCkL3slCduxs8rOsF/FV
         0EFeW7iLX+fNvJe5PsGCNbl77jrll555x9NIdjuBDKHT3PcnspXzObOj3Uenqg3x1uMa
         f0ElVgrH/f2E9W3sJ4jBjnlsiKQ0fiLlmm0hcH2sBpscC5gkaZ7S+y7SeVg+F10ihI5G
         LHFIRGU+WzqF2Z/taDLD24gBVCeXQDkHxd6XqYPJYsb20CIyKDkfc4D030YZsINUtUck
         9BYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OcUKE1tnQCraEmbECNTKRJIAh9ahq139b+/s4gYRfbw=;
        b=r96PSjoow5H6JK5d7DAJEBRG+UMFr8NLqj+6LGiCxpd3Yf56dYqrXlIvH6jzPOqnjr
         ko24McL/4rLIwHzSaU7OoKhprSrlETtQEvaRk7x8SMHS2zm6uAhjguZZDDzJZwepItPz
         Q8VTN3/ix2RrpGC7rV5iPMvpx/TuG3+MUtGNwjoLeTS6zrXBhXOWsWw8ZD41OvW6mTUk
         TBTmyO5bJ4Pe1QBWXw4mAtnJ4fw+3xo3ZeL2czxa85dRGU8uFenjOztYdzIEwpJ/J4cc
         AEJhVk7qgaoSVhMrbW+1MES4YcSkdx3dUwYUyZ4hzUwEj40PmTtnf1oxuGr9NXFNcdER
         Ld9Q==
X-Gm-Message-State: AOAM531xAIMkEaRlYSzAf+HV6VXb5NKel9eTRDzvLWI3ld11ivOSP903
        /EccNk0FfG0BBaB8AkeYXeA=
X-Google-Smtp-Source: ABdhPJxVcfODIhDenR3tcL4g+34oY/+YVvs288c2HImsS9tagMksyrQ9BDp9wqwlWA3sv3M+b2C4gw==
X-Received: by 2002:a17:90b:4a10:b0:1e0:44e4:5355 with SMTP id kk16-20020a17090b4a1000b001e044e45355mr5337637pjb.149.1653611959402;
        Thu, 26 May 2022 17:39:19 -0700 (PDT)
Received: from localhost.localdomain ([85.203.23.78])
        by smtp.gmail.com with ESMTPSA id u12-20020a170903304c00b0015e8d4eb288sm2125264pla.210.2022.05.26.17.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 17:39:18 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     paulmck@kernel.org, willy@infradead.org, urezki@gmail.com,
        rcu@vger.kernel.org, frederic@kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH rcu/dev] RFC: temporarily reduce rcu tasks kthread sleep time for PROVE_RCU
Date:   Fri, 27 May 2022 08:39:09 +0800
Message-Id: <20220527003909.18998-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Sometimes, the kernel will boot too fast for rcu_tasks_verify_self_tests
to have all required grace periods.

Temporarily reduce rcu tasks kthread sleep time for PROVE_RCU to get all
required grace periods.

Both this patch and her sister
"wait extra jiffies for rcu_tasks_verify_self_tests"
https://lore.kernel.org/rcu/20220517004522.25176-1-zhouzhouyi@gmail.com/
have their short comings:

1) this patch don't slow down the Linux boot time but will increase
the energe consumption during the boot because of reduced sleep time.

2) "wait extra jiffies for rcu_tasks_verify_self_tests" may slow the boot
process but has not energe problems.

Reported-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
Hi Paul

I have proposed some possible solutions to fix rcu_tasks_verify_self_tests
failure. Both of them are not perfect. Only tries to break the ice,
hoping to arouse the attension ;-)

Thanks
Zhouyi
--
 kernel/rcu/tasks.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6ed21720b13f..f7c849ef23fa 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -962,3 +962,10 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
 static int __init rcu_spawn_tasks_kthread(void)
 {
 	cblist_init_generic(&rcu_tasks);
+#ifdef CONFIG_PROVE_RCU
+	/* temporarily reduce rcu tasks kthread sleep time for the kernel
+	 * that boot faster
+	 */
+	rcu_tasks.gp_sleep = HZ / 200;
+	rcu_tasks.init_fract = HZ / 200;
+#else
	rcu_tasks.gp_sleep = HZ / 10;
 	rcu_tasks.init_fract = HZ / 10;
+#endif	
 	rcu_tasks.pregp_func = rcu_tasks_pregp_step;
 	rcu_tasks.pertask_func = rcu_tasks_pertask;
 	rcu_tasks.postscan_func = rcu_tasks_postscan;
@@ -1103,7 +1111,14 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks_rude);
 static int __init rcu_spawn_tasks_rude_kthread(void)
 {
 	cblist_init_generic(&rcu_tasks_rude);
+#ifdef CONFIG_PROVE_RCU
+	/* temporarily reduce rcu tasks rude kthread sleep time for the kernel
+	 * that boot faster
+	 */
+	rcu_tasks_rude.gp_sleep = HZ / 200;
+#else
 	rcu_tasks_rude.gp_sleep = HZ / 10;
+#endif
 	rcu_spawn_tasks_kthread_generic(&rcu_tasks_rude);
 	return 0;
 }
@@ -1665,3 +1680,14 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
 {
 	cblist_init_generic(&rcu_tasks_trace);
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB)) {
+#ifdef CONFIG_PROVE_RCU
+		/* temporarily reduce rcu tasks trace kthread sleep
+		 * time for the kernel that boot faster
+		 */
+		rcu_tasks_trace.gp_sleep = HZ / 200;
+		if (rcu_tasks_trace.gp_sleep <= 0)
+			rcu_tasks_trace.gp_sleep = 1;
+		rcu_tasks_trace.init_fract = HZ / 200;
+		if (rcu_tasks_trace.init_fract <= 0)
+			rcu_tasks_trace.init_fract = 1;
+#else
		rcu_tasks_trace.gp_sleep = HZ / 10;
 		rcu_tasks_trace.init_fract = HZ / 10;
+#endif
 	} else {
 		rcu_tasks_trace.gp_sleep = HZ / 200;
 		if (rcu_tasks_trace.gp_sleep <= 0)
@@ -1777,3 +1804,20 @@ static int rcu_tasks_verify_self_tests(void)
 		}
 	}
 
+/* resume rcu tasks kthreads' sleep time after self tests */
+#ifdef CONFIG_TASKS_RCU
+	rcu_tasks.gp_sleep = HZ / 10;
+	rcu_tasks.init_fract = HZ / 10;
+#endif
+
+#ifdef CONFIG_TASKS_RUDE_RCU
+	rcu_tasks_rude.gp_sleep = HZ / 10;
+#endif
+
+#ifdef CONFIG_TASKS_TRACE_RCU
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB)) {
+		rcu_tasks_trace.gp_sleep = HZ / 10;
+		rcu_tasks_trace.init_fract = HZ / 10;
+	}
+#endif
+
	if (ret)
 		WARN_ON(1);
 
-- 
2.25.1

