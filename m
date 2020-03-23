Return-Path: <SRS0=+8aq=5I=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9349C4332E
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 11:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A088920784
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 11:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxE1a/Dc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgCWLgh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:36:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36570 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgCWLgg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 23 Mar 2020 07:36:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id g12so14140569ljj.3;
        Mon, 23 Mar 2020 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fz8u0ZjFk3Lv2kJB2Ooc1ldYEjF3gky60PssRmP4hiE=;
        b=FxE1a/Dcd3Rb3fQ5h95hBJmHPkyO+2I3eUMDuzGt48a3ROTIzitvmXTpcNhGAjEUrt
         v9BDEPrCrYwxq3nT9tPw2cYCp9XiodyaxXKrqdVzi2UIV00kGiac9Q5/nWMoN80eAE0l
         8/KHmz/c6Uq6O6duAv0AIUxN7K0NxI3qRabneHCQmYs+J+umNFB2jCZAS7iQCZjazVcO
         UHauvNP33tOHw9YPdFRbXXARjlsR13F3VCutSZhe+0CJgA1oOrqlT9GYqqDQZnjftVPv
         2vzhJ49gpqsLrXgeH9t8XyzTaCdaZYioHFENdHkMNErupzpEHgesD2Wzfp7d+cpKO9gl
         kOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fz8u0ZjFk3Lv2kJB2Ooc1ldYEjF3gky60PssRmP4hiE=;
        b=fkV7pbLGADa7IT+zf+RSuUWWEBk7QlQOIvOcKgQujCPV6yVMW3zmGVYryfylDyrvVm
         pASFfOwMmANDLUtJqywMXFdhKnl5dNjFIkNRS02QcSUxF6MgYsMKygnmpYm5triAmCQG
         8kT6RfAN8JHSH3ZYywiDRFO4mGhuRe2nVl7Q6zvj3EaVi9z9ohhZYOa5J5EeHaot8CEz
         wknisF5kwGC47vmIYqYvu6Iel4aR+kfinBqMspTq995YLzRE+kGnAm/KIvPqR95EdLAw
         PpJq9LN867wJGFyOauakRW4cCbwBoy84MnA1D1Ek/dfGmctqFwvelD7+SXj8R4PV2P8Z
         4CEw==
X-Gm-Message-State: ANhLgQ1GcH8QPlSOHOAHExQRrdakewsTx30quge42UNtEfAp+VvPFkcw
        ndi7fVJPZFmrl1tRp8nhPXxF63vTv5E=
X-Google-Smtp-Source: ADFU+vt9kzX0ee3yMV61EpE28xxQpmeNO5l0Ntbl7/ZgHt/wWAOwevjPwcDxr5uTSXHK8uQ7zgT7ug==
X-Received: by 2002:a2e:3012:: with SMTP id w18mr3597046ljw.100.1584963393356;
        Mon, 23 Mar 2020 04:36:33 -0700 (PDT)
Received: from localhost.localdomain (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id r23sm8079268lfi.89.2020.03.23.04.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 04:36:32 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 3/7] rcu/tree: introduce expedited_drain flag
Date:   Mon, 23 Mar 2020 12:36:17 +0100
Message-Id: <20200323113621.12048-4-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323113621.12048-1-urezki@gmail.com>
References: <20200323113621.12048-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

It is used and set to true when the bulk array can not
be maintained, it happens under low memory condition
and memory pressure.

In that case the drain work is scheduled right away and
not after KFREE_DRAIN_JIFFIES. It tends to speed up the
reclaim path. From the other hand there are no any data
showing the difference yet.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 20d08eca7006..869a72e25d38 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3061,14 +3061,16 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
  * due to memory pressure.
  *
  * Each kvfree_call_rcu() request is added to a batch. The batch will be drained
- * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
- * be free'd in workqueue context. This allows us to: batch requests together to
- * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
+ * every KFREE_DRAIN_JIFFIES number of jiffies or can be scheduled right away if
+ * a low memory is detected. All the objects in the batch will be free'd in
+ * workqueue context. This allows us to: batch requests together to reduce the
+ * number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
  */
 void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
+	bool expedited_drain = false;
 	void *ptr;
 
 	local_irq_save(flags);	// For safely calling this_cpu_ptr().
@@ -3094,6 +3096,14 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		head->func = func;
 		head->next = krcp->head;
 		krcp->head = head;
+
+		/*
+		 * There was an issue to place the pointer directly
+		 * into array, due to memory pressure. Initiate an
+		 * expedited drain to accelerate lazy invocation of
+		 * appropriate free calls.
+		 */
+		expedited_drain = true;
 	}
 
 	WRITE_ONCE(krcp->count, krcp->count + 1);
@@ -3102,7 +3112,9 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 	    !krcp->monitor_todo) {
 		krcp->monitor_todo = true;
-		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+
+		schedule_delayed_work(&krcp->monitor_work,
+			expedited_drain ? 0:KFREE_DRAIN_JIFFIES);
 	}
 
 unlock_return:
-- 
2.20.1

