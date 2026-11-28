Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795876084;
	b=uvP7IHL0gQkt+v5oBHap6ZnptydUnBLbmN27cnjvG0T8Y67dkPEsPSJEaDf/CH88bgFq
	 KQ4g7QPHJGdN9bxj/g6J9CsanvekXFdHyprsibAT6oWMvTac+zhUAHV1i6ME7fn1nQb6A
	 Fa+Q9GneAXbJgwJkQZRI4WPVgcgqAo2+O3UTN3wVOV3umRD6rCQUprL2tAO8XfO5eugc4
	 CdoRslltfiB8dEtiCmZDfuJnIp7eMbs7EHB+V9YKCHDiMm+GLTSgoIw6xCAMgSUGAX7SR
	 CvSoLyVw/SO3nu5rB/Y1RdKBucuhZubphCh3zJs37YUMmZMUH21foYoiYv20e1y9spQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795876084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=d319DHQFJ1wXpyJqA1RTBzQQlLy8lj8BbdjFQGNIC74=;
	b=AzyEMsZGB646hY79XGYnFNL7UffrIL2xRyRK0GuEYLN0ysiyiUuML60oKQw2zNIaSvez
	 SUYL8KUEJFvAKxATVODlpOAoH21CoHq0yYXd51eYsrkExXBCyJA5UtTWIYGLcJ2vEQOsN
	 DBlSSlLd2GKOPVE5adtdApWMVxt9AWvD4nnbIw8/d+FTR5oygJoxAcfQhnOUcMOF2qfrS
	 3dxRc4huuS52nrZg2tLvGHoKIYkgeax6TaoAp1U9epXDqvNcKRlfmzNASSb32BeWAmjyK
	 gR9/eD4lPrsy7CQFoJRXhaGoYx781F6rqyzhn6Wii3rabBCbSO+fPpVQuTZYMSAMxPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9L90NVy;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F967606A321
	for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 14:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F967606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9L90NVy
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b86fcbd647so13713263a12.1
        for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 06:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795876082; x=1796480882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d319DHQFJ1wXpyJqA1RTBzQQlLy8lj8BbdjFQGNIC74=;
        b=o9L90NVyGOamVq9aHR4dHAiWMrWyy4OA/6ZiKXYlJNFk7zELLYCTMtQBduR7klXggc
         USRRfI6LV+7wC0Cq9EzjR8lv0s9EikuekSyv9m5AiC05DFGWqi/92y3oRBe7d6aBrvbO
         RLHrYJjYqtTYR4ota2idP1iom/qIEYcfXO+ehYCCEEy9bibMJCbP1C66qpA+MQhmQJFS
         nPMVavRyhBiBjU2B8Drbhgt/Q8/smBXY/hGN4D1o670bJ3Tm0EayE37hNFaEh4pHxvcq
         5aPKWUjB0yLrCIVWxZHvRH1eW0husPtUJuSJqLuBGqpEFmoT1dpltMkcUfKGY+Lw8WGb
         bwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795876082; x=1796480882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d319DHQFJ1wXpyJqA1RTBzQQlLy8lj8BbdjFQGNIC74=;
        b=RsgjzFSC3Xp6YAGR2+hTHHJVN+eqDq1hSeuI+nTHYJ5Ho6D8rlVQLkpV5uXrZ3JnD2
         gZhASHisHE1IMXun8gCey3xnu3sMTSgLLaEsG/HqAUDTsWIbnkUQ7J6C/On2wWIoACdg
         5ER14+Cd++I1XmLJDyCCpgbczNDebXEbsuNLf4Om1eeB03M0sA8hCMIf+OlZURNeGPF4
         7DWXZHrgNkLTcTuSAxBJEIrBNSBMUHRYz9NcFsUmgKki9UInXv6SKid53WxlKarT4aAp
         kGM+Y0f2RmgrC9CYBXHWk+OLFgCNfDXd/zvWcE624nSEQZklaoMxa64uboELMrwj3Z9k
         +z4A==
X-Forwarded-Encrypted: i=1; AL+hErFJ42JhU2RAAcul7zLKRBRlvszEDuYnPKlL9JKwpmRLXAC8QiH2vOaAOTrMJbHy01IWixw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XLAbhQyPzB9LMv5/GsUCTECh5KKl2BEBplNXAsUqG21QmhmAX
	uhRZZA7L8RKM25+zx+ER7FDF683gzkxvDOO3gzZEpVyO3qYldWfUvAPugcWdC02VwJ0=
X-Gm-Gg: AZFdTZf4h1zrLd8qjFO+upt0NLH2cJojxt5ZYA3lhYuAAMbWoQvdllVh0Nl2FLC2dBI
	rR7a5koJWx3/GSo9cQSRP/a6gn7Iy9bdCpTTAC6FnnjKJayOFju7ZszIiha0lwkQzgaGj1VM1Om
	6CaL/cUOYR/o/0+gUIknc/isSV2dhBT0ka1VCPgzUTMddit046nnkHaDgkne3Yae68xrye8vlSu
	pK96GvCoMbTjfoFsCXXBfw+a6soVSsVKgHxOpW4h8St0HYy1XJRU/eh3W/qd/Jz56byyZFWWINJ
	5GTC6zv7n9Ps01Fxz2r9FhiOOH8jSpJPlSTyHevFxU0G7V1L2TmGqnz1fsFAgub3LIxVF+AfIZY
	rFeFAakmbhXedTcRq6xknqiH/hCJvq61rIX3Yrn+jbmvjl3GFwpXCTVKv2ixjYHe2SREvXmKp44
	vDPPcTtcQ5f+xp5Oxvaqvzu4yw5X70hjZLIhEDEEdzTeSD3ZDKGByLuRdUPw9UDI6tUagJlpE14
	R0/rg3Y1BQzlHq9qEEVzSdEaxU6rKpBegzdNlOnfGbkKjMG0suWRvQ7yjnCdCl39aNueZFX1vOI
	Puu4pf6k6jyQcN/7hNvRwU2Fs3EjRKb7rE2MMlXiQtCBWQtJv+GRzbpItOIG/SWDQX0ABSHr4RX
	iiHT3O9xaHniVDbRV
X-Received: by 2002:aa7:d152:0:b0:6b7:b151:fe60 with SMTP id 4fb4d7f45d1cf-6ba1f5a9159mr15402831a12.0.1795876081636;
        Sat, 28 Nov 2026 06:28:01 -0800 (PST)
Received: from kernel.. ([191.40.25.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36e35ca6sm12448436a12.4.2026.11.28.06.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:28:01 -0800 (PST)
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
Subject: [PATCH v3 4/7] rcutorture: Add KASAN aux-stack self-test
Date: Sat, 28 Nov 2026 22:27:26 +0800
Message-ID: <20261128142729.3756679-5-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128142729.3756679-1-kunwu.chan@gmail.com>
References: <20261128142729.3756679-1-kunwu.chan@gmail.com>
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
index a49523c52c759..6425e84194f76 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6227,6 +6227,17 @@ Kernel parameters
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
index 8c264aaf1727a..f9cd90d54165a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -113,6 +113,7 @@ torture_param(int, gp_poll_wi_exp, 128,
 		   "Wait interval for expedited polled grace periods, us (default 128 us)");
 torture_param(bool, gp_sync, false, "Use synchronous GP wait primitives");
 torture_param(int, irqreader, 1, "Allow RCU readers from irq handlers");
+torture_param(bool, kasan_debug, false, "Enable KASAN aux-stack call_rcu() testing");
 torture_param(int, leakpointer, 0, "Leak pointer dereferences from readers");
 torture_param(int, n_barrier_cbs, 0, "# of callbacks/kthreads for barrier testing");
 torture_param(int, n_up_down, 32, "# of concurrent up/down hrtimer-based RCU readers");
@@ -4809,6 +4810,46 @@ static void rcu_test_debug_objects(void)
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
@@ -5376,6 +5417,9 @@ rcu_torture_init(void)
 	if (object_debug)
 		rcu_test_debug_objects();
 
+	if (kasan_debug)
+		rcu_test_kasan();
+
 	if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
 		cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
 
-- 
2.43.0

