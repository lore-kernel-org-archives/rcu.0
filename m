Return-Path: <SRS0=+8aq=5I=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428E9C4332B
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 11:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161602072D
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 11:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k819nhoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgCWLgd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:36:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45604 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgCWLgd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 23 Mar 2020 07:36:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id v4so6240124lfo.12;
        Mon, 23 Mar 2020 04:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hvv/BXuLWpNLLdFDZgSPAuIrVWrqIrNN7T6QpB5RAFg=;
        b=k819nhoBDc5EyyUjuH/4btny90/o6wFeimVwb5KP7g8Y16lFcL5r0JB+nV9lT525wE
         QLrDKBTCMfMf+hPhj+w+i/7GpTU7ydmBNfIbPKj5B8RCXOE+IEKq/xvl4+IY163AgZSj
         amt+kBqX72nyFwveKuIHXVKszRyG61y/idcptcCw1bunBP+imMtJPkRy0AXZjV2aXq1u
         5LNvsR0e6LhxIIDjQrriQtsyzmZnTlNEmh5bkeh2syC33yQb7m+3vPV2GbaGU9hRBScF
         V8M4I9GTkNqxDr0+Uh2Hn6p7LENmbawjjt8jvc9u+/s4luEMelPsKzO4RzFtJ1n2RrBS
         8Hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvv/BXuLWpNLLdFDZgSPAuIrVWrqIrNN7T6QpB5RAFg=;
        b=qTUmwZIZtivvOgnwB+PGyFeMfl62uMdWldz8SRWeU4/lapiSil9tihmvFy0nQSbXmB
         pUEW4uFzGFvyfWyXhsHCFhpy7G7YMR4QQSw5lvA0GhaQQvBZFsThXLv2jxibul75ilcD
         jeLtUPgOkeMQC56R9U5jrjJyx41uIx+Y7KWSGwUQ9jRnhwvWghmr+6IKqPVU0U+Gufw5
         X4ffyA6zP6w8+X2PZyYBl+yIv/osY57dwyPyuD+6Kr2G2EU2RV3yKMQP7mdGBPWex2u0
         ISn7NikQrEn4Q/u5ZBbB+EFSc9O9YRAUSGnhRVh7fh7HePWX1Qr6bZvPOU6NqG5wIODF
         sXlQ==
X-Gm-Message-State: ANhLgQ0p65HSWSwtry8x7lhzhnhqpVHf10UCRTrwDZm+KPFn5X8I0HUx
        OE9iJm8h5cMv2JTmJe1R363ig0zITfM=
X-Google-Smtp-Source: ADFU+vsXUNwIpWKAQp1aIDXwj6QSNoKhtla7QlbDXZnzdYEI1Ma8Ix5BrXGy/Ly3aisIoC1w2Bs9Vg==
X-Received: by 2002:a05:6512:31d6:: with SMTP id j22mr12838040lfe.173.1584963390994;
        Mon, 23 Mar 2020 04:36:30 -0700 (PDT)
Received: from localhost.localdomain (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id r23sm8079268lfi.89.2020.03.23.04.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 04:36:30 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 1/7] rcu/tree: simplify KFREE_BULK_MAX_ENTR macro
Date:   Mon, 23 Mar 2020 12:36:15 +0100
Message-Id: <20200323113621.12048-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323113621.12048-1-urezki@gmail.com>
References: <20200323113621.12048-1-urezki@gmail.com>
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
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e7963270e7f6..49ba1ff50af5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2740,13 +2740,6 @@ EXPORT_SYMBOL_GPL(call_rcu);
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
@@ -2760,6 +2753,14 @@ struct kfree_rcu_bulk_data {
 	struct kfree_rcu_bulk_data *next;
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

