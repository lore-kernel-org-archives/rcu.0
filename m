Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62405C54EE9
	for <rcu@archiver.kernel.org>; Thu,  1 Sep 2022 22:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiIAWSs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbiIAWST (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:19 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9419A60504
        for <rcu@vger.kernel.org>; Thu,  1 Sep 2022 15:18:08 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h22so245792qtu.2
        for <rcu@vger.kernel.org>; Thu, 01 Sep 2022 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3vWNR1lOZ3nlNpU4UUmxfmJYajX79MfO1ObVeBbomlg=;
        b=W9V/oqA+OZMtsddIG83NBCyyox5x44+ormS/AjYTPNmA6tq1LLUSu1mTv373zuQAmL
         stXAk/bY0nw2tv3MorrBWKQVz0OdcObvezxEjnW0fZHXmStt0csE5tLilyFNZXZtzQ7e
         hZ35XQl1bl0u/iHRILvxndSITlzXxbNnrQw8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3vWNR1lOZ3nlNpU4UUmxfmJYajX79MfO1ObVeBbomlg=;
        b=V8tGseKQfxncSLJK5EIjjKZtSyKiKAGHQ27Wn/3QF71OnS7lImP+1iocKZ3p232b3C
         dscJzJLmQplqyO7SbsBXwB7s38MNOsUl738BSPfGhhOA6EDg3ynlGLfh314AHJnhMQN1
         WVzmYpm76oCFMN+QaQx6ZZ0wzWC7v89h9XG7POwOk17mg8XUVH/hhZNPkyWUbvnpPJgi
         /gw9FORh4hByIBt5A0/sisNu5emndygZXTPHeFADo6pYhUh54khRy3MFP8eBngoYvmxp
         VxlJDh2FEpLtvYsfj/IlcylRAHhEisO/TNTkXUgSGlx0P/DYZl816f7UIvIhRejLPXDr
         G7fw==
X-Gm-Message-State: ACgBeo3320ekoznuKJvntKf5zk4zPzmCjvfP8Cu8sHAzZ9oI/m8O90Mj
        KdImCxkuDqFGTqisg2EUyEnqByYdKXIUwA==
X-Google-Smtp-Source: AA6agR7Md6xYqwWArMXYWwgIpGr8i6bhrZ317pWwHfXCZUjbF4/68mUbJbpxMEPOI/zS/oZi2CAc+g==
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id v6-20020ac85786000000b003433051170dmr25646460qta.429.1662070688111;
        Thu, 01 Sep 2022 15:18:08 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:07 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 15/18] kernel: Move various core kernel usages to call_rcu_lazy()
Date:   Thu,  1 Sep 2022 22:17:17 +0000
Message-Id: <20220901221720.1105021-16-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/exit.c              | 2 +-
 kernel/pid.c               | 2 +-
 kernel/time/posix-timers.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 84021b24f79e..b2a96356980a 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -180,7 +180,7 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
 void put_task_struct_rcu_user(struct task_struct *task)
 {
 	if (refcount_dec_and_test(&task->rcu_users))
-		call_rcu(&task->rcu, delayed_put_task_struct);
+		call_rcu_lazy(&task->rcu, delayed_put_task_struct);
 }
 
 void release_task(struct task_struct *p)
diff --git a/kernel/pid.c b/kernel/pid.c
index 2fc0a16ec77b..5a5144519d70 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -153,7 +153,7 @@ void free_pid(struct pid *pid)
 	}
 	spin_unlock_irqrestore(&pidmap_lock, flags);
 
-	call_rcu(&pid->rcu, delayed_put_pid);
+	call_rcu_lazy(&pid->rcu, delayed_put_pid);
 }
 
 struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 5dead89308b7..660daa427b41 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -485,7 +485,7 @@ static void release_posix_timer(struct k_itimer *tmr, int it_id_set)
 	}
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
-	call_rcu(&tmr->rcu, k_itimer_rcu_free);
+	call_rcu_lazy(&tmr->rcu, k_itimer_rcu_free);
 }
 
 static int common_timer_create(struct k_itimer *new_timer)
-- 
2.37.2.789.g6183377224-goog

