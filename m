Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DC239EF12
	for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 07:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066337; cv=none; b=TWU6Qsa51RccBN7SdyZYa2nTp6HAOjrgDz9f5GDI+oLdO0Zx0cez4XctiUYxF/d5hOiD0/qUxsdGR+CeJ9KAOmfRr0Tu0dSl5qMXJhNjPj5h+nf+SI0g7y3h03SOgwF5he8UZUSNS1Hlgz6821vq/zGwI2nzxCGv2W4/zM5iCZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066337; c=relaxed/simple;
	bh=haYoKxwnQ4IkliWshHCYCJwKmzDfLZJY0fIFa30X7D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Me51dW3ozMPJHzrUkLs4/571GI/G+JQ8vdtaGg85MK/PcN9SDgiKfiWgyJyLp03N83ppyRiYwvFeaWs22SP3buTQQwjsrUg4bEFE817zPeTVhwK0DkCKYk8trRVe1OytYOOuIQLJpZuGwBUr7CF7tgKQfbAEcRQQzzV5rDDvXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtNutOjz; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtNutOjz"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1271195d2a7so5345342c88.0
        for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 00:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066334; x=1776671134; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5M3+b2z7keZbGNN1L4pc5gbCusIv4rK3WbERlRAtRw=;
        b=JtNutOjzO9oL5iDsdBC2WRURLvOza8Hnh48XnYRktcHQj0XMOlIFZv7BP4/GAv1p9d
         jzUctCWVdvbcpeoHI/bSYVebPKQVNJE8+AnoT8b3T7ENh8N2A0IhXRHLgXUS7/y1akHG
         m5KfcN4WQYfa/WEVarvT9NSh51qmOQbT8m6xpP/RbJcHDxgYfbet1z14ouOv9HN3UbvD
         LlAqgrsVcUXQHURb6mlYqNeO9lAYdMCmiNYvkUnfof05zveFEfF8VFiVLxuqYHy99dhH
         SMEaWYH4zOvN70tMNyrh+no03GZUN1b9/5zXWtU6XjkeGVk9hgQwuU+8MdGN11BJSq5E
         a4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066334; x=1776671134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I5M3+b2z7keZbGNN1L4pc5gbCusIv4rK3WbERlRAtRw=;
        b=QMmvJr28w4gje9ynoA6+Vd0a8ymyCAERifjuPGpn79kPVHsy1kwwh4TM/pu2GN21xA
         tfD4pxRSlz8xRTxk/V/dWMSo8hpjEpQtz4k9f9U0B3LJd3cjBIXmxKkXSj6zahVwuhtB
         +tLeuzijafTd1tPPaFjiulJqUbHrWWmxef89xIJ14Ya6k0vQbsqOpLqlCLgXZzQRbuKg
         MPneqdNU7mQICIiQl/dvZBh7K/rVQhnRsk6xsl8sSoynF/sgyjHXp5KZ/V+U5SsMmEs/
         9OpeQfD8zSMnEfQ53HceVpkhoZ3ZppOjm9wuzb4u94yc6ujlg2Mf2QwwmXQym0zlortc
         eWoQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DdeywW+LSqaNeZGMT+mE9VVQeiUc/i0u7VeOhmqsdWEZ5JtRNHuXSKQU3ZPbOSdoBcFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhV7N5BTY2HWMzFS/4LZaFdwEjKEjfkHAMVWs/sgHa55VP50cu
	bn632gNe/jF/JDhpeRNigZUH7RdsTTIExbGkgzZVLqUrvsnJaXbyNbWH
X-Gm-Gg: AeBDietBcMpOgzZT9LBoc7m4/Jxfsd9U0Iymdybu/Vzzi05SH2om7W/PePDqPj/r3si
	Zh9lomOYgR+Wle1BoaofaVWxa5JDbNnjjW3EHpvBryO95oVQB5Q8BR3uyCTeREPX597kJIsIiwr
	qLgVFUssmZ0EfJyj/beHa7v2mOIvTaH4AI2kePiKRgQYd9h7t/r4wHFLjokbTkSHoQ7ckiv+IEg
	PjbHBUEygFqW2qf3b2Sx2XQ4hnKsH/hYQ5fcq4QNAzw1VnoAHPFgygBL5wCm8shS7iEjOsf62f+
	Oiqklzwc7UZl9OYQ6//28rMh+vyFv+v2c3hulfxhUk6QtKun7ivzYyLo9jQUhGRqOD9mu3RLV/Y
	xSmbASacJPVEvgonpds/Aai7dADfwJb6mowQcq950UWtOJK96r3zbfv/4ml1Y3tzaAAjhej0Zib
	+s337elWbYEsiWMnw4
X-Received: by 2002:a05:7022:e1b:b0:128:d107:da0f with SMTP id a92af1059eb24-12c34ea9471mr6689826c88.10.1776066333988;
        Mon, 13 Apr 2026 00:45:33 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:45:33 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 13 Apr 2026 15:43:18 +0800
Subject: [PATCH v2 12/12] selftests: cgroup: Add functional tests for
 dynamic housekeeping
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-wujing-dhm-v2-12-06df21caba5d@gmail.com>
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

This extends the cgroup v2 testing framework in selftests to validate the
newly added Dynamic Housekeeping Management (DHM) cpuset interface:
`cpuset.housekeeping.cpus` and `cpuset.housekeeping.smt_aware`.

The `test_cpuset_housekeeping` functional test verifies:
- Validation of DHM's SMT safety guard (`cpuset.housekeeping.smt_aware`)
  by ensuring writing to it behaves as expected.
- Basic read and write capabilities of `cpuset.housekeeping.cpus` using
  the base CPU mask.

If the DHM functionality is not present in the kernel, the selftest skips gracefully.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 tools/testing/selftests/cgroup/test_cpuset.c | 36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_cpuset.c b/tools/testing/selftests/cgroup/test_cpuset.c
index c5cf8b56ceb8f..b2a032be4407a 100644
--- a/tools/testing/selftests/cgroup/test_cpuset.c
+++ b/tools/testing/selftests/cgroup/test_cpuset.c
@@ -232,6 +232,41 @@ static int test_cpuset_perms_subtree(const char *root)
 	return ret;
 }
 
+static int test_cpuset_housekeeping(const char *root)
+{
+	char buf[PAGE_SIZE];
+	int ret = KSFT_FAIL;
+
+	/* If the kernel doesn't have DHM patch, skip */
+	if (cg_read(root, "cpuset.housekeeping.cpus", buf, sizeof(buf)))
+		return KSFT_SKIP;
+
+	/* Test writing 1 and 0 to smt_aware */
+	if (cg_write(root, "cpuset.housekeeping.smt_aware", "1"))
+		goto cleanup;
+
+	if (cg_read_strstr(root, "cpuset.housekeeping.smt_aware", "1"))
+		goto cleanup;
+
+	if (cg_write(root, "cpuset.housekeeping.smt_aware", "0"))
+		goto cleanup;
+
+	if (cg_read_strstr(root, "cpuset.housekeeping.smt_aware", "0"))
+		goto cleanup;
+
+	/* Read root cpuset.cpus.effective */
+	if (cg_read(root, "cpuset.cpus.effective", buf, sizeof(buf)))
+		goto cleanup;
+	
+	/* Write it back to housekeeping.cpus */
+	if (cg_write(root, "cpuset.housekeeping.cpus", buf))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	return ret;
+}
 
 #define T(x) { x, #x }
 struct cpuset_test {
@@ -241,6 +276,7 @@ struct cpuset_test {
 	T(test_cpuset_perms_object_allow),
 	T(test_cpuset_perms_object_deny),
 	T(test_cpuset_perms_subtree),
+	T(test_cpuset_housekeeping),
 };
 #undef T
 

-- 
2.43.0

