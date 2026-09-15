Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692914A2631
	for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478293; cv=none; b=tqL6IKyTUzQFWUqPO1wIONYixnBu/iPgwcNEWQR69wu113p6wrqpXbyCR8zTPCpP+om9JDDM/MQN76BEq7X42RpnrzwScc5FRn7Os3Z0ZHXtTkuUDpl6RbNC1LgMNjU/3WuFROFQcYtjVY8m7cqtsmJh3g/EvTtLcmigCNsc5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478293; c=relaxed/simple;
	bh=O8YdW4YSHUYyF3GwEQN16WzJM7UkZZFfh8RzVwv7xJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+/xnYCQi/NXxnSLCokJqpXdUF+GqTBRENK6vr3mI82N8crCLb81VhjmNXWP+E/UeV3AaxAHkS5cziiqk3tkpO1A8vqoqz0lr2s3EpUis5RKfivgiWy9L7n54SQkHT3sEv7Yw0J97I0FAgTToDRhfweoqdMj0ruA9gH9vs3yAIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ZNRiEjkb; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ZNRiEjkb"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ca5aa8so365503385a.3
        for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 06:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789478288; x=1790083088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MkP56mJgKixcgLXoBxrfzz0NyJo14L+hjKFrNfKE/2k=;
        b=ZNRiEjkbcxJzgkGQfsEmE4NquJ4MI7P5nVOndUM2EJRYj2e9cl8NvZt4ozVmun1SZa
         iGMGhKrQxzoLhhyYqPCsqrzDETI58u24FiNHJ4GiGgdSSnRkT9v583Vo9UJjwPEtYvt5
         RqqJ5H8H+0JJBi2hxQfPZdPcJd639d0Kr78SlkxOQhBX67A0yrCOYH4LaZoMrgt1pHhw
         3Or1HxFW59yV+SmxmiQBYV7sx8ur02+sgSxuxNAQzbC1tqqaQVRdOuK7m8H7IVRON2gh
         zcq+p9R0oeDIh8dbrHrRBZNnIn4AI9VCW3mYCjZUVoS1s7Lt7tFp9lPBdEoyVk1zHq9Q
         f7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478288; x=1790083088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MkP56mJgKixcgLXoBxrfzz0NyJo14L+hjKFrNfKE/2k=;
        b=WlJEjwNG/HR0S8NqsuisnUtGP4C0DZ/nPawHA6geZhJXvbhEEetLdFyfHo7ERWQxf4
         +lofD0qrA5E6bgVF/kt+yhEF6AY8P9DLkQjBqRhQEZgPmDub88hRLLJzhmU4+zy0ESB4
         auhHomCdhvtnoH4fCZMuEqw/yGsU5hsGdrWXydZHY8OE8e4spekqqNV1DIBZxzYTVLDS
         zoroDR8r8N0sVYeFuu2y9ZKyv6OvcayF8O5foiw32v2nPc1S72BCKv31/VEutYIFQMdW
         ByQEpK5SRYyrs33942pLPns2X2jojfDt5QR4xblB68xRD7O7Yq3eVAclO7LvxoBhTdhB
         W7MA==
X-Forwarded-Encrypted: i=1; AKwUvByctinsb4NtvhTGL1OxXsjYXBd5rT5qU1AjG2XNYtM+B17eSen10hmyTAFbk2aYWyOh2dw=@vger.kernel.org
X-Gm-Message-State: AFuF++kTI10orkiXZhLDF3PtEd3hj1rPWLzOdzwTbaYTpCqTxz1U1HDH
	mUUexBmyhUxhLxIUYMDPLRNmg/t4V5iWVB0P2x0WulF70OXr8B5I8/Yt7tLD8+02XYQ=
X-Gm-Gg: AYBFou2kGqlQWpauo+bxn2zMmjYrofc8J2COqbVNbwgSRVQmr/JDJNv5Opb3FTmAcQz
	dROr90LjFtxiGGZzmLFUemXKdZ9tajGC9RvyJOf/qSwA/7AUdQfugoF2islnwAgNIjumgBOS+iH
	8LBTAbUZE3jSDz6aSfFSHzfOq7ZV1Rm+Cq/AlWwBXeJ/x/XWkwswYImEb9hYMAFwUXYeTESlSFM
	DESuLnoRJdFjkKYkrLI9mW8ZenHr5M2lwx2yiBTXcA3P9OJKp8n6Z/hyUmiCgjsXAQJAVCitRsj
	sCmwbLuQQV2KBU9lCBxgklDw1i+44/759KtMCGiCCL1YBnPtF0TLLGvT1Vnvb59FnOioFjd5DNp
	/R2aNSU1FUQbi3HkV1UlRYTpKsxjvnYza5aglDcGJY4h14CIl+shpOKxx2NsLweJPcKIjLItETp
	iwcqxk3XxYajfLGfN9TVIkUO4NA/hacUXW2K2a7+YhZQfrY/T+a6SAVkWumen/PndKqVzBm3aVX
	Mj8zAq9sVN1RmlkrBe32mgzx8ii9xIag+qXjaCjbPOAWI6JRMFF/x1G
X-Received: by 2002:a05:620a:1b87:b0:92e:76a1:96cd with SMTP id af79cd13be357-93a297e8f8cmr1159268485a.13.1789478288213;
        Tue, 15 Sep 2026 06:18:08 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93a26921baesm489982785a.24.2026.09.15.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:18:07 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 15 Sep 2026 13:17:38 +0000
Subject: [PATCH RFC v3 11/13] rcutorture: Make Tasks RCU readers Tasks
 Trace readers where required
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-rcu-tasks-preempt-qs-v3-11-0ad30c4c5ee7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789478262; l=1716;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=O8YdW4YSHUYyF3GwEQN16WzJM7UkZZFfh8RzVwv7xJM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIccOQgqxisnPo/25JJmyx4Bx5hp1tfVVTZrdfU6SlgArQbvK/ARnj8AAoaQqqIY//mIhN1g1fK
 eVSGZVlcF5wA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

rcutorture's "tasks" flavor has empty readlock/readunlock hooks because
a classic Tasks RCU reader is simply code that does not block.  Under
CONFIG_TASKS_RCU_TRAMPOLINE_READERS a preemption outside trampoline text
is also a quiescent state, and the thing real readers (trampolines) do
to stay protected across their call-outs is take rcu_read_lock_trace(),
so have the torture readers do the same there.  Otherwise a preempted
torture reader would rightly be treated as quiescent and the test would
report false-positive too-short grace periods.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/rcu/rcutorture.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 794937e13e7c..ab870ef09af0 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1142,13 +1142,23 @@ static struct rcu_torture_ops trivial_preempt_ops = {
  * Definitions for RCU-tasks torture testing.
  */
 
+/*
+ * A classic Tasks RCU reader is any stretch of kernel code that does not
+ * voluntarily block.  With CONFIG_TASKS_RCU_TRAMPOLINE_READERS a preemption
+ * outside trampoline text also ends it, and what a trampoline does to stay
+ * protected across its call-out is take a Tasks Trace reader, so model that.
+ */
 static int tasks_torture_read_lock(void)
 {
+	if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
+		rcu_read_lock_trace();
 	return 0;
 }
 
 static void tasks_torture_read_unlock(int idx)
 {
+	if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
+		rcu_read_unlock_trace();
 }
 
 static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)

-- 
2.55.0

