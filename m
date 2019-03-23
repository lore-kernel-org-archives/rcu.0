Return-Path: <SRS0=292f=R2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1946DC43381
	for <rcu@archiver.kernel.org>; Sat, 23 Mar 2019 01:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA26B218E2
	for <rcu@archiver.kernel.org>; Sat, 23 Mar 2019 01:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="g7dDrUEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfCWB3u (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:29:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42019 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfCWB3u (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 22 Mar 2019 21:29:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id r15so2633418pfn.9
        for <rcu@vger.kernel.org>; Fri, 22 Mar 2019 18:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mcfGpLZ/prG7lz5ZeezGWFN0M8VgvLKSLKqebLRCioU=;
        b=g7dDrUEG6uBqA15uf7UaWGgqIvG7n4jiUvT0XGLzafLVJiJfhb5Az0KsOl8SUFuglp
         AQq7aplnmpJ4ONpETK8x/9ziCdNOsNwZv77791lDtCFyKmWmZwUC3fDgD9N2oybJ4JcS
         27SbRBxtYtkp1AxrKJYrP1G5P09JOy93GSlVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mcfGpLZ/prG7lz5ZeezGWFN0M8VgvLKSLKqebLRCioU=;
        b=R+73E6AFyJ0hNmvNTPxxMMf+mVbBYT4nwNajCkwMs0XHoCV5qiQYZbpdL2qNsn+Zgr
         8f2u8wus0shnD7+VXglEYsRfEZ1LpcZmK8E95mEEInVNhvES9KrjloD19PpRNyVbUt41
         AOewmLADPt+io6KAS8cFZY4PkPPB6JFiLNkB6Tj3hscreXA9LQeZpUeaJSI9wuxAdGOH
         yfpQzPPrwKlvnHnL+nl4Qqf7paEZ9gQNg8aRym1m4rDI0F80YNOqVulufSsELSd0Zk7D
         aRic/fsGEldMizozvgzkIK4hXaCWyZ4mnAvT6WYmcmr4ed+ElZOtdQ2FSLe5A3PEbS/J
         2njA==
X-Gm-Message-State: APjAAAXlvNdD8RZAQ1h2XsYV92EeMv5OHOpzUc+8X8VQeDjToz9139Tq
        R+xk5tjHvsGd9p7mUgQgfnCV/w==
X-Google-Smtp-Source: APXvYqww3QzxrykSHkJMvwPjk2ru3LkkhaXavG9KwNy2MyzOfDXUVrlcWMWacgqstbxHgPRjQh/8rw==
X-Received: by 2002:a17:902:8c8a:: with SMTP id t10mr12878572plo.160.1553304589254;
        Fri, 22 Mar 2019 18:29:49 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l7sm26672525pfj.162.2019.03.22.18.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 18:29:48 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>, kernel-team@android.com,
        rcu@vger.kernel.org, byungchul.park@lge.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [RFC 1/2] lockdep: Add assertion to check if in an interrupt
Date:   Fri, 22 Mar 2019 21:29:38 -0400
Message-Id: <20190323012939.15185-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In rcu_rrupt_from_idle, we want to check if it is called from within an
interrupt, but want to do such checking only for debug builds. lockdep
already tracks when we enter an interrupt. Let us expose it as an
assertion macro so it can be used to assert this.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel-team@android.com
Cc: rcu@vger.kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/lockdep.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index c5335df2372f..d24f564823d3 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -601,11 +601,18 @@ do {									\
 			  "IRQs not disabled as expected\n");		\
 	} while (0)
 
+#define lockdep_assert_in_irq() do {					\
+		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
+			  !current->hardirq_context,			\
+			  "Not in hardirq as expected\n");		\
+	} while (0)
+
 #else
 # define might_lock(lock) do { } while (0)
 # define might_lock_read(lock) do { } while (0)
 # define lockdep_assert_irqs_enabled() do { } while (0)
 # define lockdep_assert_irqs_disabled() do { } while (0)
+# define lockdep_assert_in_irq() do { } while (0)
 #endif
 
 #ifdef CONFIG_LOCKDEP
-- 
2.21.0.392.gf8f6787159e-goog

