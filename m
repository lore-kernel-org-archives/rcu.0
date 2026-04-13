Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED52A39DBC4
	for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066324; cv=none; b=qFS/JOS/1S8GjXLU1i9MiQgV0vcgwrVjMRehORxdq/6kDqZoKT43OA3H4vRr/agKbOizG3H6xr3+9TsdaYRW9Q79E7JTuEio3UcFHGqvfP8ZP9x+QU3WgxdKfgyYFHXPXvUsv8tDDVUTT+axAVSGjXvyIwPKpUGlbc3VYQN6fd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066324; c=relaxed/simple;
	bh=11ce8bUKvUSdcebzsjZtiRLgXFylySnevizU5TDAFts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qGsqLub7L/MZI5n8T942ernGFtdxD561uhusdnGjop3OBpzbpo5twSw9nGDlI5p2KaVilsKhxd+3c/GvnlLVuFZvUGtS7Hh+gCDs3rvW2YTQWAHji0dqQSEslqno/XYZkQLDzzJlJTN9eB5U9TFc4kjIDGHrcnn6ZaaQ8h1Bk4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rlaFdogi; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlaFdogi"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1279eced0b9so5523244c88.0
        for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 00:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066322; x=1776671122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNYrrMihyJ/UopuSP8NsPFIh0brjDU9y6jBpikXxsOI=;
        b=rlaFdogizaH8E48QTvwAewMKrEOKvjVGk8NUiMvPfxXtudCAn6AJJck1u1sPsjApvw
         V+jykR2eah19Ul04Ggv5O/draHnzso2rriDuTYkLDG69k2TUR5AV1Okwx63H/SEcQT2L
         o/VzvNMyv85GFv4tCobyFzT9S3zFYCjCVqsKNoaufkPQtko+tYf//rrd9BCFCSuG+FK+
         AkhYscxlwAjBzJA22sYZ5r/rxj/rwKw3zptSsQ/VFOLgVdpFWutMjHkQ+VBDXz8p2/Dv
         EoMHOmZOnDj/LNg+fv5UlS4Uhq7el9M/AggMd+8SQFoRSNoia/I7j/qH9kMjuUGwQ1qo
         imOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066322; x=1776671122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eNYrrMihyJ/UopuSP8NsPFIh0brjDU9y6jBpikXxsOI=;
        b=QrOXjSdW5h8zlU0Tmz2HDQKwnKMOHK2vps4FuVOQOZpUsKYskrgVufaz6pTRpPAsK7
         0ILVobcq1opMM3ibbiv3nXL7tcnwSRGxIfodIX0ACwd593ELzfe1bTHeV6Q3GPmQ8Xch
         Utp2z2uFt389C90OYiiZVEYB22tBqfCuBuAKdPFyS5mQUB5QBMTqs7A4uLlQitsd0DX1
         +dHisTOOIcq9UIJKCDkfG0/khcaow7gZdLeigdAsFomoi/+t4/v2j3v4N5DxL5wC5sNs
         nCob/TM6MOWbBaMVG8ZhX5DBnw3QHzs5/HUuFz3RZQoXs7oSBgi0cpPgK30H/u3g+myz
         zumg==
X-Forwarded-Encrypted: i=1; AFNElJ8US+eP90sGjdfmXlltV5sxaqytI4PGlUkBA5lY+cK1xa4gnLkzWkq9sy81TfMTrp76PWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Kqbh1jLPPFATpkRCEv7PuvvLzfbge3Qus/YbI43DhcRN7PVQ
	BqUkjyI+RB7PzdPgUc8+EYEbBnQ6UEZytgTInEGiWlAWJazP+Q4Ik0dzqVT15kck
X-Gm-Gg: AeBDietqmltD9eTPoy2P+TXObi+BqYXjM3uZU23gSgVOO8Zsh67ouhiC7Rp0O+K08CZ
	/eaLp/ZzuScnJ/1gDi4UlxdVKGxzUT/MHVhAiDrvCaPw4lGRrz0e3Lb5AKav5qOOrMLTvKecMOu
	oYBsDqU2kDtY4WXSX17y3TXYGY9eCH7dZsesMnVDuep5zDC8QalyVHe9ihLoedzeD/yVI0bCKRF
	8B+4MecLC6n2h/TCnGHQ8AP643nbeOczyQEqYpk0UQjwoLhO1MJCHKUdEgEcaJNuNxoui09dHEx
	OO5NzT86ltuCvSLckkNViEox4VzVW9+zVi+0NfVEetwAiwhgVQSAsZJV4a+f0PwPi2SI5l/y5Mz
	pWlwDM9QfNMmyUjRHDp0B9aVjipwttKSH3tBAW3CRJvoaTgb4MkGergPahStNvbq2e9jFWrIokn
	Zx0UJym/q/caEH+au4
X-Received: by 2002:a05:7022:69a2:b0:12c:8b9:7208 with SMTP id a92af1059eb24-12c34eeb95cmr7021315c88.26.1776066322024;
        Mon, 13 Apr 2026 00:45:22 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:45:21 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 13 Apr 2026 15:43:17 +0800
Subject: [PATCH v2 11/12] Documentation: cgroup-v2: Document dynamic
 housekeeping (DHM)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-wujing-dhm-v2-11-06df21caba5d@gmail.com>
References: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
In-Reply-To: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
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
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Waiman Long <longman@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0

Update the admin-guide for cgroup-v2 to explicitly document the newly introduced
cpuset.housekeeping.cpus and cpuset.housekeeping.smt_aware files.

The documentation explains the use of the DHM framework for reconfiguring
kernel subsystem isolation masks natively through the root cpuset without
incurring system reboots, and describes the functional restrictions of
SMT grouping safety constraints.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 91beaa6798ce0..deb644b88509f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2592,6 +2592,30 @@ Cpuset Interface Files
 	isolated partitions. It will be empty if no isolated partition
 	is created.
 
+  cpuset.housekeeping.cpus
+	A read-write multiple values file that exists only on the root cgroup.
+
+	This file is part of the Dynamic Housekeeping Management (DHM)
+	framework. It allows dynamic reconfiguration of the global
+	kernel housekeeping CPU mask without a system reboot.
+
+	By writing a mask of CPUs (e.g. "0-3,8"), DHM will update all internal
+	housekeeping subsystem masks (scheduler domains, RCU NOCB, tick offload,
+	timers, unbound workqueues, and managed IRQs) in real time.
+
+	The new mask must have at least one online CPU. The value stays constant
+	until changed or affected by CPU hot-unplug.
+
+  cpuset.housekeeping.smt_aware
+	A read-write single value file that exists only on the root cgroup.
+	It accepts "0" or "1". The default value is "0" (false).
+
+	This file enables the SMT-aware pipeline logic for DHM. When enabled (1),
+	any update to "cpuset.housekeeping.cpus" is strictly validated to ensure
+	Hardware Threads (SMT siblings) are kept together. If an SMT sibling pair
+	is split across the housekeeping boundary, the mask update is rejected
+	with an error to avoid severe cache and pipeline contention penalties.
+
   cpuset.cpus.partition
 	A read-write single value file which exists on non-root
 	cpuset-enabled cgroups.  This flag is owned by the parent cgroup

-- 
2.43.0

