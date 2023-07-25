Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B52C001DF
	for <rcu@archiver.kernel.org>; Tue, 25 Jul 2023 23:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjGYX3a (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jul 2023 19:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjGYX33 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Jul 2023 19:29:29 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F963120
        for <rcu@vger.kernel.org>; Tue, 25 Jul 2023 16:29:28 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-78bb3ff7cbcso113967539f.3
        for <rcu@vger.kernel.org>; Tue, 25 Jul 2023 16:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690327768; x=1690932568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjqXIuVtq0u8YshojVwovW+pCVt0mgB/LilQjFvvm4k=;
        b=Qe9sSQNhnm2GdgDMjBEvMNzqgoUbTZUEYU+4P5xV+G0XGcheStBtG4dXcqhIqRC+Qw
         6Appyh/rwaegQl6X307xDZAU2WiYBskonXGtUi++Tvwk5fjxWw6roo0BZ+1B4hrYS879
         YIWAL2TlvrswSmzRpSN/9zRaKs+QVVJ2oq8tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690327768; x=1690932568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjqXIuVtq0u8YshojVwovW+pCVt0mgB/LilQjFvvm4k=;
        b=JEiwqj+FY+nLpnkTB7T5JTFlcYgoGJToz7WUOJ5NIAtm4+UDkIFmAd5k2wM25Yv5SW
         JwU2D0cXd/8/j+Pk0nU77TIsE/8ruEqbAWqJrkNUExLFvc/EAeUT5CeHMNN5oPZyZT9C
         DrwwPJX0qCG0JHu2ZLqerPkNMHEsmoPxSIU3eXEY1D6bkMYFhicjmh3Cae5KS/IBy5fr
         UqHvh9hoDuBzxE3TFasjYRofHPf6F7/zbtm/bZStA1BCJ1yxgrgd/HO4E7YAaBBk+6Fo
         zFUb+PRHy0qC4JbA4lTMOaonuaRA5hwYfxHNYKs4U+sV8G1CUW6xYhYHkoL3RbL5GEn3
         SPNg==
X-Gm-Message-State: ABy/qLZEQh9Tixg7yEYqmnqR7TTmHMqZnixgpA08OPZG4u7ekiar9eEK
        4TVCpKJkcdCKBwJ5fSVlfhbbww==
X-Google-Smtp-Source: APBJJlHSQsPaCUv83pDozY5eFiLygkk647/+RNJH82m94E6xEn7hjRbJJFpy2CXENNqGa4wtwOyDwg==
X-Received: by 2002:a6b:e818:0:b0:783:6ff9:a6c7 with SMTP id f24-20020a6be818000000b007836ff9a6c7mr334374ioh.6.1690327767704;
        Tue, 25 Jul 2023 16:29:27 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id m18-20020a02c892000000b0041d859c5721sm3932053jao.64.2023.07.25.16.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 16:29:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     rcu@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 1/5] rcutorture: Fix stuttering races and other issues
Date:   Tue, 25 Jul 2023 23:29:06 +0000
Message-ID: <20230725232913.2981357-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230725232913.2981357-1-joel@joelfernandes.org>
References: <20230725232913.2981357-1-joel@joelfernandes.org>
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

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/torture.c | 46 +++++++++++++---------------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 68dba4ecab5c..63f8f2a7d960 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -719,7 +719,7 @@ static void torture_shutdown_cleanup(void)
  * suddenly applied to or removed from the system.
  */
 static struct task_struct *stutter_task;
-static int stutter_pause_test;
+static ktime_t stutter_till_abs_time;
 static int stutter;
 static int stutter_gap;
 
@@ -729,30 +729,17 @@ static int stutter_gap;
  */
 bool stutter_wait(const char *title)
 {
-	unsigned int i = 0;
 	bool ret = false;
-	int spt;
+	ktime_t now_ns, till_ns;
 
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
+	now_ns = ktime_get();
+	till_ns = READ_ONCE(stutter_till_abs_time);
+	if (till_ns && ktime_before(now_ns, till_ns)) {
+		torture_hrtimeout_ns(ktime_sub(till_ns, now_ns), 0, NULL);
+		ret = true;
 	}
+	torture_shutdown_absorb(title);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(stutter_wait);
@@ -763,23 +750,16 @@ EXPORT_SYMBOL_GPL(stutter_wait);
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

