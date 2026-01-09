Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9234E228CB0
	for <rcu@vger.kernel.org>; Fri,  9 Jan 2026 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767922757; cv=none; b=JWNuWUvbLnF5tiRHZxPqgTDhpM1GgPy2qHJgjaP4sYYMOocG0yu2g/JpG9g0vYWKYNMhHve7R6G2mdketZJ+Yenjuv3I7ykQNbxnIGhCUPzBcRc3wRVx0W5hOBD6Ylmvnm5vS69VXUDmKwTlrjyjmSCk39K9RSYn8e/7AnQ4ep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767922757; c=relaxed/simple;
	bh=PPC7NX2ky94z97LL+o2Dliiog79NuXV9wEsI2rx2Zcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1Hb6I6QJU5QwuCp2XzIZHToU9uN1QXVTpmTkV5XzaUJaeUvt4Zf1qW5nUlSTSgJ9ywCHyLVE0d9X+0yG9+qD2Ip1SwDYj7xj3LODsa9cHy2a/z9k1lau9JNZBFoc3qqJQdMNSkZ7/tmhRjXPhRtsO8/TQhN6ppvdbYsWNm1JGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=C5dN/yp6; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="C5dN/yp6"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ae24015dc0so1363811eec.1
        for <rcu@vger.kernel.org>; Thu, 08 Jan 2026 17:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767922754; x=1768527554; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dJvo7ueweLLuRHlCgBfnBfMmqli0qvfiVgRtcT1/2SE=;
        b=C5dN/yp68GIuTBRhA7mH80jsHJEDqW6yg+mN1ZGpOpyjujAqFYmsxy4CYKr7oQQv/A
         rguT144/zBCIPO8pppGllnJTyXlzGLGP6aWDZSZMpO2dSZkBEMIBnl0P+UW4TVWY+5JM
         2EvR52HzZ3yR5rhC6NlyjPk8B37iMm5aFWrVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767922754; x=1768527554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJvo7ueweLLuRHlCgBfnBfMmqli0qvfiVgRtcT1/2SE=;
        b=ID3NywLCwU+dl2x/k2PSVqbFfswpHnFPIE0cf3bHyIhduKU1rn72sjKQ0IoMtZ7M5P
         tbzp16HU2iXsU6zsRBqngRkeNRN9HSgtB7bED5icQWQOI5n6fCuyGmYrCJLfHSQqtUUQ
         E4c8yskPhKps14bTYFBd01A+vjkGTUQyGXSTxQClujnrC39NJp9mMxf4ubzzW5QVTJka
         JShFXsay0JwxFfVBr5UjWRGnl1uFSKSvp40uFtgQfzgLsQFW1xozKTTmSXvLiS2S5qoH
         VaN1qL4CWJ7wi4tJ5Kz90kyhhF8kGZyuovR+Pre3kgciQVpHh9EvSooj2fhvFUJPevTJ
         3CNA==
X-Forwarded-Encrypted: i=1; AJvYcCV8//dKaCxfnYptFrDTJa22WrqwJS/XbSZhpnjxxdWVEyyOdNsFdpk+t8HKKIyJo8HBba4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3tMXhowsbgfUzzjB6b6FcfOWPuOG7BKjFI0e5Vh3aTkk6beet
	V3g7KtRtaX7Ng/xmnF5iOsBjSEWAvFMUFyZOdBhkI3kQHo+iYCQaDrX28q19qP010lI=
X-Gm-Gg: AY/fxX5kalgEKHUc7hLIOgjNxLwEbhRBXc0qHW/ELxLp3gDBurlvMQYyEvAa1RSHK1g
	tPu6RGZKIO0Nwr8sSwiu/iWdMV80n5A9/huXhGvrvXyFSkaiq4NqBCqEydjUYy9bf6H95vtSpLQ
	I3TnFxs0HUY7niYavyOn3lZxOu0mLaj/GT3ySQ6Rv1ewscj4bbwst0yzRUUR3qb4m5AjMpU40A/
	wv5Z1rl0gGtqHUCJKsDHCU2ACj434tX6ttjhO1wAxxXNNBOLAeNLt0vQssUrfWrMhAcjJlOLM/e
	/7qXMH7KY1jGHpdmu9N6cMbNCUKepGtZNB+GDrjD3zAlMY83mrYFt9LukTPyZ1nBnzYiGKHQchh
	cHbb4GltyPLCg2dEi6ZSKBzNU+o44z3+GNXrWk3JpCrt6LHAjy6f/nJ7C0QuYeVg66XEQosvr1Q
	BsgiRI+rlv
X-Google-Smtp-Source: AGHT+IHoUVHypybcTgdklE8/ULnSnVrNSakulYa/6M6TJUePbDMMkN93P2CjKbVcyXpJbfsc0ucH0w==
X-Received: by 2002:a05:7022:fa04:b0:11a:fb0a:ceca with SMTP id a92af1059eb24-121f1b1f568mr8380710c88.16.1767922753532;
        Thu, 08 Jan 2026 17:39:13 -0800 (PST)
Received: from localhost ([71.219.3.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248bb6esm15223052c88.12.2026.01.08.17.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 17:39:12 -0800 (PST)
Date: Thu, 8 Jan 2026 20:39:11 -0500
From: Joel Fernandes <joel@joelfernandes.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next 3/8] rcu/nocb: Remove unnecessary WakeOvfIsDeferred
 wake path
Message-ID: <20260109013911.GA1102915@joelbox2>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
 <20260101163417.1065705-4-joelagnelf@nvidia.com>
 <aV_T5kLzX2qMpxpt@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aV_T5kLzX2qMpxpt@localhost.localdomain>

On Thu, Jan 08, 2026 at 04:57:26PM +0100, Frederic Weisbecker wrote:
> Le Thu, Jan 01, 2026 at 11:34:12AM -0500, Joel Fernandes a écrit :
> > @@ -974,8 +959,7 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
> >  		return false;
> >  	}
> >  
> > -	ndw = rdp_gp->nocb_defer_wakeup;
> > -	ret = __wake_nocb_gp(rdp_gp, rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
> > +	ret = __wake_nocb_gp(rdp_gp, rdp, false, flags);
> 
> The force parameter can now be removed, right? (same applies to wake_nocb_gp()).
> 
> Other than that:
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Ah true! Thanks, so the following hunk needs to be squashed into the patch
then, with the review tag. Boqun, if you want to do that please do, or I can
send it again for the next merge window.

---8<-----------------------

From: "Joel Fernandes" <joelagnelf@nvidia.com>
Subject: [PATCH] fixup! rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake
 path

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c      |  2 +-
 kernel/rcu/tree.h      |  2 +-
 kernel/rcu/tree_nocb.h | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 293bbd9ac3f4..2921ffb19939 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3769,7 +3769,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	}
 	rcu_nocb_unlock(rdp);
 	if (wake_nocb)
-		wake_nocb_gp(rdp, false);
+		wake_nocb_gp(rdp);
 	smp_store_release(&rdp->barrier_seq_snap, gseq);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 653fb4ba5852..7dfc57e9adb1 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -499,7 +499,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
-static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
+static bool wake_nocb_gp(struct rcu_data *rdp);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, bool lazy);
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index daff2756cd90..c6f1ddecc2d8 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -192,7 +192,7 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 
 static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 			   struct rcu_data *rdp,
-			   bool force, unsigned long flags)
+			   unsigned long flags)
 	__releases(rdp_gp->nocb_gp_lock)
 {
 	bool needwake = false;
@@ -225,13 +225,13 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 /*
  * Kick the GP kthread for this NOCB group.
  */
-static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
+static bool wake_nocb_gp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
-	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
+	return __wake_nocb_gp(rdp_gp, rdp, flags);
 }
 
 #ifdef CONFIG_RCU_LAZY
@@ -553,7 +553,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 					   TPS("WakeLazy"));
 		} else if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
-			wake_nocb_gp(rdp, false);
+			wake_nocb_gp(rdp);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeEmpty"));
 		} else {
@@ -959,7 +959,7 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
 		return false;
 	}
 
-	ret = __wake_nocb_gp(rdp_gp, rdp, false, flags);
+	ret = __wake_nocb_gp(rdp_gp, rdp, flags);
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DeferredWake"));
 
 	return ret;
@@ -1255,7 +1255,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		}
 		rcu_nocb_try_flush_bypass(rdp, jiffies);
 		rcu_nocb_unlock_irqrestore(rdp, flags);
-		wake_nocb_gp(rdp, false);
+		wake_nocb_gp(rdp);
 		sc->nr_to_scan -= _count;
 		count += _count;
 		if (sc->nr_to_scan <= 0)
@@ -1640,7 +1640,7 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
 
-static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
+static bool wake_nocb_gp(struct rcu_data *rdp)
 {
 	return false;
 }
-- 
2.34.1

