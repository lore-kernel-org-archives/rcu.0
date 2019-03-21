Return-Path: <SRS0=muXe=RY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE77C10F05
	for <rcu@archiver.kernel.org>; Thu, 21 Mar 2019 00:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC25720835
	for <rcu@archiver.kernel.org>; Thu, 21 Mar 2019 00:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IMN3oviF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfCUAez (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:34:55 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33800 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbfCUAez (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 Mar 2019 20:34:55 -0400
Received: by mail-qk1-f193.google.com with SMTP id n6so15331275qkf.1
        for <rcu@vger.kernel.org>; Wed, 20 Mar 2019 17:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IC0+CtzpXGHhz69/AjInC3kSHyrQxff0OCscI7M8m1k=;
        b=IMN3oviFXuoURkXevt9lKXvEeYfyhNQHi8wgNDFVtGKzqa5oayf5HKfpSpy8fvePCp
         zkkJfKAaIwPVxZWnksglQ9TK2M1aupaojK0EVDMcB/GbvNOvxQHv6qI1fBp96JRFIyQL
         IPSkPNdEZHfdqWmLrAResI2wRxRPGHwZa9sZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IC0+CtzpXGHhz69/AjInC3kSHyrQxff0OCscI7M8m1k=;
        b=Iaoxkl/gmnWoL3EoqFZwKP4yhDT41Nw+wLFbsHCd79WIPSVp/BlZuZWROkwGmSPuh0
         rc2F6/E8sBcPPS8iCom/KwhvgoD1EiuJYz700lPekgyEhZ0L7rphDTp+ZL1QxWqYv1fy
         EoA5nGEHe1mHKUh5iyq9gUXM4wSCeRLk5xzQMu3CsjTS1ne29sRPPsu+o8h2pOf97mss
         gt+binrHPwhXtf1Sxy3UuhG9sy0svR2N1nTP+jsCv2G4HuqoCvYuvAFnidJWs4lIq2Mn
         nXjhbB7Kr5O0QFiUvP9WWxt/eULbxY/b43PPo85F1EOaTCxh8ktu1//7ipUF/ltGNdjq
         NDcQ==
X-Gm-Message-State: APjAAAX4Fptwlqn8lz5bo4hq/rSm9920N8GUbPrByLwp4zyK5wK7Rymd
        BRgdGJjMtjsFEEi4WFwOrjRu3A==
X-Google-Smtp-Source: APXvYqzW1ItlokDxvifd5fwoA/cXTdAYbCDJNxmjIBAACop7r9u618kPeesEna9EnhvcgqKDOdYwxQ==
X-Received: by 2002:a37:784:: with SMTP id 126mr471424qkh.10.1553128494280;
        Wed, 20 Mar 2019 17:34:54 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id u15sm2908475qth.54.2019.03.20.17.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 17:34:53 -0700 (PDT)
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
Subject: [PATCH v2 3/4] rcuwait: Annotate task_struct with __rcu
Date:   Wed, 20 Mar 2019 20:34:25 -0400
Message-Id: <20190321003426.160260-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
In-Reply-To: <20190321003426.160260-1-joel@joelfernandes.org>
References: <20190321003426.160260-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This suppresses sparse error generated due to the recently added
rcu_assign_pointer sparse check.

percpu-rwsem.c:162:9: sparse: error: incompatible types in comparison expression
exit.c:316:16: sparse: error: incompatible types in comparison expression

[From an RCU perspective]
Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcuwait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 90bfa3279a01..563290fc194f 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -18,7 +18,7 @@
  * awoken.
  */
 struct rcuwait {
-	struct task_struct *task;
+	struct task_struct __rcu *task;
 };
 
 #define __RCUWAIT_INITIALIZER(name)		\
-- 
2.21.0.225.g810b269d1ac-goog

