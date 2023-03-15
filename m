Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD97C61DA4
	for <rcu@archiver.kernel.org>; Wed, 15 Mar 2023 19:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjCOTjZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 15:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjCOTjN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 15:39:13 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1256939CDC
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 12:39:12 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id o3so17397273qvr.1
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 12:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678909151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kodpLrQnSozwTishADT/eFOoqfGUIFhFbZ2Rg+LiOA=;
        b=WByS267g9t6NJ1kyG9/EnjmxtgTNYbezAKGqyr8CaaBwqZINFEuA/ntWN6H+6kcZlm
         0y0pivfDEqSC6+oWTYuc4+m0Ve4R+syrQBMCVHz35BK+o7Fx/qDMRs/tpQIZtjbMvVYM
         Z/STPa8OKdawLzzW22yLDCHQE1elXduZpbeGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kodpLrQnSozwTishADT/eFOoqfGUIFhFbZ2Rg+LiOA=;
        b=Ww2W9vjZMl8Swu+DLfre5ZZbPsmcI2OkXKU4P8eWFLvcuEEgIvtNuCUKGaMBBlNqUk
         elEXAZKYvZ/hfLQiuGiF0GBue1AFwmVBBkO7F51//+k1dJX2WB6qW7RK0m+xv/hXIs8y
         5YrBPv0e1lTEdhNlZi6ctDrglh4KNBEUUXp29c7yYiqXncGOUJ6v9Ex8Ec/n3Ws4BnEi
         qzWP2w0RPGqQ38Pvdw9tRhWvwPMmDnK9b8+/aUJQE+9jK5MG35oa094h7ZbvO6mdWgPt
         omgAfGKJAAJSWt67mEfOZ4bjTJpRJak8zw8sus9H2gDboO2yL0eEZxyz0f/usSXvASau
         m7Og==
X-Gm-Message-State: AO0yUKUvH0MIviyKIDWvjnLJuIALMKtn2E8tsVrRuL+A2RgxQbdv6y3C
        AcOBw8G7qkxcaEte4OZViTWzyCJYRMRblKLbKdo=
X-Google-Smtp-Source: AK7set9xcFD5mrNuQbfScTwldN49ZVEM6uEf3ek4PJRMRU82tR8zA3YA+oKG8/u9a34gp1BqcGUv3g==
X-Received: by 2002:a05:6214:20a7:b0:56e:fb4c:c1c4 with SMTP id 7-20020a05621420a700b0056efb4cc1c4mr32374960qvd.14.1678909151167;
        Wed, 15 Mar 2023 12:39:11 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b00745af48838bsm4347227qko.5.2023.03.15.12.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:39:10 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 1/6] srcu: Add comments for srcu_size_state
Date:   Wed, 15 Mar 2023 19:38:46 +0000
Message-Id: <20230315193851.8598-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Pingfan Liu <kernelfans@gmail.com>

The SRCU_SIZE_* names are not self-explanatory, so this commit therefore
adds comments to the definitions.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
To: rcu@vger.kernel.org
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/srcutree.h | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 558057b517b7..a6910805f9c5 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -92,16 +92,29 @@ struct srcu_struct {
 	struct lockdep_map dep_map;
 };
 
-/* Values for size state variable (->srcu_size_state). */
-#define SRCU_SIZE_SMALL		0
-#define SRCU_SIZE_ALLOC		1
-#define SRCU_SIZE_WAIT_BARRIER	2
-#define SRCU_SIZE_WAIT_CALL	3
-#define SRCU_SIZE_WAIT_CBS1	4
-#define SRCU_SIZE_WAIT_CBS2	5
-#define SRCU_SIZE_WAIT_CBS3	6
-#define SRCU_SIZE_WAIT_CBS4	7
-#define SRCU_SIZE_BIG		8
+// Values for size state variable (->srcu_size_state).  Once the state
+// has been set to SRCU_SIZE_ALLOC, the grace-period code advances through
+// this state machine one step per grace period until the SRCU_SIZE_BIG state
+// is reached.  Otherwise, the state machine remains in the SRCU_SIZE_SMALL
+// state indefinitely.
+#define SRCU_SIZE_SMALL		0	// No srcu_node combining tree, ->node == NULL
+#define SRCU_SIZE_ALLOC		1	// An srcu_node tree is being allocated, initialized,
+					//  and then referenced by ->node.  It will not be used.
+#define SRCU_SIZE_WAIT_BARRIER	2	// The srcu_node tree starts being used by everything
+					//  except call_srcu(), especially by srcu_barrier().
+					//  By the end of this state, all CPUs and threads
+					//  are aware of this tree's existence.
+#define SRCU_SIZE_WAIT_CALL	3	// The srcu_node tree starts being used by call_srcu().
+					//  By the end of this state, all of the call_srcu()
+					//  invocations that were running on a non-boot CPU
+					//  and using the boot CPU's callback queue will have
+					//  completed.
+#define SRCU_SIZE_WAIT_CBS1	4	// Don't trust the ->srcu_have_cbs[] grace-period
+#define SRCU_SIZE_WAIT_CBS2	5	//  sequence elements or the ->srcu_data_have_cbs[]
+#define SRCU_SIZE_WAIT_CBS3	6	//  CPU-bitmask elements until all four elements of
+#define SRCU_SIZE_WAIT_CBS4	7	//  each array have been initialized.
+#define SRCU_SIZE_BIG		8	// The srcu_node combining tree is fully initialized
+					//  and all aspects of it are being put to use.
 
 /* Values for state variable (bottom bits of ->srcu_gp_seq). */
 #define SRCU_STATE_IDLE		0
-- 
2.40.0.rc1.284.g88254d51c5-goog

