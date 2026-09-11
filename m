Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8D33515CD
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135845; cv=none; b=aIthOWeu+71RaRCeahj2UCTpJLszbevtpOgWLnxKZqKAOIJYbBzVxSBHd/dWMhIzaCnU5QaaK4F9XQu/mcKVorPyj8v8UJQOHAmSc4+q/E9C/cISy/ysqLc+DKmyCpKkatzPZkqN4Dak+BXOoxYhpUHGyxW2W+Jl58nYXGMDRlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135845; c=relaxed/simple;
	bh=K9+ZKIgsGRgsc959M4tS0rMKOB/eZlOXTQ8Ho0gK2m4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V4eL5g276WlbKBcTPRHZ91z71N8+WjbxppyrjhjT//4GEOZPBGnOT1QaATZ2KtNjbUa5BPHJ1FOEbOhhl6kzjt1N2of6pRArah0PzABKDoZDWIqIXvinziar5uYrSQPr/KwzQSFhK/MxK1bcPKeJxPevxTLuZ7E22NX5mQSAE5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=DlojXtNQ; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="DlojXtNQ"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76798a2so3010921cf.1
        for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 07:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789135842; x=1789740642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qrCxqh0lkRJGK/msNx4sQvIno2OGGDXwsMjyZ+inPRg=;
        b=DlojXtNQUMI+4RY2899Vd4IPmVGYjdfubWPeJfZpIUvjJBU3wym3CQSinEvyvDr9pK
         082SvIG7BLzZLFY79cZL8B70om+Olx3fXxpAcQQR1qCc591L7hzuznE4vhfcDug9oYzN
         Nr2s2ZDFpiRGrI4U6t3n8BBycDUuL98yWwZaNenafr0YfxKl8p5iZtwwD+H5tGylC0ct
         r0vS+8Sfrp3pA0mXnjnnJCktcs+aqWnZCuT0uONmPA/cwW3Lx0yD3xB0L3dhCTO7sASw
         wE1kkzSkDG1EJ1nLU/KszNnGOj1bg3TQDvvf/zzzO5i6M4HjgFs7HaRiQ3jZqZRXMvvx
         Cg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789135842; x=1789740642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qrCxqh0lkRJGK/msNx4sQvIno2OGGDXwsMjyZ+inPRg=;
        b=WBVycrVGO3Qr5Zoe09W9WAOOLwFcUzOtU7JIfcsS8B5oHauhzUb5Yf/6H29mEA9Y84
         zla07rX/m1K1acPe23YA58In9jEQor4Rur3inNdzSnzMqTYFG6TBofXw2FvYVCwjE9Q3
         sFLKoLNiwa80dW9u/0fdYFFGsl+eZHkc/Qx5hxrCwIt4jZ1tOl59IZhwMfKqxtM9ROlL
         hZzGMpIU81VP9KLgvn8AG2StGqjNHfqgQOp9sgKdSlCFDn+pxvc5xTvix6ipRpd9WRBT
         QJvOeVopEhPoQyRQ8B8xbrxwMpCcwujq2RBAI+Xgp51EiiY9lK6Y9vPlZz3os3TrGihc
         GBcg==
X-Forwarded-Encrypted: i=1; AKwUvBwZNMBsBxc6US1Ct18bSVfwtGNWRPkfvDdvufKiHOT5Q+4+esUXSLq20ySwNzmcxHxZ620=@vger.kernel.org
X-Gm-Message-State: AFuF++lw0+sfKNcFXikalGXRm/zzQAyHNu3fCfK0qSDGKr8FQTUSDEUL
	GMQVXdCRevyftBXVygPm+GGORtlvfGCJOoXByTGZLmMJFWi8FsC1vuDeMUYsBH14/L8=
X-Gm-Gg: AYBFou0nN/S6T+5uMRPVGyEMFgmNHE5tCVhn5s/fbGrsmCTdUfkB3SVLFmiyiqS4jk5
	GVWYesBpYZwqDLIlDKCF4g0/VyHM4u/YKxw5hc0j6QS6s7IvTtHsDZaKSw0k2TCW/l69j0MId/D
	+KZHxGn+oZsG7LJU93M8inXNU0qBztlClHiaht4+eckMQV12WKIirkwqUe4V4x00viwMjXriibX
	bSW7fCTeNlsUj8ZB7IFirp01afrqwiOD+LWpMY5LEFDOgufm2UGWxpM0/qASP056RQq4Jk4Vt/q
	gkFwi7hSjISXQwz/0rKAN4vGHOOB9MpLfR8hoWl15BXPw0HeufJpXVCQ5m+iDA/3HESYtEUD2Cc
	74ytAjfHiwUxR26Hei+a0h5/8dsZLm3XDqiA0qleoly1YLsaz73qlgl8s3gKe4PkA0U2bGcShjb
	3fFywi3ET0wIy1uluc+Yk62a+MSPJt9kKNTSFPN/hTJJ+1x3Ob7a3kRNbDnwLEENzIG3oJA88MY
	qDx4UtfF6LkI9bz93m6ZqQ+G5K5uDpfiA96o2sqfIx4UfiYJt8K8M9Y
X-Received: by 2002:a05:622a:53c5:b0:51c:b98c:f772 with SMTP id d75a77b69052e-530c86f6195mr51379741cf.15.1789135827987;
        Fri, 11 Sep 2026 07:10:27 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca460a32sm20960711cf.9.2026.09.11.07.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:10:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 11 Sep 2026 14:08:53 +0000
Subject: [PATCH RFC v2 15/15] rcu-tasks: Kick running holdouts through the
 scheduler
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-rcu-tasks-preempt-qs-v2-15-eaaa61ed2da4@toxicpanda.com>
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
In-Reply-To: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789135737; l=1790;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=K9+ZKIgsGRgsc959M4tS0rMKOB/eZlOXTQ8Ho0gK2m4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFxu9w6oKo935Kq6bYpzSj4sd/pud6qAfpTImYrmpDnci7BPIoYh09XWotebu7q/uE6z/VGg6k/
 nk0bYtqCcqAg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A holdout that is running on a CPU with nothing else runnable is only
preempted if the tick acts on rcu_request_urgent_qs_task()'s flag, and
there may be no tick.  Now that a preemption outside a trampoline is a
quiescent state, have check_holdout_task() call resched_cpu() on a
running holdout as well, so the scheduler IPIs it and it goes through
__schedule() and reports (or, if it is inside a trampoline, does not
report) its own state with purely local ordering.  Nothing reads a
running task's rcu_tramp_nesting remotely.

Only under CONFIG_RCU_TASKS_PREEMPT_QS; other architectures are
unchanged.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/rcu/tasks.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ba432bd922e2..02d2592ab7a3 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1038,8 +1038,18 @@ static bool rcu_tasks_preempted_qs(struct task_struct *t)
 {
 	return task_call_func(t, rcu_tasks_switched_out_clean, NULL);
 }
+
+/* Make a running holdout pass through __schedule() soon, tick or no tick. */
+static void rcu_tasks_kick_running(struct task_struct *t)
+{
+	int cpu = task_cpu(t);
+
+	if (task_curr(t) && cpu_online(cpu))
+		resched_cpu(cpu);
+}
 #else
 static bool rcu_tasks_preempted_qs(struct task_struct *t) { return false; }
+static void rcu_tasks_kick_running(struct task_struct *t) { }
 #endif
 
 /* Per-task initial processing. */
@@ -1219,6 +1229,7 @@ static void check_holdout_task(struct task_struct *t,
 		return;
 	}
 	rcu_request_urgent_qs_task(t);
+	rcu_tasks_kick_running(t);
 	if (!needreport)
 		return;
 	if (*firstreport) {

-- 
2.55.0

