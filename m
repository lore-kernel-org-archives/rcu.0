Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA36C00A5A
	for <rcu@archiver.kernel.org>; Thu, 19 Jan 2023 14:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjASONc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Jan 2023 09:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjASONA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Jan 2023 09:13:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1537A516;
        Thu, 19 Jan 2023 06:11:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABA8D6193C;
        Thu, 19 Jan 2023 14:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80185C433D2;
        Thu, 19 Jan 2023 14:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674137512;
        bh=OKFnPlamVIGxATjd1NpoI9TS3nc4OBBm0WxpbHl6GTQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Rt8odT8545D3qVYinjspDEh3rgwBB4ANkAKDVJEm+jJN78EnbxHQmkHc3jSEAv7ie
         6d+nWx12nnO/t1PlG5MiAVUauHLIf6SwoPGNVVeWzUADhNBkkVs3FbbW8AyTj7EkKc
         FM6T6iEvhnxgeufAUtD75tvqhZFCFFSGCmptQmFr71vNPgQdI6uBc7H3iCdMLWemNT
         XkJSnTt9+AhdmESNN357rcyZNfJZVqnOoJB7QT3p11rt2m9Y9yq9j5McHgBACnlUqk
         1EfWxnLOk6TKT1355FNci4vOY3W9WeQSfXYahhQ+B2t/iti3DlIGXw3QcL+tK+RmDL
         X0PCcw+ISdlIQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        quic_neeraju@quicinc.com, Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH] rcu: Further comment and explain the state space of GP sequences
Date:   Thu, 19 Jan 2023 15:11:35 +0100
Message-Id: <20230119141134.686626-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The state space of the GP sequence number isn't documented and the
definitions of its special values are scattered. Try to gather some
common knowledge near the GP seq headers.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcu.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 115616ac3bfa..fb95de039596 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -14,6 +14,39 @@
 
 /*
  * Grace-period counter management.
+ *
+ * The two lowest significant bits gather the control flags.
+ * The higher bits form the RCU sequence counter.
+ *
+ * About the control flags, a common value of 0 means that no GP is in progress.
+ * A value of 1 means that a grace period has started and is in progress. When
+ * the grace period completes, the control flags are reset to 0 and the sequence
+ * counter is incremented.
+ *
+ * However some specific RCU usages make use of custom values.
+ *
+ * SRCU special control values:
+ *
+ * 	SRCU_SNP_INIT_SEQ	:	Invalid/init value set when SRCU node
+ * 							is initialized.
+ *
+ * 	SRCU_STATE_IDLE		:	No SRCU gp is in progress
+ *
+ * 	SRCU_STATE_SCAN1	:	State set by rcu_seq_start(). Indicates
+ *								we are scanning the inactive readers
+ *								index.
+ *
+ *		SRCU_STATE_SCAN2	:	State set manually via rcu_seq_set_state()
+ *								Indicates we are flipping the readers
+ *								index and then scanning the newly inactive
+ *								readers index.
+ *
+ * RCU polled GP special control value:
+ *
+ *	RCU_GET_STATE_COMPLETED :	State value indicating that a polled GP
+ *								has completed. It's an absolute value
+ *								covering both the state and the counter of
+ *								the GP sequence.
  */
 
 #define RCU_SEQ_CTR_SHIFT	2
-- 
2.34.1

