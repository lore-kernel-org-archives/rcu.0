Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECFF158A37;
	Tue,  7 May 2024 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074550; cv=none; b=Ki4PX7XjMl/CMLb+M2F1PpN1qqqMRhLbI8bqKml2KF4oCNbTxEbmqgGGhrvGZdp/WgHdPaHwL5RdIss5KeSJ1Vey0jFDQzk0HhFB47oYioLdA0eaCKz6lSMoDTQxU2LISEQTDyPLO8H5RdYaMudBjkVRGWk1SNZ/41TCfxNu+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074550; c=relaxed/simple;
	bh=bHpVyST44tF4T9zshldUiiEXw2+O/L/8cC2lpkSqiIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hnuTpwclRP+OzmSjPhkNiqeCALZIQ61M1U9Ogk6zWF6HcDyRjPXYmjJiR8ILT5nfrryaNDvYpGhAE1FIMl769uOMiXxUjfkjRVQ/ZT+kewm1ys0ev5+dLKvrbUTGiXM+lrUDrsxJ/Fpfc0lOoXVLg+EGnuYM6fsloakseT+SUSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmPCNE3M; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmPCNE3M"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e3f6166e4aso7188491fa.1;
        Tue, 07 May 2024 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074546; x=1715679346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yj9chs7bm2QTr68OIU1XSJLLlP4/vHDWkmUWKji8NeI=;
        b=gmPCNE3McolKMXC5ZYfscVhmcO1TvunGl3BJ1EymyBC4MWokKfNeRJACHZGBBVcGmh
         XlyvZS7gY50kuHAxFNg2iCHi8+YFAar2vD8bheDU43pnSgnonLuDUHUUYhEU/JwQtZJo
         OvQaBUYjhEHsxViMyo2vyhzICI1aq+gsw6Ju6eqiXdRSssdSEWfU3XwgwfaDSXprkMbM
         Jo/RNNKeyYYMLWSLsNFdWl/m5zDFrvexbJwmLuDmSx6MmaTJSyVcTXXWh4kj1uxvISoo
         bK9TAA4YmAZo6ugGzP1e/jL6qLHVWJqUpIiKCpsOE5IAoY4b7zKHIZSNVwhzCpOqyVOp
         p7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074546; x=1715679346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yj9chs7bm2QTr68OIU1XSJLLlP4/vHDWkmUWKji8NeI=;
        b=d8efuk23QaekLsj49Nm0XUrq6ifLP5V3GQEwUked1ODyUCo0ZHYqFrhVXV+EPkou3i
         0DhVCmTv9eMcYp5Q5rLilxeXWUuHaFH5NxkDPZZCKEB0ioLR4w2KnoIUJ2zl5pVBfSIO
         pi+whBhPoCK6zSCZq9iLJDLTbXf77RQQA2rKBWAhaHKT7XEMrveBVUf2E7ebx5jwxbJu
         zByI7kRgDeLYrS79dVjt9tlNphZ55iBg1VtLdhYyoXCRdtC2jxDbnEbSkx4Ouo+xdfN5
         zpxlyTcT+h05bQsiBnbMAEgN39LH8RSlWMTdUVh59cZT5nXg+wAxaWa9RkF67YTrfNO+
         WiRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcIPcBTrq6rCSF+Uf59yDeY6geB9gctmgeB1FkViLChBv6uq6WX0lYjwVxo6WAymX24dpspzNSzEqBL8WVOce2PmtpLQkJOF5hoP07HcQBRfx/TrCcAGxOBWsyzxl18V4FjPxRlab6ijL9stK5Jylv
X-Gm-Message-State: AOJu0YyYJ7IslmLk+YIaZGYphiE2pYl28q9lcTcBPAxt15Xz535PDdqI
	hBPDreo7vFBIT6S/60FV5pWW8BpCyhgdUzZ6JaVujsp3j8AQeRpT
X-Google-Smtp-Source: AGHT+IEOauf9hq+Z225wSpCSM8stmekpSw5GxESD2O7JL7gGXrziPe3FLkwTMOzEhMXKzlo+hwk88w==
X-Received: by 2002:a2e:7a14:0:b0:2e1:c636:168a with SMTP id v20-20020a2e7a14000000b002e1c636168amr9523289ljc.24.1715074546347;
        Tue, 07 May 2024 02:35:46 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:45 -0700 (PDT)
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
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 14/48] tracing: Select new NEED_TASKS_RCU Kconfig option
Date: Tue,  7 May 2024 11:34:56 +0200
Message-Id: <20240507093530.3043-15-urezki@gmail.com>
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

Currently, if a Kconfig option depends on TASKS_RCU, it conditionally does
"select TASKS_RCU if PREEMPTION".  This works, but requires any change in
this enablement logic to be replicated across all such "select" clauses.
A new NEED_TASKS_RCU Kconfig option has been created to allow this
enablement logic to be in one place in kernel/rcu/Kconfig.

Therefore, select the new NEED_TASKS_RCU Kconfig option instead of the
old TASKS_RCU option.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <linux-trace-kernel@vger.kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/trace/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 61c541c36596..6cdc5ff919b0 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -163,7 +163,7 @@ config TRACING
 	select BINARY_PRINTF
 	select EVENT_TRACING
 	select TRACE_CLOCK
-	select TASKS_RCU if PREEMPTION
+	select NEED_TASKS_RCU
 
 config GENERIC_TRACER
 	bool
@@ -204,7 +204,7 @@ config FUNCTION_TRACER
 	select GENERIC_TRACER
 	select CONTEXT_SWITCH_TRACER
 	select GLOB
-	select TASKS_RCU if PREEMPTION
+	select NEED_TASKS_RCU
 	select TASKS_RUDE_RCU
 	help
 	  Enable the kernel to trace every kernel function. This is done
-- 
2.39.2

