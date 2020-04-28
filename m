Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE2AC8300B
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A21321707
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jpurp9Cl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgD1U7j (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726805AbgD1U7i (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:38 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA02C035493;
        Tue, 28 Apr 2020 13:59:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g4so256668ljl.2;
        Tue, 28 Apr 2020 13:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0CB7l/SclT28khEWhDaoUOOzb7zLYSSjDTiXz+d76vU=;
        b=Jpurp9ClV4jnTD0F9m48AGNqTXz1ipQrAnggVWpZFOF++j+brs2BKKdSPUbdX6aZOP
         BB8HYRVyTSPw91F6rc83G9mQtUbt8i+VsniMWASdZeP4lB0eHTKd1GAxaIoFracSoQ3+
         F7NRMfQvoTQaOkMDbTk7RM6frPn7zX6fgnxmlX95hAJhKHI6P8XvSJz0jdrT954quNlp
         dc7nYW9b2hFclqqafaD225XwkP8oDazc0+OJhcOqqA2m1CoVJpFVKvB9+/mbSIQC6RmP
         1sCltiRVjQyIl+DaJZ13b39p5EgL7BpUtO0Iexqfelc4wWFL2kl9G74dBy8g1jpDUACO
         T3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0CB7l/SclT28khEWhDaoUOOzb7zLYSSjDTiXz+d76vU=;
        b=tZ3jIFdz0JvxORBuf5oR5jLZqNlwOfSkeQqbL8b8oaXMqat7FBGhf5+iJ0V1Nl4Nz2
         /D2lyw52ZNQj3Ut2W+ce29wcsbSkomtur9NCr7z9/C9pDyqAzydoRjJ084HZlPY0F5U6
         CQEYEdcnDFOyjnlwaxnO1TjiuQsnFgKiG1q7MYGkpf0rrudN5fdDFwGvsP0pvlPbj9ns
         KkykGaro1mEdkzeUQ+wLHBTysdZLfVk2Pb/Vziv9TGXXbMRFAgGov1Es1eNplYYXOBRa
         1pf7NWyplLwQ52TRKEqbD7wFF60L2dKeYVCzVkBCL0VHo1rzCItSc5r5XuE6S2RbZlwq
         BXeg==
X-Gm-Message-State: AGi0Pua0wtfh2rZRon3ZfApVtNFWgV3GRjFVwl0d8wCURbrbdS/jYHpq
        Oqsh0yZALKoxy5iPWn3c4m5CA0Nz3MNgZw==
X-Google-Smtp-Source: APiQypLcBZKomWi/mld0ygXkGSXRF8+JLRFoqb07LLbjRoBNCtmRtZtFo7Ra7QnQjLvb3s+93krp6g==
X-Received: by 2002:a2e:571a:: with SMTP id l26mr18387002ljb.12.1588107575418;
        Tue, 28 Apr 2020 13:59:35 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:34 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 06/24] rcu/tree: Simplify KFREE_BULK_MAX_ENTR macro
Date:   Tue, 28 Apr 2020 22:58:45 +0200
Message-Id: <20200428205903.61704-7-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

We can simplify KFREE_BULK_MAX_ENTR macro and get rid of
magic numbers which were used to make the structure to be
exactly one page.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 767aed49d7fd..eebd7f627794 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2848,13 +2848,6 @@ EXPORT_SYMBOL_GPL(call_rcu);
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
 #define KFREE_N_BATCHES 2
 
-/*
- * This macro defines how many entries the "records" array
- * will contain. It is based on the fact that the size of
- * kfree_rcu_bulk_data structure becomes exactly one page.
- */
-#define KFREE_BULK_MAX_ENTR ((PAGE_SIZE / sizeof(void *)) - 3)
-
 /**
  * struct kfree_rcu_bulk_data - single block to store kfree_rcu() pointers
  * @nr_records: Number of active pointers in the array
@@ -2863,10 +2856,18 @@ EXPORT_SYMBOL_GPL(call_rcu);
  */
 struct kfree_rcu_bulk_data {
 	unsigned long nr_records;
-	void *records[KFREE_BULK_MAX_ENTR];
 	struct kfree_rcu_bulk_data *next;
+	void *records[];
 };
 
+/*
+ * This macro defines how many entries the "records" array
+ * will contain. It is based on the fact that the size of
+ * kfree_rcu_bulk_data structure becomes exactly one page.
+ */
+#define KFREE_BULK_MAX_ENTR \
+	((PAGE_SIZE - sizeof(struct kfree_rcu_bulk_data)) / sizeof(void *))
+
 /**
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
-- 
2.20.1

