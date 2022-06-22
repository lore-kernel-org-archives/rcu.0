Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24718C43334
	for <rcu@archiver.kernel.org>; Wed, 22 Jun 2022 22:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiFVWvp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 22 Jun 2022 18:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237106AbiFVWvm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 22 Jun 2022 18:51:42 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9FD40E72
        for <rcu@vger.kernel.org>; Wed, 22 Jun 2022 15:51:41 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id c1so27038065qvi.11
        for <rcu@vger.kernel.org>; Wed, 22 Jun 2022 15:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K8zLqAuQGGInMEO/tC5oFW9jqhiZEM0UzbeIkjAgT/E=;
        b=u6ATeb3gtaca1zArGlTV20bvGnJYCnyGi0lrVTh4JYP4rTbIjKfKdeM9RDdwdI9RAi
         ujrJtVDrjaCtmGg5lfrv26gOYUGzGdvprVDIpOwUgQm35vlAlgg6z/uQvruLfpgAqFnf
         LBh4FHH8YPXW9tWhspYhEKaA5r2GbBI4MSxtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K8zLqAuQGGInMEO/tC5oFW9jqhiZEM0UzbeIkjAgT/E=;
        b=ZKLZ3zlsw3JePG8KjL54IN2+mDNCFkV/BdCsEVjYQxlarExWLdxwEji6k329RdrO6/
         39ifMwCsmxoonqT5/qxdshl21x5JjKpSl+bFyHyKpJMI6C1+qdVSEuqsFNXo/uuCFed8
         qXXGqh/PpZ87TKgaZNAjOXkrHDAngAz7BujCy7r+LGkbnv6UGlZLwgpBks78JvA1z0ys
         QHBf7rT9CQxVeOhyY+ljmEYqRneFduRriFBTTocT5czKNMS+0M8omhDG4WRUdL5oYQV/
         Ywln4zUefwLC+iPzZBJKbb9VsH6AcuM5WKo/baYZSWpZXIXEqEeYV3WcMc0NNLoziNsK
         sg+A==
X-Gm-Message-State: AJIora81EDd01kRALJRkamaPi71bcY2qV49gcIDRvt67NLDQkBNoAqlr
        gxvLe0R2kbD2LtE3CA3CZ8WtGL1+Rs95yg==
X-Google-Smtp-Source: AGRyM1vNLmCVtta0shMDBQ0BoHzenJeOoo6ATvfQjsRBrP8Iu05+Inum8C5HKWzZ9QzXs2v3TExN7g==
X-Received: by 2002:a05:6214:2501:b0:470:3f6d:c075 with SMTP id gf1-20020a056214250100b004703f6dc075mr16486903qvb.95.1655938300584;
        Wed, 22 Jun 2022 15:51:40 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id k66-20020a37a145000000b006ab91fd03fasm1794022qke.19.2022.06.22.15.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:51:39 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        Marco Elver <elver@google.com>
Subject: [PATCH v2 1/1] context_tracking: Use arch_atomic_read() in __ct_state for KASAN
Date:   Wed, 22 Jun 2022 22:50:54 +0000
Message-Id: <20220622225102.2112026-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220622225102.2112026-1-joel@joelfernandes.org>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Context tracking's __ct_state() function can be invoked from noinstr state
where RCU is not watching.  This means that its use of atomic_read()
causes KASAN to invoke the non-noinstr __kasan_check_read() function
from the noinstr function __ct_state().  This is problematic because
someone tracing the __kasan_check_read() function could get a nasty
surprise because of RCU not watching.

This commit therefore replaces the __ct_state() function's use of
atomic_read() with arch_atomic_read(), which KASAN does not attempt to
add instrumention to.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Marco Elver <elver@google.com>
Reviewed-by: Marco Elver <elver@google.com>
---
 include/linux/context_tracking_state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 0aecc07fb4f5..81c51e5f0314 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -49,7 +49,7 @@ DECLARE_PER_CPU(struct context_tracking, context_tracking);
 
 static __always_inline int __ct_state(void)
 {
-	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
+	return arch_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
 }
 #endif
 
-- 
2.37.0.rc0.104.g0611611a94-goog

