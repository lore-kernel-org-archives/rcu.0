Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770115FD0D;
	Tue,  7 May 2024 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074573; cv=none; b=RYRwwK0LaBT+1bPhFtaTbohdmZa5FwqHLpXv4oOzr3SfQYds0sgErhHJlcF4iyS8Gd61+8aEou/d1pVruE50DKtRC7AfuTGkQz1yOQdIWT6/mERJqq4VJOUPqvCOGTis8HUt9M7jPKnNrxP2dlbiYQREPkFSrcPWVtLevIW/f7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074573; c=relaxed/simple;
	bh=n9Lpi3xDswaRGuMexMLHv+Fr/pOl2uShyoPzAxM/LkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nrndFEXZSSR+JGRLW25RsjZRiQSrqjQfnfw9AQkYrCLkjKa7ql5T8YqTMaIhdhrb58khLHEiLgxeHNDhsfmG9Ot9b1ptjvRfjlFCJ0WNrJhkibGNbo2AObWV9yEE+7RqySQgICyHClhHAtAvS1FolUerA1Kt+AtAFQ0R0I1obPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A86JSHW1; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A86JSHW1"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e242b1df60so34987121fa.1;
        Tue, 07 May 2024 02:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074569; x=1715679369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz5BXU3UHX4CwUX1cfETvCcNBZ5e+2wWNg8Li1dCQhQ=;
        b=A86JSHW1fpMiKREDa7dcbuZtDYqKOdqw/m7nGl+T+JvvboNRIhnMPkHMx1KPON9Bgj
         HkS5QHjxTmHg1aIyQ+8KW/8EC6hS3soFF+ByDVFg//2XsTxrc8HWTAT5EQZy6grUvTHh
         dCYn32LRhGe8QzLV9pCNUZA+zYE5/BisL/zbwLpVZd+GqthWyLI+LWPm+y70HikjTFaS
         0F7HimHjGVXOpitWRqwAXkbw7TnVc5ysbyQC7hINEfjfj2YFlyaVNUcTkuBxTg9yyNdk
         kscSkPs8E2JqTe2UWT0hET1upAY5ECYzCWZ6LfRTM8UgAbfmKllRzEUxNzgIMVk8kkF1
         XhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074569; x=1715679369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dz5BXU3UHX4CwUX1cfETvCcNBZ5e+2wWNg8Li1dCQhQ=;
        b=GzU4NUqRBuv7+srNFoyU6LqDSZY+DewL5IY6Ed0qefKXQjnir5PRoMcpY2e1sU7rG2
         dojK5vPqhMfrysHByt0Ve/jA/oeiZ4ZralBrj9JuVjNhaOLPgmUS282Y7HV7jul8E5wt
         QXDcIcdJvIKwvQ+dA6s/dPDUl41LETfTXoiN0J03RLkf6WAHx6s/g5xQkaUiCe0rckxK
         nlKIeNQP9n9N3EQtLfCtuee4IKVS+BQAnD7rLQYN70RRxMVudM6Lnz92IuBxg1dK+wHj
         ajPtxxU113tv4Rmy/BtXL3ApqspQILh4Onqk71fJQcLpf3mbTFSLmRAUSncLj/XYGgTv
         ybag==
X-Forwarded-Encrypted: i=1; AJvYcCUU51VaTy3KEqaZ8oh/Z3tM+Vd5q1uq0HCZJfK6F5i6P5Nf/64fNyivV8FWeJSxtbUUcGc4DVw+oXk5XQYhAtmRg61rxQUmfmw52wUK
X-Gm-Message-State: AOJu0YwYM+/7htlQPC5sMDQxsGpR4/D3DcrcNnBX921EfZuwrR0avnHZ
	dtayZ5E9Alr6QScpzbxDnVbK77cLtQhv4WpYayZg1iaIMhfGvGqS
X-Google-Smtp-Source: AGHT+IF9egT9BOHQ1RvjlkxBBCieeXHyaTXF18N4dYlrO9IeXmUlDdQYAz8W6Ivqg9cdHHkFCgCRyA==
X-Received: by 2002:a2e:9dd0:0:b0:2e2:6372:7747 with SMTP id x16-20020a2e9dd0000000b002e263727747mr10079058ljj.4.1715074568625;
        Tue, 07 May 2024 02:36:08 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:36:08 -0700 (PDT)
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
Subject: [PATCH 36/48] rcu: Add a trace event for synchronize_rcu_normal()
Date: Tue,  7 May 2024 11:35:18 +0200
Message-Id: <20240507093530.3043-37-urezki@gmail.com>
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

Add an rcu_sr_normal() trace event. It takes three arguments
first one is the name of RCU flavour, second one is a user id
which triggeres synchronize_rcu_normal() and last one is an
event.

There are two traces in the synchronize_rcu_normal(). On entry,
when a new request is registered and on exit point when request
is completed.

Please note, CONFIG_RCU_TRACE=y is required to activate traces.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/trace/events/rcu.h | 27 +++++++++++++++++++++++++++
 kernel/rcu/tree.c          |  7 ++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 2ef9c719772a..31b3e0d3e65f 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -707,6 +707,33 @@ TRACE_EVENT_RCU(rcu_invoke_kfree_bulk_callback,
 		__entry->rcuname, __entry->p, __entry->nr_records)
 );
 
+/*
+ * Tracepoint for a normal synchronize_rcu() states. The first argument
+ * is the RCU flavor, the second argument is a pointer to rcu_head the
+ * last one is an event.
+ */
+TRACE_EVENT_RCU(rcu_sr_normal,
+
+	TP_PROTO(const char *rcuname, struct rcu_head *rhp, const char *srevent),
+
+	TP_ARGS(rcuname, rhp, srevent),
+
+	TP_STRUCT__entry(
+		__field(const char *, rcuname)
+		__field(void *, rhp)
+		__field(const char *, srevent)
+	),
+
+	TP_fast_assign(
+		__entry->rcuname = rcuname;
+		__entry->rhp = rhp;
+		__entry->srevent = srevent;
+	),
+
+	TP_printk("%s rhp=0x%p event=%s",
+		__entry->rcuname, __entry->rhp, __entry->srevent)
+);
+
 /*
  * Tracepoint for exiting rcu_do_batch after RCU callbacks have been
  * invoked.  The first argument is the name of the RCU flavor,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f65255205e44..2e1c5be6d64b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3863,9 +3863,11 @@ static void synchronize_rcu_normal(void)
 {
 	struct rcu_synchronize rs;
 
+	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
+
 	if (!READ_ONCE(rcu_normal_wake_from_gp)) {
 		wait_rcu_gp(call_rcu_hurry);
-		return;
+		goto trace_complete_out;
 	}
 
 	init_rcu_head_on_stack(&rs.head);
@@ -3886,6 +3888,9 @@ static void synchronize_rcu_normal(void)
 	/* Now we can wait. */
 	wait_for_completion(&rs.completion);
 	destroy_rcu_head_on_stack(&rs.head);
+
+trace_complete_out:
+	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("complete"));
 }
 
 /**
-- 
2.39.2

