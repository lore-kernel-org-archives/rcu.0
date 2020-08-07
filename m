Return-Path: <SRS0=1SSE=BR=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB19C433E1
	for <rcu@archiver.kernel.org>; Fri,  7 Aug 2020 17:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF4B221E5
	for <rcu@archiver.kernel.org>; Fri,  7 Aug 2020 17:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wXfzHbu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgHGRIS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgHGRHu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 7 Aug 2020 13:07:50 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6316AC061A86
        for <rcu@vger.kernel.org>; Fri,  7 Aug 2020 10:07:34 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c12so1785237qtn.9
        for <rcu@vger.kernel.org>; Fri, 07 Aug 2020 10:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r/kgVzAykl5yGnJA2GIl6acqSPrU9q7mp174snysesk=;
        b=wXfzHbu+Q0Ah3V/z4NLs6+FKnKMptcw04eJgCWIYFED1/z/Ph9Ow8uHQ4P0cBdv47P
         ZcU0rMPMlQkFOleTqPHawzaA1I7aH7QVeEs020BX+4THmB2Ehfg++kaXysKXhC/m1m+a
         +ags24NlB5PWImrQVaJpjxSpxujkCoOslN7aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/kgVzAykl5yGnJA2GIl6acqSPrU9q7mp174snysesk=;
        b=o7kgrWG/6179YzcbjwFfz8wgpPJOhe0NgotjRvbDvNKK2t+rc6UCDiJQmuq1riqIpX
         39SyCAte0rk7dDEQCvnuTG9lzg2LzepgecIe5QTk9tt2mOo3YmbLrTF8ksvWumY2yZDu
         QK1xikkWc3MWwyxCCSR2MqTMcmQMObEAtQGV2Oxf/uuDWMj7gULnRkyUXgs/O55GuJ4i
         fVD1a+t/8YWjjODJ/5ul7CPFMcJ5VMEI3wXkFN6mq/L+VMZKF8IPY7lxRbtBvTrv//XC
         /oSPaR/LKNFC1x6Hg5d/FXjDk/SaLUIPvzEJJa1YfPjTUGTMaoV9g+W/jFp0haIE3O5f
         o3pg==
X-Gm-Message-State: AOAM530AKHJ31TPGTaHvMiaiZZ3YS/osE9Xvyhvzc14T+PtjECKaF15N
        rrN5hILteL8ign+Uh/fi5knSXQ==
X-Google-Smtp-Source: ABdhPJyzKNEU/rzdXH8SQ/psjR5f8EygH9d2SBiUtl9q75xiwk3I/MC3+YKzg9vILQLmLP7VtGU2TQ==
X-Received: by 2002:ac8:4719:: with SMTP id f25mr15357892qtp.291.1596820053592;
        Fri, 07 Aug 2020 10:07:33 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id w18sm8559905qtk.1.2020.08.07.10.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 10:07:33 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        neeraju@codeaurora.org, "Paul E. McKenney" <paulmck@kernel.org>,
        peterz@infradead.org, Randy Dunlap <rdunlap@infradead.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, vineethrp@gmail.com
Subject: [PATCH v4 5/5] docs: Update RCU's hotplug requirements with a bit about design
Date:   Fri,  7 Aug 2020 13:07:22 -0400
Message-Id: <20200807170722.2897328-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
In-Reply-To: <20200807170722.2897328-1-joel@joelfernandes.org>
References: <20200807170722.2897328-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

RCU's hotplug design will help understand the requirements an RCU
implementation needs to fullfill, such as dead-lock avoidance.

The rcu_barrier() section of the "Hotplug CPU" section already talks
about deadlocks, however the description of what else can deadlock other
than rcu_barrier is rather incomplete.

This commit therefore continues the section by describing how RCU's
design handles CPU hotplug in a deadlock-free way.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../RCU/Design/Requirements/Requirements.rst  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 16c64a2eff93..0a4148b9f743 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1940,6 +1940,28 @@ deadlock. Furthermore, ``rcu_barrier()`` blocks CPU-hotplug operations
 during its execution, which results in another type of deadlock when
 invoked from a CPU-hotplug notifier.
 
+Also, RCU's implementation avoids serious deadlocks which could occur due to
+interaction between hotplug, timers and grace period processing. It does so by
+maintaining its own bookkeeping of every CPU's hotplug state, independent of
+the various CPU masks and by reporting quiescent states at explicit points.  It
+may come across as a surprise, but the force quiescent state loop (FQS) does
+not report quiescent states for offline CPUs and is not required to.
+
+For an offline CPU, the quiescent state will be reported in either of:
+1. During CPU offlining, using RCU's hotplug notifier (``rcu_report_dead()``).
+2. During grace period initialization (``rcu_gp_init``) if it detected a race
+   with CPU offlining, or a race with a task unblocking on a node which
+   previously had all of its CPUs offlined.
+
+The CPU onlining path (``rcu_cpu_starting``) does not need to a report
+quiescent state for an offline CPU in fact it would trigger a warning if a
+quiescent state was not already reported for that CPU.
+
+During the checking/modification of RCU's hotplug bookkeeping, the
+corresponding CPU's leaf node lock is held. This avoids race conditions between
+RCU's hotplug notifier hooks, grace period initialization code and the FQS loop
+which can concurrently refer to or modify the bookkeeping.
+
 Scheduler and RCU
 ~~~~~~~~~~~~~~~~~
 
-- 
2.28.0.236.gb10cc79966-goog

