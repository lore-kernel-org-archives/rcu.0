Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3773615F30E;
	Tue,  7 May 2024 09:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074568; cv=none; b=NgZQu1AqPLt05yydGhAeXQWselBcvuDgWStLKi6DhVtiT5T6LflRUt9rA/PKsVe7SXBJl8LFgkilxxCeRyZQKFBABdhdKqb7mJ8OvJvHAFWb8HdMFWx2ih5Fx2klZSAKvu1b5WzjD6oQ8SZPjMGO/CkhAeP/AVCIsYL3Ql607Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074568; c=relaxed/simple;
	bh=epMddOCm5gZ2sI6W3hNDMzNbpLcxxjqRybXWGAgKqCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VqoZQPzb+PiEpJuwRycMSuU0ee8udHlj6ykPORaoAsG5478SOp5jZXOeREWQRE7Hci00tnesRiMDCYeInznYtMTpdKMp7ve3T7/v0wo1mOtCrZ/kYNEyhgYBhjD7gOWaoPWUSALAe+B7Mwi/vGuNoIT7uvrpXDG2ied5ItvhHLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5tTyf8D; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5tTyf8D"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e367c2457bso20450891fa.1;
        Tue, 07 May 2024 02:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074562; x=1715679362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cW00ztMzynhHfGhSqSCg5j9h7Fte9U/1sreRcK4DNwg=;
        b=N5tTyf8DToOG/UJkvgW5UHJnuNvCFjRg+qn3c3EYXAqIwbb8lmfaPmU9oCVXT1wom7
         0cXDCWb+RuXMug6O4OBrH7gozxoz6WC0PDW5/azL91R96umis+T4og9n2CJRJa9LYxr/
         ATaTF7cQ1epjdBKUqBLcUnPFMjBIYOz4mpcxwZsHqOKY3AjRFO/qFwpb85iDh1JXxWL6
         nY6pzi+Be+Ysf3B3pWSHNoYA2apwPqgOmWEiOuechHJbl+wszK1YaA3TK1KohWRWLAmt
         fOuBhWKEzum57AUilmy+iSg4A7S7JBrKr2b2/n3sruiBoarM9RMr2QnuYdOkdBptaec9
         q5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074562; x=1715679362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cW00ztMzynhHfGhSqSCg5j9h7Fte9U/1sreRcK4DNwg=;
        b=AoULq1Vkeqi+lzdO2/iyuf4/g6M3i7s1BtJP6WVtfIsXBTE9FbPVLtcW+2qpE5LOWf
         k08ewn9IkHsIZa4L2fM5qj/Jz9aJ7nMsljF+1rpXxX+uFyddD/yN78sdRX6ez7HZEz8M
         qo8CU7Ec1wQE1Ri9vRDXu4m0FQnZepcgT4uCN6QfADOaNy/UHVryMLVOErx9ha15JeEt
         7RWCjWOpavUFRFCPzCXg+wEbKOC1UhogM+wAUe1Cvw4IOWeymJRSbwivFG3qjrLv9RUG
         c17IJRwogjyTboEABEwf+HxPaesjLMZp0UKRg5EQssBaIaQ+QA8Z8y6wdOKdukA0sBun
         72zg==
X-Forwarded-Encrypted: i=1; AJvYcCVA34JaSv+zdJkQJ1zGRAvA/jfvrZlSgVgJ3zFE+AvT47MtwKhc4v7Rh4DXe5JL2+vipCLIt30voyBKH8mtIheE0hreLKeqM35pXPMQ
X-Gm-Message-State: AOJu0YzcXovYNAkYc84lMPg5i6xVkQvK/UFki8mbAVAYA0ldxspQhrGW
	rzsT+tKUf/okJo6lX06bJE97BWwckY0PfgL7+H0t3c/Qo6xGA5yM
X-Google-Smtp-Source: AGHT+IFQOZS522CuskEGxnusjcVeqLYDbyLGjIH2q8Qx0LPkUhS1eK6bC5DUBFHNOOWXaxeNseTYWA==
X-Received: by 2002:a2e:8904:0:b0:2df:44a1:2987 with SMTP id d4-20020a2e8904000000b002df44a12987mr7930872lji.5.1715074562339;
        Tue, 07 May 2024 02:36:02 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:36:01 -0700 (PDT)
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
Subject: [PATCH 30/48] rcu-tasks: Replace exit_tasks_rcu_start() initialization with WARN_ON_ONCE()
Date: Tue,  7 May 2024 11:35:12 +0200
Message-Id: <20240507093530.3043-31-urezki@gmail.com>
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

Because the Tasks RCU ->rtp_exit_list is initialized at rcu_init()
time while there is only one CPU running with interrupts disabled, it
is not possible for an exiting task to encounter an uninitialized list.
This commit therefore replaces the conditional initialization with
a WARN_ON_ONCE().

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Closes: https://lore.kernel.org/all/ZdiNXmO3wRvmzPsr@lothringen/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tasks.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 82e458ea0728..78d74c81cc24 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1203,8 +1203,7 @@ void exit_tasks_rcu_start(void)
 	rtpcp = this_cpu_ptr(rcu_tasks.rtpcpu);
 	t->rcu_tasks_exit_cpu = smp_processor_id();
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
-	if (!rtpcp->rtp_exit_list.next)
-		INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
+	WARN_ON_ONCE(!rtpcp->rtp_exit_list.next);
 	list_add(&t->rcu_tasks_exit_list, &rtpcp->rtp_exit_list);
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	preempt_enable();
-- 
2.39.2

