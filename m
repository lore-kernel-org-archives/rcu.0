Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1099C4332F
	for <rcu@archiver.kernel.org>; Wed,  9 Nov 2022 02:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiKICsF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Nov 2022 21:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiKICsE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Nov 2022 21:48:04 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D181F631
        for <rcu@vger.kernel.org>; Tue,  8 Nov 2022 18:48:04 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h21so9766159qtu.2
        for <rcu@vger.kernel.org>; Tue, 08 Nov 2022 18:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=POLyPFhcRrWc7CPsHxZIScHcqeGIL/i1T9EVfkZiKf8=;
        b=kVdePAWSoLRynI3q+9txnpRyNNJrqvi1yKkDnmec2nkuV78lLp+hy7GL6+AllmN0Wo
         nWGHzPLEtXHk5WzwzOXs0PR/63yzNjCrqGyj/mlvL6o/IfyQMuKaPX7tX5e3U3O4a268
         FSGA6cIo00JcVlUDFhOopAuMqrZHay6HtLizo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POLyPFhcRrWc7CPsHxZIScHcqeGIL/i1T9EVfkZiKf8=;
        b=oJIsvyFrjVhp2/ydKULf9gnrT7F7NP8Z65D8O/hni5dC3xhz/QJyjhMUMtv1iIDT7V
         /Iffl5E+KGdgGCmTwAZsOrPHBNt3Mk9tXbI3egaLm4z5puGulzajKlAhpWvwaatuvS3d
         KB/9uUBQ00Z2SQ+BDg2C3A7G+WWZgnWUdbv0Hz0a+IBJUk2Ot4zvSJ35FQKLoRqQBBS/
         SS5jkN2xmZpdZtzei74Rs/CeK5y48SNuYfrjZoA/+MzkhluFLEe96R0qI8SpYIvD1uW3
         MmF1RFOcWdq2cRdfTOEC2kBYaP6ptqjriiyke3ykeNt77d01K7RCoe1u0gRjLpDVzlh1
         F1iQ==
X-Gm-Message-State: ACrzQf2ToOE7h9xBElmY6R8FPD5SMuU8egXeXnKAGl8hYsE788lJYtur
        0syhYhQxnnbwvWXZaMNKSH3P9Md4ECYLNQ==
X-Google-Smtp-Source: AMsMyM4x/Mu1ps7RCJybA4u3yokDOI9jloyiI2QhvENo/y8MSQEctIM69iqH68lc+UgPTxswLlhiEQ==
X-Received: by 2002:a05:622a:408d:b0:3a5:533b:5421 with SMTP id cg13-20020a05622a408d00b003a5533b5421mr23458856qtb.442.1667962082883;
        Tue, 08 Nov 2022 18:48:02 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w13-20020a05620a444d00b006cbc00db595sm10498011qkp.23.2022.11.08.18.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 18:48:02 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org, urezki@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2] rcu/kfree: Do not request RCU when not needed
Date:   Wed,  9 Nov 2022 02:47:58 +0000
Message-Id: <20221109024758.2644936-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On ChromeOS, using this with the increased timeout, we see that we almost always
never need to initiate a new grace period. Testing also shows this frees large
amounts of unreclaimed memory, under intense kfree_rcu() pressure.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1->v2: Same logic but use polled grace periods instead of sampling gp_seq.

 kernel/rcu/tree.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 591187b6352e..ed41243f7a49 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
 
 /**
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
+ * @gp_snap: The GP snapshot recorded at the last scheduling of monitor work.
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
  * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
@@ -2964,6 +2965,7 @@ struct kfree_rcu_cpu {
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
+	unsigned long gp_snap;
 	bool initialized;
 	int count;
 
@@ -3167,6 +3169,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
 			mod_delayed_work(system_wq, &krcp->monitor_work, delay);
 		return;
 	}
+	krcp->gp_snap = get_state_synchronize_rcu();
 	queue_delayed_work(system_wq, &krcp->monitor_work, delay);
 }
 
@@ -3217,7 +3220,10 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// be that the work is in the pending state when
 			// channels have been detached following by each
 			// other.
-			queue_rcu_work(system_wq, &krwp->rcu_work);
+			if (poll_state_synchronize_rcu(krcp->gp_snap))
+				queue_work(system_wq, &krwp->rcu_work.work);
+			else
+				queue_rcu_work(system_wq, &krwp->rcu_work);
 		}
 	}
 
-- 
2.38.1.431.g37b22c650d-goog


