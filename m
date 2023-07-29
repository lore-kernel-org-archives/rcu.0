Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98324C001DF
	for <rcu@archiver.kernel.org>; Sat, 29 Jul 2023 14:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjG2O2j (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 29 Jul 2023 10:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjG2O2f (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 29 Jul 2023 10:28:35 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615B246B4
        for <rcu@vger.kernel.org>; Sat, 29 Jul 2023 07:28:18 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-cb19b1b9a36so3004588276.0
        for <rcu@vger.kernel.org>; Sat, 29 Jul 2023 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690640896; x=1691245696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwxEGA9bB7b0DElBaIYcQs9XoGIY+NHTZRuaPpVwP9M=;
        b=bgVc8RgM8MUE3/FR/qxJAAVnZPDSL8B/L8Y55nDBH4dQN+gKdet8DkRYtYGE5rhJKB
         5PFNZ2s+lGod3ijPAm+7YYjP7qeW1FBV3BCBrlG7+C52Vjzf4HQApIQy+8ztJrApuvFA
         jh0kfZEj3pdfu2H7JHKa7COI15JG/bknJpcRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690640896; x=1691245696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwxEGA9bB7b0DElBaIYcQs9XoGIY+NHTZRuaPpVwP9M=;
        b=Zqn7ETlW6f3sZArzi7ZK0n8AyveN3//kAUTB31rbePucGt/8pg8A4n1uqYWpRfN9Uu
         F3WPpuRTjHfnye0spGz9qLYMPVzGb+CFLABKOaDS6rCuBT/oNqLjyyZA1JtQnzsi3ypL
         A/3ejUNgaeGa9OU57p1s50XiEiIxTr/GeZ5jNWkDnEGemAvRl0GSOYGUPb+JA38ZMryh
         shO5372HQc0egqH+q5q2ZuaAObZQ2vho4e4+53wOASyU60F0CA0Qzb2pOg8ZJpbE8wQP
         MGc3IgsVftzrJTX51QWUnIKdBVP2nk6xybxZOlxIEKUo9PyiG9+uOGt1QpJPgvljeKAk
         6Ozw==
X-Gm-Message-State: ABy/qLZYUSkelkn7KuShGMFtSmLH0/uP7HLGw0vRxkRalX2N/jBZJEbt
        lohi262kLK291cxs8rdrwHX4rW+k/lfdA9zcGig=
X-Google-Smtp-Source: APBJJlFk+pVi5ucHAZ4YN78zym81iXhYotkmEVyM8rGXoNXNjoUsMje3qOOrHrpWOnLI579JZtCj9g==
X-Received: by 2002:a92:cdab:0:b0:348:8050:d7a with SMTP id g11-20020a92cdab000000b0034880500d7amr3082832ild.30.1690640875892;
        Sat, 29 Jul 2023 07:27:55 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id q9-20020a0566380ec900b0042b35c7b8c5sm1855362jas.61.2023.07.29.07.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 07:27:55 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     rcu@vger.kernel.org, paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        stable@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH v2 1/5] rcutorture: Fix stuttering races and other issues
Date:   Sat, 29 Jul 2023 14:27:31 +0000
Message-ID: <20230729142738.222208-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230729142738.222208-1-joel@joelfernandes.org>
References: <20230729142738.222208-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The stuttering code isn't functioning as expected. Ideally, it should
pause the torture threads for a designated period before resuming. Yet,
it fails to halt the test for the correct duration. Additionally, a race
condition exists, potentially causing the stuttering code to pause for
an extended period if the 'spt' variable is non-zero due to the stutter
orchestration thread's inadequate CPU time.

Moreover, over-stuttering can hinder RCU's progress on TREE07 kernels.
This happens as the stuttering code may run within a softirq due to RCU
callbacks. Consequently, ksoftirqd keeps a CPU busy for several seconds,
thus obstructing RCU's progress. This situation triggers a warning
message in the logs:

[ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9

This warning suggests that an RCU torture object, although invisible to
RCU readers, couldn't make it past the pipe array and be freed -- a
strong indication that there weren't enough grace periods during the
stutter interval.

To address these issues, this patch sets the "stutter end" time to an
absolute point in the future set by the main stutter thread. This is
then used for waiting in stutter_wait(). While the stutter thread still
defines this absolute time, the waiters' waiting logic doesn't rely on
the stutter thread receiving sufficient CPU time to halt the stuttering
as the halting is now self-controlled.

Cc: stable@vger.kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/torture.c | 45 ++++++++++++---------------------------------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 6ba62e5993e7..fd353f98162f 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -720,7 +720,7 @@ static void torture_shutdown_cleanup(void)
  * suddenly applied to or removed from the system.
  */
 static struct task_struct *stutter_task;
-static int stutter_pause_test;
+static ktime_t stutter_till_abs_time;
 static int stutter;
 static int stutter_gap;
 
@@ -730,30 +730,16 @@ static int stutter_gap;
  */
 bool stutter_wait(const char *title)
 {
-	unsigned int i = 0;
 	bool ret = false;
-	int spt;
+	ktime_t till_ns;
 
 	cond_resched_tasks_rcu_qs();
-	spt = READ_ONCE(stutter_pause_test);
-	for (; spt; spt = READ_ONCE(stutter_pause_test)) {
-		if (!ret && !rt_task(current)) {
-			sched_set_normal(current, MAX_NICE);
-			ret = true;
-		}
-		if (spt == 1) {
-			torture_hrtimeout_jiffies(1, NULL);
-		} else if (spt == 2) {
-			while (READ_ONCE(stutter_pause_test)) {
-				if (!(i++ & 0xffff))
-					torture_hrtimeout_us(10, 0, NULL);
-				cond_resched();
-			}
-		} else {
-			torture_hrtimeout_jiffies(round_jiffies_relative(HZ), NULL);
-		}
-		torture_shutdown_absorb(title);
+	till_ns = READ_ONCE(stutter_till_abs_time);
+	if (till_ns && ktime_before(ktime_get(), till_ns)) {
+		torture_hrtimeout_ns(till_ns, 0, HRTIMER_MODE_ABS, NULL);
+		ret = true;
 	}
+	torture_shutdown_absorb(title);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(stutter_wait);
@@ -764,23 +750,16 @@ EXPORT_SYMBOL_GPL(stutter_wait);
  */
 static int torture_stutter(void *arg)
 {
-	DEFINE_TORTURE_RANDOM(rand);
-	int wtime;
+	ktime_t till_ns;
 
 	VERBOSE_TOROUT_STRING("torture_stutter task started");
 	do {
 		if (!torture_must_stop() && stutter > 1) {
-			wtime = stutter;
-			if (stutter > 2) {
-				WRITE_ONCE(stutter_pause_test, 1);
-				wtime = stutter - 3;
-				torture_hrtimeout_jiffies(wtime, &rand);
-				wtime = 2;
-			}
-			WRITE_ONCE(stutter_pause_test, 2);
-			torture_hrtimeout_jiffies(wtime, NULL);
+			till_ns = ktime_add_ns(ktime_get(),
+					       jiffies_to_nsecs(stutter));
+			WRITE_ONCE(stutter_till_abs_time, till_ns);
+			torture_hrtimeout_jiffies(stutter - 1, NULL);
 		}
-		WRITE_ONCE(stutter_pause_test, 0);
 		if (!torture_must_stop())
 			torture_hrtimeout_jiffies(stutter_gap, NULL);
 		torture_shutdown_absorb("torture_stutter");
-- 
2.41.0.487.g6d72f3e995-goog

