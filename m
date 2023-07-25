Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95662C001E0
	for <rcu@archiver.kernel.org>; Tue, 25 Jul 2023 23:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjGYX3c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jul 2023 19:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjGYX3b (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Jul 2023 19:29:31 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85391BE8
        for <rcu@vger.kernel.org>; Tue, 25 Jul 2023 16:29:29 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-783549ef058so316767539f.2
        for <rcu@vger.kernel.org>; Tue, 25 Jul 2023 16:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690327769; x=1690932569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1/tyaZq/EJBhi/7l+hIL3z3pGtmH2Zjtk0EiAh2ooA=;
        b=W4LU5bSa/QHlkTdxIb4sY4pM7LWuU9noqwcduFR+0CmKenXKzGAI5fNoSvgjHOSlUm
         IwiPuf4Gm81MY4HrBIdQsBc4MnQ8nMUuNbJ7L7Lgmjqm9m9qXFc6vriyFqRhMkbcPGUE
         QC142xSTHhGMr/9RiF3+UQBA1dMQ1hLm+EzgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690327769; x=1690932569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1/tyaZq/EJBhi/7l+hIL3z3pGtmH2Zjtk0EiAh2ooA=;
        b=dA/pH4/q1taswvfRQZ8Swg8Ira/2sHrcv/tU0zCFf1n513QO8HkoInvgRnYxPJKh4a
         +tq/jiRhO24JPLFfuny7TyJlCFLHRyyXml3iNltvBYAET3DgQgtLb9e/pXAEzpI2ec9J
         qJ41IIya5dyVF3fEeEEj+CXFxa34x0o6YO+rmY/QnE+egDJNA8GuxAMgwyLdztYdrlA2
         940mXNuz+vfnGrMGTp976kujIFXH8B127d1Ayy0ghhwLOZBycFmkTeSRBs/E9dC8L59l
         HXnz4jfFuUEFJR8IjAhcZf5N3E6vj6wgY36JGtd7Q3v9tc4+OdbIZhyPJgsOqm6FPzDO
         3ydw==
X-Gm-Message-State: ABy/qLYGkDDztYPX/PF6zeizbfgSNb2bk47zmkzE+Jb+WKeVBwyHOwOj
        Axy9PU/Y3tTypnNpeALv182TZIGEpzZhJHfMrr0=
X-Google-Smtp-Source: APBJJlFTSX89ddGUxW0LY7A4uygDts9vWsSV2ZCphFzDYxJVS7ZYCAeaT9OC8EaxmdhM7TusKTii5Q==
X-Received: by 2002:a6b:5c10:0:b0:783:72d4:8c38 with SMTP id z16-20020a6b5c10000000b0078372d48c38mr341104ioh.13.1690327769166;
        Tue, 25 Jul 2023 16:29:29 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id m18-20020a02c892000000b0041d859c5721sm3932053jao.64.2023.07.25.16.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 16:29:28 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org (open list:SLEEPABLE READ-COPY UPDATE (SRCU))
Cc:     rcu@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 2/5] srcu: Fix error handling in init_srcu_struct_fields()
Date:   Tue, 25 Jul 2023 23:29:07 +0000
Message-ID: <20230725232913.2981357-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230725232913.2981357-1-joel@joelfernandes.org>
References: <20230725232913.2981357-1-joel@joelfernandes.org>
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
 kernel/rcu/srcutree.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 20d7a238d675..cbc37cbc1805 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -255,29 +255,32 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
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
+		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
+			goto err_free_sda;
+		else
 			WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
-		}
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

