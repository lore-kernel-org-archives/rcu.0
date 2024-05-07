Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA3415EFA1;
	Tue,  7 May 2024 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074564; cv=none; b=nyXYf5yaydlkd9Ep4xR9UK4NNkKcwHpY9++tl9G5rJYgp51IdZlptdLEOhdWB/uIHN9S5NUPnmsVxEHfREK08ML7lp8cdES0mKeaTY7Y8NDJXLiFZbRUVYxvuchA+oR473UgwKGMeuRfht5rcWo3Mjq0MzU3ed4NNquajn5oRQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074564; c=relaxed/simple;
	bh=xLIkzUhYqkpoaAiaQxcqMO2Ytt7HUJ27tzDsmg6WfCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KGvrZwkCnvz21DEXX0kMIy953m2/j3ehMq0QlHuJYIiF9J1ABgoagpo5KkK4kY6W/Ah7PssGWp8SMP/9myLWUJ2kikzjgs8dS/iQuMdWW1v2bY9bNkduZP4vozJg/ZBt2TUyNZVJwHQ51dA/u52xVcTFS+hMyz43CuDosqUzkf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URAp9JHq; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URAp9JHq"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e3e1ad0b19so8252951fa.0;
        Tue, 07 May 2024 02:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074559; x=1715679359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdJY0TZw/fjltnhvg0EPkwklXe5dzlu0wabU2jZ/52w=;
        b=URAp9JHq9K2vrhXWLr9yPZnKObzQo/IvLOJCvDYgJLqZP1m6Yq2dIQEGSvV+2snydK
         H0rHvmue5VnuKh1SWZn88El1ANktAsHPMRj8qfQ7k7tgID7ZDmpSFDiVWmnBvS1Co2FT
         4K55opFA4KFxQW7Hz9mj+/7l8Sn0iwEbWPhmQJMHYsx8d+tlxmr4MIfaTHmo7fVJZeNE
         ZO64dQhiVMsrkN3eSFLda2iwm60hyH2WS4Eg5pS2rLI8qZG63hPdokF8Lr3Bue1u10Ub
         95apv8G7Lea70EK/FXmbCPpPmh+EoEsms+pNnwdtOa2jf37H7+WILmiQD/sQm8NzoNyQ
         AvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074559; x=1715679359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdJY0TZw/fjltnhvg0EPkwklXe5dzlu0wabU2jZ/52w=;
        b=t4ONy/ykzgRW0YvxTb3Cu5nBUj/3nrxNWcmFSU9sOEvGCrtNrAu5vxTshQesEcb/NK
         57EaMdjrSMQs9b2dBUND4MmKvk/U/DRrem++MyMafaX9P1vz5oLmYZc8legrMRjNjA3r
         gUx6kR6Yu2EW6hoDBQBYMP0xJGyYjrmp4QTpbnd8gs0tYuJsD/z6E+CfOXwj/0/djHLi
         /At2MhaOeDTbFWhPFGfbCWCWhzRty80EPvbgNsQ+40KRVXtCEKsHhH753LyW6Y45Qm4b
         zqf8e4J2Llzo92rqoWD2/zpwQo3DZR5XqaQpu2wubQQe+j3f9IZBkc29PmnXH8QXzPAz
         WaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuLWELE/29xUT1pzgTuZoHKtp3VKjfHnLbQHJf3Cc45qodu7zad6iEkRJDyyBrkJimo87xCQgZlNJI9FGA2EqRKq/Zkau5WMGyWH16
X-Gm-Message-State: AOJu0YwMnMcRNeenSx99x4B2HE5Dpi/KC3OdVi8Bj+jd2bGWIoPT+UIr
	MzXt7sqFhU33gjsYmspUc6HeuuyAkotvuAl9XyCJFeuTsee8yHF6
X-Google-Smtp-Source: AGHT+IEA+c+gDL6J8ZrBuC+CGl6J+uw0YGSUA+D3NFyQuktUotuVGX88q5QGcMdQcwvZvDQ8PfEoXg==
X-Received: by 2002:a2e:2406:0:b0:2e2:5fd:7030 with SMTP id k6-20020a2e2406000000b002e205fd7030mr7916249ljk.13.1715074558517;
        Tue, 07 May 2024 02:35:58 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:58 -0700 (PDT)
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
Subject: [PATCH 27/48] rcu: Make hotplug operations track GP state, not flags
Date: Tue,  7 May 2024 11:35:09 +0200
Message-Id: <20240507093530.3043-28-urezki@gmail.com>
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

Currently, there are rcu_data structure fields named ->rcu_onl_gp_seq
and ->rcu_ofl_gp_seq that track the rcu_state.gp_flags field at the
time of the corresponding CPU's last online or offline operation,
respectively.  However, this information is not particularly useful.
It would be better to instead track the grace period state kept
in rcu_state.gp_state.  This would also be consistent with the
initialization in rcu_boot_init_percpu_data(), which is to RCU_GP_CLEANED
(an rcu_state.gp_state value), and also with the diagnostics in
rcu_implicit_dynticks_qs(), whose format is consistent with an integer,
not a bitmask.

This commit therefore makes this change and changes the names to
->rcu_onl_gp_flags and ->rcu_ofl_gp_flags, respectively.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c        | 12 ++++++------
 kernel/rcu/tree.h        |  4 ++--
 kernel/rcu/tree_plugin.h |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7149b2d5cdd6..306f55b81d10 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -841,8 +841,8 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 				__func__, rnp1->grplo, rnp1->grphi, rnp1->qsmask, rnp1->qsmaskinit, rnp1->qsmaskinitnext, rnp1->rcu_gp_init_mask);
 		pr_info("%s %d: %c online: %ld(%d) offline: %ld(%d)\n",
 			__func__, rdp->cpu, ".o"[rcu_rdp_cpu_online(rdp)],
-			(long)rdp->rcu_onl_gp_seq, rdp->rcu_onl_gp_flags,
-			(long)rdp->rcu_ofl_gp_seq, rdp->rcu_ofl_gp_flags);
+			(long)rdp->rcu_onl_gp_seq, rdp->rcu_onl_gp_state,
+			(long)rdp->rcu_ofl_gp_seq, rdp->rcu_ofl_gp_state);
 		return 1; /* Break things loose after complaining. */
 	}
 
@@ -4420,9 +4420,9 @@ rcu_boot_init_percpu_data(int cpu)
 	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu)));
 	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
-	rdp->rcu_ofl_gp_flags = RCU_GP_CLEANED;
+	rdp->rcu_ofl_gp_state = RCU_GP_CLEANED;
 	rdp->rcu_onl_gp_seq = rcu_state.gp_seq;
-	rdp->rcu_onl_gp_flags = RCU_GP_CLEANED;
+	rdp->rcu_onl_gp_state = RCU_GP_CLEANED;
 	rdp->last_sched_clock = jiffies;
 	rdp->cpu = cpu;
 	rcu_boot_init_nocb_percpu_data(rdp);
@@ -4682,7 +4682,7 @@ void rcutree_report_cpu_starting(unsigned int cpu)
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
 	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
-	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
+	rdp->rcu_onl_gp_state = READ_ONCE(rcu_state.gp_state);
 
 	/* An incoming CPU should never be blocking a grace period. */
 	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
@@ -4733,7 +4733,7 @@ void rcutree_report_cpu_dead(void)
 	arch_spin_lock(&rcu_state.ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
-	rdp->rcu_ofl_gp_flags = READ_ONCE(rcu_state.gp_flags);
+	rdp->rcu_ofl_gp_state = READ_ONCE(rcu_state.gp_state);
 	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
 		/* Report quiescent state -before- changing ->qsmaskinitnext! */
 		rcu_disable_urgency_upon_qs(rdp);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index df48160b3136..ff4d8b60554b 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -273,9 +273,9 @@ struct rcu_data {
 	bool rcu_iw_pending;		/* Is ->rcu_iw pending? */
 	unsigned long rcu_iw_gp_seq;	/* ->gp_seq associated with ->rcu_iw. */
 	unsigned long rcu_ofl_gp_seq;	/* ->gp_seq at last offline. */
-	short rcu_ofl_gp_flags;		/* ->gp_flags at last offline. */
+	short rcu_ofl_gp_state;		/* ->gp_state at last offline. */
 	unsigned long rcu_onl_gp_seq;	/* ->gp_seq at last online. */
-	short rcu_onl_gp_flags;		/* ->gp_flags at last online. */
+	short rcu_onl_gp_state;		/* ->gp_state at last online. */
 	unsigned long last_fqs_resched;	/* Time of last rcu_resched(). */
 	unsigned long last_sched_clock;	/* Jiffies of last rcu_sched_clock_irq(). */
 	struct rcu_snap_record snap_record; /* Snapshot of core stats at half of */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 36a8b5dbf5b5..340bbefe5f65 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -805,8 +805,8 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		pr_info("\t%d: %c online: %ld(%d) offline: %ld(%d)\n",
 			cpu, ".o"[rcu_rdp_cpu_online(rdp)],
-			(long)rdp->rcu_onl_gp_seq, rdp->rcu_onl_gp_flags,
-			(long)rdp->rcu_ofl_gp_seq, rdp->rcu_ofl_gp_flags);
+			(long)rdp->rcu_onl_gp_seq, rdp->rcu_onl_gp_state,
+			(long)rdp->rcu_ofl_gp_seq, rdp->rcu_ofl_gp_state);
 	}
 }
 
-- 
2.39.2

