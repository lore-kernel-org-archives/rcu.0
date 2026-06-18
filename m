Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77110331EA8
	for <rcu@vger.kernel.org>; Thu, 18 Jun 2026 03:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752356; cv=none; b=oj2p3HeTKjwYUuLppsgCI+56qNc2paqblAJjY6JAuexwSZ7zOEEqxWFNfJJFJizBaK1vAEHtsJbbNcKC1fmwoCK6ZVHUcHR5urduhorfwHi1ww+SzFw/ETszHE5PZ/LJIh7+qh/vr3cC4xsiK9sYPDJEdsTzyY+5ytYhUaoZ0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752356; c=relaxed/simple;
	bh=1wFtiEBV/eExa/0fk9lHm27dQyGmUqkvypCV6YhwRzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/vopwg6620mImx9p0Zqhwr85CK1KtK36ZNxpyLS17XqFhedjOsfQKGDnmSke+rMOq3pkaMoHvbtG0r8De16XbQSdfg5HGp1YgC0r85tfbzq1Y+hCqda0vYS/N6CtHunztXahPAb/Rs6E22ZIp9Y61a9ifCDYN9u/V9VaGNalzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsaYj/jr; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsaYj/jr"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so215586a12.3
        for <rcu@vger.kernel.org>; Wed, 17 Jun 2026 20:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752355; x=1782357155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=115mykkTwm3kAcmxwjkRrMY9t8k6+X+EEMpEx7hgUEU=;
        b=VsaYj/jrf+ZEe5Imp3Ek8cO/T2bMuZNeZTotlq3vYw8xilW7zHAGNKorbVZdo3YJSq
         aIBB0cD/0HMBDeUaDLkvJ834mUUS33tDonCbToIMcorUcxlLR4V+scQ7bu5nnJbjuz+A
         L2aVa/LLqsOkG1hoC3GRhgwYxotJl8xbGtv00+WzMjQgrblHsDuXs7QALbjCEA0UxpZp
         LRSlXzk0ixotFpQzgR7+3g5yW43Q2T9hunXg2yFsPi4XSduYvxGEgTilfe8OPNUtL+jd
         3Fvx2D5yh4bv0soZV0neOlkkfSFRb2dF00j3fZ7ogOqBYnvZz0b/o3zldRW4ljdjRq9H
         M4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752355; x=1782357155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=115mykkTwm3kAcmxwjkRrMY9t8k6+X+EEMpEx7hgUEU=;
        b=NAxkcjJf/lvTMHo+HDMzRomGkgmzm6q9nQd90oEeRMgNSZZcERXwtOmGi1IGI+ZqQ1
         YT0ad5wbMQMy7UwF3NYOErPMHk4INXF4vETJq64eM9r3l256+3z7xiUssfK50vbn9WOG
         PnqxT6BxpEuoo4Stf4sy2RfOMdfeeVdHUHhAlyxEpX+wa7BpCczL5HcXFC88Y5T4mGLe
         s/vcQANRthIv8Wa63Tx5iiclE/i7GQitHHXutNpClZforDesYN5NnwuV3a6fG/L1/6C4
         7fM7Z5s9C8NnJkGsAlesmuiFtpAvJV6ay/Qv+LYL4GpO32efTO2pRZEUr7224RWgqGSB
         xMMw==
X-Forwarded-Encrypted: i=1; AFNElJ+f1Kdr3OyE1Ru6/RZzfU7vWkvOK5hb4IWtQgNLZqUdo7tdVjIQf/kU0JCGr5AAwTDBuCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeSuacZu20bdNHM9+4y1D8/3OBnKUb7IzaOit+XUSXFrP7Wlt4
	5Unv8eu52ZEO4K5mdt95W4Ge5OnugohsI890vrrx0D3aTkXuT3t/gCjt
X-Gm-Gg: Acq92OHY8r0P5uPBdZ2yOqPrdxEb7CyQ8DP8bg5j6hBLO/PvG4x0olww6Hu2DNKnQYB
	BjnUaEVhCBNw/dd6tFYqpGXFbyoof272relye2snpO+BzWdTilL3wbjLS4tCw04gK4S6bSPWplp
	BPwG1kZd/nVcQzcSEEvV7QaY6eam5o+Z5u5ugDFPD2FvnF+nay5aUOmzUokUoXqmasEFibfXDoK
	NkFnBNGWlhJcQrXe1x/aIVI5RseeMfuc17HnwGEzsygxYFYEIv3l3ZZsN/tM8dWpLCnP8H70/JZ
	P4hbvDurahS4J2XKhlaeBUNytSXxiaxzcjO+PPHrIvHVKXFjl56GKpWGSni3W6byVHwJLy4nyZC
	f/MFdilJdDUxQsg6pG99iAr9LSomKd7/DOhBwLBo95sF8wckYjlgL4X3pJuiYqZa7qSZNNTybH6
	QA91yMLQdop8CtF23/mFpjag==
X-Received: by 2002:a17:902:ced0:b0:2c0:c625:400d with SMTP id d9443c01a7336-2c6e52debf1mr15847925ad.37.1781752354656;
        Wed, 17 Jun 2026 20:12:34 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm60152975ad.31.2026.06.17.20.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:12:34 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Thu, 18 Jun 2026 11:11:22 +0800
Subject: [PATCH v3 11/13] cgroup/cpuset: Extend isolated partition to
 trigger kernel-noise isolation
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-wujing-dhm-v3-11-28f1a4d83b68@gmail.com>
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

When a cpuset isolated partition is created or destroyed, also drive
kernel-noise housekeeping types (HK_TYPE_KERNEL_NOISE and
HK_TYPE_MANAGED_IRQ) through housekeeping_update_types().  The sched
domain mask (HK_TYPE_DOMAIN) is updated first via the existing
housekeeping_update() call, then the explicit callback chain in
housekeeping_update_types() invokes subsystem apply() handlers to
toggle nohz_full, managed IRQ migration, and RCU NOCB offloading.

The update runs outside cpuset_mutex and cpus_read_lock, protected
only by cpuset_top_mutex.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/cgroup/cpuset.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5c33ab20cc208..67b93bd4d58f2 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1347,17 +1347,30 @@ static void cpuset_update_sd_hk_unlock(void)
 		rebuild_sched_domains_locked();
 
 	if (update_housekeeping) {
+		static const unsigned long noise_types =
+			BIT(HK_TYPE_KERNEL_NOISE) | BIT(HK_TYPE_MANAGED_IRQ);
+
 		update_housekeeping = false;
 		cpumask_copy(isolated_hk_cpus, isolated_cpus);
 
-		/*
-		 * housekeeping_update() is now called without holding
-		 * cpus_read_lock and cpuset_mutex. Only cpuset_top_mutex
-		 * is still being held for mutual exclusion.
-		 */
 		mutex_unlock(&cpuset_mutex);
 		cpus_read_unlock();
+
+		/*
+		 * Update the sched domain mask first; it must succeed
+		 * before the kernel-noise types because workqueue flush
+		 * and timer migration depend on the sched domain mask.
+		 */
 		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus));
+
+		/*
+		 * Drive kernel-noise types through the new explicit
+		 * callback chain.  Tik/rcu/genirq subtypes react
+		 * through their registered housekeeping_cbs apply()
+		 * handlers.
+		 */
+		WARN_ON_ONCE(housekeeping_update_types(noise_types,
+						       isolated_hk_cpus));
 		mutex_unlock(&cpuset_top_mutex);
 	} else {
 		cpuset_full_unlock();

-- 
2.43.0

