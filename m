Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A1E4EB86C
	for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743023; cv=none; b=eBAj/NelKw0+baQwVK0qNK27hWN3KNHCB6A1Tbrci7f1R9Lix8GHSkA6r45LwbNO4sEfWW30+ZgkOLttBFRs43e9ZlzO4ahwbKH/kEw43k3eAonq6qd/mNkkvhLVs4gEC98zQ+tw/4yiuHcqO20RzhZarKFN1pM60u6e7xKpR1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743023; c=relaxed/simple;
	bh=FRa7j81kn+FZifN+tU/RXt2NlHMQaOXWqjJvWoyULIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bjd1nvOwsO2S81JwEb3K3/HN0lE/GDDX7G7XKj1BzxtOIfSVn/lNGRbUpXhnJRTz8RbR7Xbe1RKO2AfbsNnrYbRXAU/HGhLeXOg8Rty+s34epSwmtPyGJzXXU3WFiDF0Pb8U6bCDM4HCN7DQSGd4+0vqcDAjpMkKDfH+RQL8R7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=eaAruMPi; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="eaAruMPi"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-910704e63a9so3889256d6.0
        for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 07:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789743009; x=1790347809; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z+PbvTl7j6crAVqwwSi1N6wOs6bBuNm88XPaAXlYwG4=;
        b=eaAruMPiqNCETlndUIMEsTI8wwe4IyMYRp7IY+Jq1Pz5C6glptp6M48r3gAtXl3R3o
         o0mk+4/fYf/RyVbjMLlqirV3r0k7aLq8D3SJBS9TnmTyroJxI1lWFXcCmVmMQh49977z
         6BQCEXpuZs7auPVq7cO2mxTj47CQGQVRNaycwaX/MxEuIHuS5LluhN/YiJkMHk4Mwv2V
         o7U9rfACfUocBZcnkxbCCUpznnuADY5zCOTAOYF19t0uxRlYXEoRTgNXQZgU5edp5tMF
         Ls0N2NnNmCjfe2UterERkyBV/iPZwAwtdi7ArbkvvGykip2Bk11CMa7dpDOgmU7PrcuI
         bjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789743009; x=1790347809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+PbvTl7j6crAVqwwSi1N6wOs6bBuNm88XPaAXlYwG4=;
        b=UmxdeX36LJyFZcWMGYF0VycJrl6Cda8ozFSv5ryK3RElfN6Hrmrhhb/g1Vd1bYBQj3
         2Lf4jqd/l4RZeB3qfS2HECK9pxz1AiKiaCL2j2Ct1WPkrX4DKKQRq2So7CN/D/SZlorV
         4jtzCL0ZqOxM7R1OJWuUrsEkyYU2FPJQWQpqhv6FjFN4cRBA+0LHooo9TA53KdIGZuqt
         WwfDN4ItfeW9xAIHULkMIv4yp+h06gqNGMcxV6KhsKahztwx2rTMuAXc+mFM7pdNgHn9
         kcGF0R034OQ49DP1j22amIhMBTPnGHOMbCwDzk+hYAKdix1CfrnuhoHBO5Yk48Rh2rJI
         xuLg==
X-Forwarded-Encrypted: i=1; AKwUvByO/DUOQ1LDotREylCxJeSS4BgY6kRwWv7YER0xHh41Z6or0fZBX/fKFzswJ3h6ksbCaw4=@vger.kernel.org
X-Gm-Message-State: AFuF++lnT26+LtDifp144wlvo0CCVEvB0EAO3/59zFkL86mPNyKALHEC
	JqW010lQqFnls6usqfm9ySBOPTIthOnn07kTTR1JfCoflfSpzYroJwFaTtW4OsqY7Qc=
X-Gm-Gg: AYBFou2TlSo0SmS7fTGQLg/aEHvB3/avZ7OlcoxVYmDCEW0kzv2j8SI6e+R4/lIy2GU
	n8I/YG9cAOdazZXfP2FU/wxnBiQ77ypYy2/vscNmf6z9LxLqz/M1lDVNdG5XmPuHktuylwFmqE9
	uhptsaFRfujGXGpKJrhBxRiljPV0n+irApMrFNeiPKpkV2eNjTFqshula9UBtxnJEVmUNFIRM/7
	2/iVsCZsiV7gB76kC3UuCukDyCYAeaa3Sokj4HDR3TX+iZ+uJuiFQFLuHuZrye2rXNMFfGopdIi
	iFPmb3ySVrS5Qgo0zRa1a/09Z4VLUOmzoH3tmIiL9xRJxDmfCkWDqsS2BfgyN1XvMAk0J+4gx3x
	CC/iFeBWityg9C63WMZefX7USuvuzpNQTVj7N6IKF0IgPj7NQ0g2SEGC4eEsKEoo797KI3GJZ2V
	coOQqoQ2Rd8QncMmsn5Np2b1LJB8e2iXGrsQnWcE+qyemDqpA8EncOiCE3fSzQHpkACT4i+5PBs
	8e08aXmSE+V1pDAMVm5KdnZrXSq712J+uNdyBmGAsxRbj8H0jINkGmg9A==
X-Received: by 2002:a05:6214:ca6:b0:912:3d05:eb11 with SMTP id 6a1803df08f44-91254e4feadmr40041586d6.5.1789743008667;
        Fri, 18 Sep 2026 07:50:08 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9125802d79bsm13900886d6.24.2026.09.18.07.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:50:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 18 Sep 2026 14:49:31 +0000
Subject: [PATCH RFC v4 12/13] rcu-tasks-trace: Assert no reader is held on
 return to userspace
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-b4-rcu-tasks-preempt-qs-v4-12-63f0e9d69661@toxicpanda.com>
References: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
In-Reply-To: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789742980; l=2581;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=FRa7j81kn+FZifN+tU/RXt2NlHMQaOXWqjJvWoyULIE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAsi6H715Q7GMOS9YXNtKesBwx2lesjeCIIWVvPLg8W7bMTSPfSKqF2zG8KnHJqpv18BR10X5Rc
 7g2eq40cmPAk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

With trampolines now taking rcu_read_lock_trace() open-coded from
assembly and JIT-emitted code, an unbalanced reader would silently
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
index e19b41ee6b18..d42568a488a7 100644
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
index 273c59a03251..6034c6b19479 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -211,6 +211,12 @@ unsigned long rcu_tasks_trace_batches_completed(void);
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
@@ -220,6 +226,7 @@ static inline unsigned long rcu_tasks_trace_batches_completed(void) { return 0;
 static inline void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func) { BUG(); }
 static inline void rcu_read_lock_trace(void) { BUG(); }
 static inline void rcu_read_unlock_trace(void) { BUG(); }
+static inline void rcu_tasks_trace_assert_idle(void) { }
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
 DEFINE_LOCK_GUARD_0(rcu_tasks_trace,

-- 
2.55.0

