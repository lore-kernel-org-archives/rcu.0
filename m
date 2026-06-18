Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4DE33BBC5
	for <rcu@vger.kernel.org>; Thu, 18 Jun 2026 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752362; cv=none; b=ay7lH31GC+esCSqHAj+2IXms39BX/2I7YeQrWB65eoj9OsHJsT8KxUQLKG3KwkfX/Ykmo2LPhrLMMvZUMm97iogFYnVNpX10aPrHd1Qn2fL4l5wszAkCHdrwqqp+g2Mq4LZSYDlCUwBPfTuGV2rBDN5pb2VTqiUCQQ8nsAZzG6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752362; c=relaxed/simple;
	bh=SZSfvX12VlEuwZl+6hAVKIfqxpPnB1VqKOp94X4ryo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PABc0P9BIxRD+NelpEjC83XVkA1kAXl61gIxkWGE602ekYW4rEKm8FkG9xX5mnIb0X7Q7q8+dX5MgK329Hao7MzbM/iVmF+lWbGM/Me9ulCGmG9BF2UzuxUuWl4aFVhUoOy4LuLUQi41K+FRUnnI06RMZ6RSqp2/DQm3dju32ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZqe4DdH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZqe4DdH"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c6be9cd89bso1988555ad.2
        for <rcu@vger.kernel.org>; Wed, 17 Jun 2026 20:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752361; x=1782357161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3I6IX1xUYJMTfIXEi0w2UhaS8cMsiIG3uPORXy/Kqg=;
        b=CZqe4DdHuvA83HXuWHxNF+zbSnA/5STgQ7D8CWrVBB6gmc4KskyUW59tKbRVl1V3vC
         iEnxeIbNe3Xk0TsPZiLIVbK3M1WDMzKTjnTvV9gA2Y5bT1L1ZRtvGxWDT2KP1sVCWjaO
         DN04QcsZ6c6SDbsjZakOm/AD3yccCOyNCXMMd6c1EsiqTocuIJ9wUGoy5B6H/OgIey5M
         G6vWB6sE3qPynStWyu7ckXbk8zpmAUQ7G1rwosSEp8tUxgEfCqd83FBTwaIBr2xpeNe7
         kXFDpdpf+DCO9kP2Wb9HfyfFet0xxaYu/Aj2ft5pOLvWHGzAaqcqE8i/AruzjUBA22wT
         CLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752361; x=1782357161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v3I6IX1xUYJMTfIXEi0w2UhaS8cMsiIG3uPORXy/Kqg=;
        b=JfGh4d1XoPkU9yzt7BaKAicjC7GoNaIos0Um7kT9SV9aK0+hnKnZuFdfJGbulQAgBC
         CI08VAdvEnvhEbKke32MqO4eSyKAkYGjsxuSVyaHiXcj3cgaB3tq+5cObTIJFzKrTHwG
         6AfOapX+hnXA2vZ7ayC+EwDT++7wIbLP9IHIBCn8d0zSBvDzP+i0xUogECI5FHQ/pfND
         sSXEyB3nQvvGDP+3uDnjUQvKVq/7aNMIZqGr7MmU27pN7BQuBILHJzgWW9IQeYB3w3BX
         Zh9woIxa4pI7rNA49XOrlx9ADtbm0CTO/MBeUGXx8vOC8EaIp76CTAhGCqxonflENwlL
         7FZg==
X-Forwarded-Encrypted: i=1; AFNElJ/M6wkIJ9x1L7z7txfuivF6ihgntBuHXZUyvCJF1hE1J0VBEwM91OlxKf2Z76Eh4s/IM64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw04VATmXgJw0ee5+1VGdbHEiVLtM+2kZ0OY41PrucGjt9WrhwR
	Ixa5nwU4pfeS5l7ajzHXzh7hyFkADDCNYyQ0wl5Ky2r46BWRbdX+204O
X-Gm-Gg: AfdE7clXkL06cOD720/Zhxtap2ns4NQKNE60dVGVDEY2GgKq5ecQ3Jp9/GkDO83Duoy
	hsujtrQyu91Xar7EeU54A/Ai1+9TZSSNzh6THAwae+VrfljMS7Mb/RCPhp2reD8KGFxKXbzhMpr
	lyz9SHLvkD84+CVqTgfOP3mU2MWOS08p1juAD25ot/i49OR+u1Ww1JyhZuq4IfwQIZgeY5DytWd
	eELgN4VJUt+VGzM3BLWh7AaKTsvZ0SQJ4EkcULDHMFcLHdmOd0dKxtdxySR8XSSnB1L3skeCNym
	jMpEp5q6jAU7HcOsuM9x4XwdfdVhp5JSdieaH0oMLOQNyIFS4SYkRHRxmavdfp/h4j8Akqyl66j
	dT26mVN0UWBaHX1iIVHEcCjoUUddKmW4g60PgCDiOkr+RWLK68EaPGQWJYLB8dnQ+rU0LdBeoKF
	IEsnwdw+ug+I0=
X-Received: by 2002:a17:902:ea07:b0:2be:22cc:e227 with SMTP id d9443c01a7336-2c6bbf9dfa0mr65761055ad.4.1781752360871;
        Wed, 17 Jun 2026 20:12:40 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm60152975ad.31.2026.06.17.20.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:12:40 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Thu, 18 Jun 2026 11:11:23 +0800
Subject: [PATCH v3 12/13] docs: cgroup-v2: Document kernel-noise isolation
 via isolated partitions
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-wujing-dhm-v3-12-28f1a4d83b68@gmail.com>
References: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
In-Reply-To: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Tejun Heo <tj@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0

Document that cpuset.cpus.partition=isolated now drives runtime updates
of the housekeeping masks for kernel-noise types: nohz_full (tick
suppression), RCU NOCB offloading, and managed IRQ migration.  No
additional cgroupfs files are required; the partition update path
automatically triggers explicit housekeeping callbacks for all affected
subsystems.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 Documentation/admin-guide/cgroup-v2.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6efd0095ed995..7c3b048e75cb5 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2721,6 +2721,14 @@ Cpuset Interface Files
 	kernel boot command line option.  If those CPUs are to be put
 	into a partition, they have to be used in an isolated partition.
 
+	When an isolated partition is created or destroyed, the kernel
+	automatically drives runtime updates of the housekeeping masks
+	for kernel-noise types (nohz_full, RCU NOCB, managed IRQ
+	interrupts).  This extends isolation beyond scheduler domains:
+	the tick is stopped on isolated CPUs, RCU callbacks are
+	offloaded to housekeeping cores, and managed interrupts are
+	migrated away.  No additional cgroupfs files are required.
+
 
 Device controller
 -----------------

-- 
2.43.0

