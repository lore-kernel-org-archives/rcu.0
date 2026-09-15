Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A199E4A3F0D
	for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478296; cv=none; b=L5tKuaKbagFhTSH3rA4XVrxwpzyb17E5Ahk0Ifu3NCPmqW7BoFsRqkw8Tbmq0XyFXup4tevaZ9h+/SWqBxIp7NYThu7QcOZqjVUeo9KClVSdgSFg0JWHVhIXehV3te+wuCl/+ODt2COVfybECGAe/eP3x9C2Jhtehmc/2T4A+Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478296; c=relaxed/simple;
	bh=a8x0095kiaPfODWOL6BE+0O7E5TXMNLRrf+m1qUM63A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dLYoV3EUM2/3jKrMph6elCSALE8UAqU5J94P7SKu0tWZWEqGKR00QwrANqNp0arBk4HLbzMYARSx9bKrsBKZyrWsn2atfAEgBhsj4Vzbf2d82/Fc/tSZfhBI3rM8AmClWytD4w+j0OopV01iQD1kTKaYxzjrX4prrMHi22rRMQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=GcHM5kne; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="GcHM5kne"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76ef1d0so33567731cf.0
        for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789478290; x=1790083090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4AdtdE/dNeJhNnC7k2tL4hzZr80UNkNMTy9M8Z5zSRM=;
        b=GcHM5knei46u64fvgeHMLZZx4CC/aABYu/dUG4fLhVq+Hn1pHHoaqKChILqst+JnJN
         QFv+pN4eoXxbWbi+yd75J4Fc4Lp00WxoeewVk7ba5YRVhHCVSSsQZhSCbyJvltk0ruC9
         bzdeWyGSqWxVM3VY6BwDOQLyNbqZ7tBsAs3bx5RjawGGHkUx+Zo+EwHsgKa1yWCWiULQ
         sATFcDXQYBW0UHT+wz0aTjzmxw6UOhYRywOrto5iu92XbxS67ZrLuHb+vnaa4rmeqkIv
         gNOe4L7qpas5zIicX/Ty0gHI2mMIGfHFVK8OqCjUosGmtLdzfKPM76jbdHpQu0dDtCgk
         NpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478290; x=1790083090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4AdtdE/dNeJhNnC7k2tL4hzZr80UNkNMTy9M8Z5zSRM=;
        b=ipAEpHty5WlVLJxlfDuuiqfW2Brfh0jJHOBhn4TfP5OJqbGZ5xdNhiC+b96jAp5PW8
         sRK63x7JfPZfLUVoo+FSn1D4D6BQZMTP0gyL1A8lU4ru6rmkuMrWK/3JK8miTd9TMpbM
         7yFMKCK8d0heMSBeYNldQOpTIWiYi5ynJiAsqbwPl7AexC6OHZ59Y+0J4+d7DHFtC9A9
         dmBhtUiqLy3zCs36w/8WMLGAy+YKmJ3RdLf5/sT/WDsTPBSl7m6QEENynRF80F/M89jA
         i5QzuIssy8eXkdLrEqaJur5YyL0tQNs2OMSDT43tQnFXRKTyur1kxJDMK8/VUiUjPfwx
         KFhA==
X-Forwarded-Encrypted: i=1; AKwUvBzYMHxuPefx5bHZIEqnrxCDyi/AYf0j75VRKaMVhXr2zz3JUZy+S4nuMPDbHQaUO74Ypjk=@vger.kernel.org
X-Gm-Message-State: AFuF++mmZVIeK86sdPQa8B9JuozjiMM5O2JW9bXisVksbAinTvasvuQS
	Losqw1jYlfkig1S11HjFAfBgig44mKAWowjl42MJMMEiO/281wSPSu89jbXouBQAKpM=
X-Gm-Gg: AYBFou2bWVyPOrZuHGor2bM/foLTrT4eBcSPrkOEtBOsQbyHCtktLW/Azf4iQK6x9mc
	6jwSwMcKqnMvavGsml6mcxN9jWEYAhGhSlUPQwV5nwliF5NMz+Q4mzEIic/JaD94cm6MLk6YeqG
	s9+xnUcqYKnS2IeVmam0mTPUwcmkw1CA58KcZ7r/PyFvQnsodunczy+XSqDTHIEvnZxIctuidL5
	SAtzriIhQUgrAsjZrFlryWduy2xYaAJLL6kePCqXumf4yeNi12zHJ9ZfcEI1l0JlEg5TkvtLvgh
	Jj77YCW4KZLl6hA1LwGY9+ISZBwGf7mXwgnCR3EehG+iAtsf3kIG9PTwts44+XzSj0birbEq8NF
	I5UNb6i/NEeeiXUTNSVuBmdpGoWG9KJdkAspY69MYyjeY1Bj4NXAiSZZV4YMnNwEDSoNQD5ar0Z
	QmXravr9huNso4y1TE2jLJ2VndnwMymu09MdhqdcNrXJJZXCoA0sc/4izIWT9EGdsyTtpudZmm2
	/9wH+nUErfJGKcYtZgRlEPeIahHLnqhmXGHgaLyUUxbPqSIjJLUzpEU
X-Received: by 2002:ac8:5705:0:b0:530:e6b9:f5d9 with SMTP id d75a77b69052e-5310cf60dcamr104610221cf.20.1789478290432;
        Tue, 15 Sep 2026 06:18:10 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53104165737sm56777241cf.27.2026.09.15.06.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:18:09 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 15 Sep 2026 13:17:39 +0000
Subject: [PATCH RFC v3 12/13] rcu-tasks-trace: Assert no reader is held on
 return to userspace
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-rcu-tasks-preempt-qs-v3-12-0ad30c4c5ee7@toxicpanda.com>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
In-Reply-To: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
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
 Xu Kuohai <xukuohai@huaweicloud.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
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
 xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789478262; l=2589;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=a8x0095kiaPfODWOL6BE+0O7E5TXMNLRrf+m1qUM63A=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNQ+h4Rgq+uBTWY42BKURCuzv1XjZ1QDbD5nWJycO3HnjSRSDGwSoVc9aADl5pV0kBRcRtS0O1v
 XzhUhrtoXcQU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

With trampolines and their glue now taking rcu_read_lock_trace() from
assembly and from several C paths, an unbalanced reader would silently
turn every later Tasks Trace grace period on that task into a stall.
No task can legitimately reach userspace with current->trc_reader_nesting
non-zero, so under CONFIG_PROVE_RCU check it in the generic entry
code's return-to-user validation, next to the existing kmap and lockdep
assertions.  Compiles away otherwise.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/irq-entry-common.h | 2 ++
 include/linux/rcupdate_trace.h   | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index b811b469b0a7..58086cc1140c 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -5,6 +5,7 @@
 #include <linux/context_tracking.h>
 #include <linux/hrtimer_rearm.h>
 #include <linux/kmsan.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/rseq_entry.h>
 #include <linux/static_call_types.h>
 #include <linux/syscalls.h>
@@ -214,6 +215,7 @@ static __always_inline void __exit_to_user_mode_validate(void)
 {
 	/* Ensure that kernel state is sane for a return to userspace */
 	kmap_assert_nomap();
+	rcu_tasks_trace_assert_idle();
 	lockdep_assert_irqs_disabled();
 	lockdep_sys_exit();
 }
diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index 4035054309d7..f5a51de4a4ef 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -209,6 +209,12 @@ unsigned long rcu_tasks_trace_batches_completed(void);
 // Placeholders to enable stepwise transition.
 void __init rcu_tasks_trace_suppress_unused(void);
 
+/* A task must never reach userspace inside an rcu_read_lock_trace() reader. */
+static inline void rcu_tasks_trace_assert_idle(void)
+{
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && READ_ONCE(current->trc_reader_nesting));
+}
+
 #else
 static inline unsigned long rcu_tasks_trace_batches_completed(void) { return 0; }
 /*
@@ -218,6 +224,7 @@ static inline unsigned long rcu_tasks_trace_batches_completed(void) { return 0;
 static inline void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func) { BUG(); }
 static inline void rcu_read_lock_trace(void) { BUG(); }
 static inline void rcu_read_unlock_trace(void) { BUG(); }
+static inline void rcu_tasks_trace_assert_idle(void) { }
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
 DEFINE_LOCK_GUARD_0(rcu_tasks_trace,

-- 
2.55.0

