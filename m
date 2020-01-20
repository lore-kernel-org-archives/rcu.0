Return-Path: <SRS0=Bg9d=3J=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EE0C2D0DB
	for <rcu@archiver.kernel.org>; Mon, 20 Jan 2020 14:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A3F22522
	for <rcu@archiver.kernel.org>; Mon, 20 Jan 2020 14:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY1AKRnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgATOmm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:42:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37143 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgATOmj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jan 2020 09:42:39 -0500
Received: by mail-lj1-f194.google.com with SMTP id o13so34062790ljg.4;
        Mon, 20 Jan 2020 06:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THmrsHnqHz9ZxmfCi3sqszMX8qWql+dzWxbMha10mnY=;
        b=SY1AKRnkZCHr3Q1gVt/6qb9A/x79hFaJ28/gUupHZJu0MvJtZeAD4VM1UwWtnsdSwR
         QN9lLg9URSvBZM7li9ffQz6WxXd/ToIDaiw1iAgMBSu35uJ6fH4wI+XhZz27CmpMlBw2
         lJQJuBsDZX62AOIlrK/QDDGq5IHDK8vJDFp5OGjC3EbG0EO1j2TKdQfgJwpwI8zz6cCk
         8M/JB19I3TilhgHLYFCQlf7UxwClR8IwjlPX4Vpc35eqWhVC/m45WNjIBB0XET/HQA73
         tLvwZ1xYu41pDbBjnt98N7109S8nGZecfvBUX+ZFM+c4u7UDlzYlh2w4Vv3aLdx21L2o
         sEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THmrsHnqHz9ZxmfCi3sqszMX8qWql+dzWxbMha10mnY=;
        b=k4UUTrvTY5Op/WnHaJv6TzIpPcmGX+JoKs33qKdLQ6yidzh7smTAc77IcrN4ehGwky
         eDTsLlwiG4G+zLUlI/G+gKfgAkdfMQRwCwarsQ6goD2uZ4M+/KFc2KLc425M+NF3IU/R
         OAxhxyTZ1edmgLpO+iwrpbP5IJKqfUZlfwooApMEthF5WwaaJQ5GTNHj58EMILhd/0gd
         UXVAJU6XC463twLK+BY9xffy/nFW9fS9umQ2Hn5V8dx+zYCSKb3mL9VI2RaEcAKRZ5TS
         fFVZxquKDqdT+oIz5PdglQAH/XPaWPRtvRCZLQPhUdAFZnP5XetBfB17b0RUREdZPui7
         Lzwg==
X-Gm-Message-State: APjAAAUHFvrNdkbJL1ub4PcgNjKBp8u7YuEqgaU783TobZgh6S38OCcg
        uMpodw0257Jb32oldwWJMuadZAHQ8kxM0A==
X-Google-Smtp-Source: APXvYqzkWY673VBP15Hp2khEOd9gBBjFkQSrWPtxNgdEaQYEm5t5HxKF9uAC778z5Q62JOnNBynZKg==
X-Received: by 2002:a2e:9b05:: with SMTP id u5mr13782064lji.59.1579531356887;
        Mon, 20 Jan 2020 06:42:36 -0800 (PST)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id 21sm16945432ljv.19.2020.01.20.06.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 06:42:34 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [v2 PATCH 2/2] rcu/tree: add a trace invoke event of the kfree_bulk()
Date:   Mon, 20 Jan 2020 15:42:26 +0100
Message-Id: <20200120144226.27538-3-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120144226.27538-1-urezki@gmail.com>
References: <20200120144226.27538-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The event is given three parameters, first one is the name
of RCU flavour, second one is the number of elements in array
for free and last one is an address of the array holding
pointers to be freed by the kfree_bulk() function.

To enable the trace event your kernel has to be build with
CONFIG_RCU_TRACE=y, after that it is possible to track the
events using ftrace subsystem.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/trace/events/rcu.h | 28 ++++++++++++++++++++++++++++
 kernel/rcu/tree.c          |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 5e49b06e8104..49a49e68b916 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -623,6 +623,34 @@ TRACE_EVENT_RCU(rcu_invoke_kfree_callback,
 		  __entry->rcuname, __entry->rhp, __entry->offset)
 );
 
+/*
+ * Tracepoint for the invocation of a single RCU callback of the special
+ * kfree_bulk() form. The first argument is the RCU flavor, the second
+ * argument is a number of elements in array to free, the third is an
+ * address of the array holding nr_records entries.
+ */
+TRACE_EVENT_RCU(rcu_invoke_kfree_bulk_callback,
+
+	TP_PROTO(const char *rcuname, unsigned long nr_records, void **p),
+
+	TP_ARGS(rcuname, nr_records, p),
+
+	TP_STRUCT__entry(
+		__field(const char *, rcuname)
+		__field(unsigned long, nr_records)
+		__field(void **, p)
+	),
+
+	TP_fast_assign(
+		__entry->rcuname = rcuname;
+		__entry->nr_records = nr_records;
+		__entry->p = p;
+	),
+
+	TP_printk("%s bulk=0x%p nr_records=%lu",
+		__entry->rcuname, __entry->p, __entry->nr_records)
+);
+
 /*
  * Tracepoint for exiting rcu_do_batch after RCU callbacks have been
  * invoked.  The first argument is the name of the RCU flavor,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 27cb536d25bb..98cc13c44511 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2858,6 +2858,9 @@ static void kfree_rcu_work(struct work_struct *work)
 		debug_rcu_head_unqueue_bulk(bhead->head_free_debug);
 
 		rcu_lock_acquire(&rcu_callback_map);
+		trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
+			bhead->nr_records, bhead->records);
+
 		kfree_bulk(bhead->nr_records, bhead->records);
 		rcu_lock_release(&rcu_callback_map);
 
-- 
2.20.1

