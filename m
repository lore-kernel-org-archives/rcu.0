Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BEC1C4609;
	Mon, 21 Oct 2024 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548786; cv=none; b=hFp0IbaG0dKI91gM+N1/dmU2ki05U7mAQ5XheQ5AQAo/yw+GYpZpkDxMBjDT6H0SgtHhQ7IKv1oAPjVjYPW2kATy4/eIkGVplxMi9vt7Iz+qkmcDSxVmjkMllLl5nAeh7GJvdWEX83yOmTvqv+30AX5s3J2QAuXZwo81TUJ2KF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548786; c=relaxed/simple;
	bh=M5yWAF/R0QTARoO4jvZtiId1CKtuH6rgLGc/G5eCqss=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UiGjo/VqaK+39o48HXn8TCp5A+n8SuSarz/D+O8NeH7cgrckmEAj2nG8g42ASjiN51F693+/tFSXne0K53riNgRHqQf2sN0av1QVBhXTQGzBRnsKjhuMJ/cBieqa0RZRxEnXthmsJel0GHQ3wgzqp720VzWHK4059Pig8YA0kiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYLLQSY8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYLLQSY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DCCC4CEC3;
	Mon, 21 Oct 2024 22:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729548785;
	bh=M5yWAF/R0QTARoO4jvZtiId1CKtuH6rgLGc/G5eCqss=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=FYLLQSY8+hiNT27tq1xtyrBqatmAUSWCNIWcwsInBotQo7eCmN8NCQXAtoXNHbmaS
	 13OuEUpib00MVT+3hTZk6KkcnqYLOZCFIREjZ4uV9MqAMZzkBySSZtNcEqaDf73v8j
	 IYFu6f0fahr7+kLPMQXgW+kjBw3vQTGYNPHIkIz6Bz7FgwGjl+Vp76NIFuqTifj9f/
	 aQXogLCrhlSHvMA5QbaIVXkzt3cgSI5B9mH/kMnizQEabmPaiJRRUyLFLZSslssQDD
	 ymM3QECz+MwYnEjeIgGbnadXaEWQo2kYuzlipUavoVdO5vHSiG6ibqTHxwalJnQa9c
	 pW3unPS9DnLIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 74B77CE09F6; Mon, 21 Oct 2024 15:13:05 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:13:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	peterz@infradead.org, andrii@kernel.org
Subject: [PATCH rcu] srcu: Guarantee non-negative return value from
 srcu_read_lock()
Message-ID: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

For almost 20 years, the int return value from srcu_read_lock() has
been always either zero or one.  This commit therefore documents the
fact that it will be non-negative.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index bab1dae3f69e6..512a8c54ba5ba 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -238,13 +238,14 @@ void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
  * a mutex that is held elsewhere while calling synchronize_srcu() or
  * synchronize_srcu_expedited().
  *
- * The return value from srcu_read_lock() must be passed unaltered
- * to the matching srcu_read_unlock().  Note that srcu_read_lock() and
- * the matching srcu_read_unlock() must occur in the same context, for
- * example, it is illegal to invoke srcu_read_unlock() in an irq handler
- * if the matching srcu_read_lock() was invoked in process context.  Or,
- * for that matter to invoke srcu_read_unlock() from one task and the
- * matching srcu_read_lock() from another.
+ * The return value from srcu_read_lock() is guaranteed to be
+ * non-negative.  This value must be passed unaltered to the matching
+ * srcu_read_unlock().  Note that srcu_read_lock() and the matching
+ * srcu_read_unlock() must occur in the same context, for example, it is
+ * illegal to invoke srcu_read_unlock() in an irq handler if the matching
+ * srcu_read_lock() was invoked in process context.  Or, for that matter to
+ * invoke srcu_read_unlock() from one task and the matching srcu_read_lock()
+ * from another.
  */
 static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
 {
