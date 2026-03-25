Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D213234E75A
	for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429895; cv=none; b=KVW3khACS0xU4Qw7VUH3rp3IdT5jQVaUpw5r04hWB2ljS/NRxx1jKxVxhErzgoKsBU5SZLVotlr7MN5f8+OqVF+0QeGrIiPrdzk+C5lKiVjOjonv/uq7NW00THkDo5Z792DBP9lex1BtSFKoFMz8K9j0ctWhSa6vMHR1Os9rOiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429895; c=relaxed/simple;
	bh=I7peAwba+g6DkhuQBgaU9UnLggjeBQUrKJ0kCB1N/SQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CAVlBO+JF1cmGX/fvEy+QxSVOQiLbUpy7fqf1VEq3tv1YswKvE5ZoZBj5PEFy1Sp2lmUdp2jiRsCVIdu9f5Ve4/2jtEaxoz2SORjc1Qo+ud1gqpQl5XgMcktursI/qZDdH0b2w3MagKRnRWBRXD/jFIOadj/fgJ8wTI4m/4zqpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DF+2xk2V; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF+2xk2V"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so4211636eec.1
        for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 02:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774429892; x=1775034692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2KjID10vkg/qXstgNRvPPvkY3Brj7dL/qNSBa8q0+4=;
        b=DF+2xk2VvlBqpOeTb6EOTiIEb634AjwT5HU8+7tytyLvWi4BxY0fse0AQGOqAbLPGP
         curV0Jp5ptcOPLTLy2uPMBHzgpd2nyiMH5ZsoJHNdL9stXi1kQzwoVl+aTQfGPopfqDv
         VBnz359TI0cq5/R6H4SOcV0VuIEXOLLkhEtNBX8W47LlpWzAuQsXPdL5SWX2JwJdWEqN
         /Fny0y+IYakovDEAg6hs63BYhHdG3dAcz8WTQZHbmVzlqYqxnLiPHzJ5expBT4C2kmfx
         FhGeJc5bXN3d2FJPdujGE6qUwJwUWtXjXmdHpOuJITUkYzraP4YaAVvTQwSEWRiTFV2k
         bIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774429892; x=1775034692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p2KjID10vkg/qXstgNRvPPvkY3Brj7dL/qNSBa8q0+4=;
        b=hMYpjflq3GkykN4a9wT2yyJ5KOvXtHiKS5k5AeywaPebatgMvdf7wqGJoRWl7t/jck
         hRY4SAJ1sIB5fXTckhva4x/58uJYvi6lEyR5RDgvztxBt9W0K2SZImzW0qjse6eygGdh
         MdYO2sRK6igfx+y5zkhE64SH7+4CTcW5NQSDXTkIGze5CM/wk1HFopDULKpwQrKeSeOS
         ZPrcG6w78X9HXlcty3TLh3XoXWmtWw6T7ycZTmNQONEGqMKH5lCQqiwqb0rbS4MI8tj3
         RSrmvUWRalnZSfRvTRtSvsmM+bKmA3EPl3tDRia4qYW1rdDMmAzyrFeciypsaPQL5/VH
         LpoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1+8HPnHdM0DeuWFUS9oAlTiJVuRYHPRBc1v7WrPfrLEHn1uGwsKzWPSrrgj9brMk5TPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzasZHI25zge3AqL8RzYxDOPyoYHvZGTeIa0cTqvrJp91sWaKmx
	FtBzrADTi7uXgSphUshZc8QdmNwYtqjHTsigOX7wMV9WpvCqOBkyB+Vm
X-Gm-Gg: ATEYQzxjxwmgNtrKOU9EcgkL6cIChhNMfgqqU9FgqaN8Y9u6pa/KvV+DDpIzD15XsIK
	voO8dS2xcBDtQwtP0rILT9xFfORZ1YRp30IPM7QM0bBm6lCIOCUK51zJiq5I7aIX/DkrjxLMDvV
	zYxP6bnDQmlejnYdpQ02+HjgatzsF9qFAPSgxEipS5cARrO8ORNES2aDqMhizQdG5we7mSMttQS
	Ifdlok/MfDfWiCTbO9rySdvGTiv73XTDnWqW7Oj3QMlWABqydLKbP6t5eFC7mg7IBiJYgs9Hutd
	gYFEcl7wQgicuwLX97HrzsO1stBj34yvvY+s4wOXY+IuXQ8DUYUgKCXWLrDE2/hsn/4fkoNwrWf
	m3S/qaMTV1FUbnaHLSKv2Ph3OWh4pM31KZfXnABEj49HmOwPWI9xlvMvj6wbc6uNBY4t3GyDEgs
	EbAClOdV4403PD/OC6
X-Received: by 2002:a05:7300:2305:b0:2c1:4f1:c87b with SMTP id 5a478bee46e88-2c15d357a32mr1565966eec.18.1774429891947;
        Wed, 25 Mar 2026 02:11:31 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c159e25dc7sm2786389eec.27.2026.03.25.02.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:11:31 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Wed, 25 Mar 2026 17:09:45 +0800
Subject: [PATCH 14/15] Documentation: isolation: Document DHEI sysfs
 interfaces
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-dhei-v12-final-v1-14-919cca23cadf@gmail.com>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
In-Reply-To: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0

---
 .../ABI/testing/sysfs-kernel-housekeeping          | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-housekeeping b/Documentation/ABI/testing/sysfs-kernel-housekeeping
new file mode 100644
index 0000000000000..3648578200111
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-housekeeping
@@ -0,0 +1,22 @@
+What:		/sys/kernel/housekeeping/
+Date:		March 2026
+Contact:	Qiliang Yuan <realwujing@gmail.com>
+Description:
+		Directory containing the dynamic housekeeping configuration
+		for various kernel subsystems.
+
+		Each file represents a specific housekeeping type:
+		- timer: Timer and hrtimer interrupts.
+		- rcu: RCU callback offloading and GP kthreads.
+		- misc: Miscellaneous kernel services (e.g. kcompactd).
+		- tick: Dynamic full dynticks (NOHZ_FULL) state.
+		- domain: Scheduler domain isolation.
+		- workqueue: Workqueue affinity.
+		- managed_irq: Managed interrupts migration.
+		- kthread: General kernel thread affinity.
+		- smt_aware_mode: SMT-aware isolation toggle (0/1).
+		  When enabled, writing a mask that does not include all
+		  sibling threads of a core will be rejected with -EINVAL.
+
+		Writing a CPULIST to the type files dynamically updates the
+		housekeeping mask for the corresponding type.

-- 
2.43.0

