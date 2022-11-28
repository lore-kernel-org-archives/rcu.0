Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB07EC433FE
	for <rcu@archiver.kernel.org>; Mon, 28 Nov 2022 08:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiK1I2w (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Nov 2022 03:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiK1I2v (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Nov 2022 03:28:51 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092DE1057A
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 00:28:50 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id b4so9728924pfb.9
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 00:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UV9geM/JQWW7KZsn3D2jR1o/HpwJ7Whcx3peCh7dDk0=;
        b=SQFVA2WNmqUs6RMu0elVVjI+PpzkbEgegh2kfmYzk1cg5PndZgMDNsIVLri+9j9iMy
         LF3QFAMGonWZlrKAtZ/hFMPvjEsorNkcooGRlzg4z9fDWEeumqp69yfQZeJczqnUru5F
         050Sn61kdHsM94psBLDNFG8zv7NIwZv4vpO+T7n7zOzxtTUFXl6ezdbhVPi7bGwY/72y
         6amVpxqhsPlwVv4c3OYA9HNZ3ZndXMxDpnPM9tnWW2mvqwWc5rc5dPatU8dkVSTuLmY7
         hR/khC3TUvWjjwuWQukxX0XlI24sBia77Yw9vFJXWbkXM9miYV/hr3TBX8MaPK6LUn84
         lHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UV9geM/JQWW7KZsn3D2jR1o/HpwJ7Whcx3peCh7dDk0=;
        b=aRS1XUgkHmB0WRDVuSW3cgbKc+pndPMulUEM7+SA7ducpoepF6/LqDl8JcrY0PLVTo
         Gabyvbwd0vVPIt8ReS+68kZIdDxDk2tWm7alqgnipj8cbVMqW1lY8pHdZMWxqkSHotYp
         P/eJ/aspT+vb+3qeBgpTmB6OfsHbxI0Gw/8HPH857efdv84l8c5NLEJhVbWSWOmdEMIh
         nszzZfSFAetCdDGqaPKSN8bZ26WwJdhUuB7ixf78n3BthD5FxG0zJEHWlkBsdyLkGIaA
         t8JuuEXNbEmXfN/rJfmhnzoc78VgxaAYm0gv1aMYA+NorJL645NnxglBkS7Y0T5zBdYj
         Kyjw==
X-Gm-Message-State: ANoB5pmHkiqr8PAbcJV1vsJvUBkEKK4IOM+AEbBLHNrGhpDPbfQ98hAz
        xrr3Agp7YaUBnuz9YJElOsBItvN/vDQo
X-Google-Smtp-Source: AA0mqf6+zDzgDoIYiHYXvnWKF30KTvx4SDiKqbDPBiJPGm2Qb8Qqc+ZMAo44faq3aGnzr03Mq95cDQ==
X-Received: by 2002:a63:d04f:0:b0:46e:c41c:e4bf with SMTP id s15-20020a63d04f000000b0046ec41ce4bfmr26658618pgi.123.1669624129127;
        Mon, 28 Nov 2022 00:28:49 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z20-20020aa79494000000b0056f0753390csm7601637pfk.96.2022.11.28.00.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 00:28:48 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH 3/3] srcu: Decrease the srcu size state numbers
Date:   Mon, 28 Nov 2022 16:28:16 +0800
Message-Id: <20221128082816.28518-4-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221128082816.28518-1-kernelfans@gmail.com>
References: <20221128082816.28518-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

With the previous patch, srcu_cb_mutex is held when setting
SRCU_SIZE_WAIT_BARRIER. It means that only two seq snap value can exist.
And these two snaps can not see the active snp tree if
srcu_gp_start_if_needed() fetches the srcu_size_state before it is
updated to SRCU_SIZE_WAIT_BARRIER.

After dispatching these two snap value's callbacks, the mask in
snp->srcu_data_have_cbs[idx] is assured to be right. Hence the size
state following SRCU_SIZE_WAIT_BARRIER can be shrink to three.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
To: rcu@vger.kernel.org
---
 include/linux/srcutree.h | 15 +++++++++------
 kernel/rcu/srcutree.c    |  3 ---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index e3014319d1ad..34cb9435c14d 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -94,13 +94,16 @@ struct srcu_struct {
 /* Values for size state variable (->srcu_size_state). */
 #define SRCU_SIZE_SMALL		0
 #define SRCU_SIZE_ALLOC		1
+/* If snp tree is initialized */
 #define SRCU_SIZE_WAIT_BARRIER	2
-#define SRCU_SIZE_WAIT_CALL	3
-#define SRCU_SIZE_WAIT_CBS1	4
-#define SRCU_SIZE_WAIT_CBS2	5
-#define SRCU_SIZE_WAIT_CBS3	6
-#define SRCU_SIZE_WAIT_CBS4	7
-#define SRCU_SIZE_BIG		8
+/*
+ * The following two states for the in-flight seq snap, who may not see
+ * the snp tree is active.
+ */
+#define SRCU_SIZE_WAIT_CBS1	3
+#define SRCU_SIZE_WAIT_CBS2	4
+/* All seq snap see the active tree */
+#define SRCU_SIZE_BIG		5
 
 /* Values for state variable (bottom bits of ->srcu_gp_seq). */
 #define SRCU_STATE_IDLE		0
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 281cd69fe804..bdf392e2ef63 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1652,11 +1652,8 @@ static const char * const srcu_size_state_name[] = {
 	"SRCU_SIZE_SMALL",
 	"SRCU_SIZE_ALLOC",
 	"SRCU_SIZE_WAIT_BARRIER",
-	"SRCU_SIZE_WAIT_CALL",
 	"SRCU_SIZE_WAIT_CBS1",
 	"SRCU_SIZE_WAIT_CBS2",
-	"SRCU_SIZE_WAIT_CBS3",
-	"SRCU_SIZE_WAIT_CBS4",
 	"SRCU_SIZE_BIG",
 	"SRCU_SIZE_???",
 };
-- 
2.31.1

