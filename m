Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA035C432BE
	for <rcu@archiver.kernel.org>; Sat, 14 Aug 2021 01:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93AC7610F7
	for <rcu@archiver.kernel.org>; Sat, 14 Aug 2021 01:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhHNBnQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Aug 2021 21:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbhHNBnP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Aug 2021 21:43:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922FFC0617AD;
        Fri, 13 Aug 2021 18:42:46 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so18532803pjb.3;
        Fri, 13 Aug 2021 18:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5idM3Ueup4b94JMyXu62nSSGfYlEtXvaikv0F9J55U=;
        b=vdmL6s1BTz5qC5et9VmTkY2s0iXRifELOl9oqWeoiEujLkdqwSicCYEIaJDubnBJGh
         ki3rsrAOzjdWQD6uqzKSZAymDRP7XD+I/pT3bZifdWKu7M/FbFJEb7bwlgBWoPleJiLx
         FWAABX3HqoByphFyNuDKSywZYlrJQGYaCS8MFftqXkLxfolK4/HB6X6hovWh3gH8Qznf
         Kj5uJLYVDaO//EESOEdv2O77fyvQ9yZWBoaTvIY1rxUoe4hChjat4N1bhb7bxiPNtHw0
         l807wnAqb9XbgXy06uTzg4fiMslOO9zNtnUrAvjr3hrRkjmcZoWGOFG0nulrmerdFc9R
         867Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5idM3Ueup4b94JMyXu62nSSGfYlEtXvaikv0F9J55U=;
        b=n9Umdhsay31xKhrZ3Cxfbph+/94hn9glVZwE+MnFI42H2kDKOf0ScZ901fJWG1bFDP
         SX6IbncWZq27jHuvFbcm+5HDwvs+5tasnjyHHaZwKf7frZUy/lQ3MXOmGDR3aiH0YHrA
         xB0LMfOJijnPKWQRjgH/ZugYwhu0UlPTvTDBI2ANlOFHNOXn84H3MCw6G0SQp/bgxjos
         gNVFUII3h9Lp+bBmoxQNJl6t6z9B1otfnrRSJp6dM/Dfd4rNJYCCf0gBT3GuMXjD2PaK
         Lfk1P070NNKqlaaqL9az/HEcUjkhk24D2PIs0cfdRFEJkwvrt8XCgye7tLFTy326fwwc
         DkJw==
X-Gm-Message-State: AOAM532O54sGV6brSQzTN4I69BkTMrYHHj2Zyp4M64Cm3tORz3yAnvkt
        CBtzX3aVwHTHqoEYxsexR47RqMrMWH4=
X-Google-Smtp-Source: ABdhPJxLHxY5B/1/24SCUn7XXKlwC94b5w3syA9kZtJZKyl6crABDt97iM/RyZ5rE5bZWb7g3CLTvQ==
X-Received: by 2002:a17:90a:c7d5:: with SMTP id gf21mr5221555pjb.111.1628905366170;
        Fri, 13 Aug 2021 18:42:46 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id w2sm2907847pjq.5.2021.08.13.18.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 18:42:45 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] preempt: add in_serving_irq() and apply to rcutiny and vsprintf
Date:   Sat, 14 Aug 2021 09:42:34 +0800
Message-Id: <20210814014234.51395-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

At some places we need to determine whether we're in nmi, hardirq or
softirq context. This adds a macro in_serving_irq() as a shortcut for
that.

Meanwhile, apply this new macro to existing code in rcutiny and vsprintf.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 include/linux/preempt.h | 4 +++-
 include/linux/rcutiny.h | 3 +--
 lib/vsprintf.c          | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 9881eac0698f..9a1c924e2c6c 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -92,12 +92,14 @@
  * in_nmi()		- We're in NMI context
  * in_hardirq()		- We're in hard IRQ context
  * in_serving_softirq()	- We're in softirq context
+ * in_serving_irq()	- We're in nmi, hardirq or softirq context
  * in_task()		- We're in task context
  */
 #define in_nmi()		(nmi_count())
 #define in_hardirq()		(hardirq_count())
 #define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
-#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
+#define in_serving_irq()	(in_nmi() | in_hardirq() | in_serving_softirq())
+#define in_task()		(!in_serving_irq())
 
 /*
  * The following macros are deprecated and should not be used in new code:
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 7fedbd33d5d2..812d42f22e9c 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -87,8 +87,7 @@ static inline void rcu_irq_exit_irqson(void) { }
 static inline void rcu_irq_enter_irqson(void) { }
 static inline void rcu_irq_exit(void) { }
 static inline void rcu_irq_exit_check_preempt(void) { }
-#define rcu_is_idle_cpu(cpu) \
-	(is_idle_task(current) && !in_nmi() && !in_hardirq() && !in_serving_softirq())
+#define rcu_is_idle_cpu(cpu) (is_idle_task(current) && !in_serving_irq())
 static inline void exit_rcu(void) { }
 static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 2c5b4351330c..9324439c8543 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -865,7 +865,7 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
 		 * kptr_restrict==1 cannot be used in IRQ context
 		 * because its test for CAP_SYSLOG would be meaningless.
 		 */
-		if (in_hardirq() || in_serving_softirq() || in_nmi()) {
+		if (in_serving_irq()) {
 			if (spec.field_width == -1)
 				spec.field_width = 2 * sizeof(ptr);
 			return error_string(buf, end, "pK-error", spec);
-- 
2.30.2

