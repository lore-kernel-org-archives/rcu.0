Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991958;
	b=pcD7ItVlxvAOs0rjhBibUzYkfYlwJU7MNlFFoU3p6tNKWQAxDyRWRBHpoKw81TooXzeI
	 fbPTmw5wPfd94THYWUgfMGL+gVKZF6JbZBvJi/iMc6RwQOFOTvOnTl/wRmfzEBSsASjl/
	 0jkeEurdRH5iyxeUUXbJNmZQheqgwQqJ0hfbnv1uuhTPieeIfuFH85fqVYuVyAbWtJnl9
	 ooxdzQdTktUAfOGu+ngT0q9rVbfSBwiMMYKai0k7bhdz8fOnCtrwf49szJpzO4jHR52+K
	 KnFKbpkm3ad2EfRUDqwxFvbXeBC7H5USVdo4xCritggWs1KnHdtF7onm4454HJz286w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cmclyy+oqh2tP8YaWR+pfirFW50GH14lOaNjbDPN0Cw=;
	b=vwbZA8FJhWdKm1aN+T9OthnSexSlLPlDm3hyA9TDzSuzncxsJXslZ7nb1ktiRERcNo/e
	 aeoGr6vrAyxrvi6tBHqDJfSlJmhxELRT+eMR6Aj94FCD+1joMGuKZ3KB21Un1tpLm0tVx
	 rfn6PEq21ji2JDVFirFQvJtJm1lys9oYeythbG6cbfmvOFCggM1YhLcjuMaNEku5C/eT6
	 LnDzbEVDmSP11K1izcoKVYNwbZ8kwGbYM7nQtWK/ORgvAjxrbX0Fl0/Aod48NmGL2E8Wy
	 nvBbQLMcPiBUevz7ztnLPO3zjJwktvm3BR0VlYxBpuG3d8I/Ns5JoLd1iiYj1w4rnAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XAp6m8pL;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA845606A325
	for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 08:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA845606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XAp6m8pL
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c50933bdf4bso159634366b.1
        for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 00:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794991956; x=1795596756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cmclyy+oqh2tP8YaWR+pfirFW50GH14lOaNjbDPN0Cw=;
        b=XAp6m8pLBTS6qgDNHMFpn/BOdvNiOdHvPmkhQiUqH8Ik3NRAl6oD6JOt2mWcs4CZoK
         vY3jnYh+t5FIECZdNjztFz3Z0qCE5H4t4BCy1skNQyWTdWI28Y/g6Nb6z2OlIXE1FTY/
         zFKtGn1I3tyo+EOIepd9FBaacekCAuazEFdAI3DR3sWH5fMgp8FMdaLIb8qlvzK2DhyG
         LmMiAoNMA4NAsa0nM4Izh0ZlIStMJZxE4PK4RmEp7CzdeBclLRLpQCdGnU7ffLmM53+w
         f7l1em7fE3MiRusz+B6hizyk2nfHOQHO6HZVsiijZcxLxnEKxdo45yqp2zbAPQtH2XtP
         DU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794991956; x=1795596756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cmclyy+oqh2tP8YaWR+pfirFW50GH14lOaNjbDPN0Cw=;
        b=siBBAee5VMPSnYYrXXapvksfzqESiNhG3EH4QiwVKiT3LbzgDvVVU16GrvVequwEpn
         2echNsQqI33bgiW+5BhSoTWQObMOUKG8qymAana2+xx1JgOtK822LuYfhQbbz37Xyo14
         np4a4jfcDK4WLBjmUeqZo1bH3KO88KJg1RbfRnth2G51zYyxLlvm6dWghlYSyn12Y5cW
         iqvarA0eAjUHQYZYxSLqmSywRHW9UgryuHT1q2iNXRFqJZKlFku5q0ro1cKcpUN29IyS
         +XCAPaT2wKdeQ/D/M/gFgmrJu+mBqDv8tOEcj+QJ1cqrDuJCqveNCX5LVbum8heOqBSz
         w4gA==
X-Forwarded-Encrypted: i=1; AL+hErEb/iCVPOaaT78tuBoURVcoVvp4HWSuwDFINzeaabQaNahSH5XuPwN8y+Ox65ugZJg62Xk=@vger.kernel.org
X-Gm-Message-State: APuU4Z92M1Xjlvwn8YAlDM53z4H9SDrdA70rPBfEMiav4Dbti3BHUtFE
	QoWv/lreDRcGj/SOIVGPI1a/Uo8TA737B6EhM4TGy8j7KPYp5QSFBDfe
X-Gm-Gg: AYBFou0VtJgwYKPIpNjFunm/mgofuR75TBfcMxU6BVWiYWFYCglFz5dyOMLtIHyRiJi
	DyKT+jg0odKcEeS6Xie4up3dTaah9GS0uUNB2KPm2EfS96F1PTAfGxEara9HNPsCe/r5clPnBPY
	Gv6OUq3sH6Wr0mdqkBDmyyZrwdCQd2ZP23H91lTRjtRhT1A5q2QQte4nrAW139EHfTRipIWDKRt
	6j+SJa3Co7vifceIcr7KraiCrz17jb4vyifwxS0aVxnedINWXw4FtUS9Mznx94fHX+puvNcNM/W
	sWr2bxrAVymWSFPofu0IPmucv62pyLqesAPumDYAhG2kk3IR9MsGa5kD8TbgAJQsSeKa/ZdOgo1
	wCXkf/9ji/5FwQn6QlhRH4veNioMNsyF6n92R59OZsD3HQ0KUmvaRQg68KkXtZhketeurFOYtOM
	rVQz1Sw5OZc+xTZq4UlSLmC8Jv/xIH1CGYcS1c7/SMRSTY7I8eIINMHAtgKRIMkUFn3GA3sZD1N
	ZYCO0n55sdCZvcNkCU4cg6mXJNd7pDj78MjImdTZRmAcelD5ZS+f2KI2nKR8py9W66p43h5env1
	/N4C6EjzRmyrQqVABmt5EjrIVO8y5bE6sVOe
X-Received: by 2002:a17:907:6d11:b0:c49:8bf8:a7a7 with SMTP id a640c23a62f3a-c510e158af7mr146788466b.7.1794991955656;
        Wed, 18 Nov 2026 00:52:35 -0800 (PST)
Received: from kernel.. ([191.40.25.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83f31csm71077266b.10.2026.11.18.00.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 00:52:35 -0800 (PST)
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
Subject: [PATCH v2 5/7] rcutorture: Add KASAN aux-stack self-test
Date: Wed, 18 Nov 2026 16:51:45 +0800
Message-ID: <20261118085147.1668598-6-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118085147.1668598-1-kunwu.chan@gmail.com>
References: <20261118085147.1668598-1-kunwu.chan@gmail.com>
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

Add rcutorture.kasan_debug to queue and drain an empty callback,
then free and read its rcu_head to trigger a KASAN report.

Check "Last potentially related work creation:" for rcu_test_kasan()
and the enqueue path. The intentional report makes kvm.sh exit 3
(runtime errors), even if rcutorture prints SUCCESS.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Suggested-by: Zqiang <qiang.zhang@linux.dev>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 .../admin-guide/kernel-parameters.txt         | 11 +++++
 kernel/rcu/rcutorture.c                       | 44 +++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e3c5a6b68fc34..d88471dbdee40 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6257,6 +6257,17 @@ Kernel parameters
 			accurately, from a timer handler.  Not all RCU
 			flavors take kindly to this sort of thing.
 
+	rcutorture.kasan_debug= [KNL]
+			Enable an intentional KASAN use-after-free test of
+			callback enqueue-stack recording. Requires
+			CONFIG_KASAN_GENERIC and a torture flavor with
+			callback and barrier operations. Inspect "Last
+			potentially related work creation" in the report
+			for the enqueue stack. Disabled by default.
+			Use a dedicated test run: the report taints the
+			kernel and suppresses later KASAN reports unless
+			kasan_multi_shot is enabled.
+
 	rcutorture.leakpointer= [KNL]
 			Leak an RCU-protected pointer out of the reader.
 			This can of course result in splats, and is
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 0e8366eb2efb5..5051ec0a853b9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -112,6 +112,7 @@ torture_param(int, gp_poll_wi_exp, 128,
 		   "Wait interval for expedited polled grace periods, us (default 128 us)");
 torture_param(bool, gp_sync, false, "Use synchronous GP wait primitives");
 torture_param(int, irqreader, 1, "Allow RCU readers from irq handlers");
+torture_param(bool, kasan_debug, false, "Enable KASAN aux-stack call_rcu() testing");
 torture_param(int, leakpointer, 0, "Leak pointer dereferences from readers");
 torture_param(int, n_barrier_cbs, 0, "# of callbacks/kthreads for barrier testing");
 torture_param(int, n_up_down, 32, "# of concurrent up/down hrtimer-based RCU readers");
@@ -4639,6 +4640,46 @@ static void rcu_test_debug_objects(void)
 	kfree(rhp);
 }
 
+/*
+ * Trigger a KASAN use-after-free report after draining a callback. Check
+ * "Last potentially related work creation" for the callback enqueue stack.
+ */
+static noinline void rcu_test_kasan(void)
+{
+	struct rcu_head *rhp;
+
+	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
+		pr_alert("%s: !CONFIG_KASAN_GENERIC, not testing KASAN aux stack call_%s()\n",
+			 KBUILD_MODNAME, cur_ops->name);
+		return;
+	}
+
+	if (!cur_ops->call || !cur_ops->cb_barrier) {
+		pr_alert("%s: %s has no callback/barrier ops, skipping KASAN test\n",
+			 KBUILD_MODNAME, cur_ops->name);
+		return;
+	}
+
+	rhp = kmalloc_obj(*rhp);
+	if (!rhp) {
+		pr_alert("%s: KASAN aux-stack test skipped: allocation failed\n", KBUILD_MODNAME);
+		return;
+	}
+
+	pr_alert("%s: WARN: KASAN aux-stack call_%s() test starting.\n",
+		 KBUILD_MODNAME, cur_ops->name);
+
+	/* Keep the rcu_head allocated until all callbacks have completed. */
+	cur_ops->call(rhp, rcu_torture_leak_cb);
+	cur_ops->cb_barrier();
+
+	kfree(rhp);
+	/* Intentional use-after-free to display the recorded enqueue stack. */
+	(void)READ_ONCE(*(u8 *)rhp);
+	pr_alert("%s: WARN: KASAN aux-stack call_%s() test complete.\n",
+		 KBUILD_MODNAME, cur_ops->name);
+}
+
 static void rcutorture_sync(void)
 {
 	static unsigned long n;
@@ -5198,6 +5239,9 @@ rcu_torture_init(void)
 	if (object_debug)
 		rcu_test_debug_objects();
 
+	if (kasan_debug)
+		rcu_test_kasan();
+
 	if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
 		cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
 
-- 
2.43.0

