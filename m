Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576D7381AFF
	for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044416; cv=none; b=G+rrTPoEdqDbdNWuHcx5jJD0AS+uYnGOH5o0yF7kSZHBfGb8hCidaPPMcgAH80kOA/JT9RzB8W0pko8Mg8o4UPyaBk2i/qvkmUi7xvzDHQWzIFD/8doCEkMr6Ix9dXjTyDDwnEpeYCBV7YvZXZTNBtvbULf577R0clykfh/YOXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044416; c=relaxed/simple;
	bh=O8YdW4YSHUYyF3GwEQN16WzJM7UkZZFfh8RzVwv7xJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dWy/pEwKOxtHeh0l47q295bjVxhEvvhnbU2NZVs/mVJouNZ2Qf0Kjyp7n8ocvpYiZGWYicxnEgIyXi1WfiMaeWcZfM0LhtD+EVw15qWTLCL43I5BsVT7EjKb+4VHjRbDpX5YvPN1xaIbUQCwls3wHzE+AJUyNKuJKy6mLoHX2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=qnop8KF3; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="qnop8KF3"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5308fc4b716so21451511cf.1
        for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 19:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790044413; x=1790649213; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MkP56mJgKixcgLXoBxrfzz0NyJo14L+hjKFrNfKE/2k=;
        b=qnop8KF3/xW7MwL1cIJXYaz6P00OjjBFrfHjtnUWJtITYukvpJlNeH67b5oRueMoeN
         +9iNeNuROHtNBwVOTMxFGCYqdea5MgnfuzTmuV7+Uyo0h97iJRgpdNvB1Zl3SXORxe/6
         UFXPHDHz2UTjAK3LnoIlPD0HJW460Ck1CYDtKPikLXiurZkm7bRXd9XLl7PMJSVJGqPu
         Vm/c99t9vVQgjsuKmh7g9c+oi5FWSwaSdqjES/dhgofRGDi6Iu9GPbDAPpR1Q44b/oMv
         a2JxoQUU+ci+gBPzSJpVIHq/QWMAcxnJYplsZ3xVsgDXF/VJ5YBP+po7IIbHbnom3PE8
         iIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790044413; x=1790649213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MkP56mJgKixcgLXoBxrfzz0NyJo14L+hjKFrNfKE/2k=;
        b=DpAniBjLnvWkUReI9fjXQau2h6+fM0NmmfV/ErUB+4yX1GbDaJkPsmCetGLNO06DO9
         dtJdAV2jKtvtoXPTXFsxHd1c25fB0Ik492OplWBKh3awiKrCecsIBHrYdHTPHpVCZ1QJ
         RoiqnIOiYOwg9hbiIKxM9u3WJRUViuvBTFjx+Cjdr5ZCUeillFQswHjeD4YfgJpWgbGy
         JOq0B0QLwIQLsW8D8QlJHTmhHROlhSJzkRdbMte71fTSDGCP9H5G1lg69gDRgO1jBCow
         vOA4bkPbVg1EoHCHqSzAni2c/qWBIoOsBQLEF0AXqL37m0GnzOyOULEfvVht+BrLS4ah
         SMMA==
X-Forwarded-Encrypted: i=1; AKwUvBwU7cBMZRvtKpLgzkeLfxKwguMdNso8NIAa5VUHmDldwUuMSsD+KBhrP1HxemIL7t9Lnsw=@vger.kernel.org
X-Gm-Message-State: AFuF++lN97sGG24id+9IDGNkjxBWioxNhEOQkSd+/AnliA1g/AkQXCNy
	v+fWCyMjzvYRrCCI7UyKfaLobTYgY+yPKWaCFtqA3iOTrVjwdulgmdXMdX6yy1+7RMQ=
X-Gm-Gg: AYBFou2bGwsBi83IAD25ZpUvOXS3Jy4stEakzBmT4OYJ3nx1G74wyKcibqhvKLwUcfH
	erRui+O83pBdi3oE/f017K/Hc6XgfIPzeiKN7JRu7+TugUC7UbJj0LYhFLjQIdwethlzNWs/X0c
	HLGjNNvlLIeQ1DAWNcE1ZoJFCKBkU2Z+ZvOugBLg0SQOGk+Pj6WfmvPT+JYoWq8bU/yxVsLchj0
	CF7yJ6dZycknqq4rDcBvrAJgzCziHE8XqT+tx8Xtfr9JuupIMtlZ27zzr/hjlhVQHjJ1K5qmdPJ
	ZQgnKgwCbVjsqwxwFG4AQCp5k1jCDjujsuaImunJHvY8p9ThI60AGclwSbxwn3IjbAJT6/jSoW6
	7c5SMBg27mbvttMbylivIKz80ogMsnL3CvJSh7FbaOjkizpIbhKnAfvO2hvJTEw0xzFmmZcp0iR
	qqmtB0HA1DeHUeHoV18b4JSdILV3U8Xnir5Ug77sgQF/++olyEseu6woa5vw0IbRTFN9GukGKM/
	i5ZOjeXJChvWBdk
X-Received: by 2002:ac8:5a12:0:b0:52d:cda5:abfd with SMTP id d75a77b69052e-532d8e10f9amr37728211cf.38.1790044412692;
        Mon, 21 Sep 2026 19:33:32 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-914024ee211sm4656006d6.34.2026.09.21.19.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:33:32 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 22 Sep 2026 02:23:30 +0000
Subject: [PATCH v5 11/13] rcutorture: Make Tasks RCU readers Tasks Trace
 readers where required
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b4-rcu-tasks-preempt-qs-v5-11-410f57770bad@toxicpanda.com>
References: <20260922-b4-rcu-tasks-preempt-qs-v5-0-410f57770bad@toxicpanda.com>
In-Reply-To: <20260922-b4-rcu-tasks-preempt-qs-v5-0-410f57770bad@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790043820; l=1716;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=O8YdW4YSHUYyF3GwEQN16WzJM7UkZZFfh8RzVwv7xJM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QN+SSmbqaUDY715i7pHjObQRKDl/n4FuMBV449sPKr77qotFd+q5BWjod9YbtBMN8iSeWuFGbqu
 3faoKTTHOvw4=
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

