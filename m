Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756BE15B995;
	Tue,  7 May 2024 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074552; cv=none; b=Gedy9bovmu8bbFDgkGVDNDaoXlIfKtficblqSzqc+m6B+GrPELq88cemQJ6NJeE2HjmHZOmW726ki4fbYpyzVetktidUN+oiWGOyNx6dEMEERN55VGYtdrlwz4l/mUhgaHPa13JhrwKbM+Z1GKJJRg8nAcig5PJy9C/NjGc6gDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074552; c=relaxed/simple;
	bh=Xup+ur6V7gGCPjLWD2d3gVVVucYcMlzVWTS+lp/sUdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b17VeTI+aYrJ5inuUaq3Lz2CZEVRBe8aY2VH6A9TV7MR0kkcfPIMJ+mXh9XNrHIpy++e4SbCT53InaP7LDB1/54HQnGantClA4abbFOFhYc2vxQtWUClnFL0o+Vghv2iP2vZHMgPHaG+pXiaKlsaTluU5lcZCvR5DtW+S+WAfYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8gmE8Mb; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8gmE8Mb"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e3f6166e4aso7189291fa.1;
        Tue, 07 May 2024 02:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074548; x=1715679348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGeMtJo22ZpGiOOGfiBpDVqkkH4o+185ycvE55zdP/o=;
        b=M8gmE8MbMnYyAKJYr96bfv+XLsSbDdAhX4rNHDjsq/wfokUCfq2CAY2O9CQNK+9T4x
         KqMAsvdD/k1epQZNCcjR1GIdAJDEJ6UY0gZO7XgE5hhGSUMR7jlExF0dpsBb42jBEJkv
         vEGeo6rJXXJxb9hkVpcOKm6qAewaHmjwQixLvULRNfI2cP3fI+YOiCS4eghQ+HAhTlrs
         nYgAbpCTX3rdw97oVJkqW7s30Syqb0vwghnrjahPaIGATacVaCi0oWst9rAvdc2aHrZn
         oiJZSmytnJjPnPOWuEHV9cTkQ6k4QOPk1R/dN7+azbytTTXexJX/nhD4XxpvsDRXTAvK
         YlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074548; x=1715679348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGeMtJo22ZpGiOOGfiBpDVqkkH4o+185ycvE55zdP/o=;
        b=muIfTO7vbe8a8/v2IFCk5feI5tsoW4eO7RvzzKWy3MGMiT8LL6YN5FdO7METUDHokq
         ZwCEpV4rqcJNFpS+1sVMJNOZOOqW9XIXO4QsAfzBSi6VHTQ/Be9AzZpVbWL6IogObrpW
         rQx6V+AKYocIPrF8604uo3JaFdiqIufIAXIAC9+Rf66kYXZvl+nwp3NopCIyacquNakY
         NV8AH/37vM9yjNWGmXYeNdK/hIbg+Sc712ZRbOK7EYelzip/FQiIquPj+Jw/uNXYsbh1
         hlyzBqPOESEVgn/kjpDrEZYMOSEqRVeZsNjj7wZ6HhoSSX0wfj63NBFJHjeKcWyJwiwS
         ltDA==
X-Forwarded-Encrypted: i=1; AJvYcCXVqtMNPnJU1VsD2Jzeqso6NF557n9ualH4vskklfiJRQPZf5/IUzVkJZ9IWsFoXGaEu8NYleIE539kSyWDhKIodyZ1zoriIj/c8mMBIxv9gfSqzjwYiN8p5HN4QusKV8/B2UekK79URhvNWeiXULNj
X-Gm-Message-State: AOJu0Yz/sPzPA2fouQqUnL/41R7p9O9WXUhwC4FDg1z9OIzFC16mpxGm
	Mwuq+B7ktomR202b0PhXM2W50UziYSowA383Zvb6Q9R01HM6tGL4
X-Google-Smtp-Source: AGHT+IHLJp/5yXY68S2MEoHJWtlxnGiX1bJVli0zsoyajbNNQvNKrwVfZXDfz7x/bta8cstMv3LicA==
X-Received: by 2002:a2e:914d:0:b0:2de:75de:5b0b with SMTP id q13-20020a2e914d000000b002de75de5b0bmr11651610ljg.18.1715074548565;
        Tue, 07 May 2024 02:35:48 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:48 -0700 (PDT)
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
	Frederic Weisbecker <frederic@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 16/48] ftrace: Choose RCU Tasks based on TASKS_RCU rather than PREEMPTION
Date: Tue,  7 May 2024 11:34:58 +0200
Message-Id: <20240507093530.3043-17-urezki@gmail.com>
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

The advent of CONFIG_PREEMPT_AUTO, AKA lazy preemption, will mean that
even kernels built with CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY
might see the occasional preemption, and that this preemption just might
happen within a trampoline.

Therefore, update ftrace_shutdown() to invoke synchronize_rcu_tasks()
based on CONFIG_TASKS_RCU instead of CONFIG_PREEMPTION.

[ paulmck: Apply Steven Rostedt feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <linux-trace-kernel@vger.kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/trace/ftrace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da1710499698..6c96b30f3d63 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3157,8 +3157,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 		 * synchronize_rcu_tasks() will wait for those tasks to
 		 * execute and either schedule voluntarily or enter user space.
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPTION))
-			synchronize_rcu_tasks();
+		synchronize_rcu_tasks();
 
 		ftrace_trampoline_free(ops);
 	}
-- 
2.39.2

