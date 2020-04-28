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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9E6C8300B
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4582E2072A
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kP02x+M/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgD1U7s (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726884AbgD1U7s (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81899C03C1AC;
        Tue, 28 Apr 2020 13:59:46 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g4so257695ljl.2;
        Tue, 28 Apr 2020 13:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3fJ5TMdCQebVw9K/lB+iz58HUNfGtYvyfl9ym54rQlM=;
        b=kP02x+M/0VMqRYPckvkQ5KHhPgnUW+5je7IT6oUunk7FfGrXaOci+I2mXWMDeyhOV+
         KCxCW5+E3z8CDdniIsgjw+Ujmj6woV9U2vpX7RROlqU9D0LbWlJfs+R59GhHyvBsxF+I
         L47755O8cNu7u2Z/RS+DscHR3jg7t2kEgk2+xKx+IeZvovvdyET6gUnF4P4jSVhGfSNE
         v+b+D8rAkEN2F79mxfA/MHMqmjojM/AFxTmpVrpecE23T7JYANaUUoy818jZ50BZmWok
         ge+DSSWtnaH79mXjgMAsH8fLpNXfKya00SxR3Ef21hbEWNN5D2wi/rAOzhUnL8HEykqb
         fE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3fJ5TMdCQebVw9K/lB+iz58HUNfGtYvyfl9ym54rQlM=;
        b=fAo1NBk5TaNYBUgYAb6u/U6rqmcW7fVk5hFMzv50n9Ey+dvVtLMDfvxzm69zPxJKPz
         IZq/THb+eiJ+wsiVJQZhqyFU1bPRFbB4eYPqngRC2h4IVXnrelAoVuvK5yJgHTb6A7j8
         Ouf/C+5nYWs2ECKvhMYZ3+sJ/whsMiSKEyI7Zb2u3r998BPt/jF0q4UWhKpoMd+DQjzr
         gmZXUu4mfWmIGl0Mmu5xz+LOnla9xYssDw4usVP/5Vds1tbqwk+PoMRom9uqSvED84nD
         82uhY8AzY4d6t1DMLhvIWCmHYwmEZxIZPfITZ1uFMbbPHJ+H79SzMV6wPFZiObnqdam0
         vmCA==
X-Gm-Message-State: AGi0PuY1+1fvC/d5ht75oGic/F7z5BabNvLr/Al51FxHsxrB2uOQC3A1
        pSDGIEiTsq8BUy08wgtsg7XuNQ2VzOkL4g==
X-Google-Smtp-Source: APiQypLFK7pLf6v4TBbEd8q0pQMGD3hqv0CAeV1BrlcjzHb6iUbngmOpghi/7W8+zKnNzxEpk2jThw==
X-Received: by 2002:a05:651c:2002:: with SMTP id s2mr17409411ljo.285.1588107584561;
        Tue, 28 Apr 2020 13:59:44 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:43 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 13/24] rcu: Rename rcu_invoke_kfree_callback/rcu_kfree_callback
Date:   Tue, 28 Apr 2020 22:58:52 +0200
Message-Id: <20200428205903.61704-14-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Rename rcu_invoke_kfree_callback to rcu_invoke_kvfree_callback.
Do the same with second trace event, the rcu_kfree_callback,
becomes rcu_kvfree_callback. The reason is to be aligned with
kvfree notation.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 8 ++++----
 kernel/rcu/tiny.c          | 2 +-
 kernel/rcu/tree.c          | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index f9a7811148e2..0ee93d0b1daa 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -506,13 +506,13 @@ TRACE_EVENT_RCU(rcu_callback,
 
 /*
  * Tracepoint for the registration of a single RCU callback of the special
- * kfree() form.  The first argument is the RCU type, the second argument
+ * kvfree() form.  The first argument is the RCU type, the second argument
  * is a pointer to the RCU callback, the third argument is the offset
  * of the callback within the enclosing RCU-protected data structure,
  * the fourth argument is the number of lazy callbacks queued, and the
  * fifth argument is the total number of callbacks queued.
  */
-TRACE_EVENT_RCU(rcu_kfree_callback,
+TRACE_EVENT_RCU(rcu_kvfree_callback,
 
 	TP_PROTO(const char *rcuname, struct rcu_head *rhp, unsigned long offset,
 		 long qlen),
@@ -596,12 +596,12 @@ TRACE_EVENT_RCU(rcu_invoke_callback,
 
 /*
  * Tracepoint for the invocation of a single RCU callback of the special
- * kfree() form.  The first argument is the RCU flavor, the second
+ * kvfree() form.  The first argument is the RCU flavor, the second
  * argument is a pointer to the RCU callback, and the third argument
  * is the offset of the callback within the enclosing RCU-protected
  * data structure.
  */
-TRACE_EVENT_RCU(rcu_invoke_kfree_callback,
+TRACE_EVENT_RCU(rcu_invoke_kvfree_callback,
 
 	TP_PROTO(const char *rcuname, struct rcu_head *rhp, unsigned long offset),
 
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 4b99f7b88bee..3dd8e6e207b0 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -86,7 +86,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 
 	rcu_lock_acquire(&rcu_callback_map);
 	if (__is_kfree_rcu_offset(offset)) {
-		trace_rcu_invoke_kfree_callback("", head, offset);
+		trace_rcu_invoke_kvfree_callback("", head, offset);
 		kvfree((void *)head - offset);
 		rcu_lock_release(&rcu_callback_map);
 		return true;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7983926af95b..821de8149928 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2794,7 +2794,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
 	if (__is_kfree_rcu_offset((unsigned long)func))
-		trace_rcu_kfree_callback(rcu_state.name, head,
+		trace_rcu_kvfree_callback(rcu_state.name, head,
 					 (unsigned long)func,
 					 rcu_segcblist_n_cbs(&rdp->cblist));
 	else
@@ -3048,7 +3048,7 @@ static void kfree_rcu_work(struct work_struct *work)
 
 		rcu_lock_acquire(&rcu_callback_map);
 		for (i = 0; i < bvhead->nr_records; i++) {
-			trace_rcu_invoke_kfree_callback(rcu_state.name,
+			trace_rcu_invoke_kvfree_callback(rcu_state.name,
 				(struct rcu_head *) bvhead->records[i], 0);
 			vfree(bvhead->records[i]);
 		}
@@ -3077,7 +3077,7 @@ static void kfree_rcu_work(struct work_struct *work)
 		next = head->next;
 		debug_rcu_head_unqueue((struct rcu_head *)ptr);
 		rcu_lock_acquire(&rcu_callback_map);
-		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
+		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
 
 		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
 			kvfree(ptr);
-- 
2.20.1

