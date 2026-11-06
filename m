Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976002;
	b=R1OhFsT6I1iju+CqK7wLMbczpdWpO19nFGz4TuPjIwxpBYPlZdXNt51e7krhH5DfV227
	 EgV81aKxS4zOucsO5cObs75EhS9ihr3py3JIUBOmdVoAAIJOoCtikjNfC1zUJYggdiRVD
	 GjGdjkybI+4T/00kD42Q5rO6jRZZa1O8eK0SaN/ISeGizwB76H4KlZ4qXqaVOGoiWX2QR
	 8fUqAL3PYiG6t5VgWS7IweSoGaB5s+VW4Q7jMVamP0irYyNNwG1ANobegYL5AGCy8Ks0B
	 553iwUB/6Dm6I7tvdZZFodZiWDQNw6BUlH11UDPIPCEgW209Rj06QMFfcrYNwxTengw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JToukDNMNPYjncVinCRQVqH4lNSXma38Neh0EQ6yzFk=;
	b=kd+ARqMzYp7cP111W9ng0BoBGuz0IDj+l6s+qLBIFS4F45wR0h96jglOqud/X3NIziW7
	 TaRTp8UFpao2r4Jz5bKpwuuQ/N4k72cRiHZ3CeyhdKhZ5tC03qwZXlEVXOANIbxjFXghE
	 JmSluT1dp+Sma8l/6cRbHdkzfrxMlbvSiYBOaI/qKT81Wdx+WuVrQv4gaAV9nXWlBUulK
	 +YcZDnlEgmqQL7XdCfO3V4gOmcTLQnCjIK+e+V1RhK1yLLSPgk8RYv9NtFqMT4OL1N84C
	 aoXVSubPHbBFWUM1Wz/uR53wQA3TKP/ntIlJ51EgnmVwZ502Ai6vKaXg4hMVoca4PKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SiWP5Rp6;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB57606A326
	for <rcu@vger.kernel.org>; Fri,  6 Nov 2026 14:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EB57606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SiWP5Rp6
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3282db206d3so1468242eec.0
        for <rcu@vger.kernel.org>; Fri, 06 Nov 2026 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793976001; x=1794580801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JToukDNMNPYjncVinCRQVqH4lNSXma38Neh0EQ6yzFk=;
        b=SiWP5Rp6kd3p6MMbZBzvLpzPMo+fAyp1/SPx/oyv8p5muNVS98HYdpTM5HVYNFJ1Jh
         5wxRL+iFKXsDyxkQa8SP4ITL6xuSb1hHga0qOuIABwwuaCCLKZ1h/OHNoqPNvCUwIyyD
         suxhxanohfNlOIFVHYwndFNpekv9Sos1VacqB/bBk8lPILelwFi2l5N3fS5nzR4K11ys
         YzQELGZ3YDrE4fZQnIjAigv23jNxRGsUolcTsQ/WC9G8+buPa7sgBBS1lu/4uE8BvCwl
         fSidnoobNdypRBq6i2mNTUe9tMJVnR1IK1jzqAMij18IexUeVoZNgr6Jse3rkSmgXLlS
         B3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793976001; x=1794580801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JToukDNMNPYjncVinCRQVqH4lNSXma38Neh0EQ6yzFk=;
        b=UUQqRrNxYY0WIDYYEXZwto8Yvm8y+9XyOTgB1rfAC4wLx9vuNWJhbocp18wQfmcw3h
         bV5caAmu070Bg7HbdWdAkhxlQP0s25jSfI7Eq8eXUb2//FnpXw3ASPUBqgxJOLenzVB4
         07XHtpNDRNvA8yaUjgRIEeNd5nR8+ACk3ZEVXl9407yiZeAoGlqhkC1qrCEYevfr98lA
         zof3i9eJ9w3AatdoifQfohpOsucrWqDnsgmaLW8dZsbRb2bDE2IFkUqgRQep47kkaMu5
         hoYa5mQUVcsSGA2sevSV/BQeQr+8VxjAJ2PKPZCeqMpI31cd9pDu49thm/3w0XUs+3ea
         +Alw==
X-Forwarded-Encrypted: i=1; AL+hErFG9KUSkfw5faeAqmKxAeSxsx3f+UOQ5QgM/a+wjnjZZ+dDqCSGuh0NDZ8m4MbAB0b39NA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Xpk5knTmkiVAdwdSsxxjhmgudd1QZIUB6BLPbVUI84ZR3DWDe
	LbCklG9sTE/RQuGBfnwOabbMtOXKNAgVY6e5TruiBQyZuqke/QM6SvTW
X-Gm-Gg: AYBFou1DCfAJbt6IB5aU/vqgkV8zz1x+yDmQg0vvqZwnFRd/RTfFKZkuwXU2tjbBKmw
	aTMstguIQEkpMtNHlOWY5m/fooULhzzsWDDeZE9h3+UsHvOldAO9mOuGxR0A+m0Fu9DIPm+RRFG
	5WponW/unY3sEAXBfMQ0WmaOumrOG408ehsWrHQBK1Jr5ch8w5JGor+a8dLRONdfl3i6eNj2Hj4
	FEFTH0jmztXBfp7PEY/R6d6JSM5hTtVyFrjzPzz/gxIwtjsifnVtsybjmfpPrqyn9VYEZy4mH7z
	B6NBohC4KPbnF9rYsDk5X3KMafH7YjDKbeD0Y9wq6nqVPZ1gDkon8BE9hQRYWdieWu81QM35a7s
	JledKKuBj8Im7zJVfPs4dSuAkOPvMdiPlYP6Ci4Q7wc1d3+Ohwx3k8KYpxBotYYjSd+xgAkShzZ
	nXmIQpZ2adVssUxTo6zCWRQejWVII3HAMBsCdjRL4XSk0HHu+mnqR4/7hOdoeMC5tN7RMh+n7Ey
	fYeDFUAvTij7FmSmlqiA7aue+OnQ7/QZh5OMmrlgltIH48+Qb9PvnofJoMovURTDXmpu4RD+txL
	UiCz5Kvu3ZtfmQByvegBsEfwaGTjK+w0Dr0jK40=
X-Received: by 2002:a05:7300:f68b:b0:368:c6b9:d3c0 with SMTP id 5a478bee46e88-36f76719fd4mr3580740eec.28.1793976000977;
        Fri, 06 Nov 2026 06:40:00 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa6a649csm7182068eec.26.2026.11.06.06.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:39:59 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 4/5] rcu: Add KASAN aux-stack verification test
Date: Fri,  6 Nov 2026 22:39:12 +0800
Message-ID: <20261106143913.3627722-5-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106143913.3627722-1-kunwu.chan@gmail.com>
References: <20261106143913.3627722-1-kunwu.chan@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test module that verifies kasan_record_aux_stack()
recording for RCU callbacks.  The flavor to test is selected at
build time by a Kconfig choice.  The test enqueues a callback from
a noinline helper, drains it while the rcu_head is still allocated,
then frees the rcu_head and triggers a use-after-free report.  The
report should list the enqueue helper under "Last potentially
related work creation:".

Draining before the free keeps the callback from ever running on
freed memory, and the post-call statement in the helper prevents
GCC from tail-calling the enqueue API, which would drop the
helper's frame from the recorded stack.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/Kconfig.debug        |  38 ++++++++++++
 kernel/rcu/Makefile             |   1 +
 kernel/rcu/rcu_kasan_aux_test.c | 107 ++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)
 create mode 100644 kernel/rcu/rcu_kasan_aux_test.c

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 7c3c6017b266..5c6c07d36157 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -53,6 +53,44 @@ config RCU_TORTURE_TEST
 	  Say M if you want the RCU torture tests to build as a module.
 	  Say N if you are unsure.
 
+config RCU_KASAN_AUX_TEST
+	tristate "KASAN aux-stack verification test for RCU callbacks"
+	depends on DEBUG_KERNEL && KASAN_GENERIC
+	help
+	  This option builds a test that verifies that the selected
+	  RCU flavor's callback-enqueueing path records the
+	  enqueueing call path via kasan_record_aux_stack().
+	  The test intentionally triggers a single KASAN
+	  use-after-free report at init time.  The report should
+	  list the enqueue helper under "Last potentially related
+	  work creation:".  Check the kernel log for the report.
+	  Select the RCU flavor to test below.
+
+choice
+	prompt "RCU flavor"
+	depends on RCU_KASAN_AUX_TEST
+
+config RCU_KASAN_AUX_TEST_FLAVOR_TREE
+	bool "Tree RCU (call_rcu)"
+	depends on TREE_RCU
+
+config RCU_KASAN_AUX_TEST_FLAVOR_TINY
+	bool "Tiny RCU (call_rcu)"
+	depends on TINY_RCU
+
+config RCU_KASAN_AUX_TEST_FLAVOR_SRCU_TREE
+	bool "Tree SRCU (call_srcu)"
+	depends on TREE_SRCU
+
+config RCU_KASAN_AUX_TEST_FLAVOR_SRCU_TINY
+	bool "Tiny SRCU (call_srcu)"
+	depends on TINY_SRCU
+
+config RCU_KASAN_AUX_TEST_FLAVOR_TASKS
+	bool "RCU Tasks (call_rcu_tasks)"
+	depends on TASKS_RCU
+endchoice
+
 config RCU_TORTURE_TEST_CHK_RDR_STATE
 	bool "Check rcutorture reader state"
 	depends on RCU_TORTURE_TEST
diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
index 478ef2237fee..bca05ac9c4cc 100644
--- a/kernel/rcu/Makefile
+++ b/kernel/rcu/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_TREE_SRCU) += srcutree.o
 obj-$(CONFIG_TINY_SRCU) += srcutiny.o
 obj-$(CONFIG_HAZPTR_TORTURE_TEST) += hazptrtorture.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
+obj-$(CONFIG_RCU_KASAN_AUX_TEST) += rcu_kasan_aux_test.o
 obj-$(CONFIG_RCU_SCALE_TEST) += rcuscale.o
 obj-$(CONFIG_RCU_REF_SCALE_TEST) += refscale.o
 obj-$(CONFIG_TREE_RCU) += tree.o
diff --git a/kernel/rcu/rcu_kasan_aux_test.c b/kernel/rcu/rcu_kasan_aux_test.c
new file mode 100644
index 000000000000..df3169ac39b0
--- /dev/null
+++ b/kernel/rcu/rcu_kasan_aux_test.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * KASAN auxiliary-stack verification test for RCU callbacks.
+ *
+ * Copyright (C) 2026 Kunwu Chan <kunwu.chan@gmail.com>
+ *
+ * For each supported RCU flavor, this module enqueues a callback
+ * from a noinline helper, drains it while the rcu_head is still
+ * allocated, then frees the rcu_head and immediately reads the
+ * freed memory.  The resulting KASAN use-after-free report should
+ * list the enqueue helper under "Last potentially related work
+ * creation:", which verifies that the flavor's enqueue path called
+ * kasan_record_aux_stack().  Check the kernel log for the report.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/rcupdate.h>
+#include <linux/slab.h>
+#include <linux/srcu.h>
+
+static void aux_test_cb(struct rcu_head *rhp)
+{
+	/* Empty: runs while the rcu_head is still live. */
+}
+
+#ifdef CONFIG_RCU_KASAN_AUX_TEST_FLAVOR_TREE
+static noinline void aux_test_call_rcu_tree(struct rcu_head *rhp,
+					    rcu_callback_t func)
+{
+	call_rcu(rhp, func);
+
+	/*
+	 * Prevent tail-call optimization so that this function remains
+	 * in the stack recorded by kasan_record_aux_stack().
+	 */
+	pr_info("Tree RCU: callback enqueued\n");
+}
+#endif
+
+#ifdef CONFIG_RCU_KASAN_AUX_TEST_FLAVOR_TINY
+static noinline void aux_test_call_rcu_tiny(struct rcu_head *rhp,
+					    rcu_callback_t func)
+{
+	call_rcu(rhp, func);
+	pr_info("Tiny RCU: callback enqueued\n");
+}
+#endif
+
+#if defined(CONFIG_RCU_KASAN_AUX_TEST_FLAVOR_SRCU_TREE) || \
+	defined(CONFIG_RCU_KASAN_AUX_TEST_FLAVOR_SRCU_TINY)
+DEFINE_STATIC_SRCU(test_srcu);
+static noinline void aux_test_call_srcu(struct rcu_head *rhp,
+					rcu_callback_t func)
+{
+	call_srcu(&test_srcu, rhp, func);
+	pr_info("SRCU: callback enqueued\n");
+}
+#endif
+
+#ifdef CONFIG_RCU_KASAN_AUX_TEST_FLAVOR_TASKS
+static noinline void aux_test_call_rcu_tasks(struct rcu_head *rhp,
+					     rcu_callback_t func)
+{
+	call_rcu_tasks(rhp, func);
+	pr_info("RCU Tasks: callback enqueued\n");
+}
+#endif
+
+static int __init aux_test_init(void)
+{
+	struct rcu_head *rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
+
+	if (!rhp)
+		return -ENOMEM;
+
+#if defined(CONFIG_RCU_KASAN_AUX_TEST_FLAVOR_TREE)
+	aux_test_call_rcu_tree(rhp, aux_test_cb);
+	rcu_barrier();
+#elif defined(CONFIG_RCU_KASAN_AUX_TEST_FLAVOR_TINY)
+	aux_test_call_rcu_tiny(rhp, aux_test_cb);
+	rcu_barrier();
+#elif defined(CONFIG_RCU_KASAN_AUX_TEST_FLAVOR_SRCU_TREE) || \
+	defined(CONFIG_RCU_KASAN_AUX_TEST_FLAVOR_SRCU_TINY)
+	aux_test_call_srcu(rhp, aux_test_cb);
+	srcu_barrier(&test_srcu);
+#elif defined(CONFIG_RCU_KASAN_AUX_TEST_FLAVOR_TASKS)
+	aux_test_call_rcu_tasks(rhp, aux_test_cb);
+	rcu_barrier_tasks();
+#else
+#error "No RCU flavor selected for KASAN aux-stack test"
+#endif
+
+	kfree(rhp);
+
+	/* Immediate read of the freed memory to trigger the report. */
+	(void)READ_ONCE(*(u8 *)rhp);
+
+	pr_info("done, see kernel log for the KASAN report\n");
+	return 0;
+}
+
+module_init(aux_test_init);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Kunwu Chan <kunwu.chan@gmail.com>");
+MODULE_DESCRIPTION("KASAN aux-stack verification for RCU callbacks");
-- 
2.43.0

