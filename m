Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21AF36F415
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135824; cv=none; b=NI4PcuoD4p8tTHQeslRpIUi6KKjToA1NLpqpHizj9QcNaTlLFm5/fx1Ii1V5LkQZyI8dhutBEbHATDCb4Ft/Hxx9qVh9EI5XtLyJ+ZVD4igwVx6nDTyjIMRVC1g2REgccqqV8CtRtXDRjDKWjFi1ayXilPEERPdqVFem90qEOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135824; c=relaxed/simple;
	bh=c9hUQ9kAAl2b2IbncqDZq1k2ejJxuc1g83EyvfAIkis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lrGmpBIxGnEzjZsDK5ZaKvCmoJSlRtmsC7xI2rUHkibTa0ByOG6R6cIOrfrdpMkr++wPjrCTeYVW+DDcl2I6nFgcfvlcISo/9YyB/iyy2G6w2gYKFIWhxGvsmR0hhMVKfH9jU8VQ2lVy7kGZ/jeLPDyrpzXpc+JR2w4jMpSa+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=sEj2yrKM; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="sEj2yrKM"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6e4so8995856d6.3
        for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789135822; x=1789740622; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=twz7P/UgrzFqFrDTfXn+06wBF94/L3aT/pnjRwe1Smk=;
        b=sEj2yrKM7LoiGvXXSDui3Yxt5Wo/1EAqnB+2TdmNcXflZPU60rM43QcsFv4ZHamil9
         4ayhrtRrWNM0eNX7VYyGD1qP1DMWKpMasBod+T7NtuUMErnnsaPugiS6aKi2NWDgzPkp
         yj8uz+0fLaoT9SjMBztpGaCsf2VJVBtqabmEIbzjqV29Xg4niZH7X3jkYsY4E1VhVkbK
         qLBVpJQCd4zxXf+qYieoaox3qfHFPQECzTl3v4eGLsectK144EtZ694cKEFe5cNOwKuG
         T2XACnlZMJmYirbCTjK9u8P6lfbJTHSH9cETQpiXvhnPde/KIfwPkz5LDYXIVk8LDY/H
         o+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789135822; x=1789740622;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twz7P/UgrzFqFrDTfXn+06wBF94/L3aT/pnjRwe1Smk=;
        b=gyWLfRrFamSLmbNS7E0dMUmiR/oJgI4yy262FfBTnw5NIdQSZq/Xj+iykOv4hdKBtq
         NY3qP/dQvjVX0j1vYg7SgL9hjWkZGhlU5LGlFXZnfqN/hj+q6Q0UsyXnq2mmsKz0jVl4
         rWCRxjmU/FeZrFVE1rKSdl1ofNxA09RUcKAgVWPJqpqjeVDjC4/3KekqXco/aisi02SC
         dFJKFdB8XE5hBlbHfOvPYP8oTDrJCv4DTUhkvNwjtBR6rtfjuUnkEs2r5xkmLX4I+Q3Q
         Dd8ahsixAf0CHoYl2PMJEtORH5//szVSCHVVaJUEFwU7Yan9dYOECDZhkYHbezDpcc6d
         pVCQ==
X-Forwarded-Encrypted: i=1; AKwUvByiWDU2YSLAiJrstmzLbfja6QVM1jecfnDUXj4rIq8NKYWeZNuxjsYKCGhd5Vj+RvGtZ6U=@vger.kernel.org
X-Gm-Message-State: AFuF++mYrcznRtW08hzOtva5ZfCo9XCPZITvR65OuDNr+SmQvLK6XsPD
	Jpx54EETrTyMrrImcxb3tRL8ciCws57iLhbT2Mz4/P3Fmjr99nZ3HOX7V5uM6LyNI+I=
X-Gm-Gg: AYBFou039WXNdOoldqwS6er3SrZlEKnL6b4zFagul1DIeAilLqNMpDhJPNIbrw94dlP
	uWiNMJNFYSo+AIrHoskX/5OQLhR6RUKNoSUwZfTCibzcRKwSj2X7MJfdjfoxnNLOIz2XjsFg2At
	769VbqYBDyP5HfJ3mYo/0+3I9dLKR6NksUSISsHEwWQyBnIIWpS67jIfE/Hp1Vd8u1Y3pydYNaj
	QS+q39Pbiib8viQmcFP/N2v+far2vpufm5eqdimnn72r0G1Xdw48x7xlCTCYJhhh0to1Tr8hPrf
	xlT1wDLXlQJzQiB6UrgbYJ9M/hIdrlTKG7vyDdl6L9ZOK1p1OdGwI7XE7bhQjKLNBN5jXzDMCxj
	iWDv1ZD+ZhLVWXUfduWj39Uhsp+LOyzXoN2RFoHM2eXRoLteqdT3r2svOB/Xl0VFmAICbqirhIX
	s8wY/vpNl/4VfBA9AGBmTok2EEqc87R4hrzUUiSeBh6UKQHIXB5ihvXwu/82viKOMGLvKJuedhV
	HeaHHrHlJyVcJ9ChPWhmmn5jC22EgUn1yjyS9+uZfagb54q6mVPpB+t
X-Received: by 2002:a05:620a:690e:b0:939:639b:2e1f with SMTP id af79cd13be357-939ea04922amr525733885a.7.1789135821311;
        Fri, 11 Sep 2026 07:10:21 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80dc002sm248697485a.39.2026.09.11.07.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:10:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 11 Sep 2026 14:08:50 +0000
Subject: [PATCH RFC v2 12/15] rcutorture: Bracket Tasks RCU readers with
 trampoline nesting
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-rcu-tasks-preempt-qs-v2-12-eaaa61ed2da4@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789135737; l=1492;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=c9hUQ9kAAl2b2IbncqDZq1k2ejJxuc1g83EyvfAIkis=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDpeCdAsuDTbsWwi8oqAy5KN1IjS7Ye/ysM/qLEJAJ0SGsvHuCkttXUFQ2AlX09A0IwbwXmGUQ4
 qHaGMzc7/Vgg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

rcutorture's tasks flavor models a Tasks RCU reader as "any stretch of
kernel code", and rcu_read_delay() deliberately preempts inside it to
check that a preemption does not end the read-side critical section.
Once preemption outside a trampoline becomes a quiescent state that
model no longer matches what Tasks RCU protects, and the readers would
report false too-short grace periods.

Have tasks_torture_read_lock()/unlock() raise and drop
current->rcu_tramp_nesting so the reader models a trampoline, which is
the thing Tasks RCU actually guards; the deliberate preemption inside it
then continues to be, correctly, not a quiescent state.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/rcu/rcutorture.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 794937e13e7c..df6dd708cea7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1144,11 +1144,17 @@ static struct rcu_torture_ops trivial_preempt_ops = {
 
 static int tasks_torture_read_lock(void)
 {
+	/*
+	 * Model a trampoline: with CONFIG_RCU_TASKS_PREEMPT_QS a preemption is
+	 * otherwise a quiescent state and rcu_read_delay() preempts on purpose.
+	 */
+	rcu_tasks_trampoline_enter();
 	return 0;
 }
 
 static void tasks_torture_read_unlock(int idx)
 {
+	rcu_tasks_trampoline_exit();
 }
 
 static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)

-- 
2.55.0

