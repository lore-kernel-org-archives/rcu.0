Return-Path: <SRS0=muXe=RY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0900C43381
	for <rcu@archiver.kernel.org>; Thu, 21 Mar 2019 00:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED0120835
	for <rcu@archiver.kernel.org>; Thu, 21 Mar 2019 00:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="c8SEnqX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfCUAe5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:34:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37662 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbfCUAe4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 Mar 2019 20:34:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id z16so3413005qtn.4
        for <rcu@vger.kernel.org>; Wed, 20 Mar 2019 17:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3BCZ1lsacTsgFMuBPjIGWwMmDsstTbo8DviFJ0mb0ag=;
        b=c8SEnqX2KnNGVEDjz3mPiFXvsItfq9cY17AoP/PqrLOJoo+mXC/uhYUvFoBy7yilKw
         TK71+HYMsAiIkyIV73LQ73LS4IKvd1kRgfgdV0tzLw0EBuO3ZwXzDV0IwLHyc+5SrODd
         3zGUlL1yuhuOrnAn77h6Wc7VCU6UZr4SlQ+3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3BCZ1lsacTsgFMuBPjIGWwMmDsstTbo8DviFJ0mb0ag=;
        b=C8a9DeQuLOS/QakRo8n6ZOWlrT/EXw+nAOJXOLx3fJ5noJQhxWTEwMF1itY7sobwNK
         zdnIuYzDZEUKzjT2B3HYJ/2mJcePGWn918kDOgQfXhoSKQypDgrTuKKqBNXv1w1kFz5j
         X/1lYxblC3gqJk/mXhh5gNglFLuWxnL4Fro7RxIb0TY0ElM2Jxphp6pGP9PWc9ykK8an
         VwIRPgMHQHH9aY6+aaRyvr/if/bJqw6qSry6czKzwTAJcaJIOJI5JKrvCWheDwy/pYpk
         kq3I5gDwv/qaAT99bjvYHTh5AjLO8UykKaFwad4ma6747jFTVPELxuX97R9j07nzXMSw
         w1/A==
X-Gm-Message-State: APjAAAUD+oU6ZEKJZVpnzbuW6Ww215DhWZJ8+8YprfLpX8k82LHf/P57
        EoyGX/e/r/+TB1nrPntSgldH7A==
X-Google-Smtp-Source: APXvYqyKz8eiuiukjGWMlz2K1RtXcTv8xyeBJgywnaCkw86IBcuZ7HUWbRdeFpvB2XfJCP47FOijMw==
X-Received: by 2002:a0c:b05c:: with SMTP id l28mr757047qvc.95.1553128495754;
        Wed, 20 Mar 2019 17:34:55 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id u15sm2908475qth.54.2019.03.20.17.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 17:34:54 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 4/4] sched: Annotate perf_domain pointer with __rcu
Date:   Wed, 20 Mar 2019 20:34:26 -0400
Message-Id: <20190321003426.160260-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
In-Reply-To: <20190321003426.160260-1-joel@joelfernandes.org>
References: <20190321003426.160260-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This fixes the following sparse errors in sched/fair.c:

fair.c:6506:14: error: incompatible types in comparison expression
fair.c:8642:21: error: incompatible types in comparison expression

Using __rcu will also help sparse catch any future bugs.

[From an RCU perspective]
Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2b452d68ab2e..b52ed1ada0be 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -780,7 +780,7 @@ struct root_domain {
 	 * NULL-terminated list of performance domains intersecting with the
 	 * CPUs of the rd. Protected by RCU.
 	 */
-	struct perf_domain	*pd;
+	struct perf_domain __rcu *pd;
 };
 
 extern struct root_domain def_root_domain;
-- 
2.21.0.225.g810b269d1ac-goog

