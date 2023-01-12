Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E94C5479D
	for <rcu@archiver.kernel.org>; Thu, 12 Jan 2023 00:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbjALAwk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 Jan 2023 19:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbjALAwh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 Jan 2023 19:52:37 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796EA202F
        for <rcu@vger.kernel.org>; Wed, 11 Jan 2023 16:52:36 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id bp44so15436505qtb.0
        for <rcu@vger.kernel.org>; Wed, 11 Jan 2023 16:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2I5oixqy8XG8QqDsD5/7LMDpKsPL0rc5X+pW+Qf7+8=;
        b=q1DDpxic5REbf6LMrOSAX1yU3yqN66bHX+glJbgrl5t72Vyhcb9G9oZ5pevdW6yry6
         UAmgnfolaFiM2NkVZOZMAYAT4iUCBFHGg+euQNQPXu9uIdP8dtfsBCE7sauksSvo8R3p
         Xn/nSAGpI9CMssRbe5GZaqYuhaHzjLk7KEZg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2I5oixqy8XG8QqDsD5/7LMDpKsPL0rc5X+pW+Qf7+8=;
        b=shBzbgWjotXj+dQkHnRv+2tiHj/UGmQ4+6nE6QLmk1HQJMslMRAgtK6X3gsssh1CQ4
         yAtACpl9/GtR5vqGLE2UtU/7fYIY2vYaFMMJDDrWn2WOeTJlnqdW+mwHineUjP2mleQ8
         /lBMVivBCwWT/yIfO/x5r42+XoKeCh5YQANETA/MYUfm5W7VQx6WM/z46gIpD1c4rsrY
         YwCaciL5Y+7DZPEt2noT9iixOqW6NQWnf9lgcI3Kn6YWixJ17X9Gt3DmwgvQmSgPfuq4
         D3EBLUmwQKrTWb2TLkeqk5/G/ubPCVEm815DBM6H9l+66fcyopTgC2ueUJw4nO43cbzO
         bM8A==
X-Gm-Message-State: AFqh2krO8g3a5bUslLhrqyRnw4T/lvxWyej9liTbf6Vprw6+9h5zS4Cv
        vixkeCQf78UGQOkDqGYZJ2PUmQlvLu2Leg/q
X-Google-Smtp-Source: AMrXdXt3O42e8rpTmZw72BUQy3v4/sPg0KY+2T2Bz5Vxtgi01MUfm9iywFoeYlRJslhu4I9nFRd0bw==
X-Received: by 2002:a05:622a:4a1a:b0:3a5:f9cb:8869 with SMTP id fv26-20020a05622a4a1a00b003a5f9cb8869mr109878938qtb.12.1673484755586;
        Wed, 11 Jan 2023 16:52:35 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id z9-20020ac87ca9000000b003a7e2aea23esm8307523qtv.86.2023.01.11.16.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 16:52:33 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, fweisbec@gmail.com,
        urezki@gmail.com
Subject: [PATCH v2 rcu/dev 2/2] rcu: Disable laziness if lazy-tracking says so
Date:   Thu, 12 Jan 2023 00:52:23 +0000
Message-Id: <20230112005223.2329802-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230112005223.2329802-1-joel@joelfernandes.org>
References: <20230112005223.2329802-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

During suspend, we see failures to suspend 1 in 300-500 suspends.
Looking closer, it appears that asynchronous RCU callbacks are being
queued as lazy even though synchronous callbacks are expedited. These
delays appear to not be very welcome by the suspend/resume code as
evidenced by these occasional suspend failures.

This commit modifies call_rcu() to check if rcu_async_should_hurry(),
which will return true if we are in suspend or in-kernel boot.

Ignoring the lazy hint makes the 3000 suspend/resume cycles pass
reliably on a 12th gen 12-core Intel CPU, and there is some evidence
that it also slightly speeds up boot performance.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 78b2e999c904..c71e38d7815a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2594,12 +2594,12 @@ static void check_cb_ovld(struct rcu_data *rdp)
 }
 
 static void
-__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
+__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 {
 	static atomic_t doublefrees;
 	unsigned long flags;
 	struct rcu_data *rdp;
-	bool was_alldone;
+	bool was_alldone, lazy;
 
 	/* Misaligned rcu_head! */
 	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
@@ -2622,6 +2622,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
 	kasan_record_aux_stack_noalloc(head);
 	local_irq_save(flags);
 	rdp = this_cpu_ptr(&rcu_data);
+	lazy = lazy_in && !rcu_async_should_hurry();
 
 	/* Add the callback to our list. */
 	if (unlikely(!rcu_segcblist_is_enabled(&rdp->cblist))) {
-- 
2.39.0.314.g84b9a713c41-goog

