Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98144C43331
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB52206DB
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="eAqEJ2hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgC3CeP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:34:15 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32971 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbgC3Cdl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:41 -0400
Received: by mail-qk1-f194.google.com with SMTP id v7so17571091qkc.0
        for <rcu@vger.kernel.org>; Sun, 29 Mar 2020 19:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VhRXFX915ZZjf6qHI5PrZD8T8+tPOI/Cg2isptxenk4=;
        b=eAqEJ2hyTMW80nl2AFCJp8deCuE81RBBTLR7Vl6BziuMKTXwko1qIyEOcelWccQQkl
         O5/4QbRDcxFSa30uXFamCDL0znuq14BuHKIBCF9g0pIf/GCsLfXA1UF2HikN7r+Yka5t
         f1hMLlRKNr/Ngcmd9WJd2kkyL8wzZaz0204+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VhRXFX915ZZjf6qHI5PrZD8T8+tPOI/Cg2isptxenk4=;
        b=E83+iELBHt+c8DteY1XQsEyBWnutZQJpZ9Nnc1+maQfVdKAcS/CLIT3d8MxVGq0bT9
         p7CmbmKA8DV7c244xS74RVCm/sMmZteaGHZpug3QXG8cROHoOpdYG6Z4MLdgmYgZsnef
         9G1pHPgSM/fdjn4skk2wqM3O/BKZ0jnRMcfP7vK7ZWfhFPPVrJ7d1HE7wyZR6e9GCenL
         dd2qM7Z9DSiAaxQub9u85jXkwge+tABmwmiBSjWHY8vc2UlhsnhsKzji9b4PL+qD7k9J
         FoWDUQgHOpeq/m1twU5em/+yoZH4VcjVmHBngCObRH+R+ksr2ePdwByzHdNfwqU7ADSb
         AQ7A==
X-Gm-Message-State: ANhLgQ1fA2Vmk4HJr/aK874Kkg1vVshEtsHqII29aCgtHQ5hKn0KeVaU
        SofeXkNatvAKFyRWsv+gBbqq/A==
X-Google-Smtp-Source: ADFU+vvqvHDIo+I+fVPksGXLy4Vwf61hpGLUBlvFZuL8EfaZx88zhM/5jOyQn340v+Wi0oZQiZ1hBw==
X-Received: by 2002:a37:87c7:: with SMTP id j190mr9957429qkd.66.1585535619052;
        Sun, 29 Mar 2020 19:33:39 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:38 -0700 (PDT)
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
Subject: [PATCH 08/18] rcu/tree: Clarify emergency path comment better
Date:   Sun, 29 Mar 2020 22:32:38 -0400
Message-Id: <20200330023248.164994-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200330023248.164994-1-joel@joelfernandes.org>
References: <20200330023248.164994-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Clarify emergency path comment better in kfree_rcu().

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 95d1f5e20d5ec..8dfa4b32e4d00 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2924,9 +2924,10 @@ static void kfree_rcu_work(struct work_struct *work)
 	}
 
 	/*
-	 * vmalloc() pointers end up here also emergency case. It can
-	 * happen under low memory condition when an allocation gets
-	 * failed, so the "bulk" path can not be temporary maintained.
+	 * We can end up here either with 1) vmalloc() pointers or 2) were low
+	 * on memory and could not allocate a bulk array. It can happen under
+	 * low memory condition when an allocation gets failed, so the "bulk"
+	 * path can not be temporarly used.
 	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
-- 
2.26.0.rc2.310.g2932bb562d-goog

