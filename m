Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3143D6473
	for <rcu@vger.kernel.org>; Fri,  8 May 2026 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248977; cv=none; b=FeZFPYYUfpYs9B3roZDa8ED7JLLtjE/1Voej6jU9LHzYDV9dBHeey32umhaTnigT68OFmKzeVLZexc0+WRdzsXP7cp4nRZqxuBgQuyCCAu7As2YbJeM1gsH32fo+0xf8rQlB6/4wQUSgVqvpq28OZjjJPvbkMP/4OH86XZPBPC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248977; c=relaxed/simple;
	bh=wFDH1o3olfLg5Ia+rpt7qq+s9E6GpSnwIOlVVU8i2Tw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e5xSZ1+o0e7lwP+BQDNrsxbXHNm6Kawq/4lR0NOLetenjgKWkpKYKDaXFHJlwLwculY2kT1/cIg5XmP+KbWDa3zSjXjiv8AQkEjP+4E85iRcvYBvsomeNNdcReZZHp/9lOUrqhV313ENjIMLOVsl4M/qntaWpPtX92TZx+FFjFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QXOGJC9W; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QXOGJC9W"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-44f1b4d0fb0so1397073f8f.1
        for <rcu@vger.kernel.org>; Fri, 08 May 2026 07:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778248974; x=1778853774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VXcmRThuEWO63YTSaN19aEGemVtVdbv7aDPqYYnwWkg=;
        b=QXOGJC9WSmTMuWvA57PTvZ05TTFNOItLUD5f6UVAD9cTJ4GsHUE5vndpO9dMM8Ba9+
         qA+hhjybXC2UiXMGkgVd/Us6KmdLzFlJFAoxsyecZCj2DxN80COgAicnx8KSNHrrIqFy
         pwyStGk+ecQ/k6Cnhhh1yBf5Lkc6Rvo8avJM6wfRL2OP28xE2iPys4PoIZ4PwZf2LTnk
         jo0a210ppE4YxGTCq8bvxjE49jMwB/EK9jeQtwddMUqvd/hsVu7E2RK+e2NK31xw+8nk
         O2q2qTYNh3PkcEpGeXrgsGt4B0+BpZg1ff1kKeLHTtrGP9pK4qB7AnMX7DG7pdBq0XTU
         wxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778248974; x=1778853774;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VXcmRThuEWO63YTSaN19aEGemVtVdbv7aDPqYYnwWkg=;
        b=QOijNNaxzkzOe9r1l8j2M4VTJpOHPRQcGYyoAOYKvuQIsPI29qQx604p17mp7nZOLD
         KTr65mAWyEGlCzlyZDAxV3LTZFGAcThn0lkXR47UMtvobtdLklFm/xpVpAHJ69Nc/y1k
         KvVeGKFyef+UjBi2WGcC4Jr7YKdsJyt7enjqZiN/KVZUBm0ChCynpN6msitC2588wUUK
         9AAmc/z0C7y71q0sDyb/HhZZvdxURCoyT6q2yw1hi0izO5EeMe/Bg5qMWSHn1G5FjpR6
         1gxFpRP6B0kt4c1UfD/eX9u3ejEBqz9yGT7LDbIAXuWeZn2f2iguHMVvFuAVsQdNMK+A
         Yq8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8j8KhitZhEz+64s41ScWDeYTlPNt89c/+lorIG5Sginuzqdp5Dnw8Vs8m/TzHJ4J5XhxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6vFVJV6L+OjZ3GjoSbNKMn6Ps1KCr4czmyvmkCVib1XICRucg
	i/PRjWZvlFGqrRpqT+XK2ms++qRByHaFXo9olsuh1jQBy0H193ux32uZBWGZ6p09f873khYaaHf
	BLzCrDSdHhXVAFlxd+Q==
X-Received: from wmlf10.prod.google.com ([2002:a7b:c8ca:0:b0:48d:146d:6669])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1797:b0:48d:366:b962 with SMTP id 5b1f17b1804b1-48e51e0a8a8mr106370715e9.6.1778248974199;
 Fri, 08 May 2026 07:02:54 -0700 (PDT)
Date: Fri, 08 May 2026 14:02:45 +0000
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAXt/WkC/x3MQQ5AMBBA0avIrE1SjSKuIhbFYCJKOiVE3F1j+
 Rb/PyDkmQTq5AFPJwtvLiJLE+hn6yZCHqJBK10ooyrcj4DByoIS/NEHXK270XSm02NuKStziOn uaeTr3zbt+34VHkJuZgAAAA==
X-Change-Id: 20260508-put-task-struct-many-5b5b2f4ae174
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5092; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=wFDH1o3olfLg5Ia+rpt7qq+s9E6GpSnwIOlVVU8i2Tw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp/e0La+wERa4SgFHFwZzu6XdSGRui6vLxCtQ1s
 2d/uBZx5ViJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaf3tCwAKCRAEWL7uWMY5
 RuFiEAC5xbqkM6wsZulENtzyW35yQTipHX4FGSiCnlBNG0C/ALdZUnlYbHusE/PbThUZAzDPICP
 6NZoIe83p3LB102k3/H0nmM7h//WpfKQ+beNIitFlu5nJRvEn9yoWUnmxQRdfhhEdVFC+fwGS4G
 WXqGDf/g+jN0avXueIXVT6U+sU9vuHkM2HeDzEL54K19PBK7YTUiltoW8M+5TsNyivxsFUtGwD0
 DtoGh6Fc8fQztcEMzvtmND0SEHYnPYTUwl2Gd51Zse/f48HnAyqxC224v7NUBC18JGmXVHocAlK
 AYDGUQBbjBK6wvlR/pkxWRIWQGgrPlWjkcvat7XvfuYpBq44CYtoOhrU1quGlTSGN0U3z7ed+41
 25V6gvY1uF7yL9n4NgfoPXlUNsZJKU9Fe3y983KzVvCqOiz5HbWhHgmZlxgQSt+P4aNLMqX56wB
 SWbLJ6GZwVvpZz6udveJg+SuwxQ8/yAnYuy1griDWwfQE3/pN2o7qtg1jCfLh3qTKPRUNN3cYrb
 IvrR4dBTpFOBXSCOpzFf6Vf2GNiTpsBfCTmTQBCpEHfukjHLCJ7SnOUA5s0G57YQ0y3mzF0oXuW
 xZZJUR19vdEiUc6Od57NHsULjnuePCAUcJal5yb56ov32Z8sfFhdZq5cWZAX4nnqOdKS0zG9ez4 5VKjj2h5MtF98Aw==
X-Mailer: b4 0.14.3
Message-ID: <20260508-put-task-struct-many-v1-1-8341c18141a6@google.com>
Subject: [PATCH] sched/task: always defer 'struct task_struct' destruction via RCU
From: Alice Ryhl <aliceryhl@google.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, Andrea Righi <arighi@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
	Changwoo Min <changwoo@igalia.com>, Clark Williams <clrkwllms@kernel.org>, 
	David Vernet <void@manifault.com>, Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>
Cc: io-uring@vger.kernel.org, rcu@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The sched/task.h header file currently exposes a tryget_task_struct()
function, but it is very risky to use it: If the last refcount of the
task is dropped using put_task_struct_many(), then the task is freed
right away without an RCU grace period.

This means that if the kernel contains a code path anywhere such that
the last refcount of a task may be dropped with put_task_struct_many(),
and it also contains a code path anywhere that tries to stash a task
pointer under rcu and use tryget_task_struct() on it, then if they ever
execute on the same 'struct task_struct', it results in a
use-after-free.

The above applies even if the RCU user drops its own task reference with
put_task_struct(), because if that is not the last reference, then it's
possible for another thread to invoke put_task_struct_many() and free
the task less than a grace period after the RCU user called
put_task_struct().

There does not appear to be an actual problem in the kernel tree right
now because there are no in-tree users of put_task_struct_many() where
refcount_sub_and_test() might return 'true'. Io-uring invokes the
function from task work while the task is still running, so it will not
decrement it all the way to zero. (Note that if I'm wrong about this,
then it's probably possible to trigger UAF by combining this codepath in
io-uring with the tryget_task_struct() call in sched-ext.)

However, the current situation is fragile and error-prone.
- If you look at put_task_struct_many() in isolation, it looks like it
  would be okay to call it in a situation where refcount_sub_and_test()
  might return 'true'.
- Similarly, if you look at tryget_task_struct(), you would assume that
  you are allowed to call this method for a grace period after 'users'
  hitting zero. (If not, why does it exist?)
But if two different kernel developers anywhere in the kernel make these
conflicting assumptions at any point in the future, then the combination
of their code may lead to a use-after-free if there is any way for them
to interact via the same 'struct task_struct'.

Thus, as a defensive measure, we should either make
put_task_struct_many() use call_rcu(), or we should delete
tryget_task_struct(). This patch suggests the former because it does not
change anything for any callers that exist today. (As argued previously,
the body of the 'if' statement is dead code in the kernel today.)

The comment in put_task_struct() is also updated so that nobody changes
its implementation to only use call_rcu() under PREEMPT_RT in the
future. The current comment suggests that would be a legal change, but
it is similarly incompatible with anyone using tryget_task_struct().

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Including sched-ext and io-uring in the cc list as they are the only
users of tryget_task_struct() and put_task_struct_many() respectively.
---
 include/linux/sched/task.h | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 41ed884cffc9..da2fbd17b676 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -131,19 +131,25 @@ static inline void put_task_struct(struct task_struct *t)
 		return;
 
 	/*
-	 * Under PREEMPT_RT, we can't call __put_task_struct
-	 * in atomic context because it will indirectly
-	 * acquire sleeping locks. The same is true if the
-	 * current process has a mutex enqueued (blocked on
-	 * a PI chain).
+	 * Delay __put_task_struct() for one grace period so
+	 * that tryget_task_struct() may be used for one
+	 * grace period after any call to put_task_struct().
 	 *
-	 * In !RT, it is always safe to call __put_task_struct().
-	 * Though, in order to simplify the code, resort to the
-	 * deferred call too.
+	 * This also has the benefit of making it legal to
+	 * call put_task_struct() in atomic context. We
+	 * can't do that under PREEMPT_RT because it will
+	 * indirectly acquire sleeping locks. The same is
+	 * true if the current process has a mutex enqueued
+	 * (blocked on a PI chain).
 	 *
 	 * call_rcu() will schedule __put_task_struct_rcu_cb()
 	 * to be called in process context.
 	 *
+	 * In !RT, it is safe to call __put_task_struct()
+	 * from atomic context, but we still need to delay
+	 * cleanup for a grace period to accommodate
+	 * tryget_task_struct() callers.
+	 *
 	 * __put_task_struct() is called when
 	 * refcount_dec_and_test(&t->usage) succeeds.
 	 *
@@ -164,7 +170,7 @@ DEFINE_FREE(put_task, struct task_struct *, if (_T) put_task_struct(_T))
 static inline void put_task_struct_many(struct task_struct *t, int nr)
 {
 	if (refcount_sub_and_test(nr, &t->usage))
-		__put_task_struct(t);
+		call_rcu(&t->rcu, __put_task_struct_rcu_cb);
 }
 
 void put_task_struct_rcu_user(struct task_struct *task);

---
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260508-put-task-struct-many-5b5b2f4ae174

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

