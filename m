Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC07C433FE
	for <rcu@archiver.kernel.org>; Fri,  4 Nov 2022 14:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiKDOYF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Nov 2022 10:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiKDOXp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Nov 2022 10:23:45 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9142FFDF
        for <rcu@vger.kernel.org>; Fri,  4 Nov 2022 07:22:08 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id e15so3275822qvo.4
        for <rcu@vger.kernel.org>; Fri, 04 Nov 2022 07:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=POLyPFhcRrWc7CPsHxZIScHcqeGIL/i1T9EVfkZiKf8=;
        b=iyGPSuH4knMUpOAbTKKY7ANdDoLZLwu4D+gzuk4mhBolJyamFMeXtlWs4LrOfvrgGx
         pENZp8WidziwYuVlQEJQFYuRrILiPHx04k2voWxCxKFCcVsolZG/DStHot0UsbHx/P2k
         A5vrebvl/Y3mruegKlQGmDF5NcRCP12PkeYAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POLyPFhcRrWc7CPsHxZIScHcqeGIL/i1T9EVfkZiKf8=;
        b=qpigAUPTO4igPb4R2O1OUk7q1HVMwZoGSDTYtpRiVvx2PBVT9SsBA6AoU/mCfkd55m
         saJkdyTW9s6gs0ES2FCMINOdHAHA4sbPgaEDmBLYc/5cWOYpL9/lvHFld0szj5hD5p1d
         dxeRED6UfGenQEje5p9lJbJQexRArrHp64FYbxBxesend2ZMuktVSoDmzEBqRGi0L1e7
         gd996xnaxqhhtRDX59XoODGO7vaHLcUU2zyl2uRRjnfIj0CvAGJox0Xk7035xQMsa0ld
         YLjNbH33ueRF+tPHrpLkiHYXM92YCzXUF8JNddvFlGVvUYyQwmM8XZyXwPjnBhb4Hh/m
         qdeg==
X-Gm-Message-State: ACrzQf3Ybpctux+oKvzNDz/HFlzNPau4egWq4GQmIYufi3lyAyV5jWhs
        Tj9ZHjfrs+7m+CEt/HJSdyunbYkofUEKEQ==
X-Google-Smtp-Source: AMsMyM74mAYB0QeEPZy+GC+hs9tCCRCf8SdtJWAcDNRwzluyiQU2DDeg5VBRxOMxJKVkr+hfp29IWQ==
X-Received: by 2002:a05:6214:c64:b0:4bc:33f:4515 with SMTP id t4-20020a0562140c6400b004bc033f4515mr23747253qvj.44.1667571719562;
        Fri, 04 Nov 2022 07:21:59 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id d16-20020a05620a241000b006bb29d932e1sm3081423qkn.105.2022.11.04.07.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:21:59 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, urezki@gmail.com, paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2] rcu/kfree: Do not request RCU when not needed
Date:   Fri,  4 Nov 2022 14:21:35 +0000
Message-Id: <20221104142135.991888-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
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

