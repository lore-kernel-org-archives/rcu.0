Return-Path: <SRS0=jKPx=DA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54057C4363D
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 15:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1927021D7D
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 15:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Mq8zKvJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgIWPWX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgIWPWV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Sep 2020 11:22:21 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73122C0613D4
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2020 08:22:21 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id p65so191263qtd.2
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2020 08:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8xq+fCDo/vu8CjnIMXFVGoGMGuT1VF/zHBuR0NfskQ=;
        b=Mq8zKvJjqHKv2wrRkPwZFKEIE7VWCHKj66KghdiL0FxqS99AkdtOedD0OsXw680dsc
         i7/KikWD/p8ktqbDnmJoxESjZuRf7Bjn6MG9AE2CAwfvVBLYU/FTn6JG3hpTZtGrjzmY
         w0qB3pUGLXpnQyr42RI78j6IzfHUYj4fTZC7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8xq+fCDo/vu8CjnIMXFVGoGMGuT1VF/zHBuR0NfskQ=;
        b=eBQ4XMOBioQhHC/1XK16rem4SkiWSuqQGTZTZZ+fvovYkPVryVMM1ViDqpVmcIcJJ9
         cRvUwdBRCQ7O7xOV2+ufEqgi6416wICVvLEf4FQoPvj+Kz/0276/6qD1YDWmsBYFSOvA
         YBOwi1LQn7C+y4gyjyZ2a5mQRyIH6Jml8rsVIiI+T01CunDve7E8x46QZ9Yo/gIq468g
         r5iv2tSuiiUVjSufVWdYZaJqDSxpnuBEp2ocKRHxzgOdcCSBVezzfkS5UjyUYWHmP4jJ
         e3I2wXoCImmPoWTdfcSH6aumKV+u2m87gOcIN4RCOUzCaoLtYHtwAOEZoekzYIaVp9Ez
         zWoQ==
X-Gm-Message-State: AOAM530FKKza4MsysNLTZGLMarNNpr+M9vCpvMtWraG8xxOxTt/FpkLq
        lVjSy5qC8RVFKlkNiJor0LL2xw==
X-Google-Smtp-Source: ABdhPJz0/nQpiHyn7rGKxteTNmCnymn00QqB+C+NlBaqtGqnC2ygp4UuKVH3leJnkajL/jc9NZkrdw==
X-Received: by 2002:aed:2986:: with SMTP id o6mr512699qtd.269.1600874540711;
        Wed, 23 Sep 2020 08:22:20 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g5sm37909qtx.43.2020.09.23.08.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:22:19 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH v6 4/4] rcu/segcblist: Remove useless rcupdate.h include
Date:   Wed, 23 Sep 2020 11:22:11 -0400
Message-Id: <20200923152211.2403352-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200923152211.2403352-1-joel@joelfernandes.org>
References: <20200923152211.2403352-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu_segcblist.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index df0f31e30947..b65ac8c85b56 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -10,7 +10,6 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
-#include <linux/rcupdate.h>
 
 #include "rcu_segcblist.h"
 #include "rcu.h"
-- 
2.28.0.681.g6f77f65b4e-goog

