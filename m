Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C3D47D92D
	for <rcu@vger.kernel.org>; Mon, 11 May 2026 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522103; cv=none; b=dPwYx7/POpvKh79XI7Tj1KXNSyT4YG+C0+BBs5ZQSXOyAkb5RVGWFenYsGfw/jP+WHAsW2Xvfz6+RbO44yB2AZMKtrJ9C9XCiUc5pB21ROt5hm55Tu0+C3nyG0KpAX7xTo7FelWVryStUkK5o5E+R3CnVAvWQym56HkN+ve7TI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522103; c=relaxed/simple;
	bh=aGn8oFIeADYd9zR2os0KsYgOWUkPHLyy0V9cTn+474I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2ggztHYrHYYVwdudAAlsPB9I6U3P7yH+710HsNoFdDBWc2pePE0moYPQR3vo1wUmALbqAoFDelVXRfdbz/RBaXne868SbbFXVyI4hDXQOKLe8V3xdX8wUH0WadzzMfuyll3lF70Y6MKTPlad1cps0XQkpyjVjnyCGP9KwJyj0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0FMVz/D; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0FMVz/D"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8c94cefcdso1177667e87.0
        for <rcu@vger.kernel.org>; Mon, 11 May 2026 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778522099; x=1779126899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgAUP6OLEyhflkklRcpo72fjxpM93txMmwPi2+jDRTQ=;
        b=Q0FMVz/DfjFpaoRaB0RxYuo7jZdhUPrwfuiFUnINQLvMVeocPjBfJBp+9eXeYUd3TW
         cNFJhpPsbm1a6g5AQWuQItnND0ASh0jolLw5CcetOTnb0eJNjIEibZjo0OdhSANmMj3A
         j2qyzRfqLQ9huM9GgSeVjeDL0O/AcN5ZTJF5P/8vD9thqNWfYqK3ovH9Hzk3w/svsuiZ
         IIlrfUyFeQ+CxBrAOFBdDeSUuFA0i2TRE9k7QWRcQXeWkAz34x9KefOKiSV9KpNqnNFJ
         AZqmEDb+G1SpBUNmQpDrFJFG96OnFavuGz8bzxrlorI8KxioRIktsR52vGVf1JFUSXTk
         kmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778522099; x=1779126899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jgAUP6OLEyhflkklRcpo72fjxpM93txMmwPi2+jDRTQ=;
        b=f4SXC6kC/g+O4XTBF6yEb5Ly6KF9u44cFT/o4DlB7GleVj3IfnnxGk82gb9vxgREz3
         6XeLMEn16ZE9U25YuAT863rWTNMdOcrLedmkRVZkQd1QZ2WZAl5WTqaGiTK1FqOYUN/w
         LqtPBMfuR3PJB9A8KE5RyIS54x/EfITWlDeD5Hy5NOt9p82KPoNW11P9N8PEH/bp4i2z
         CWjz5wUUQFogk7Wje9QyyLcafoc0zk0dQO7A3PlBfXyttkiFFTIYf09jUhPtsNAmsux4
         J22cYMSAQ3A7/X2SpWx1OUYPRFvSe2od+YQu0h0SPp0r2Acq2PNCxgqSEQcO1ZXaEReU
         oqbg==
X-Gm-Message-State: AOJu0YxwIJ4P8ztymMEijZiO/UP1QRJlI1BYSAGaZ2eLK4E1Wj6iY4xu
	qxIqCix7YmG1zEoqtF+lqvmTCpmNs9+5SZAXzbBaMMdaawsef1pwVObv
X-Gm-Gg: Acq92OHvsxnJTPhL/uPOvFqz60Ut6mut4bOFGrxaOfc0g+HFWRDrrIH1jX2Wsmd2Y7a
	C1wdyBY2bmZQqowPr+k2r4Fkxm3QBuDLQ4fADwPMXaAJd+py0xBYyN3CYRH5SuSDqhkkUsWJtfk
	UH9TCgK+NTkB+RRlIWrIxKecBPIUlKu97h92TliBms0upLsWIZbvL9jGtievUw9osZsPq5E4TJc
	PQ2dGJkq0mDcka4KIgCQ/qZqes4aL9anG1Z/hEoEy+kApynB95leKiPrC4Ujd8ySeFrISDIQPHK
	RLSVWsn8eERtcFizNfLJ4ojk7DALDZlMNCveiSyW/xb29rJVWi09VfJEM/XduFXciol7028815n
	lz/S1zJvdmLIKCL/ZNQizCXn5e7314VtLDl7MBeNz/C/zgsnPgXgFRKhVymePJdOP5uVcrvKVrN
	XPrI9chQ2o9cwZheI=
X-Received: by 2002:a05:6512:6d0:b0:5a8:74c3:5d9b with SMTP id 2adb3069b0e04-5a8b6c5f46fmr3217767e87.0.1778522098929;
        Mon, 11 May 2026 10:54:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f614a5f4sm28968891fa.33.2026.05.11.10.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:54:58 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH -next v1 12/12] rcu-tasks: Fix possible boot-time tests failed for the call_rcu_tasks()
Date: Mon, 11 May 2026 19:54:48 +0200
Message-ID: <20260511175448.153326-13-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511175448.153326-1-urezki@gmail.com>
References: <20260511175448.153326-1-urezki@gmail.com>
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

