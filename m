Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3399FC433EF
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 03:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244480AbiELDFI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 May 2022 23:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244450AbiELDFG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 May 2022 23:05:06 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143081FC2E2
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:06 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id u35so3409694qtc.13
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EfV4yWDJGiChIrululMwLYVp74K3O8ar9DeNHie78NA=;
        b=D69o/mFEs6JlcjHLexiUzbRKIB8i2MrJgyyP+hFR26flu0CZjJrFxDDq7b7HBJgWk2
         KzTtJSBcXkXxMB5J4gmMBWlpJ37LeRM5hmsHBeKlfUjmzv9sjzm968Cudz7eWGqHzb9Z
         pXaDXHzg123ti55tg82tN8DC2P/hHZXuMY8Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EfV4yWDJGiChIrululMwLYVp74K3O8ar9DeNHie78NA=;
        b=Z7V12xQ+YMWB8veuVBjF87xCNuWhXzYALO1YuCoYavC67W2t1nog4WoeTgH74lGWI8
         b5uZqf+sBSuxBPXq5XSnmQKMxChswfp3BBzJZPLaID5eAwEW0j6YmcIVHZXICACkovpF
         c9I/GlC/1guZIIDkiXt5fN6nJgurt8KDYoAcjNt2DOMkTMv4xD1bEN3cHCe/C5mAD1GX
         BgS08a8WS8xk0Rs73UcSz7GBvV3AoO2nMaHzfh4MOgoL0s6PEglc8fNUm9j0J2gebsEg
         11rVBHk7qKdgx8Nz3CEB2l7tFORc357wpT22quQtp0iPnDJXo7+sjGK9HjW3g79etntv
         Wnjg==
X-Gm-Message-State: AOAM533W+dKwhyJqoSC3PO0ITJ0wqvggXKHw/O6jdt7I0o2kYy6BO3g5
        fspm9SP51ghyP8KLM/NG7/SsXy96rKm+SA==
X-Google-Smtp-Source: ABdhPJzAJ6la+p18oLB6wyrN2jmE1J7R3XulQnk0Scm9w/JxFeN+NubmFZ/1BQMpt14tRX3/IUMiug==
X-Received: by 2002:ac8:5852:0:b0:2f3:cdbd:d5a0 with SMTP id h18-20020ac85852000000b002f3cdbdd5a0mr23561982qth.207.1652324705089;
        Wed, 11 May 2022 20:05:05 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id h124-20020a376c82000000b0069fc13ce203sm2270334qkc.52.2022.05.11.20.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:05:04 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC v1 06/14] kernel: Move various core kernel usages to call_rcu_lazy()
Date:   Thu, 12 May 2022 03:04:34 +0000
Message-Id: <20220512030442.2530552-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220512030442.2530552-1-joel@joelfernandes.org>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
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
index b00a25bb4ab9..6d84ec8e1fd0 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -177,7 +177,7 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
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
index 1cd10b102c51..04e191dfa91e 100644
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
2.36.0.550.gb090851708-goog

