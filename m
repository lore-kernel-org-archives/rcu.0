Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8B915ECEE;
	Tue,  7 May 2024 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074562; cv=none; b=Ull7cVf82cS9NcSwb+FSWxIflxJ4Sm7liXz7y5dmjI2kgflNUjDtEyXqHoSrJAYa4PJ7E0EodEYFgQDrLsJTg4ejtoPOOXiSQnGUXoQuLCDuWGvhHFCg0RPd6CICycwVZ7dOSnWCSI3VHNG/cUYp8UmaH6bRCJATXUIm3f7btmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074562; c=relaxed/simple;
	bh=po1Bc4OlQN2l2sQd7lU08kIpHqYxLZA1VMA8exIsmUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UwGgjMryFtwQkF6npD0+BJiDCcjyna3s2v0LOj49w9rgsIYkC5rcBtZRaGdLBF3c7A6kLYL0A/l7wVOR/B3C3bMIUnuF+XL+h/pDg4VHLu7FcTROcZAhXjQQcxKkwFFpFkSgnP0AEb6djBxcoob9/zCY2sOeiJxel6Zo3iIcamA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHZ24tCE; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHZ24tCE"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2db17e8767cso36154381fa.3;
        Tue, 07 May 2024 02:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074557; x=1715679357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDR1Qmw00xm3OT7ACyqw6PuZVtuXarB9fOJED0vsuzo=;
        b=UHZ24tCEUDvRXib+9H4EbocJrIM6EhhBlQ7hu1VHOdbwxs/FCbQZKW1om9ctEkpBzS
         MvxpvLTRjKrT96iubo+O/B3I6XjAOYV1OknJnJasaJ11L0wOdS0T98tyE52Q4SpZ3zkx
         2epBO7I5GApf/cI3OzCvV/3naLDtyrSCFbuyPFPc5wE0tTXNSzzvRBFX0a8RINXFtDNP
         apgvnLlnJc4dlefkIhbPsjm7EkVyy8ia/c//E3q+1cCohBx0F+r36l53xRAf0QplcMgq
         JuSZcXnNJoF+i012N/DFFd4VENvjTGUzRsMqba3st+EQqNmIu6XqlNAyGq3XRcDDzTPw
         nczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074557; x=1715679357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDR1Qmw00xm3OT7ACyqw6PuZVtuXarB9fOJED0vsuzo=;
        b=bhCrDP8gZwRVqzacWdWkv5L3Ht/Un9zpMmC2jEYi2yyGT6ru46YHh2fdmFMx7vBNh7
         Xud1yO4/xg8drtW+BSRWITPecGM6842IYIEmC1+ikJMEFvVOkgItBsmqmQ7pMswKIOsy
         cQhVRJf48yda4itmK1R9mo8K+SRU2a0R43Bcqox2zOzpNTZLXsqSp1deG3pfRtnXIQ9+
         +ub9By9uNQENAp1bRe+UCDZnGbYi2fP93GaJDXwoAWDHUP0tvWlG9jaY0FAmiCBQ9Uqh
         mPqaQ3Ltos9VMqj5VeqhAGgdikAOViwarrvyAv+LASpqniDlLParwjjmgJc9Hd/N0f6X
         MmTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyp5b/gCFlfNh6NG04U24PWpbu6n0kfu1nTMk5PNTf84yNPJur/yRKyRURwpuVS/qBrym+O5WpJYDrPXhqd/wVRUrXHCqhuE+IsB1q
X-Gm-Message-State: AOJu0YzOQyYSBTYKQOtMQpTpI+Zcm6jQHP5BdZWHDbBUkHLp/E0wetyZ
	huL3dWYcYQdokXEMs4PcoV8v9WrYV5KDrwwtdZ51+5wK6tWjBCod
X-Google-Smtp-Source: AGHT+IGGQQ38KZ2VpG4c3sSrj1xA0S5pzEkwKFmmMks9ZmyND9PKewFv0bBW5uRGltNzXdTOUCk8Pw==
X-Received: by 2002:a2e:9f45:0:b0:2e1:f591:a857 with SMTP id v5-20020a2e9f45000000b002e1f591a857mr8358944ljk.34.1715074557467;
        Tue, 07 May 2024 02:35:57 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:57 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 26/48] rcu: Mark loads from rcu_state.n_online_cpus
Date: Tue,  7 May 2024 11:35:08 +0200
Message-Id: <20240507093530.3043-27-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507093530.3043-1-urezki@gmail.com>
References: <20240507093530.3043-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_state.n_online_cpus value is only ever updated by CPU-hotplug
operations, which are serialized.  However, this value is read locklessly.
This commit therefore marks those reads.  While in the area, it also
adds ASSERT_EXCLUSIVE_WRITER() calls just in case parallel CPU hotplug
becomes a thing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c       | 4 +++-
 kernel/rcu/tree_stall.h | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 559f2d0d271f..7149b2d5cdd6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4328,7 +4328,7 @@ EXPORT_SYMBOL_GPL(rcu_lockdep_current_cpu_online);
 // whether spinlocks may be acquired safely.
 static bool rcu_init_invoked(void)
 {
-	return !!rcu_state.n_online_cpus;
+	return !!READ_ONCE(rcu_state.n_online_cpus);
 }
 
 /*
@@ -4538,6 +4538,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	rcu_spawn_rnp_kthreads(rnp);
 	rcu_spawn_cpu_nocb_kthread(cpu);
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.n_online_cpus);
 	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus + 1);
 
 	return 0;
@@ -4806,6 +4807,7 @@ void rcutree_migrate_callbacks(int cpu)
  */
 int rcutree_dead_cpu(unsigned int cpu)
 {
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.n_online_cpus);
 	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
 	// Stop-machine done, so allow nohz_full to disable tick.
 	tick_dep_clear(TICK_DEP_BIT_RCU);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 62b2c4858028..8a2edf6a1ef5 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -628,7 +628,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
 	pr_err("\t(detected by %d, t=%ld jiffies, g=%ld, q=%lu ncpus=%d)\n",
 	       smp_processor_id(), (long)(jiffies - gps),
-	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen, rcu_state.n_online_cpus);
+	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen,
+	       data_race(rcu_state.n_online_cpus)); // Diagnostic read
 	if (ndetected) {
 		rcu_dump_cpu_stacks();
 
@@ -689,7 +690,8 @@ static void print_cpu_stall(unsigned long gps)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
 	pr_err("\t(t=%lu jiffies g=%ld q=%lu ncpus=%d)\n",
 		jiffies - gps,
-		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen, rcu_state.n_online_cpus);
+		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen,
+		data_race(rcu_state.n_online_cpus)); // Diagnostic read
 
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
-- 
2.39.2

