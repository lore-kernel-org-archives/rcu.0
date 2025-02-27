Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D404D1EEE6;
	Thu, 27 Feb 2025 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662179; cv=none; b=NLZcogG3l1JvQ0y4gB8qwWawFIwvIVqgXoosz0NtK31BflZ9Zh7N6suKiI5CXT5BXwBGC0nd0iBtuvAYp5dTcXQuXDO02iaSLRjxD2oZuPtzbbJoNpHD9XPOmyYZM9g9xkMcGUsex+8d/2DZL9a7ihceD/ZZPob877zFeZeRkJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662179; c=relaxed/simple;
	bh=Doo9h8rDILvFD9ZI1R4zrKDhGIvOUHx2tr/WWOpJB30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ExBQa0skSyE3kz/DlmRbK3qck4XPvDcbAXhDSL+BNCIRMbTBiOqwoeUgblfsoG7LQMi4zyMjElgXWTj7OJAEYhrhotiEdTQ3fEZ6b/h9kD+HYzGoC9/uUirFVKa88Fi5aATGs9zPZ9YL2X5IS1AQl25AO0rOvfer4303Gs4fq5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpEt0aAB; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpEt0aAB"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30a2f240156so10940961fa.3;
        Thu, 27 Feb 2025 05:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740662176; x=1741266976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ETdvtoQGgCR4LJwwIoQaYhjASMAk+zxXhtPjP/EhFyY=;
        b=bpEt0aAB6YTisv1enhU8tjnd+NkxJ39x3o613rE7cuf828vh0Ia4JTxcz5D+Yoa1t1
         lnxyE7x3DFRrYCsqhT7IfISGoIWFr0ZYv2ApEQ69NsQ68QSeF3m5MimK4htImTxzFmwr
         HxsDn9bgmGJjZefaC8OohZaVxlKMYapeFGTNmWxt31OoE2fk7Gx8gDncWge0Yfc2JVee
         HHSanGIQhPSgexls+XGOe054ykfoPKDuKz4LMBYJvmSHA9HbQA8vPMf4PyJBrbBn22O6
         vRCltmkYhXdFwekpC97RXARPYOn6gfGtPuAAjDZrFtq8v/ResgLjZ+29Oa+GTslO/tRL
         wtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740662176; x=1741266976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETdvtoQGgCR4LJwwIoQaYhjASMAk+zxXhtPjP/EhFyY=;
        b=a6VJJN3b6fpJY4z513BN09sTt20WnonE/SQ3LIsi4D3tWXfX9+zN7iANIhk733Fhcj
         kcg+U/CknHDtb1+dpxDoXiuCLsfyY1mdp444pXvLsKEcwHAyIuBKJLmdd+XT4aQVA3o/
         c9MsoRn1YHpLHVFqo38Bh37Ox6B6KqwuRMkPG+FL97VM29tGiYwHT8keVuZ38gP+FiHg
         RuWWkaBcPEZS8vDxqr0ZE2LO1zcIV569UBCnLk7FGsnB8DzSs5CQmlcgWfiHY6cvOwQw
         ANDCI3zUdbuayxyL0hv6bzBfTSpVQVstTFjF4HVTmt3TXAPuJUhJFfHtpOOwv00j2O7w
         MqiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZDoJoSrD04i+mCL2nwHu2GrbSxbH30GUB1bphBzOAOlrOhpRvEmwukwq/xZM5Thkqeqw7vKYkrKQCJCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9kjpnY8FWgfVnasYDkepUABqypKi21vYy4LcVAyIT/qSZyOMy
	qRgmMXjBDf5KePcxbfxqcI+rSz1bXB2AlO2MKKsjHE06vxD/Kk0U
X-Gm-Gg: ASbGncuZ1ycxZ3VyRknnxjbidIV7en1vPPtSl2J+I1LTbctBNA2IpeKrb3+gEOgigP+
	3A6x90ju+Y+8bU9xjzZjbY4CL94t5SXd64kLS5tfTW7cwnLNhTao8ZdQYWCV6v2dPwRZil/AX6A
	ST8E1o/jUlnY8DeVXuxCHus3D19/CGQ6TlbZtN+jjHKv76Dg3iifkbjVto+ZGzqODeBVlJFE3hC
	Lghh2HEqxMNvZ72YggIqReGy5+Q7dxPRbc9nEPKPGlSYVg1Lw5gekdtawMnK09GLFKasjDjN1BA
	qPLna6XS2ifciCbp583JGg==
X-Google-Smtp-Source: AGHT+IEj9G/y6WMZtEWxBiJwT5rlV3g8qaMZ7UuKOW/qNLRk8pdyiOSY0W3wEo/Xz/4zo1hpS238Rw==
X-Received: by 2002:a05:6512:3ca5:b0:544:1156:a9d with SMTP id 2adb3069b0e04-5493c578cffmr4346847e87.22.1740662175480;
        Thu, 27 Feb 2025 05:16:15 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54944174505sm157011e87.37.2025.02.27.05.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 05:16:14 -0800 (PST)
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
Subject: [PATCH v4 1/3] rcutorture: Allow a negative value for nfakewriters
Date: Thu, 27 Feb 2025 14:16:11 +0100
Message-Id: <20250227131613.52683-1-urezki@gmail.com>
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

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcutorture.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index e01c0022c175..65095664f5c5 100644
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
@@ -2582,7 +2583,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "nocbs_nthreads=%d nocbs_toggle=%d "
 		 "test_nmis=%d "
 		 "preempt_duration=%d preempt_interval=%d\n",
-		 torture_type, tag, nrealreaders, nfakewriters,
+		 torture_type, tag, nrealreaders, nrealfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
 		 test_boost, cur_ops->can_boost,
@@ -3658,7 +3659,7 @@ rcu_torture_cleanup(void)
 	rcu_torture_reader_mbchk = NULL;
 
 	if (fakewriter_tasks) {
-		for (i = 0; i < nfakewriters; i++)
+		for (i = 0; i < nrealfakewriters; i++)
 			torture_stop_kthread(rcu_torture_fakewriter,
 					     fakewriter_tasks[i]);
 		kfree(fakewriter_tasks);
@@ -4080,6 +4081,14 @@ rcu_torture_init(void)
 
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
@@ -4136,8 +4145,9 @@ rcu_torture_init(void)
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
@@ -4146,7 +4156,7 @@ rcu_torture_init(void)
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

