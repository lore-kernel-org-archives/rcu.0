Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712EDC433EF
	for <rcu@archiver.kernel.org>; Tue, 17 May 2022 00:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiEQApm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 May 2022 20:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiEQApm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 May 2022 20:45:42 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEE5113B
        for <rcu@vger.kernel.org>; Mon, 16 May 2022 17:45:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso919048pjg.0
        for <rcu@vger.kernel.org>; Mon, 16 May 2022 17:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lZgp6fJSRJ9rQ7hXqVPBGm8okWZ5djYvjGgWxJgQzBw=;
        b=Ah/eXJUhbBlfOdl4GuH/lGw99JcDkf2s1+LpNYbG15wj4FaD0b0ibt7H7wDFThfcUr
         07/g8jWhqayxo7ub4lfGVL3FPD0DQ134yeemtC+1tJbKTdYscb9Wi/qALB58Hp8qmRRr
         yZSwGvGa2cw4VVY42Mc+zKFdVOF5FpamE8pKdyioxKrfi+wXnfJ4UNhkgaEEok5f0lzr
         ZVeryFAuv7fcyzDO5zG6LELKEyj+iqE7D64rAbARXMtYPFGTckd0f/2nTRnH24x3jrI0
         q2iDRCSamw5bzQJdClMxmWWQoSRUBZogVnlTzNqWUIPTvbJpUP+b/lDMLpaXDo0y/SfP
         py9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lZgp6fJSRJ9rQ7hXqVPBGm8okWZ5djYvjGgWxJgQzBw=;
        b=v4A8RRtiKWC7Xu5rA1y3+Gl9ueLEIe7zvVoVRSYAKLWtBnykVl5y4GIwnQP8U+ZKjM
         ocqhmXSMRaN++kEJWlwBiKPVgCAT2ROgomJ63ejMbzvL9xQ3fPiOZNN8iVINh2jKqJXE
         zPCZSRXp5+D0YW3IkvjxhFt3rQ/sEDtpT2zlSDK09NOS/aIJX9VbNfMb8RE/kvqrkpqY
         pQatqP3WacCPQSwNbd9zNC/w5JyK/VuphEVA5yO+E4JL5ie0TgDfRXofneSk7Qch0748
         bhlaz3oDm64X5l2gX94aKGMjtl+m8Y5oPORrQPe+7pfbEAabHguF0zXZYxgHjny2HN2W
         ejhg==
X-Gm-Message-State: AOAM533GOt3NcBGblgiUN1qkjBkxgaGnvD0VeYoT82Az28cqLov91VqX
        F4jqRwEghxKccTr5Zs3B7eg=
X-Google-Smtp-Source: ABdhPJyekbe45Hxbeee2p19QH0poRL97aWVUppUPUQ2uzPPXWJRGV0KA4qJ0m+9gyWIWBTs6rTr4+w==
X-Received: by 2002:a17:90b:1a88:b0:1dc:e4a1:a81e with SMTP id ng8-20020a17090b1a8800b001dce4a1a81emr33729692pjb.96.1652748340077;
        Mon, 16 May 2022 17:45:40 -0700 (PDT)
Received: from localhost.localdomain ([85.203.23.238])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b0015e8d4eb22bsm8011721plh.117.2022.05.16.17.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:45:39 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     paulmck@kernel.org, rcu@vger.kernel.org, frederic@kernel.org,
        paulmckrcu@fb.com, willy@infradead.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH rcu/dev] wait extra jiffies for rcu_tasks_verify_self_tests
Date:   Tue, 17 May 2022 08:45:22 +0800
Message-Id: <20220517004522.25176-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Sometimes, the kernel will boot too fast for rcu_tasks_verify_self_tests
to have all required grace periods.

Wait extra jiffies for rcu_tasks_verify_self_tests so as not to punish
people who make Linux boot faster.

Although 'wait extra jiffies' approach may slow down the Linux boot, but
the CONFIG_PROVE_RCU option is only enabled for experts and for test only.

I also considered temporarily reduce the gp_sleep and init_fract before
rcu_tasks_verify_self_tests, but we can only guess those values
from experience.


Reported-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 kernel/rcu/tasks.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index bd9f2e24f5c7..b1be85da29ec 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1766,7 +1766,38 @@ static int rcu_tasks_verify_self_tests(void)
 {
 	int ret = 0;
 	int i;
+	int delay = 0;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (!tests[i].notrun) {		// still hanging.
+			ret = -1;
+		}
+	}
+
+	if (!ret)
+		return ret;
+
+#ifdef CONFIG_TASKS_RCU
+	delay = rcu_tasks.gp_sleep;
+	if (delay < rcu_tasks.init_fract)
+		delay = rcu_tasks.init_fract;
+#endif
+
+#ifdef CONFIG_TASKS_RUDE_RCU
+	if (delay < rcu_tasks_rude.gp_sleep)
+		delay = rcu_tasks_rude.gp_sleep;
+#endif
+
+#ifdef CONFIG_TASKS_TRACE_RCU
+	if (delay < rcu_tasks_trace.gp_sleep)
+		delay = rcu_tasks_trace.gp_sleep;
+	if (delay < rcu_tasks_trace.init_fract)
+		delay = rcu_tasks_trace.init_fract;
+#endif
+	pr_info("wait extra %d jiffies for rcu tasks self tests\n", 2*delay);
+	schedule_timeout_uninterruptible(2*delay);
+
+	ret = 0;
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		if (!tests[i].notrun) {		// still hanging.
-- 
2.25.1

