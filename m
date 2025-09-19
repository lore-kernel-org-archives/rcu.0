Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEFD2737E6
	for <rcu@vger.kernel.org>; Fri, 19 Sep 2025 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293458; cv=none; b=POb6LigfJr0lBwZwZG0dntxV1ujENKE7IRw9rJ23Y8nnsdaiSqA6U8v1N6OFP8/T//fxMZJwIEX6H4g05tog25llPc3pcmH4YielrJNnkeKBX2UXTxPsQFjACD3jgjRbis/ocq8o+a0K4wASmr6ZNzEfAUn3gVd61ZLdmlCwFfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293458; c=relaxed/simple;
	bh=PV1pAIQ5r/c1M5gMZ2HohN1y5CIC3ZVhLK658XfNPxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqJ1AOHha9j0aL85L2fkXiLXtmdeP6CliMq3ZDoTv54VzpiWJd/LVYANhKj4mSOc9EaTRrN47z/qP4Gc49rx4wFg7JXgyoQOwVl4wf3ux/TYxXUJIEuiKzXk75Fo7NFqTdKWyFdnuQW/b1+2Xoyo49qGLV0CnppDylT68UMb6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A1+fIz8n; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A1+fIz8n"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so21681785e9.3
        for <rcu@vger.kernel.org>; Fri, 19 Sep 2025 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758293454; x=1758898254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7KPemB2n/F5BC+EkjNbWfvGZs7MphH30xFCVibraPw=;
        b=A1+fIz8nzWUpGNFVF49sR1dEHw6QDb7EpaKwIDXcuZicKM2wfWdTgyh6v0G/+SwgSw
         N5VpQczXeXYQtz9O0LmzLKSri5Vn7NHblJ/owXuOk88EAdx+1YmxPV9sMiTF4nCYE62X
         JGdQluOJ89dfdWNRTjgjjkCVa9YU/zY3KmjtjFV2s/EhH24Vna9+vzEMn9cKjhpw26uf
         +v2EKa6s9smKQ3QVVMzXJMJvaa3PqCRl3jNCekRt60mGCNBwNGuqfXDqgvqFAZlsbHrE
         PuFdPL4ZaSblvblXqHjXcDxb935ZyOQZNGGk0wt2uWBqTEXByy5hfyFzEREeTopazOA4
         5TLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293454; x=1758898254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7KPemB2n/F5BC+EkjNbWfvGZs7MphH30xFCVibraPw=;
        b=KXVeKUfOG1nNyESUN0uhZs1z0ErkDgl83YKQ0zl2rW5vYwiV2TAuKfUgKOCQFeD8ep
         7W0kYb7EDnwgQpE+IYzW67ASTmOZxCC4CUtDoJhh0orw4ycr6wmYiek2UJ7ykuC4Ki4c
         kVWdcfx1/BLHJVPQknurb331s9PhEcX07kdKeC3Q1t9M2xh1x0RzJqIVuPCoJ9ZfGZxe
         I8Fsw0H0Boht0MAi+RFNqdgyDYlW25RNw7E6/2VaR8K80xM+UdfxtlS7UnC2jiy5bQHy
         bxMEb0p86fkOk6hmlVC7aC2k/TEWKDuRJQ+WoU/Hnp79ueJh7GRhvbKoysWjxV8jsKWF
         0Zew==
X-Forwarded-Encrypted: i=1; AJvYcCUZRWKVEQLBaHofI/7mhXOSoPR+heDhudrPmv1GNntyqpLd9v84IDKajwAS9o4pE2fx2xU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8n1utNU0kql0neP0vEVocBsz/4GOY+rlCL8X2SlQ31P7LH1Bc
	zGA+lrbQeFPygsbxKzgzIgqOqsDpmidKW22ngYBTd2cMGDdpOWWB2I0rvobwD55dyUs=
X-Gm-Gg: ASbGncvH6gNIFXlt58gAWaxkJzhHs/N1+31twQUcFxRk78Ci1MNo54hXmFaOIEHEEOr
	7PzJNzJbj0bLCme43wjGXEf+3vBBw5746FnX9vaO71PQyRORKLkAl6A8He9ZTRcYZmV7NGjO2bO
	CgfHoeFxhiFRGEtrAVcdVhZDG2B1taf1PhO8UUdPfu3jRynBfKL45tYdE7a6KbOOzbwX83oBZkf
	v7bgiyjzfeSKkULUBEWCE8RLZY1NTLpKGpmbZA82T7hNqAWDw5fWG90AbdTGuB/oc93rWIOa16f
	IkP+xhxzkXW6xwOBYPKX1mdZpQlqPrEnokodc13BWMWLc6WlJ4L41IZaWrZNQf9n7+1KGX/46Cc
	yQ80Hbj3Mcry5AzdUPIBFFWBBbVBeNlO/8ALvbLVr07Af3w==
X-Google-Smtp-Source: AGHT+IF9CraP+MLmX7L2E45ETGVlK7VJDOImtYV8q1ZaMup6tdlxqtMY+0E+owqXOtOkfQashquiyA==
X-Received: by 2002:a05:600c:470a:b0:45f:29e4:92ff with SMTP id 5b1f17b1804b1-467ea89daccmr39463245e9.17.1758293454299;
        Fri, 19 Sep 2025 07:50:54 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325c3c29sm86220025e9.3.2025.09.19.07.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:50:54 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v2 2/3] rcu: WQ_PERCPU added to alloc_workqueue users
Date: Fri, 19 Sep 2025 16:50:38 +0200
Message-ID: <20250919145040.290214-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919145040.290214-1-marco.crivellari@suse.com>
References: <20250919145040.290214-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to explicitly request the use of
the per-CPU behavior. Both flags coexist for one release cycle to allow
callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8eff357b0436..4f3175df5999 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4885,7 +4885,7 @@ void __init rcu_init(void)
 	rcutree_online_cpu(cpu);
 
 	/* Create workqueue for Tree SRCU and for expedited GPs. */
-	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
+	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	WARN_ON(!rcu_gp_wq);
 
 	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
-- 
2.51.0

