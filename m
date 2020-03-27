Return-Path: <SRS0=KYXL=5M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FF8C2D0E5
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 21:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E09206F2
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 21:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu7jsjpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgC0VYX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:24:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40129 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgC0VYX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 Mar 2020 17:24:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id a81so14030745wmf.5;
        Fri, 27 Mar 2020 14:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4xPO8eVqTt9l/uaZnaIr8tbja2hwuVvwRYCjBY7pIEI=;
        b=Cu7jsjptYx1vrlkZ+q0qkFuoBaDuIBDgeHxvr8Nuk3xWzkEMNQDP0aqJwfu2STJcPW
         SsYW9f61kOijmKWztqze+OrlpUgHu31J6pbz3MnftiRRm/z1px3yk2OWGGZs7aIWw/LY
         sKHdff/FGRgPC2ugoDX+FNfuu8zJnPZOk0NJ5tuFmOVEkhQHMZcoakMXjWuT+vjpMArH
         oVtDq06E6ljA/iBklFxhw1R54woFRTondSOpKMmlYjQ61Nwo4+mC0jmqw6ncFOvG8ru2
         jQGQtx7BoCiqK6WNoQ+lUcspy7IJP4EyTerilz3j1OA1umSgXjY1WWp0KfeCHjJiA+ps
         EXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4xPO8eVqTt9l/uaZnaIr8tbja2hwuVvwRYCjBY7pIEI=;
        b=pmpSSNRgmwwCyyzRQOvpuwIpzJm5lv/rXGQ2jM5sX1PEQYVDW0u7G1BPw7qqIPMfLy
         dkVmF8dt9j5HOvKt5yfDF6TbOV0uzLHfaRCsEi4BMWWpricOjTetdU1g/DivHbjaBT+Y
         1L0LlGOYGeBbsIF7sgfL0PHH+pSRkWHdFgPbmkhj4UfSLd6lVK6CYZJjja7MOwGV67ZB
         69HmOB7IE97SoWEl2gTYf5lC9UE8IHQGEaQWYCrM5FC690kDv7bGVrOfGOE5pyBYcdM5
         0hcOYbL8yKVwZhGIx0/GAjBNB+h/bwlfzQvpxn99ob+j+VSGU6ad89mtu5GTG4wZLMvD
         Y4hA==
X-Gm-Message-State: ANhLgQ0TStkqDWyqWhRRndsV7CmchLCcyxUhcZl4DxTs2qmC7u57s0DN
        oelLaE5lXeHzvonl6L0a/Q==
X-Google-Smtp-Source: ADFU+vsgk1CVD8uaxH2wBkuZwRRmB415F+Y2SyC32UGwlVGUkEFc5Tag8xVHtkk8ExNduqTU4sb5sA==
X-Received: by 2002:a1c:147:: with SMTP id 68mr795846wmb.28.1585344260673;
        Fri, 27 Mar 2020 14:24:20 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.gmail.com with ESMTPSA id h132sm10215141wmf.18.2020.03.27.14.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 14:24:20 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     julia.lawall@lip6.fr
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@example.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, Qian Cai <cai@lca.pw>,
        Arnd Bergmann <arnd@arndb.de>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-kernel@vger.kernel.org (open list),
        rcu@vger.kernel.org (open list:READ-COPY UPDATE (RCU))
Subject: [PATCH 03/10] cpu: Remove Comparison to bool
Date:   Fri, 27 Mar 2020 21:23:50 +0000
Message-Id: <20200327212358.5752-4-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327212358.5752-1-jbi.octave@gmail.com>
References: <0/10>
 <20200327212358.5752-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Jules Irenge <jbi.octave@example.com>

Coccinelle reports a warning inside __cpuhp_state_add_instance_cpuslocked

WARNING: Comparison to bool

To fix this, the comparison to bool is removed
This not only fixes the issue but also removes the unnecessary comparison.

Remove comparison to bool

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/cpu.c      | 2 +-
 kernel/rcu/tree.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9c706af713fb..97f8b79ba5f5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1682,7 +1682,7 @@ int __cpuhp_state_add_instance_cpuslocked(enum cpuhp_state state,
 	lockdep_assert_cpus_held();
 
 	sp = cpuhp_get_step(state);
-	if (sp->multi_instance == false)
+	if (!sp->multi_instance)
 		return -EINVAL;
 
 	mutex_lock(&cpuhp_state_mutex);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d91c9156fab2..c2ffea31eae8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -100,7 +100,7 @@ static struct rcu_state rcu_state = {
 static bool dump_tree;
 module_param(dump_tree, bool, 0444);
 /* By default, use RCU_SOFTIRQ instead of rcuc kthreads. */
-static bool use_softirq = 1;
+static bool use_softirq = true;
 module_param(use_softirq, bool, 0444);
 /* Control rcu_node-tree auto-balancing at boot time. */
 static bool rcu_fanout_exact;
-- 
2.25.1

