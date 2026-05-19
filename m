Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2C3B6362
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219936; cv=none; b=ps4IL+XIVA4duP+/CeEUP3fN1SKJdApiPE+SFxQLoj+I1GMBNNifqXgmUQvQB79UxT0g3lsCGiF2hDr2M8Bh3TwLj8A7Wtq2eBFqe7Qkg/zYBB0IRx8Q4GVjPCrCOTTVDr3cAT5dQ4L4WwMKvoNwU8xjPF9ZpkGzaIbgQ+Wf6PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219936; c=relaxed/simple;
	bh=aGn8oFIeADYd9zR2os0KsYgOWUkPHLyy0V9cTn+474I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhanAe38kqxXq4lxX6yVd1pwH1piVw9bm1p5H+3oq7KTVFvwZ4tOfGPABLsNKp+4dy4sycw4ZQS7oUBS3/6esSNf+VbQpenS94Z3uD13wr+jGCi4qiG6tKksP2/USh+H3fpDQivouwL3pLLFRblypJ54VWdffA75jnk6fsBHiKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RD92niPd; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD92niPd"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38e84ed22bdso50339451fa.2
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 12:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779219932; x=1779824732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgAUP6OLEyhflkklRcpo72fjxpM93txMmwPi2+jDRTQ=;
        b=RD92niPdX0KPsWnjbexl68dIZtonhA0psOyhc7G2IO6XBEeO69+WADTp1KrflnO7mb
         Wcc+SA2JKx1q72y6tyAFDIDzrsqsQKEOkeGPps7hswOU91lNljknqO1xN+ZUAnL4Bo01
         p1fiR3bW9q8dF8FWS454eLa+hB5rkM2eCxwJ0VF5uSaGtNpQMiWm4NY3yE40ZiCRqXHn
         Y0SKqyLgLn7voafra8t26KeWEtXlzS2xZgaxs55EsrEN1xVvzKDCgUBsDamcsI+eTkey
         yqQHuBEfEwrlixEAsB24PwoJOWEXm4RGwjwESq15ZT8vPYYrYUOWkTBs7e10Nufe0nAr
         iNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779219932; x=1779824732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jgAUP6OLEyhflkklRcpo72fjxpM93txMmwPi2+jDRTQ=;
        b=BLG4RdzHxFfadq/0IAXKcGYSPOKigtb1/csBk1X6scIdmO3g6/f5uoGap6nbN+FwUh
         gbzdT3IDf7k6TZrcozZdlSfgO+toiO3a07J9H065jTGHvl2+yISASyWgEtbhSHamKbZp
         kQw9CVzmCCI4+OpVGimFB1xo2s2OBA42C7l2KMQGuZgrBppVTBQpUlNsX0iQ4Lp76xTc
         9nUuF6xoANDTiSqgtU5/yv5e14MuVsLUpMZpKKjt8fDyVTxihS+HFAN1gtF4GUfHd0V7
         p+h19nXMuDB9stFkEofoCzcxuVC5gVg+0urVx4YYN8Y3bifkLqpRTjIkgbn26WV2+c7y
         z6Gg==
X-Gm-Message-State: AOJu0YyefZ2ojQ9y9RCtADLhG/LNscTWOhD4Ev/1WYD+TFJ2qQDlLGBP
	XMhqZMe/MdtE/3Sewl3sgDqhh7dhWNBOhUbw6g9dWjGralVpEQDxuy46UOydEQqn
X-Gm-Gg: Acq92OHiicysPW3MASWeyba5C5Cw1Vw9L7dIrx3iwoffinXBNUlKdiG9Fwu0z3QKVnG
	eUkwwkcbA35HCmYO6xpDiD0drgLUO+koNVG+CLcZRoVAnDg0UvsdiifOlsWXoQBB13g0rZMUJ11
	myuEG+yFkkstK+SYI3LxA4uMHK1JxXY6NIPhY++owVNO+Xh2tQhhTCMmoSgCe/aI1vdGNA6CI/l
	FbLH/6zvsRKT+pxjeLv+3kwFHbRSeqcJi4YNnNvsFWHuUoQhV8bqDxDggPDzhiYHMs1BdYC57MA
	sooX8gL4xIwFuHSY20JD+QXa++V6KfW22xYdv+EocXPtUK8HZlzWiKZtsoNbWwd71Q5WyPCa5r7
	n2RfebQBYKGI2F1zK9qxRm7QO0SrYVfnEzZ9VOlalQtbivDj3G4V7hPQIiyVHzCZUNMrW8CcNxO
	AQ9oTtatHgO3dIyRk=
X-Received: by 2002:a05:651c:e18:b0:394:5a09:e8af with SMTP id 38308e7fff4ca-39561adbaa3mr54361861fa.1.1779219932386;
        Tue, 19 May 2026 12:45:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958827ec3fsm23558761fa.9.2026.05.19.12.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:45:32 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH -next v2 11/11] rcu-tasks: Fix possible boot-time tests failed for the call_rcu_tasks()
Date: Tue, 19 May 2026 21:45:24 +0200
Message-ID: <20260519194524.158515-12-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519194524.158515-1-urezki@gmail.com>
References: <20260519194524.158515-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

The following scenarios will cause the call_rcu_tasks() boot-time
tests failed:

                     CPU0								CPU1

rcu_init_tasks_generic()
->rcu_tasks_initiate_self_tests()
  ->call_rcu_tasks_trace(&tests[1].rh, test_rcu_tasks_callback)
    ->call_rcu_tasks_generic()
      ->havekthread = smp_load_acquire(&rtp->kthread_ptr)
       "The havekthread is false"
    ....
								       rcu_tasks_kthread()
								       ->smp_store_release(&rtp->kthread_ptr, current)
								         ->rcu_tasks_one_gp()
								           ->rcuwait_wait_event()
								             ->rcu_tasks_need_gpcb()
								               ->for (cpu = 0; cpu < dequeue_limit; cpu++)
								                 ->rcu_segcblist_n_cbs(&rtpcp->cblist) == 0
								           ->schedule()

     ->raw_spin_trylock_rcu_node()
     ->needwake = (func == wakeme_after_rcu) ||
     (rcu_segcblist_n_cbs(&rtpcp->cblist) == rcu_task_lazy_lim)

       "the rcu_task_lazy_lim default value is 32, and the
        func pointer is test_rcu_tasks_callback, lead to needwake
        is false."

     ->if (havekthread && !needwake && !timer_pending(&rtpcp->lazy_timer))
        "the havekthread is false, will not enter here."
     ....

        "the needwake is false lead to rtp_irq_work can not queue,
         even if the rtp->kthread_ptr already exists at this point."

      ->if (needwake && READ_ONCE(rtp->kthread_ptr))
        ->irq_work_queue(&rtpcp->rtp_irq_work)

For the above scenarios, if the call_rcu_tasks() is not called again
afterward, the rcu_tasks_kthread will not have a chance to be wakeup,
the test_rcu_tasks_callback() will never be called, the boot-time tests
failed can happen, this commit therefore check havekthread variable, if
it's false and the rtpcp->cblist is empty, set needwake variable is true,
if the rtp->kthread_ptr exist, the rtpcp->rtp_irq_work can be queued to
wakeup rcu_tasks_kthread.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tasks.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 48f0d803c8e2..f4da5fad70f5 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -373,7 +373,8 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	// Queuing callbacks before initialization not yet supported.
 	if (WARN_ON_ONCE(!rcu_segcblist_is_enabled(&rtpcp->cblist)))
 		rcu_segcblist_init(&rtpcp->cblist);
-	needwake = (func == wakeme_after_rcu) ||
+	needwake = (!havekthread && rcu_segcblist_empty(&rtpcp->cblist)) ||
+		   (func == wakeme_after_rcu) ||
 		   (rcu_segcblist_n_cbs(&rtpcp->cblist) == rcu_task_lazy_lim);
 	if (havekthread && !needwake && !timer_pending(&rtpcp->lazy_timer)) {
 		if (rtp->lazy_jiffies)
-- 
2.47.3

