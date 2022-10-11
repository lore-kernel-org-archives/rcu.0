Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922EEC4332F
	for <rcu@archiver.kernel.org>; Tue, 11 Oct 2022 18:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJKSC0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Oct 2022 14:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiJKSCV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:21 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5516C113
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:14 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id m6so3905650qkm.4
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WO1zLatTGk7w49T3dw38/yevK8lFIMN7WGO9rdhO2q0=;
        b=hJudK9mmd0OcgTLgDLgV1SgQdwzWbP+YDsFTSLx5pTw6kLDd9wvZUakI1Y0RBR9N4F
         MiCZ9FURS1a2ZlqaLiJrZAVZui1do8JjJFFDrGJZVUyP9dLAXPaLHVN4wSeUhFGYY3O7
         Foo5ge8rRQxBknxNlFPED8LHL+QAt890PhS/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WO1zLatTGk7w49T3dw38/yevK8lFIMN7WGO9rdhO2q0=;
        b=UVDF6dzSTerayfccQpgqoPzUFNxhUYuoHbrBYFU8tc9FXiA6WRW0RaamwEsUDaUBp5
         hQVQdHkl7YeXwnIRBBOlwvDiBIxaQK1ErbD0VO+D4bXM3xGR1MerWiOc25ZdOGgrOaUV
         aPuTSIgCjdZDiZhhfnLJWnrh7hwBO6B3H2a1v8qziemK+JX5yQCocUut2iakjibDD67+
         fGxNlD0KP9r09vsGQi3wmxgjydhvHVxgig0R4GocMk2GIKR6gsl7dnaf52LLvK90Rqwq
         S0eU9BoR+ziKU6iQTSOYCH+TG8UX4EilH5iTXQJozKieBaC/XeizGIInhP4nwg85jkb8
         j1ag==
X-Gm-Message-State: ACrzQf1rhGsSA1nJ0E40n6NXsfWEepYtVs1IDy8+p/jUbyX2GxFPWxaI
        y/FeMYmC9Tuy80+A/pMGLWYkD2pzaDjvIg==
X-Google-Smtp-Source: AMsMyM7324BoWYVxRirwNMwpbVd3WMPZue9BstlCjUpvA89OlscCV7sGeoW1dTP5ocXp5XnFyijwVA==
X-Received: by 2002:a05:620a:28c1:b0:6ce:b23c:dcac with SMTP id l1-20020a05620a28c100b006ceb23cdcacmr17417950qkp.123.1665511333536;
        Tue, 11 Oct 2022 11:02:13 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:13 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v8 06/13] percpu-refcount: Use call_rcu_flush() for atomic switch
Date:   Tue, 11 Oct 2022 18:01:35 +0000
Message-Id: <20221011180142.2742289-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

call_rcu() changes to save power will slow down the percpu refcounter's
"per-CPU to atomic switch" path. The primitive uses RCU when switching to
atomic mode. The enqueued async callback wakes up waiters waiting in the
percpu_ref_switch_waitq. Due to this, per-CPU refcount users will slow down,
such as blk_pre_runtime_suspend().

Use the call_rcu_flush() API instead which reverts to the old behavior.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 lib/percpu-refcount.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index e5c5315da274..65c58a029297 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -230,7 +230,8 @@ static void __percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 		percpu_ref_noop_confirm_switch;
 
 	percpu_ref_get(ref);	/* put after confirmation */
-	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
+	call_rcu_flush(&ref->data->rcu,
+		       percpu_ref_switch_to_atomic_rcu);
 }
 
 static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
-- 
2.38.0.rc1.362.ged0d419d3c-goog

