Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C292CC433F5
	for <rcu@archiver.kernel.org>; Wed, 24 Nov 2021 11:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241767AbhKXLGy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 06:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241702AbhKXLGj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 06:06:39 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7272CC061746;
        Wed, 24 Nov 2021 03:03:29 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id l7so4630010lja.2;
        Wed, 24 Nov 2021 03:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UGBcTMU8e3Nn01ZNbbWLJmUbEOeeYN+AaV3/0kh4e/s=;
        b=T2XJdDBSg4SOL+JcAvZvJbXSVMcVIf/GGlUJNA/ZRzSX6l1Sa5jtX5QA/H7U4gmIwr
         oAYtgPTYcarfMGd/O+rAjY0nJxR2d3iJv+71JF6GxYR6zatVGvifDJuJLiMGJRj5sqNT
         rpsvbYFcTAdCeliFy2Kfb3OSwAm3jzHsoE7ZtABJZUMKslYuSvO6RZFh1QEcsUxod6GZ
         TTXVCmufo1loV9iUoeJ+wIXqxqgdXAg31X2y7GWD8LEYZT7WPVcElCXPY4wm2QG3yqjc
         X/oyi8gF69HAoFpXP+eZfNcJkcYwh4G6ts6628ux6WbIkhI76t9esT8epLvbNjXXJ31U
         82UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGBcTMU8e3Nn01ZNbbWLJmUbEOeeYN+AaV3/0kh4e/s=;
        b=mzwMYrOySA0kvGVC27w55hfiipZNzum99BtM1TjtQ/ZUr6bIP+dMdGkUrRSOy/BzHf
         5rt9ri19TQQXmvRFLAi36ee9F8Omc6U15eoROyum9QW/9qUn3fqJCUtE9WxQKlgPs7sA
         4yTaMk5ZlEC2nbKpgg/K8RoYGhdPMaeA4xVyPBmOTMti2Wwchm+W8dUgTUzQzRgQ/J1T
         2NNQDO60Ux+dPDLBYK/EshGty7k9CVmgoSTeqF6+dq+PX+bT8EA98uKq1KL/KVEZFgVc
         BLrivYVYpxPFAEY6+rkeOf0Yz6JuGaGtRJYHY+m/xt3/e1TuI/v+lNmPtH1erKRauxNA
         V/hQ==
X-Gm-Message-State: AOAM530qdF8zAKzvCJVSTOPsaaVUevzGHLgVlhwdipfaJMy2gsmhB6jW
        XA+4QzcwFw+WDb4yV45gKIcqISMsYkSmZpka
X-Google-Smtp-Source: ABdhPJxOf9Pvqu9rJWed+r7nH/8tYLbdepman5UHfS+/wnBfG4KYRWRRAWyQkDKcnaDne7cSq3aYWg==
X-Received: by 2002:a2e:974e:: with SMTP id f14mr14537168ljj.153.1637751807805;
        Wed, 24 Nov 2021 03:03:27 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u22sm1579907lff.118.2021.11.24.03.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 03:03:27 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 9/9] tracing: Switch to kvfree_rcu() API
Date:   Wed, 24 Nov 2021 12:03:08 +0100
Message-Id: <20211124110308.2053-10-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124110308.2053-1-urezki@gmail.com>
References: <20211124110308.2053-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Instead of invoking a synchronize_rcu() to free a pointer
after a grace period we can directly make use of new API
that does the same but in more efficient way.

CC: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/trace/trace_osnoise.c | 3 +--
 kernel/trace/trace_probe.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 7520d43aed55..4719a848bf17 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -138,8 +138,7 @@ static void osnoise_unregister_instance(struct trace_array *tr)
 	if (!found)
 		return;
 
-	synchronize_rcu();
-	kfree(inst);
+	kvfree_rcu(inst);
 }
 
 /*
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 3ed2a3f37297..8a3822818bf8 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1138,8 +1138,7 @@ int trace_probe_remove_file(struct trace_probe *tp,
 		return -ENOENT;
 
 	list_del_rcu(&link->list);
-	synchronize_rcu();
-	kfree(link);
+	kvfree_rcu(link);
 
 	if (list_empty(&tp->event->files))
 		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
-- 
2.30.2

