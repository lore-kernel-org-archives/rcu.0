Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C22267B97;
	Tue, 25 Feb 2025 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481226; cv=none; b=JOjzBCx1rburyzwlqWdM7T3dhFGmbERfTUxTQw0+bOZH3Cqi9aBdHT8NFm+YeDIRzOji+9pQjCSDXRQKD4nO4nW0t36kExBAet5nuRbGeCJkzAiqf7wAHwI5jedFFZjGGbi1g7ze1r8iCCkhub0Ve6huy4WWPbVSGOO5jjmUqj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481226; c=relaxed/simple;
	bh=3QC7bLLQ/zkEb/zgxj1H5xIc9uVr/+bRhetdiLgORIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qy2VqDNx1J40uNgSTiH9OSgIh1UQC3U6Sp2JMsLWy4wiMH/vbiYUSndVERq0XmXpsOyMaOzWbC6X8SLaV44LhiyMNdsdCRHwUZ+JCGNAMlrEL7uF/DMB6DAMWGHsd0KFOtB3zI0rp+bG2L28F3fUk2gcLSxJ/SiG51GdVd5U8WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMmSyc37; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMmSyc37"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5461f2ca386so4668153e87.1;
        Tue, 25 Feb 2025 03:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740481223; x=1741086023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=miA+E2wD4Pd4SV+NIcjk6rwZpf9OynLUKJ339stxcis=;
        b=bMmSyc378ScpxzmJJBFTAr/qMJQBysla/daIhnk5rdmzb2GAXDBx3RN3pz6O1Wnmli
         kqYS6h2Sdda2aYGjQMtsFFV2rSf/Zzw7BghirbPQp8O89QFq/QSohcwsoGk1rB3Djmrv
         hGoJCl1g56Mtuqy1nYsoeP3C74KfP+Ammml4H2+YAyWJxpilG+1xHWS6qpqV3iWK2q7B
         nDCU9U0+NcKZ0D0WpoP69Pz2A5YRfJF24EYQA50VrVB4cXzt7TBCc5bPAHl89LC1kE5B
         RTb5XnGzxf5jDGdrQdSLnqmhjbOyj1eGPb+Xmbj0KqrmDczQLiGMMP9lfgEz6J9OVC35
         74wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481223; x=1741086023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miA+E2wD4Pd4SV+NIcjk6rwZpf9OynLUKJ339stxcis=;
        b=IOcZXxbLLbytL2R/jkMS1OOxNlI4JMjV7dv5ugDTNep0yTmvWjnvjZzxnccRa8lF6o
         itAPxQAK9u3ttgEdfwaDBoMEn2OuJWpA/VVu9uuYsiivnvF800+Q/bI029rTyDapNQpb
         y1v4oraoTxxh66TKe4hzhDNSPVAeuSJLDyTD1gGrdI0YcBzxheNyVYRTqaHz/wf0CxQ1
         57P2c1Z2Idy9YHtN+o55AITv4BbVYCj9hVCMNHdmyL5qGebqJsY46dHJQtwgGJalwy5J
         oAZ/7NGkjYnVkPLYTjVojdure/IsqkZtFZ8RDHypdDPYfeMHKQnzMBUft3h79Vnz2rS/
         wIxg==
X-Forwarded-Encrypted: i=1; AJvYcCXi+qC8HWA3DzZdBNxk5lRuIUG0YqOvTo6zKsMTahAnHny7+eY57Go7SlrPkF6ss2NNTOf5zRE6cj9xUhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF7Ux96InybvkGDCh853VgHqJMNliSYsdEZO9OL58gPYaF6Jf8
	mWU2vb6ggn1DCZZZjSwoncvvaTws9j2xOoXZtJuC0TbSK+pnqt0d
X-Gm-Gg: ASbGncv/mLaadHav0/03SGDVf6ht33wRcQJ4ebfRgGuQQOnaINzZCxiooI53zIx9j5L
	BbL3lm4wIpn32M5N0WA9qhgWlo9OFIJuijEWCQFVwihPNnO3+MnWSf9GyyRfW5wD3X8TSxWC6i7
	8r8YOcN4IhnwoJ0RsPxn9EBrGylnCkZgoOrL2UetIPPHIOpQm/j6KZFvxnS/uvfRUmAIKwC4RfK
	XCnwx+Ff38k7FIVce5zPZDf7p56hgxNLE+1GKgIuLR0lWXECZX1QizenUo60j9dQFYxhT65ywsg
	mP8rYk2oXPU2I3ohu08ZIw==
X-Google-Smtp-Source: AGHT+IETbAXIoIWzB9fO+htnlh5GeNXoYelbVkB32w3oybvIUeQtcTfGyBpIkXj6AQXbtlpZtX8MDQ==
X-Received: by 2002:a05:6512:3b2b:b0:545:a1a:5576 with SMTP id 2adb3069b0e04-5483914012cmr6514678e87.22.1740481222380;
        Tue, 25 Feb 2025 03:00:22 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b9886sm143850e87.71.2025.02.25.03.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:00:21 -0800 (PST)
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
Subject: [PATCH v3 1/3] rcutorture: Allow a negative value for nfakewriters
Date: Tue, 25 Feb 2025 12:00:18 +0100
Message-Id: <20250225110020.59221-1-urezki@gmail.com>
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

