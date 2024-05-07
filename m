Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C58D15ECCC;
	Tue,  7 May 2024 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074564; cv=none; b=At1I2yLQk8QLXMhnn97+EqCeu5l+uVN0WNoAOIz9V2ljXVxJherWJ559JTek5j4ATy8+Ow/l/TO+psY81rLIrRurV3mSJF54xI4OXfFTP9+mt+x+yApmqKpQAb2tnOPr6ta4st3poeDAXzuShVo2mcqe2/fffu9Hat5VYl1hgoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074564; c=relaxed/simple;
	bh=EWsVRIZxGPSXoY2Njx9/Sp9Wsqp8UVQL2ck7eZ/1txM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P1YxwSukEcxJ0vS8P/tcudPtj79rKw3KbVa3E0xw8caUqMsqpT8RSw6Y7jRso94gh3HQZxkSzMqt9JqHZvJcuCVJjl7NK8h2DyvJ9oIY2vyLauN6Re2Qpwj2DO6/RLJexKKMeYVM/tTm3uCUvIYkn7ZPg1u2flQEf3IIBmsukX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDdmL3aq; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDdmL3aq"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e367c2457bso20449381fa.1;
        Tue, 07 May 2024 02:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074556; x=1715679356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfH9K/eXzjwreUAemmntcMfIwoR9Zl46+OauXvPYO0k=;
        b=mDdmL3aqYgEx5+BpKsDxmxnJ7WUsS/5vaVGb4vCzgdlQmtMSbcmZMH6kgXhgNVSYx1
         0T1T3O0WQQ/EvdDNxeDwMXXLY+Uywl6j1/myp71r6UFEFaZKGQiN9wRCFoFntSAebNNt
         wTptxJrvTH/oobxk3QhXRmYb3LXSR7YMNT+v0GY8EAd6rXpYMpFOx+FYjHh+LHSiXS+N
         UoeCWS/+AebRcMPudgu3olf68Q+w0kjznrdLznVFoyTb6Elfdo0gOdKDTlQ+9/K8R8M1
         noQXysCa9Od7udgSQs61RrJ0u2AnR+4Y3Vw0+Ui3HTg6lLZFZPUnXLB//4vQpqnK2CK0
         K6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074556; x=1715679356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfH9K/eXzjwreUAemmntcMfIwoR9Zl46+OauXvPYO0k=;
        b=R4f5gfiOKHdhOBCyljkJ8Whv6CVImfUaNknddI4FMEzL0Oz+KLDZQv+NTMpqaduHuZ
         pSHkl5UElBvosyqv+gXAaMqj1p24KgyCJCs8q2Bv6iQ4s3ruWSKfkZaCNOKT50TA4WEr
         vipV+lLdVpaBJJUbfJRalAhvm7ruOPAYRnh8GMaQg8dUY/+q7A8NIuh64e44aZtkt495
         rSA3XVWUPY0Izsh6hIpapWgIXW/J0USorZX+9+UBHAjCF7r2d7IS5ZIeupJ+6JIdlOR1
         X3c/pPmDCUhWrgJaI0KV81h3m2XQIICKafPyk/O5k67KLygYf0+Ln/lVWmuOFLa+gdvQ
         IOJg==
X-Forwarded-Encrypted: i=1; AJvYcCWAMoruT66F1Bv4QNbBWJ1BUnMjhlxwc1GaX8BN9MWl2CW4SElZSYmH5G7GJXGGhgEvBqLBy2/PAW6S4N+6RXWIvg0pZYkjRtVj3J4K
X-Gm-Message-State: AOJu0YzTKhEMca7m7c/m4xUxtW5Y3Vu22yqrZpBIh+lgCwiAxXIj+3Ka
	XhqVRDMi8VBaMxnkjj8raoD+xRdbiMuyxoZTRYDFRr87Tn7jViKjHTJPU4MS
X-Google-Smtp-Source: AGHT+IHOIZDj0khBN1W8nHdPykH/y4sTAyNBeP5xmuK7akM5SJ1vs4umBw3oDZhkNvNfs4Mj+xr4NQ==
X-Received: by 2002:a2e:6109:0:b0:2e2:ab69:d10a with SMTP id v9-20020a2e6109000000b002e2ab69d10amr6164194ljb.39.1715074555694;
        Tue, 07 May 2024 02:35:55 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:55 -0700 (PDT)
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
Subject: [PATCH 24/48] rcu: Bring diagnostic read of rcu_state.gp_flags into alignment
Date: Tue,  7 May 2024 11:35:06 +0200
Message-Id: <20240507093530.3043-25-urezki@gmail.com>
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

This commit adds READ_ONCE() to a lockless diagnostic read from
rcu_state.gp_flags to avoid giving the compiler any chance whatsoever
of confusing the diagnostic state printed.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree_stall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5d666428546b..62b2c4858028 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -579,7 +579,7 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
 		pr_err("%s kthread timer wakeup didn't happen for %ld jiffies! g%ld f%#x %s(%d) ->state=%#x\n",
 		       rcu_state.name, (jiffies - jiffies_fqs),
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
-		       data_race(rcu_state.gp_flags),
+		       data_race(READ_ONCE(rcu_state.gp_flags)), // Diagnostic read
 		       gp_state_getname(RCU_GP_WAIT_FQS), RCU_GP_WAIT_FQS,
 		       data_race(READ_ONCE(gpk->__state)));
 		pr_err("\tPossible timer handling issue on cpu=%d timer-softirq=%u\n",
-- 
2.39.2

