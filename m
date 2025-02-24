Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B576286340;
	Mon, 24 Feb 2025 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404226; cv=none; b=PsIBmA63x32i1TYoYCUacvpTf7iSdOpJM56QuswCv0MNX/JHWHz4IL8gV5GW5sVcdBxtk4jmw7ONcxMIoZBai2pZKg8GrXNo6X+o+FbSTTFpkjA17hGF503GJOqRPJAREt6l6qYgwMxRvSFPQDFII1WRtexxqx3PGf9Q1fyIH1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404226; c=relaxed/simple;
	bh=9bv/BkfKEIv9oVjGUQsKqnEbdHXpyR6xGX9zMJD+pwE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qNIQgfRQxpJzOIKRw6eugWI5nxvcKBnbdspjIbA0QfWSaCeaNi9ez+f0AvmPV7qkXbH5GGfdnT3wjMk/jUyBjxKlLuLCZn6qQL6u8LQ2DN5Mqv+01MGEh/8WMHgKILjePlnW+13W2ZS/9PTbguEtNiu/z4H9lu8Tm2WDDyOki34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdtVjHcT; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdtVjHcT"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-546210287c1so4589900e87.2;
        Mon, 24 Feb 2025 05:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740404223; x=1741009023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wdv8+U0yij4s1XgNV9ma7hVlOv6Caj6S/IBFLz/1n8s=;
        b=EdtVjHcTsN7lq5u4hj5DeTtAIzekBw3lZFiqSh4VnVaXrb9l0oWyxEGiEPjU0E01ps
         Dz3obP4TEqZThzHATEoX+XhGnw7li3vpRHA/KiiognY94LTb6C/XsSeBCpjEU3TRdbmw
         skFP+cmi6N6MX2BFPBTrgIyA1lc3hOHmk8B4qA0zWsDEZlbWcII+HImXy8gGQxPLpx4m
         6HXM5xNGK2eGyvKbJ57Rk6Og3BCIkqKX6AABHewDTJQHtCEjRclUl0KTeB3DPMrwUvXP
         B8Ry+gUpXz2CAqsSsoj7OsgFeS2vFjEX39Kep2j1qYYdxbMYmviSZDmUh/hNAvOgxbHG
         UT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740404223; x=1741009023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdv8+U0yij4s1XgNV9ma7hVlOv6Caj6S/IBFLz/1n8s=;
        b=mnQcZt6Ifw33rfpplTCjSal/UX5lkQseuRPdM9fCFOJTYKkFHs82WBKLWQzrkGCZHZ
         hVWyz1HbPehbHSGZ5D5/XaiPEldk2C8yCwigghaeRPfEFHLCjw0V1vNg38n58n7a1euk
         kZwBjBpOcoC9jZlQhQLrgwjjwXuYhcwowMpnCOqvVFb9naT0E+17BxTrPOkV1LmGpZkS
         1HNnuVzqD8+ayny37rljxl9u/Ui3fLo3plnAbuwCrHzNi9ZTuoqIzAEPE1M/FfDTVjpF
         uQaV1fFSQGoBRFLYNBjUM7mNr14D6mpH1gdqW3I+zri5kttB1N+rdYmcoTEyCKufNohW
         tzvA==
X-Forwarded-Encrypted: i=1; AJvYcCUxtP2h0TmBfG6o3zAlzyM3rETGRBXgagGsyYOWGFS/VhKFct61tfhWXzZPcI1SMzup2QxDDzfLozPicX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyDDKajMvtqwqjcNoweZxqD0kc5jdtc3EEp9mnLX92CoSND+8P
	YYipvkO0lqBZsmaIb5jEQBZdHdgW6+dMv+8nWGBtliHjF/FhVPrs
X-Gm-Gg: ASbGncs9DH8ih2P8FVs8FhiUWrbzqA+H3Gr1cOtjzlyQVEKXCGDpPATXxg1TyBXuqPq
	Cio4QKScIYxJQzsyYcwrafq5vVLI0Ux0TAkODs6MP7xpPeKaNybqRwC+FwGLTCrifELoGbKOjxI
	AGjQqQbeD17eBPCv4HXlyAGXDVS1piDUDQBHzm11vNcXMmU0xQIpgHqS9AnGCOZT/02HxAfQGaN
	EXY/g3O5zUJiYtGS2adBLgXts21aBwqqzRay24fyH0Fuz1QN5l7Ra0NSEVek56UkOQAayD2gK9i
	l9e/3+4YVhfemUR+kT1b4Q==
X-Google-Smtp-Source: AGHT+IF9V3z7jyWk2I52KnpgJLgcQTTOJI1gAW4Nz7p5BXjwR8EeAlRkkNBmXL0VdG/Lj6HLGi4t4g==
X-Received: by 2002:a05:6512:1244:b0:545:ee3:f3cd with SMTP id 2adb3069b0e04-5483912fd2dmr4529859e87.9.1740404222396;
        Mon, 24 Feb 2025 05:37:02 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461eb04602sm2424799e87.68.2025.02.24.05.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 05:37:01 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 1/3] rcutorture: Allow a negative value for nfakewriters
Date: Mon, 24 Feb 2025 14:36:57 +0100
Message-Id: <20250224133659.879074-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently "nfakewriters" parameter can be set to any value but
there is no possibility to adjust it automatically based on how
many CPUs a system has where a test is run on.

To address this, if the "nfakewriters" is set to negative it will
be adjusted to num_online_cpus() during torture initialization.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcutorture.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d98b3bd6d91f..f376262532ce 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -148,6 +148,7 @@ MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
 
 static int nrealnocbers;
 static int nrealreaders;
+static int nrealfakewriters;
 static struct task_struct *writer_task;
 static struct task_struct **fakewriter_tasks;
 static struct task_struct **reader_tasks;
@@ -1763,7 +1764,7 @@ rcu_torture_fakewriter(void *arg)
 	do {
 		torture_hrtimeout_jiffies(torture_random(&rand) % 10, &rand);
 		if (cur_ops->cb_barrier != NULL &&
-		    torture_random(&rand) % (nfakewriters * 8) == 0) {
+		    torture_random(&rand) % (nrealfakewriters * 8) == 0) {
 			cur_ops->cb_barrier();
 		} else {
 			switch (synctype[torture_random(&rand) % nsynctypes]) {
@@ -2568,7 +2569,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "nocbs_nthreads=%d nocbs_toggle=%d "
 		 "test_nmis=%d "
 		 "preempt_duration=%d preempt_interval=%d\n",
-		 torture_type, tag, nrealreaders, nfakewriters,
+		 torture_type, tag, nrealreaders, nrealfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
 		 test_boost, cur_ops->can_boost,
@@ -3644,7 +3645,7 @@ rcu_torture_cleanup(void)
 	rcu_torture_reader_mbchk = NULL;
 
 	if (fakewriter_tasks) {
-		for (i = 0; i < nfakewriters; i++)
+		for (i = 0; i < nrealfakewriters; i++)
 			torture_stop_kthread(rcu_torture_fakewriter,
 					     fakewriter_tasks[i]);
 		kfree(fakewriter_tasks);
@@ -4066,6 +4067,14 @@ rcu_torture_init(void)
 
 	rcu_torture_init_srcu_lockdep();
 
+	if (nfakewriters >= 0) {
+		nrealfakewriters = nfakewriters;
+	} else {
+		nrealfakewriters = num_online_cpus() - 2 - nfakewriters;
+		if (nrealfakewriters <= 0)
+			nrealfakewriters = 1;
+	}
+
 	if (nreaders >= 0) {
 		nrealreaders = nreaders;
 	} else {
@@ -4122,8 +4131,9 @@ rcu_torture_init(void)
 					  writer_task);
 	if (torture_init_error(firsterr))
 		goto unwind;
-	if (nfakewriters > 0) {
-		fakewriter_tasks = kcalloc(nfakewriters,
+
+	if (nrealfakewriters > 0) {
+		fakewriter_tasks = kcalloc(nrealfakewriters,
 					   sizeof(fakewriter_tasks[0]),
 					   GFP_KERNEL);
 		if (fakewriter_tasks == NULL) {
@@ -4132,7 +4142,7 @@ rcu_torture_init(void)
 			goto unwind;
 		}
 	}
-	for (i = 0; i < nfakewriters; i++) {
+	for (i = 0; i < nrealfakewriters; i++) {
 		firsterr = torture_create_kthread(rcu_torture_fakewriter,
 						  NULL, fakewriter_tasks[i]);
 		if (torture_init_error(firsterr))
-- 
2.39.5

