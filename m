Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668053A3B9
	for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702185; cv=none; b=W/QccH01xXAocU9Fgbgy90HbzYnrmsgamS7v67P7TfKT6GAaNJfLwaxNrFFLAZAaB0nNTcdOgCw+LgMM+qp38PITd1DuGK2fen8qEa5DqxQwvNHl2mmpJQzdWlPoc95a3Nw5iuofbq+3fsnOk9O6LfHhxI0Yd2YRDxW/zrskNio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702185; c=relaxed/simple;
	bh=O8YdW4YSHUYyF3GwEQN16WzJM7UkZZFfh8RzVwv7xJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AbbdlJUw4pSyYvDpYJYzzdKS0GCYRzI0NvyIJtH/MCU0oXmTqHtQ1Ac1HRzlfB+bX/Rd3mWOl/kitZJtK8O0PGhBc4K6Cm39uG+GfXXZyeRuJMjegZF3f0nD4nFrYM4ZayYvRe4CBk44IUDfytXQfjE5sXdHkGE3NGJDeyioe4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=SgxugGSK; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="SgxugGSK"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91058dd77a2so42955456d6.3
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2026 10:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790702182; x=1791306982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MkP56mJgKixcgLXoBxrfzz0NyJo14L+hjKFrNfKE/2k=;
        b=SgxugGSK7xX8tGtKss4aT3rvCMbrHwqFkGDiNckBxgTsaTkiHntdXdsaVHyXNcXn/P
         PNs9u7emtMoH/TJ4Od6ZClaH2yXh8C/inKVFhNYXzjePB7FX9YiL9tJwiCUyBpd7aGjl
         p+2OdhJmsb3SRhcvhAEZnHyOw+4G37PapmcAzP3BZxlx1F2x/MNFXQhytDz8Tvo33H6f
         0uu2gpCfiFjN8vtzb1IgSlJ6vlWe7P4vNrrsWRDP1QCrjOmmqGKpldjkhwkE5xCRzJYl
         EZ4tFZLzOh4a1JNBhrb+zPKQRdBdc+USphvwF+mXrtEWDa0aP7tGfflKTTqUOhF4N0TQ
         GUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790702183; x=1791306983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MkP56mJgKixcgLXoBxrfzz0NyJo14L+hjKFrNfKE/2k=;
        b=TwLbwbW6pzPh4UbA4du8X4261oTSKCZXyJ3uZvOVWO4A5BKeLKEx8Ka1gOIMiqF4+z
         PD1EFMtk+MI6en5Zvj6xRi1mS1rsQ6g6ELsEf/z9M57YeDEtRN7tToFG/P61sd/Y+vX8
         yf2Z5mK+bdfwLhXPQwmw5N0G7MRZCwHkCjT4/E+VDrl+HXutf/XHFNLnXnYohblar5gw
         ohE+qNjrbbpANQ1SztKnvizSBLxc8VcQDO+9kHKzSa7+ANmWO19uN/yRBO3yn7U9DGUM
         y016MJMwYtTaMA7oG2OuU6I2FleF/X8TEtlr7Qt25sGjx/k4SaAW9EX1vkf7Zlc17Szx
         kxSA==
X-Forwarded-Encrypted: i=1; AKwUvBylrAR7AFVbgueMGdHwjB/ehhFgOgrpcSbr5YUCabFOD4N/5Zjv/GgV4GAjK9hUxZNMNVo=@vger.kernel.org
X-Gm-Message-State: AFuF++nkoiZuLXuc12JoWTGxfJzX8q9AYPuOwuKexsTgCY2dQ6XY/EEW
	URTIvB20Xju0IC4LM8RipXYWGzCslNFmNTYC5+2r+mt7yGVjqutNCKyEoLC1xVWsCqQ=
X-Gm-Gg: AYBFou1F1l+H4oB1C5RFXqnNs9uzs4RxoVYC1MiODTr9nOlac9Pzu6jMdLzu8EpOKH7
	zHAiUw5/ZjkaN2pW4j1poREGI2sKspIy/XaT+PIb7UCh2YWVUaYRs/d0bQZtBcU4GOluyKIzeuC
	0NsWU+cTElVNdXkK/Ob+8z17VkTTGLiQX+VfCEqrO1OKRf72jim3HhQzejOJZDyl8EnriK86V5i
	/RIBuQBscY1x+eopa+hqnh7zIfkXaAnqZUniyFKlZIQfN5wWRSwZfiSNmiUr3964Xut00gHEixV
	RULXvy8pRE7hPTiYMHlxQaoDmEWE5XAsdfMsVTYexIb+kth1ZGScAZRzCCtYzj2eIkLdBNSpydN
	Ti3E1qT7ly22IIh4aRZ4eabS1wQcoiEJGLr1GhXYtt7bMmQfu/+Xc1ihbFs+ru6tUpCaWBX+LLz
	a+6JsUtxhmgSIKcEMxZ5XJ5jxtK1sg5jXrxCubQjbBkeaag3Q7ELVM63a/UOp1FE4gvpINJnZZz
	x1ahV5sNN30GgY=
X-Received: by 2002:ad4:4ea3:0:b0:917:8c86:6608 with SMTP id 6a1803df08f44-9178c8685e3mr38720066d6.42.1790702182375;
        Tue, 29 Sep 2026 10:16:22 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917981f5c18sm546196d6.0.2026.09.29.10.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:16:21 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 29 Sep 2026 17:07:29 +0000
Subject: [PATCH v6 12/14] rcutorture: Make Tasks RCU readers Tasks Trace
 readers where required
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-rcu-tasks-preempt-qs-v6-12-c111ee02caca@toxicpanda.com>
References: <20260929-b4-rcu-tasks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com>
In-Reply-To: <20260929-b4-rcu-tasks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Boqun Feng <boqun@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 rcu@vger.kernel.org, bpf@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1790701682; l=1716;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=O8YdW4YSHUYyF3GwEQN16WzJM7UkZZFfh8RzVwv7xJM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QG3jQwCkEzXVFZFj5OJPsasIxdbQv9M/HHEGtLd8yZhbdChJa1bb33IuFQ5NDeb24Kaa8oYTn7u
 N5DM7Y1DOQA0=
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

