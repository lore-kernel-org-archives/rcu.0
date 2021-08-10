Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D479C4338F
	for <rcu@archiver.kernel.org>; Tue, 10 Aug 2021 21:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4768360E09
	for <rcu@archiver.kernel.org>; Tue, 10 Aug 2021 21:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhHJVEE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Aug 2021 17:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhHJVED (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 Aug 2021 17:04:03 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41E0C0613C1;
        Tue, 10 Aug 2021 14:03:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nt11so6478pjb.2;
        Tue, 10 Aug 2021 14:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fz0iEsmbP+UovNHnMjy0vvTC6LaoMPc9ZqWQw5ZZu2U=;
        b=doBa1shVFvbzNc/vedDkWmubrx/3avl+zKtIt42eDsdkVr/HBmO1nJtjzO9kIPDaSO
         y5cfp6It+ZLCVLU0Bb1ouUzSggifKkB81Ag7IQWfk2/1igiTJ+6GPvSpMHeZFpgLRQGT
         y13ETRZ3DYVSSr7f/0miwSx2uQ9FxmdzV06GspPmw9Bx44kS0ty9ZIyUtVU0RO0+1x4r
         DQ5pqZsS3f8keEjcY8P7vHh6DoqLjOGdBPKVIMiNb3WkZ3AZ/nmohbUydXFNIkQF40+i
         WEPVsxT5iTAs4m32S+0OOGjEN1g7Q8pz+Jk2R2KHBjrBG4v0G/0NzHKFA52lah8h/6uz
         pqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fz0iEsmbP+UovNHnMjy0vvTC6LaoMPc9ZqWQw5ZZu2U=;
        b=fWPOL73Gvbm+h/2h8jSA/IrMzC6qbcr536yOQeVpJwY+ADkjR1XNJZn/XvQ4NGIENm
         WDCQ6YZZdpWvSw7Sc4K8P3kkmES+L3HPUiqz21c8b5KCnwBGrK7WlsHTat4447nkjxg0
         fNAsYgegP/CVIYgEBkx+D2uBsMYpt/46/Xx3Swtb+IFrVJTKaigpW51EkIVBG4NkVD9a
         7/+OwvGRAUgFxuGsz554zRu+bKcnChC1eyd0ZCHp3Vc3mStFk0LnEgotVG3gCtajgsbp
         ymlmBPOz1N13lFQ19oFr+hVekm3zrjNp/3YBEiw7/DEj2FnzC4QmpuiAlEtSjKmFyA/j
         oA9Q==
X-Gm-Message-State: AOAM531x5TeAso9UggrMQMFkytG6V032ckj0NeMprAqjIU88bIqTevAC
        vqZi6buq2KYr6Sxg1/ip9gk=
X-Google-Smtp-Source: ABdhPJwKIsFbAVRd2p+wbNEr3iIWoS3caIae6UcmBjLy1lldjtBBHNrODO35yCaeGptP6P6OzXUp1A==
X-Received: by 2002:a17:90a:5a4c:: with SMTP id m12mr7097453pji.15.1628629420520;
        Tue, 10 Aug 2021 14:03:40 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.173])
        by smtp.gmail.com with ESMTPSA id a4sm1868333pfk.0.2021.08.10.14.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 14:03:39 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, paulmck@kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH][RFC] lockdep: improve comments in wait-type checks
Date:   Wed, 11 Aug 2021 05:03:19 +0800
Message-Id: <20210810210319.6564-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Peter,
  I think comments in wait-type checks may benifit from some comments
improvement.
  I recklessly add Paul to signed-off-by, because I asked his opinion
about comment in rcu_read_lock_bh part.

Thanks a lot
Zhouyi

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/lockdep_types.h | 2 +-
 kernel/locking/lockdep.c      | 2 +-
 kernel/rcu/update.c           | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 3e726ace5c62..d22430840b53 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -21,7 +21,7 @@ enum lockdep_wait_type {
 	LD_WAIT_SPIN,		/* spin loops, raw_spinlock_t etc.. */
 
 #ifdef CONFIG_PROVE_RAW_LOCK_NESTING
-	LD_WAIT_CONFIG,		/* CONFIG_PREEMPT_LOCK, spinlock_t etc.. */
+	LD_WAIT_CONFIG,		/* preemptible in PREEMPT_RT, spinlock_t etc.. */
 #else
 	LD_WAIT_CONFIG = LD_WAIT_SPIN,
 #endif
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bf1c00c881e4..952d0ccf8776 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4671,7 +4671,7 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 /*
  * Verify the wait_type context.
  *
- * This check validates we takes locks in the right wait-type order; that is it
+ * This check validates we take locks in the right wait-type order; that is it
  * ensures that we do not take mutexes inside spinlocks and do not attempt to
  * acquire spinlocks inside raw_spinlocks and the sort.
  *
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c21b38cc25e9..690b0cec7459 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -247,7 +247,7 @@ struct lockdep_map rcu_lock_map = {
 	.name = "rcu_read_lock",
 	.key = &rcu_lock_key,
 	.wait_type_outer = LD_WAIT_FREE,
-	.wait_type_inner = LD_WAIT_CONFIG, /* XXX PREEMPT_RCU ? */
+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT implies PREEMPT_RCU */
 };
 EXPORT_SYMBOL_GPL(rcu_lock_map);
 
@@ -256,7 +256,7 @@ struct lockdep_map rcu_bh_lock_map = {
 	.name = "rcu_read_lock_bh",
 	.key = &rcu_bh_lock_key,
 	.wait_type_outer = LD_WAIT_FREE,
-	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_LOCK also makes BH preemptible */
+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
 };
 EXPORT_SYMBOL_GPL(rcu_bh_lock_map);
 
-- 
2.25.1

