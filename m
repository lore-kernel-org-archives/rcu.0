Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950331C2E
	for <rcu@vger.kernel.org>; Fri, 12 Jul 2024 00:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720745812; cv=none; b=SXDyVAmYDGgGggrhuIoFOOXOxN0uxwH+X75mtSWK8Eo0d0K06U56WYH29lFAuyGoHL4bu7mqXKBjcJ8MZhem1vwrydoqwzZhigvB5FqX76p8/f4Vi00W086aoMSLILl8yL6qJhVOCn9g7+CYNXRs6Ks4OrDmf5eKcV8+N/G5nr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720745812; c=relaxed/simple;
	bh=o4KE0eSAF1Z+i16D9k2fb7T5EhISeKW0bbW/IwJMFRc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Pwwb9Bq4qswU7GrnNEbvemP90lPr728btYCEJ/4q/BwIZbl2Y8DzNO108Lno1a0ZG6STXgbrN3of4A9R4AdNAwYZefh6n3mBaGxvWC1bahiGTlec9CKXgUUOoaj2+ppE5PgERsXJBc9DzXsoasuol9von/1I9yq2FnU4ne3TeJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUaprB+6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUaprB+6"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb70169c23so13618985ad.1
        for <rcu@vger.kernel.org>; Thu, 11 Jul 2024 17:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720745810; x=1721350610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jrM7Czli+kAVh1Xo7kDMa5N0NWe0q42unvcsrT2Aezg=;
        b=MUaprB+6mznZHFksSR1RZsLEOnx1g4heKAAcu6QRyXSkqxYlaWGMoSceAc/xX8W8qO
         420IrCTnAq0IJhTIr6zTsLRZEFJkAEmbEUYMbCv+XyaSejlCQNv9zJGCZPOHhjmB64Hl
         g/sJFAjX3HdHljeGb3fdZRXIM0lOc5b9fC2vQx6pcNx9Jm2LW7f2/K0HY6j1zkLbfLvZ
         avE9Y38PPGPpFcIB8YTucvdlhb0h/TurKswdS+fibwJEdLjnD6X2Cnwpyh6N9kZmKf2W
         kYuNsS30Rm1fOLb/VZkNNi+RBCsH5Y+i/R1F/mKh5gjF18xS00Jkd+XG7uck1PsbY/u/
         dH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720745810; x=1721350610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrM7Czli+kAVh1Xo7kDMa5N0NWe0q42unvcsrT2Aezg=;
        b=e4wvsYZCwkYdcfqgTdMfnfdpe3obInf0ZZWTo7uLNx5OhBAN2JQYCtEqs7Td4Ty3fX
         T1ntjgoUVTCKCqModuRFDb6TukbP7zLidarn7N78/jP/++6h8ICEfrRNFEA/ImRCXhMh
         ZInv7f/wtSsW3NAqhtzJQzH8gPMP9Bp//9OXOIQdF0h7Z2Uh60CqIpkgxJqKJs3hjwaz
         KePYgv3hHdyByrbyhUVFEXDsrB+/05fKtia4CJ8txCUx03ps55lw0Ct5JD24fmZpnXgg
         73malrZ5LR8G1/54Cd/52F14kZ1BCDtd2ewxyNpJPqR/fUMGfp0UH41Vioe2kSg8/Nrq
         Xgew==
X-Forwarded-Encrypted: i=1; AJvYcCW2W4cT0IUY4mkBY5a5vFv0F+AtqU/MLOfcNw0/5CRywm7S77ht1eQd1NSc6RtUa3aEuMH540mLQo8+8SyRZGc8evOO
X-Gm-Message-State: AOJu0YxtgyHViyNZWo4kMcgy2E4UPbt9UwoF5vGu2NyaZ+m6OPdhgoyU
	I4SXzKfUXwNhMpJJk9QOuWzw0Fo7aLS63yTCx7sWL8Q0L/0DodTI
X-Google-Smtp-Source: AGHT+IF4K65Rw8cKbgD/4pWgBG8FUS25hTsdwhp1d953L74aZ36xLimxAOjyfBuJvKOm9/Y1r9/+jQ==
X-Received: by 2002:a17:903:32d0:b0:1fb:6ea1:35 with SMTP id d9443c01a7336-1fbb6ee1e47mr93628375ad.69.1720745809737;
        Thu, 11 Jul 2024 17:56:49 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac8c84sm56272185ad.246.2024.07.11.17.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 17:56:49 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: paulmck@kernel.org,
	rcu@vger.kernel.org
Subject: [PATCH] srcu: faster srcu gp seq wrap-around
Date: Thu, 11 Jul 2024 17:56:29 -0700
Message-ID: <20240712005629.2980-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using a higher value for the initial gp sequence counter values allows for
wrapping to occur faster. It can help with surfacing any issues that may be
happening as a result of the wrap around.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/rcupdate.h |  3 +++
 include/linux/srcutree.h | 15 ++++++++++++++-
 kernel/rcu/rcu.h         |  3 ---
 kernel/rcu/srcutree.c    |  6 ++++--
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index dfd2399f2cde..c148674b9e09 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -35,6 +35,9 @@
 #define ULONG_CMP_GE(a, b)	(ULONG_MAX / 2 >= (a) - (b))
 #define ULONG_CMP_LT(a, b)	(ULONG_MAX / 2 < (a) - (b))
 
+#define RCU_SEQ_CTR_SHIFT    2
+#define RCU_SEQ_STATE_MASK   ((1 << RCU_SEQ_CTR_SHIFT) - 1)
+
 /* Exported common interfaces */
 void call_rcu(struct rcu_head *head, rcu_callback_t func);
 void rcu_barrier_tasks(void);
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 8f3f72480e78..ed57598394de 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -129,10 +129,23 @@ struct srcu_struct {
 #define SRCU_STATE_SCAN1	1
 #define SRCU_STATE_SCAN2	2
 
+/*
+ * Values for initializing gp sequence fields. Higher values allow wrap arounds to
+ * occur earlier.
+ * The second value with state is useful in the case of static initialization of
+ * srcu_usage where srcu_gp_seq_needed is expected to have some state value in its
+ * lower bits (or else it will appear to be already initialized within
+ * the call check_init_srcu_struct()).
+ */
+#define SRCU_GP_SEQ_INITIAL_VAL ((0UL - 100UL) << RCU_SEQ_CTR_SHIFT)
+#define SRCU_GP_SEQ_INITIAL_VAL_WITH_STATE (SRCU_GP_SEQ_INITIAL_VAL - 1)
+
 #define __SRCU_USAGE_INIT(name)									\
 {												\
 	.lock = __SPIN_LOCK_UNLOCKED(name.lock),						\
-	.srcu_gp_seq_needed = -1UL,								\
+	.srcu_gp_seq = SRCU_GP_SEQ_INITIAL_VAL,							\
+	.srcu_gp_seq_needed = SRCU_GP_SEQ_INITIAL_VAL_WITH_STATE,				\
+	.srcu_gp_seq_needed_exp = SRCU_GP_SEQ_INITIAL_VAL,					\
 	.work = __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),					\
 }
 
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 38238e595a61..2bfed9855d67 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -54,9 +54,6 @@
  *					grace-period sequence number.
  */
 
-#define RCU_SEQ_CTR_SHIFT	2
-#define RCU_SEQ_STATE_MASK	((1 << RCU_SEQ_CTR_SHIFT) - 1)
-
 /* Low-order bit definition for polled grace-period APIs. */
 #define RCU_GET_STATE_COMPLETED	0x1
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index bc4b58b0204e..2209dd0589de 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -247,7 +247,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	mutex_init(&ssp->srcu_sup->srcu_cb_mutex);
 	mutex_init(&ssp->srcu_sup->srcu_gp_mutex);
 	ssp->srcu_idx = 0;
-	ssp->srcu_sup->srcu_gp_seq = 0;
+	ssp->srcu_sup->srcu_gp_seq = SRCU_GP_SEQ_INITIAL_VAL;
 	ssp->srcu_sup->srcu_barrier_seq = 0;
 	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
 	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
@@ -258,7 +258,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	if (!ssp->sda)
 		goto err_free_sup;
 	init_srcu_struct_data(ssp);
-	ssp->srcu_sup->srcu_gp_seq_needed_exp = 0;
+	ssp->srcu_sup->srcu_gp_seq_needed_exp = SRCU_GP_SEQ_INITIAL_VAL;
 	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
 		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
@@ -267,6 +267,8 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	}
 	ssp->srcu_sup->srcu_ssp = ssp;
 	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed, 0); /* Init done. */
+	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed,
+		SRCU_GP_SEQ_INITIAL_VAL); /* Init done. */
 	return 0;
 
 err_free_sda:
-- 
2.45.2

