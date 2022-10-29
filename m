Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1996C38A02
	for <rcu@archiver.kernel.org>; Sat, 29 Oct 2022 13:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJ2N3P (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 29 Oct 2022 09:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2N3O (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 29 Oct 2022 09:29:14 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD843B973
        for <rcu@vger.kernel.org>; Sat, 29 Oct 2022 06:29:13 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id c8so5779539qvn.10
        for <rcu@vger.kernel.org>; Sat, 29 Oct 2022 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QCeOrmF4sULE5fXDGGQt+e1Jnohk08bl1WSeFsgJlgA=;
        b=xMvWDbz0oeAQAIrRFyo+vUr+dMPxopQnuakIKzTkv+acMn9+1gxGF0ASPykFKV99ek
         8Z5q3vjtUY2jrsiRp1+jE80bVJrfMz8D6Yn228v7hFV0EQ/KmdTZqIzO5kqUDNyY1dFN
         h9IjdWjbLI2WPORr7k2EjnRc+RXKIeLDc+FmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCeOrmF4sULE5fXDGGQt+e1Jnohk08bl1WSeFsgJlgA=;
        b=CUGWsYh0PeaYuaxeMjwXEhpvI8g1nHYPgyGPVIalqK+xIZUYtdKZJedzaBuWRaGI8H
         4B+9n214XQ1o76M5WgGv5kOm6sxsQ5Fvd9lxf8+6HcwhQTKWhG0AgqAsZg+LCjTD/cCP
         xj/pJikkFR6s5tWiStvjMoNHN+2JZymBKPDqxU/NDC1AOJhZ+U9C1ou/5HuQH9WVqPqD
         MPsD9neCSuwPjyRENB9jD4DOUDm+M4+qzpdx201KOL2kyviFKm0Z/xUeYg8LfNSNIE0Z
         UcUDpO+2J1y4avLi9OTyJgxD8XuiKxrlaYKTWo81WZ0jBijD+hJw/gFrI3LygdD/A4AC
         Yd6g==
X-Gm-Message-State: ACrzQf3A4E2MKQWh79vRzjKICsaIhjN3sTG8HcnmrYR9ndNud1mvIKg0
        cc5oK5nEkiuST/6rZBn/IgxLF7hqDtcGxg==
X-Google-Smtp-Source: AMsMyM7eNySHwa1HVwzxGmBhrU8qjaZvi462BJFkCrr+ifBczzJRKwji6Emu9gxLigdXcXLb6C3m6A==
X-Received: by 2002:a05:6214:29e7:b0:4bb:db99:c393 with SMTP id jv7-20020a05621429e700b004bbdb99c393mr360121qvb.12.1667050152789;
        Sat, 29 Oct 2022 06:29:12 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id m22-20020a05620a291600b006f926a0572asm1085843qkp.27.2022.10.29.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 06:29:11 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org, urezki@gmail.com,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Date:   Sat, 29 Oct 2022 13:28:56 +0000
Message-Id: <20221029132856.3752018-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On ChromeOS, I am (almost) always seeing the optimization trigger.
Tested boot up and trace_printk'ing how often it triggers.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 591187b6352e..3e4c50b9fd33 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
 
 /**
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
+ * @rdp: The rdp of the CPU that this kfree_rcu corresponds to.
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
  * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
@@ -2964,6 +2965,8 @@ struct kfree_rcu_cpu {
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
+	struct rcu_data *rdp;
+	unsigned long last_gp_seq;
 	bool initialized;
 	int count;
 
@@ -3167,6 +3170,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
 			mod_delayed_work(system_wq, &krcp->monitor_work, delay);
 		return;
 	}
+	krcp->last_gp_seq = krcp->rdp->gp_seq;
 	queue_delayed_work(system_wq, &krcp->monitor_work, delay);
 }
 
@@ -3217,7 +3221,17 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// be that the work is in the pending state when
 			// channels have been detached following by each
 			// other.
-			queue_rcu_work(system_wq, &krwp->rcu_work);
+			//
+			// NOTE about gp_seq wrap: In case of gp_seq overflow,
+			// it is possible for rdp->gp_seq to be less than
+			// krcp->last_gp_seq even though a GP might be over. In
+			// this rare case, we would just have one extra GP.
+			if (krcp->last_gp_seq &&
+			    rcu_seq_completed_gp(krcp->last_gp_seq, krcp->rdp->gp_seq)) {
+				queue_work(system_wq, &krwp->rcu_work.work);
+			} else {
+				queue_rcu_work(system_wq, &krwp->rcu_work);
+			}
 		}
 	}
 
@@ -4802,6 +4816,8 @@ static void __init kfree_rcu_batch_init(void)
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
+		krcp->rdp = per_cpu_ptr(&rcu_data, cpu);
+		krcp->last_gp_seq = 0;
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
-- 
2.38.1.273.g43a17bfeac-goog

