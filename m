Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A174BC001E0
	for <rcu@archiver.kernel.org>; Sat, 29 Jul 2023 14:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjG2O17 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 29 Jul 2023 10:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjG2O16 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 29 Jul 2023 10:27:58 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DF8E7A
        for <rcu@vger.kernel.org>; Sat, 29 Jul 2023 07:27:57 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-348de515667so13590075ab.1
        for <rcu@vger.kernel.org>; Sat, 29 Jul 2023 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690640877; x=1691245677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/AP9GOcXVQHz8AOI7UjuaU+sYzEqAzG6F3W2fxwbBg=;
        b=J4kyjvgZ82W4wgXCeEeMZsVCguRFpikKkcE2HcgJj1qeY7vt+QnMIYGWOOT+WB4w/d
         QxBIq/qctXIL+Pq+QR5781uOJJWRU23mvLFOkz/5oH2U307qLuDCMVxppr9LWan2wYgB
         x4GjVCbkk7A28bEYLtEBKdloUvZLupH9Z4E6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690640877; x=1691245677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/AP9GOcXVQHz8AOI7UjuaU+sYzEqAzG6F3W2fxwbBg=;
        b=A8r9GcJeh0g3EkrZrOHVxtHUdcO60GNG6suqlheDGMhc4aDroEac9ya2KjS0xtyLsr
         geGviMn+xVj2YtH72Pos470tnz/Mly6EZ3oPsTFaAt0lMaWQR7H3rTiqTjLsq/cw9kv8
         v2m0d8bXB0kZDHpW83iIYnVbIie0k7i6vQj15g+tvtj4wBjtQqbwZ5biwJl0xdhXHbwi
         fmsfNY62XAygNg0H6CjHXaPbcJ+yDQIHYr2gouwaMdboodosg2Cq1j9+g95rCWIqQA+b
         6nrU+ZnVFxUn06JhOIMZKGqLLT1JCAZl6BW9U8k8/lqsqhs0FQDZfEUVQnAXthLiynDj
         vLEw==
X-Gm-Message-State: ABy/qLYfE4IaDP9W5GhGHvQBreeZeCkhpo+E1cJbosgwc5npiG9cbrRn
        mxBQ6aqV2jLyCyN+h5AVJiGf/Q==
X-Google-Smtp-Source: APBJJlE8nBeVkXcUMALJORNmqTh8c7r1ht4vw0YPrIrwKi+ZvPe7AoO4UA+ZLaLbe2+FsI5VCRzahg==
X-Received: by 2002:a92:c7c1:0:b0:345:ad81:ecaf with SMTP id g1-20020a92c7c1000000b00345ad81ecafmr2084447ilk.3.1690640876885;
        Sat, 29 Jul 2023 07:27:56 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id q9-20020a0566380ec900b0042b35c7b8c5sm1855362jas.61.2023.07.29.07.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 07:27:56 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     rcu@vger.kernel.org, paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2 2/5] srcu: Fix error handling in init_srcu_struct_fields()
Date:   Sat, 29 Jul 2023 14:27:32 +0000
Message-ID: <20230729142738.222208-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230729142738.222208-1-joel@joelfernandes.org>
References: <20230729142738.222208-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The current error handling in init_srcu_struct_fields() is a bit
inconsistent.  If init_srcu_struct_nodes() fails, the function either
returns -ENOMEM or 0 depending on whether ssp->sda_is_static is true or
false. This can make init_srcu_struct_fields() return 0 even if memory
allocation failed!

Simplify the error handling by always returning -ENOMEM if either
init_srcu_struct_nodes() or the per-CPU allocation fails. This makes the
control flow easier to follow and avoids the inconsistent return values.

Add goto labels to avoid duplicating the error cleanup code.

Link: https://lore.kernel.org/r/20230404003508.GA254019@google.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/srcutree.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 20d7a238d675..f1a905200fc2 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -255,29 +255,31 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->srcu_sup->sda_is_static = is_static;
 	if (!is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
-	if (!ssp->sda) {
-		if (!is_static)
-			kfree(ssp->srcu_sup);
-		return -ENOMEM;
-	}
+	if (!ssp->sda)
+		goto err_free_sup;
 	init_srcu_struct_data(ssp);
 	ssp->srcu_sup->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
-		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC)) {
-			if (!ssp->srcu_sup->sda_is_static) {
-				free_percpu(ssp->sda);
-				ssp->sda = NULL;
-				kfree(ssp->srcu_sup);
-				return -ENOMEM;
-			}
-		} else {
-			WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
-		}
+		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
+			goto err_free_sda;
+		WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
 	}
 	ssp->srcu_sup->srcu_ssp = ssp;
 	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed, 0); /* Init done. */
 	return 0;
+
+err_free_sda:
+	if (!is_static) {
+		free_percpu(ssp->sda);
+		ssp->sda = NULL;
+	}
+err_free_sup:
+	if (!is_static) {
+		kfree(ssp->srcu_sup);
+		ssp->srcu_sup = NULL;
+	}
+	return -ENOMEM;
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-- 
2.41.0.487.g6d72f3e995-goog

