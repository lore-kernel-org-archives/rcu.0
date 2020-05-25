Return-Path: <SRS0=Lsu2=7H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8DEC433E0
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C44C207CB
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQAomHcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbgEYVsV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 17:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731500AbgEYVsT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 17:48:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E6BC061A0E;
        Mon, 25 May 2020 14:48:17 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m18so22152056ljo.5;
        Mon, 25 May 2020 14:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZQqXHmyUSlSMzrEScq/mc28bFFncHq5WVrswvpeHH5c=;
        b=nQAomHcfsNoRankxf3s+HeOEHNCHu2KmuSmpUalABmcCQtLqexcSQ3HblvcZtsuaF4
         otVr2oDxWeVWUW5VOoQ2++yly0jQXYqjKZdL8iwzqlLqnci24JZ7HYKlwLwIuJGpeMGt
         JEqpfJKb2UHMs5+ON23CHKijnJJ2/L00Iit2ge7oba8fvFLYW1tInnxhyLssBi39T00m
         qi/iRX5hCt9qeOBqpcEyZFAuSuD4wbHSMCrv9jW4p3XXI+JoqECU4N39O7fBLPb8QcuO
         rtJbdTeEu49DYmRRX9Pp6Q0/kkZjh2qa3kaaxZ3FMJ5Ddxg1eF0jzv/99t023HnWMGHQ
         mRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQqXHmyUSlSMzrEScq/mc28bFFncHq5WVrswvpeHH5c=;
        b=awguTCTx4m1mk6Qz80H5v+BKVFSoUgfXR6LPObZgXnKBIPuBuCNn+B4+juzWX5w1Jj
         zV0JJ2s2IJf6P+mS2tvUbRAZFqG1PF5LdjnsPAwtw5E2ssmbPI+Yd2S2Df6erRvwDs+l
         Ns4D0lRVv+rD8b/BFTP4sKtasDIlMlckreFO9V5qmf/dzekRcUTCidaM/4Kt8Fj+bz2D
         C2ipctCUgBhqMQPC4SZ1ayypACapq7Ubr79WsrfgwZmIH2PFOJU/is/OodlVetT1F6BE
         cx3PzNILruPleCFAC98p9kPwWiW5iqGJKSwTXvj3oOLRGyeFxx8YfatZ0y/ptr02EGbw
         OlFw==
X-Gm-Message-State: AOAM531F3qulFUpXFSzdc+VDxYelWcA5yN/JfT351D5mjag0xvWyycJl
        TX1pr3eDdKbvpWKlqzHkfO5aTmhy7jIBQQ==
X-Google-Smtp-Source: ABdhPJynkTSq/4AdeYM1T/xp9OPOdZ+/e3MJPy/AjzsKPtpdjsgFusPDyaoa2eBXUB0sJQXz2faVew==
X-Received: by 2002:a05:651c:209:: with SMTP id y9mr13605918ljn.408.1590443295981;
        Mon, 25 May 2020 14:48:15 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a6sm2280044lji.29.2020.05.25.14.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:48:15 -0700 (PDT)
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
Subject: [PATCH v2 05/16] rcu/tree: Simplify KFREE_BULK_MAX_ENTR macro
Date:   Mon, 25 May 2020 23:47:49 +0200
Message-Id: <20200525214800.93072-6-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525214800.93072-1-urezki@gmail.com>
References: <20200525214800.93072-1-urezki@gmail.com>
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
index 776ccf858154..6501fbcae3c7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2824,13 +2824,6 @@ EXPORT_SYMBOL_GPL(call_rcu);
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
@@ -2839,10 +2832,18 @@ EXPORT_SYMBOL_GPL(call_rcu);
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

