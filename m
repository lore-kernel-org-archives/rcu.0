Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70E1DE8AD;
	Thu, 16 Jul 2026 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161094; cv=none; b=IpAC5fzjBNeQc/N8ZZliePyc+M4f331mzgmdxDG9YMqmivAnQjPaOA98xjnT/x4XwBReIoNps+Y3F2R0Tg1+ccNy49WPUbi0Wox7QR0jgkdBFP0jqQMsUZDCRYHjAqgELboaqqsmIh+3tSFjgZO4Pi29GFi0RNk8hADXN0ag028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161094; c=relaxed/simple;
	bh=MVYVSEwgX9ErXlL3oNlXG1ram+EvlEnkLLeYLffDHVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PgWENY1ciUcTg2Ul4pULG6HHn5Rgh4UOri74F3UKsRWEOWrgjzv7dzk3w8tsHBgXuP5ieW2PldEOL7FqWM8r9daTGJKY43/v5TnaCUfdas6idLo7cGbyriZQso0nEUA+pm5q5gWDDDsguJPoTKds/xwyHUkMRjx850G02hyimxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WChgXTfi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WChgXTfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860A41F00ADB;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=WhHqRMaeXfu70Of3FC59od/tkpMMpTIm2Z1mPB13wwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WChgXTfi4Ccs3qdg+1AaiZ7xocuQZR1CYDvm1IuQ34zLbJNLxH25CRdQMs822+Ib9
	 AdKcFQORm2ADBXBb2gyE78zjDL8EAmDaeLL6NXxrMBbEMjMT2zXCMlWdpiSZQryCDk
	 XtlObGSLQ5+7AmkxG9yPqgHtbcN9oERk5Wc5Z8DvQgdEHPWREeoJM5piAQlZ+RCjrl
	 dEBuR3TUrAgT4uMIWPd2LS7PPwWq1f3CJcv7mAN+PJgR6blNoRKVCifcTvGhslAUSG
	 1M52862a/2fnDtEV+jPGAJZZGWQ2h4+PYG54k3xRkh2Spetysz5VEnahKNoOK+8Ydh
	 D/COGE8/FC92g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 34AA6CE0E0B; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 07/24] torture: Add a stutter_will_wait() function
Date: Wed, 15 Jul 2026 17:17:52 -0700
Message-Id: <20260716001809.11084-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
References: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a stutter_will_wait() function that returns true if a
call to stutter_wait() at that same time would have waited.  Of course,
the passage of time means that the return value might become immediately
stale, so this should be periodically polled on the one hand, or used
only for heuristic purposes on the other.

The initial use case for this function is to clean up references to
objects that might otherwise be held across the stutter interval, which
could result in false-positive failures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/torture.h |  1 +
 kernel/torture.c        | 23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 66d2d444428aef..b8e5d0f3c2d8f9 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -98,6 +98,7 @@ void torture_shutdown_absorb(const char *title);
 int torture_shutdown_init(int ssecs, void (*cleanup)(void));
 
 /* Task stuttering, which forces load/no-load transitions. */
+bool stutter_will_wait(void);
 bool stutter_wait(const char *title);
 int torture_stutter_init(int s, int sgap);
 
diff --git a/kernel/torture.c b/kernel/torture.c
index 77cb3589b19f9c..bcd2e9c8a26356 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -727,6 +727,26 @@ static ktime_t stutter_till_abs_time;
 static int stutter;
 static int stutter_gap;
 
+static bool _stutter_will_wait(ktime_t *till_ns)
+{
+	*till_ns = READ_ONCE(stutter_till_abs_time);
+	if (*till_ns && ktime_before(ktime_get(), *till_ns))
+		return true;
+	return false;
+}
+
+/*
+ * Will stutter_wait() actually stutter?  The returned result is of
+ * course immediately stale due to the passage of time.
+ */
+bool stutter_will_wait(void)
+{
+	ktime_t till_ns;
+
+	return _stutter_will_wait(&till_ns);
+}
+EXPORT_SYMBOL_GPL(stutter_will_wait);
+
 /*
  * Block until the stutter interval ends.  This must be called periodically
  * by all running kthreads that need to be subject to stuttering.
@@ -737,8 +757,7 @@ bool stutter_wait(const char *title)
 	ktime_t till_ns;
 
 	cond_resched_tasks_rcu_qs();
-	till_ns = READ_ONCE(stutter_till_abs_time);
-	if (till_ns && ktime_before(ktime_get(), till_ns)) {
+	if (_stutter_will_wait(&till_ns)) {
 		torture_hrtimeout_ns(till_ns, 0, HRTIMER_MODE_ABS, NULL);
 		ret = true;
 	}
-- 
2.40.1

