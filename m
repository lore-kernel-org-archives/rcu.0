Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.68
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795169109;
	b=4oZDZuucUQek5i5syDPtwaMLaCUaBmY2TewODanU1e+MebdB0k12IvAkgEDefXcHZDNQ
	 AHY15/sOv5TA/LwJLWRyp0Cs9rgYJKXY80ZrLgBDTlKFL9Wn9OtRzCm/Gzzd3C5b6xnM6
	 CHd2x4jRp3sFz6XQuFzjROym0SFRWtRHvWmi7/udkvbJVwaqPvPOZk1+wy2EPl/YPoGCR
	 PttImrmuWokJms2Z+IHLcf6/jQtoe1/aI9a//dQfp3EupUJJT5mMn4+osPGZTomnjIsZN
	 fm92vBhmcAyxrmFum8lQLzVXjlFgxHyvJk+c34iDkNTaQturtl1z1gh6jCa7y13DIDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795169109;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References;
	bh=J/9x1RtExl97wOFG7Vfjm+JZGXRnyW2HlrYcYOuIfiQ=;
	b=vxQbMYTRVYe0yvJZDVfQvUKL8+LuC/vOZ6mH+pJtRJ4d01UnROVwhFev05tDOjMtMmfE
	 IfLnL5WjVnHDBpFflQxEX/gtiout4WP3mImwRxBnurSbp1Z34Ju/djpN7SmduDhMnLOff
	 Z6UgdK9aZkQiCAsFv0/XiubQge/aiEaNGNvRl5ghUlrDdko+N5/c+Ik1LAte00svY6fCA
	 rR2fXl2ySjNe3bPAYx+voYRhtDqPSyubSY3KbaVImXqL/XlP9tV1S+ojV3dG+VzOpEXAQ
	 CQetH41QYdM8eOsXXnTg+sin1Qhi0yJ2AdjPLF1CIzdCSDIwgZvp9KeC+mkYeBqJpSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=g10iLgNw;
	arc=none smtp.remote-ip=91.218.175.68
Received: from mta0.migadu.com (out-68.mta0.migadu.com [91.218.175.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF00606A336
	for <rcu@vger.kernel.org>; Fri, 20 Nov 2026 10:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BF00606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=g10iLgNw
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9AGEfIiVGWrTA/p5hs69E6CJD8N4yTCqONqtJajSDAU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795169107; v=1; x=1795773907;
 b=g10iLgNwQCw/55siNlA/sbtu7bXrmzn6+MI9pLilpwKSzDHX0EB+S+tPmMU+q8mezbiWzf8Z
 GMppO0ovNWZhG6MZ+uLzLzZMCz7w2/SSuIGT8lHtV2N6x0B1zaE/kgWo/yYfb6NcjLY0htQ+Tx+
 +6KfClkiYDNxexMFYqIBXkyw=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 75db37803e1466f9;
	Fri, 20 Nov 2026 10:05:06 +0000
X-Mizu-Trace-ID: 75db37803e1466f9
X-Migadu-Flow: FLOW_OUT
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	urezki@gmail.com,
	boqun@kernel.org
Cc: qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcuscale: Invoke cur_ops->cleanup() in kfree_scale_cleanup()
Date: Fri, 20 Nov 2026 18:04:53 +0800
Message-Id: <20261120100453.5826-4-qiang.zhang@linux.dev>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261120100453.5826-1-qiang.zhang@linux.dev>
References: <20261120100453.5826-1-qiang.zhang@linux.dev>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list

When the kfree_rcu test is selected, rcu_scale_cleanup() delegates to
kfree_scale_cleanup() and returns, so cur_ops->cleanup() is never invoked,
for the srcud and srcua flavors, this fails to release the srcu_struct
which allocated by cur_ops->init().

This commit therefore call cur_ops->cleanup() before kfree_scale_cleanup()
ends, and also guard the cur_ops is not NULL.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---

insmod rcuscale.ko scale_type=srcua kfree_rcu_test=1 gp_exp=1

unreferenced object (percpu) 0x607d981476c0 (size 576):
  comm "insmod", pid 1151, jiffies 4294997383
  hex dump (first 32 bytes on cpu 11):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc ad6c346):
    kmemleak_alloc_percpu+0x89/0xa0
    pcpu_alloc_noprof+0x69c/0xd30
    init_srcu_struct_fields+0xb45/0x1070
    __init_srcu_struct_common+0x4d/0x60
    __init_srcu_struct_atomic+0x45/0x70
    0xffffffffc060380e
    0xffffffffc06071d8
    do_one_initcall+0xd9/0x620
    do_init_module+0x2b6/0x830
    load_module+0x7b5b/0x81d0
    init_module_from_file+0x15f/0x180
    idempotent_init_module+0x3b1/0x800
    __x64_sys_finit_module+0x11a/0x170
    x64_sys_call+0x3e0/0x1fb0
    do_syscall_64+0xd2/0x750
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

 kernel/rcu/rcuscale.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 5659eaebc5c0..a5644db54119 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -901,6 +901,8 @@ kfree_scale_cleanup(void)
 		kfree_reader_tasks = NULL;
 	}
 
+	if (cur_ops && cur_ops->cleanup != NULL)
+		cur_ops->cleanup();
 	torture_cleanup_end();
 }
 
@@ -1036,7 +1038,7 @@ rcu_scale_cleanup(void)
 		SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
 
 	// If built-in, just report all of the GP kthread's CPU time.
-	if (IS_BUILTIN(CONFIG_RCU_SCALE_TEST) && !kthread_tp && cur_ops->rso_gp_kthread)
+	if (IS_BUILTIN(CONFIG_RCU_SCALE_TEST) && cur_ops && !kthread_tp && cur_ops->rso_gp_kthread)
 		kthread_tp = cur_ops->rso_gp_kthread();
 	if (kthread_tp) {
 		u32 ns;
-- 
2.17.1

