Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E603C32771
	for <rcu@archiver.kernel.org>; Fri, 19 Aug 2022 20:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351848AbiHSUth (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351614AbiHSUtS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:18 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803819FA9C
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 13:49:12 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id y4so4203174qvp.3
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IM3xuvgYuRBTMeRN6UX20iY+v3dQGfWqdrHzqRgQ3nc=;
        b=j1zt/vmPhAeHqF3WzjQbwEdocA4ht6wnFFga1N4nnE/ogTiDii9fSTlX1cbj76ACKx
         rkDnBXZzmErhi7X3m2eBFCzCzDmUBL5ffMMdYDxeijnHDwVr3uO7inraAuHPZ94DWzIh
         S6PULMcp5wfkjvgZ5K6KG090NhD3f4pk7La+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IM3xuvgYuRBTMeRN6UX20iY+v3dQGfWqdrHzqRgQ3nc=;
        b=fOBMGDIsbWDs4zS42OdB6cLOOImO4xVj94AbBegvFA9Rvo8Vz+pp7pVYG0DC4gxwkt
         qdHtm5KddNkDQsSmpok3OaiUMHx1DEkUj9cHBXUhOE+nl2RI/c5/VjGFIlXwkFJXjQtd
         KS36BucFs3gPrQAtoNYdiEgh8Yti1W2n9z4eS2tfIRJsUJLBs9LY+zPxfu+V9ennKC5Q
         r26nO4j/IcjYaszdwTXh/AV0xos/Z59UXdmYrVPOsumyQeoTk+Cv8qpl5JODgQODUKLw
         gRedUGil3FoVmdn8poiqfoQqthbDlOPYCoL1UKYqvDXjRg/jZnlVO1NdH2K1asGeoouE
         jQQg==
X-Gm-Message-State: ACgBeo2oWE2Co8/v5Zw0Gk2FYNQiONWih3VZ3AqD7qkrc2hg+YhC9zPG
        0m4PL/8GwVZ+NvAJPtucLJUCvg==
X-Google-Smtp-Source: AA6agR78xm+acrn/3AsCNGALGerD8M0khl3rhGk2dAyVszt75ahBd55xnbLLHZC62JHF+LYJ9HIWfA==
X-Received: by 2002:ad4:5cae:0:b0:496:a988:ddc0 with SMTP id q14-20020ad45cae000000b00496a988ddc0mr7940572qvh.3.1660942151448;
        Fri, 19 Aug 2022 13:49:11 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b9a89d408csm4377123qko.100.2022.08.19.13.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:10 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
Subject: [PATCH v4 10/14] kernel: Move various core kernel usages to call_rcu_lazy()
Date:   Fri, 19 Aug 2022 20:48:53 +0000
Message-Id: <20220819204857.3066329-11-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
In-Reply-To: <20220819204857.3066329-1-joel@joelfernandes.org>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
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
index 853c6a943fce..14cde19ff4c2 100644
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
index 06d1236b3804..63489c4070cd 100644
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
2.37.2.609.g9ff673ca1a-goog

