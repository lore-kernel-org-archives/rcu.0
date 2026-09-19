Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78BA26A1AC;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776062; cv=none; b=FeldEbjK9WGuwhOj6RVyNlS5QWnGQOuCUWubz7RfW8DJAfwgQMBy8oZDr7hYZ8SDro6h19dPmuWzsK0vonF2kiCffOZziSfLJhhStuGVovnKypejcBQNs4wjMV8uZVH+elrz32IeFFnQj+PrEGMeXEr7ScDxnA92H3oOISwZAu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776062; c=relaxed/simple;
	bh=VCVMz1AmcrwnnPk7zKIIGoO7evWk11L6/SA1wsDcR88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IRhOVS4TuhP4cNSRx/r3+FvjySXDG6uqHLoLTSfXxxb9eoCnQuVJvQKNZhil6Q40bBL52g8n/Hnq+XCnLhCppggBEcXD4OL8MfUethlANz+j0yUuGwiwymbDfOHaFAlzP7AlhH1f5JlsIL/DBrowPzdUrjoXTQqTQhNippUObDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDZHw7ZZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDZHw7ZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BA91F008A6;
	Sat, 19 Sep 2026 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776059;
	bh=cNq/1X0FOP/AzhVHpp3kQaCZowngQghQCIMmMwINQAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WDZHw7ZZbVucyY3OFUbC9U/eGp/c8eS6kp0SCBwvJbGARyRO0OQRSSQgpUgSluJ6Y
	 Gex/1FqQwgVIJH9RJTYVZvZO7oxjnsIVx5gdPIXwAUNPfrULC+IdJqLkOYrtjuAjcu
	 NLItfS/mEvfU5or098hP1QoVcAkP7bQX9BIH39v1szxtKOXu+n7CLNNzTj7yk7XHyH
	 jve27ihv10J8JHVHx5/SpyLUjomScGCO+X09n8bGJ864bc8AyoQvcC1S+G7xhOH27w
	 IAiQGhV6E8e4WFr5dikEm30eboBklhOPeNvUs2a/XCu7XovOArSgMElsqKtTOo8hUm
	 MR6BOSmsZe/BA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5D5FACE0ABD; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 07/28] torture: Add a stutter_will_wait() function
Date: Fri, 18 Sep 2026 17:00:35 -0700
Message-Id: <20260919000056.3132131-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
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
Cc: Boqun Feng <boqun@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 include/linux/torture.h |  1 +
 kernel/torture.c        | 23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 66d2d444428a..b8e5d0f3c2d8 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -98,6 +98,7 @@ void torture_shutdown_absorb(const char *title);
 int torture_shutdown_init(int ssecs, void (*cleanup)(void));
 
 /* Task stuttering, which forces load/no-load transitions. */
+bool stutter_will_wait(void);
 bool stutter_wait(const char *title);
 int torture_stutter_init(int s, int sgap);
 
diff --git a/kernel/torture.c b/kernel/torture.c
index 8c4e6b2fe8ba..93caaa8b807e 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -732,6 +732,26 @@ static ktime_t stutter_till_abs_time;
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
@@ -742,8 +762,7 @@ bool stutter_wait(const char *title)
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

