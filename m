Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F5BC2D0F0
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08F620735
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IoSt4QrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgC3Cdt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:33:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39251 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgC3Cds (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id f20so13936585qtq.6
        for <rcu@vger.kernel.org>; Sun, 29 Mar 2020 19:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bOOZauNhsuF3feRi6dtskt8y9Qi7+H8gEQhQhgkWxqI=;
        b=IoSt4QrCLedpBvOuvuIWu3Cl4FfWPyXvbqqnuq/GaQ1HcU9khIkVEaqme/mPZxUhwv
         kD/yTyqYJNzHz7rPyQEXhmXtMbm69VHMETJQyAIAvXcj8l0UuBlX+/nqST46f4yYXTrf
         k0xWlyQk9oM+n+F+7at54OwU18Uv8Wr8uj0Vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bOOZauNhsuF3feRi6dtskt8y9Qi7+H8gEQhQhgkWxqI=;
        b=sdPDt1CqQeYH1ySJEDnIHLfumzSNGvrr0GYU/Ex0ZBzoL4Re9yc1cjs4N+IwF8Pd8c
         xoe8tS7hIRD6VzM4docpEN6MkJ1UB06Gv8zdUFhLiF7jPWjJD9D62EqrILJFJ/qb2EbW
         RI+jtL0iScEkUUOvjrFnEPxPtDryDHjURYLZA1UiHpF9G6wQ1HDwHZv6t0BhKXLtEwh4
         kprFC7Irtw+GXO6TzOnnQRF+O2ZVhie6JcFAXGCaEG6JimXEwe3kv3g06vbakbosc1Km
         l3nL8Yx9vYnWwNQMugEhKEH8ZRfJ/aqWXoUu44W1PtO9DZNcOC45bRQVUnYH9j3DPXeZ
         4G8g==
X-Gm-Message-State: ANhLgQ1LyuH0WY5XV0lbmZKWAuN4/6hPiiQI7FfK2SIGpKOfywGAapNY
        bTdMTSMzXM5Mul7qH+ubeOqoPw==
X-Google-Smtp-Source: ADFU+vvpUM4thXk+u3mpgUqeS17+XJRaBpxyDXS4TQ5h4ZRtyfMYG8HpGORF6osOZmFTIBNIXOApRA==
X-Received: by 2002:ac8:2c73:: with SMTP id e48mr9339461qta.96.1585535627462;
        Sun, 29 Mar 2020 19:33:47 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:47 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH 16/18] rcu/tree: Remove extra next variable in kfree worker function
Date:   Sun, 29 Mar 2020 22:32:46 -0400
Message-Id: <20200330023248.164994-17-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200330023248.164994-1-joel@joelfernandes.org>
References: <20200330023248.164994-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

No change in code, small refactor.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 204292378101b..56c9e102a901d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2889,8 +2889,7 @@ debug_rcu_bhead_unqueue(struct kvfree_rcu_bulk_data *bhead)
 static void kfree_rcu_work(struct work_struct *work)
 {
 	unsigned long flags;
-	struct kvfree_rcu_bulk_data *bkhead, *bknext;
-	struct kvfree_rcu_bulk_data *bvhead, *bvnext;
+	struct kvfree_rcu_bulk_data *bkhead, *bvhead, *bnext;
 	struct rcu_head *head, *next;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
@@ -2915,8 +2914,8 @@ static void kfree_rcu_work(struct work_struct *work)
 	spin_unlock_irqrestore(&krcp->lock, flags);
 
 	/* kmalloc()/kfree() channel. */
-	for (; bkhead; bkhead = bknext) {
-		bknext = bkhead->next;
+	for (; bkhead; bkhead = bnext) {
+		bnext = bkhead->next;
 
 		debug_rcu_bhead_unqueue(bkhead);
 
@@ -2934,8 +2933,8 @@ static void kfree_rcu_work(struct work_struct *work)
 	}
 
 	/* vmalloc()/vfree() channel. */
-	for (; bvhead; bvhead = bvnext) {
-		bvnext = bvhead->next;
+	for (; bvhead; bvhead = bnext) {
+		bnext = bvhead->next;
 
 		debug_rcu_bhead_unqueue(bvhead);
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

