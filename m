Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4E958B6BB
	for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066289; cv=none; b=Z9K+jNdzJVhiCYSD3xWI03U0uV5cPSO/yHHSoPrv5hTR3K5CjZ3rMhiXMVhh3NK08wauhlfUIn+226HVPNNE/IYqGdq1RPMa6v5/UET5+JKVLIsd0VyjVoJ8QZtelCh7JZL0+wqWd/w2ItrUakj+YZFzay9ms7g+7ad+JlrlOGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066289; c=relaxed/simple;
	bh=c9hUQ9kAAl2b2IbncqDZq1k2ejJxuc1g83EyvfAIkis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QL5vhdGcZB6rqKqT4vL5MdQEh3POurdsHXVxeUDrB2DijbqV6EoB9yWpoIhpi9dAkrd/KtKSmyKPrynV0HVTja0nQZ8C8N/2kcQiFdBUYgybzgirMnwn0kQxauFcFCnxKtsjg+wg4d1GdKLOITq3LBo689H0806W8h+3QfwT5to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ZT+QHQOL; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ZT+QHQOL"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90e7c71f86eso312146d6.1
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 11:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789066275; x=1789671075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=twz7P/UgrzFqFrDTfXn+06wBF94/L3aT/pnjRwe1Smk=;
        b=ZT+QHQOLa6RGP+APk20ltNsal1w/dCUGd4vqqbR6Hed8n7USi7jymaRnDPfJKzWjeR
         YddlC4IFv24U8i/3lE+gBq+f8CzWloCFwVLnzxWUX6sRQyS8B/44SfOw3UQ50QN39jZQ
         1U1Rdjlv5nTN1jGfRs25YlzkPcs6ZkqLYAj4AnmtdaqD545UdHrNXOg8JVAKdcTgNUXa
         bARuoRzSU4qm7HSuRhPOpBtmazV0NRsBtkyzCOD3E1N0N4q0335UD1u5+q6DI57z1C3U
         k4D/pLxaeBOA8D5QRkH6BDIH+6N76IaFQ9YDMnXc67aMXaL0B4ygBBXqV9OCddN0CgIv
         oNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066275; x=1789671075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twz7P/UgrzFqFrDTfXn+06wBF94/L3aT/pnjRwe1Smk=;
        b=fbBAWrV7du379TNPaBu9olLL280GSnR+OQBZtP7bQOQ4SwVUMQzuvCh5RyV5bz4RD1
         3MvPGu42agN+OW91kfOyXKgAgQuY9/q5n2qYmzyxPcxjn4Ah2Nk+jlYQ0L4k2OMVQrLi
         qoYMy8H6IfNMe3kUP4mc20SWRk9ciMeU63WrJT39+CkKkmYP9J1LclqkYvZqHPWlXkYH
         jBpUJGHfxhLtqMlL6YWxjHVsgQ/fmtRtrVXgS+CIWJRBrCkA1obETKqrBLePYQWFGL8a
         hbbo3Pv9ryvNHELsCbmOsSPMHl8egFkKFgCuQCh9jhshQNEFnNGmMVYCqxpT0lsSbomQ
         qgug==
X-Forwarded-Encrypted: i=1; AKwUvBxn1bine0uW5iCIPJKPf44p+oklJpo5awiduk3SrpOV77yS36Qb50g7DGIpgf4vOXSOcOc=@vger.kernel.org
X-Gm-Message-State: AFuF++lvmfJFZX3GDMKdS3Syhk27YasZo4FIz2PNB9Z9zzIF0NEPIFjU
	6x7TQY2SFlKc+4Cz8eoA7e4zP3L6nwXJEGEN/bA7tYR3WJIg9aJ9+/oqwqsBQ2usAAo=
X-Gm-Gg: AYBFou2aKCOUsA2dl9qFfkkSxZEWZNVErsnUFI3sKlXrS7Cx51vonLUdh+Zg+H8rUab
	ABQPkAadobveFMRB3D756oHfFjjA7+HS1TZTtSww4I4anW4lG9Qq0IkwS6gpzUCkemprVW50j7Z
	6Sk8MSRvmg0X8L7OhN+W4uV88qxVVJFyLYyUl35f0q1EEdecl1YmsH5mEWqoXQtgPF5my9ku4UA
	GL5BSrl1xOZCWnL0fzUm+rt0s1JyzRTOCcTID2ewMwsUXwDLmS6srKDh3CHTXjH4dWXMt0+ahg0
	GrOGmWFi3lyOSWht8/iSzDP25XDscoiFQrfOpHwz8VaPxImYj2oyQJ1vfGDbiRbkux4DjSorxLs
	r90LKh08wXPX2M+JZAzmTffq+ufWfnP9+Pu3xQuEZnPCcJLKMI4rqROfpRwutb/RGP5t/te3+s4
	CRmbcoPoj+Y8XGFdlFdf9ip2IKzuEPkxN5JffK71zC42hPTaqCDtAgAgXTETqdV4UoYuRMQ+5Jf
	2031LXpHRbnuoUEpVWxOQDTrMNrpd+rT4y4KIpyBtBPMEUA89fp1w3k
X-Received: by 2002:a05:620a:269d:b0:939:6de9:208b with SMTP id af79cd13be357-939ea2b3827mr16779985a.48.1789066274997;
        Thu, 10 Sep 2026 11:51:14 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f184f5sm49053285a.15.2026.09.10.11.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:51:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 10 Sep 2026 18:50:35 +0000
Subject: [PATCH RFC 12/13] rcutorture: Bracket Tasks RCU readers with
 trampoline nesting
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-b4-rcu-tasks-preempt-qs-v1-12-d4469f4cc101@toxicpanda.com>
References: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
In-Reply-To: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
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

