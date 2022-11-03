Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDB4C433FE
	for <rcu@archiver.kernel.org>; Thu,  3 Nov 2022 13:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiKCNOG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 3 Nov 2022 09:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiKCNNq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 3 Nov 2022 09:13:46 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DA914D24
        for <rcu@vger.kernel.org>; Thu,  3 Nov 2022 06:13:29 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f63so1639416pgc.2
        for <rcu@vger.kernel.org>; Thu, 03 Nov 2022 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8i3HOPgQD8h0tleJXR3Dl7B6Fax/sa1QpGi6GzW7JKU=;
        b=hcck/yLu0dBwa2x0PUHfqS5MhO7YH1sOnBOBrTOvLvpCKg+iv/w/uzSeILfQFLsRTe
         /7OAzNZGLTpGukKUG/Gsl6pNiFoj5zYAQzpAlMoFfV6NLtMynOWkQxana2nvqj/ystjW
         ht4vFEk3EcbI/PW8T0Kpy+NpPI2Q0OUl4H3H6Pd0R4cPqJw+KDnpFMsjTy465GKtKS8G
         n6BKce4i7GmbIGmvs/bwx7AKg4Kq52yPsr2btt8oFumRfY0H1fKt+IYdEDtQClS3g5c/
         IMiRX+GGYfcr1lXSGFY8N9QkAJwEqDgkgR7Fq7BsLPTL6LKkgZRsGdpNTyzzZCHGHIZl
         Gw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8i3HOPgQD8h0tleJXR3Dl7B6Fax/sa1QpGi6GzW7JKU=;
        b=rHefvMv0JQqQW332+ub3MbaNIC7R52OZaoS8GkcIw0hbqXYPqxNPbgBxvJcF8x2KPk
         oDo42ePwOFmHzPo+pjrWDa4BpQ/qP+0GR2wHbDIvqLpej8rj0ZUU26TzKsgdG38VdeWY
         CJl/DWYN06uKwH3G+WGC1G3Uy68cI5sp4aYxLiWgMluXin77PFDFCgpKeqfgpDoJCv9G
         UUJ5bdsq2qTDJq9ls8RnowKvSztKTyWuWQS178SKQ3dxl7Ehzq74WDjWUt5JLJBS+v/s
         BD00vNkk1rQhbixBzrK1O/aBNCAFlbVQ2T8w0P1VuvC3ggwog1LNVZEKKgB+pabL0raR
         fhHQ==
X-Gm-Message-State: ACrzQf0XBlu0nti8X1uq5PP5Fif+BX+jGYxYMP+FJVi/B2VOLep+Rri+
        ZjwY9iwuTUA6vem8u76NY1EdMg8VnZCW
X-Google-Smtp-Source: AMsMyM7l7OGUpD+LFI7727cikjvVgG+fJS+8mAqEsHNik4fr2zC8yjDKCgUf1Jd0T94wUdCo6C0gKA==
X-Received: by 2002:a05:6a00:993:b0:56c:80f6:db5 with SMTP id u19-20020a056a00099300b0056c80f60db5mr30065480pfg.45.1667481207141;
        Thu, 03 Nov 2022 06:13:27 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h16-20020aa796d0000000b0056c2e497b02sm704433pfq.173.2022.11.03.06.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:13:26 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] srcu: Fix a rare race issue in __srcu_read_(un)lock()
Date:   Thu,  3 Nov 2022 21:13:13 +0800
Message-Id: <20221103131313.41536-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Clarify at first:
  This issue is totally detected by code suspicion, not a real experience.

Scene:

  __srcu_read_(un)lock() uses percpu variable srcu_(un)lock_count[2].
Normally, the percpu can help avoid the non-atomic RMW issue, but in
some rare cases, it can not.

Supposing that __srcu_read_lock() runs on cpuX, the statement
    this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
can be decomposed into two sub group:
    -1. get the address of this_cpu_ptr(ssp->sda)->srcu_lock_count[idx],
denoted as addressX and let unsigned long *pX = addressX;
    -2. *pX = *pX + 1;

Now, assuming there are two tasks, denoted as taskA and taskB, three
cpus, denoted as cpuX, cpuY and cpuZ. Let both taskA and taskB finish
the first step as above on cpuX, but migrate to cpuY and cpuZ
individually just before the second step. Then both of them continue to
execute concurrently from the second step. This will raise a typical
non-atomic RMW issue.

Solution:

  This issue can be tackled by disable preemption around the two sub
groups.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rcu@vger.kernel.org
---
 kernel/rcu/srcutree.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1c304fec89c0..a38a3779dc01 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -636,7 +636,11 @@ int __srcu_read_lock(struct srcu_struct *ssp)
 	int idx;
 
 	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
+	__preempt_count_inc();
+	barrier();
 	this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
+	barrier();
+	__preempt_count_dec();
 	smp_mb(); /* B */  /* Avoid leaking the critical section. */
 	return idx;
 }
@@ -650,7 +654,11 @@ EXPORT_SYMBOL_GPL(__srcu_read_lock);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
 	smp_mb(); /* C */  /* Avoid leaking the critical section. */
+	__preempt_count_inc();
+	barrier();
 	this_cpu_inc(ssp->sda->srcu_unlock_count[idx]);
+	barrier();
+	__preempt_count_dec();
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
-- 
2.31.1

