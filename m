Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24489C433E1
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7D6206D7
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="n9nUMKbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgFRUab (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729847AbgFRUaK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 16:30:10 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D2BC0613EF
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 13:30:09 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k22so5549991qtm.6
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/RQBZIfLfkPA1F9dvaxuurpmXI5VeeQwSsHL0IE+EQ=;
        b=n9nUMKbZTc0bcoyBUQkboyXlrXcJ5Oq95ai+o6Mku6y074LpoPW7DUzYlk5oDHPyVS
         sSAU1sQMpf3NvTiSKTxq079w+XwGKgFFAiSUnatfCotU6qDUlj+accIVsbRZjksi+/Kn
         HR7AhQHj9pZf/AQr7lklYyEEFwL366A0dADUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/RQBZIfLfkPA1F9dvaxuurpmXI5VeeQwSsHL0IE+EQ=;
        b=fInhDuHMv/Zx3sjFghaFLA5N5ImtU7vWiPL114YpSmMyQ8DHoUDAqJEo599NeHXsxa
         R+VTAVAOnBODmin7+hhSFYDyvVCN5FzFWr7Y0Rb190EKnWb0qsg2yAnEOcpC1dAGuZI1
         KLaW5y/ywohhfubEeg6Jdt6fCSE9Bh02aaj5IHpHStHpdvz9GI1FZw+b1WngKzbNxIPu
         MIgzPMkKJggYANbY3VnXaf81tKlYCF3vTnR/tycnEn9/cQXRfbSX9olxOI++viaTM8Wa
         qQKUSTpFiE0ZZpJNggk5wuk/aAv7Bg4UG3ZraPW7sUhSCH8M2KuI8ZgH574oyu8VaqKS
         MfyA==
X-Gm-Message-State: AOAM531rK21Xv5pzac2wIQhkeL86SPLufUdxkXt1nUpTKhMgmY9f0c9I
        OEjrHQl3pu3EbOetCy8YxFKxwAUNjJg=
X-Google-Smtp-Source: ABdhPJxVIw+9MedPn+0uHFOu0+u8AfUubjtJZreMuMIkgxa1KMo+DtpK5ZQpomh8wgOn/JAl+aUhYA==
X-Received: by 2002:aed:2084:: with SMTP id 4mr4944qtb.43.1592512207480;
        Thu, 18 Jun 2020 13:30:07 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v3sm4027503qkh.130.2020.06.18.13.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:30:07 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH 4/7] rcu/trace: Print negative GP numbers correctly
Date:   Thu, 18 Jun 2020 16:29:52 -0400
Message-Id: <20200618202955.4024-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200618202955.4024-1-joel@joelfernandes.org>
References: <20200618202955.4024-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

GP numbers start from -300 and gp_seq numbers start of -1200 (for a
shift of 2). These negative numbers are printed as unsigned long which
not only takes up more text space, but is rather confusing to the reader
as they have to constantly expend energy to truncate the number. Just
print the negative numbering directly.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 62 ++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index cb5363564f7ed..bc24862790623 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -76,18 +76,18 @@ TRACE_EVENT_RCU(rcu_grace_period,
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
 		__field(const char *, gp_seq_src)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(const char *, gpevent)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
 		__entry->gp_seq_src = gp_seq_src;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->gpevent = gpevent;
 	),
 
-	TP_printk("%s %s_gp_seq=%lu %s",
+	TP_printk("%s %s_gp_seq=%ld %s",
 		  __entry->rcuname, __entry->gp_seq_src,
 		  __entry->gp_seq, __entry->gpevent)
 );
@@ -118,8 +118,8 @@ TRACE_EVENT_RCU(rcu_future_grace_period,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
-		__field(unsigned long, gp_seq_req)
+		__field(long, gp_seq)
+		__field(long, gp_seq_req)
 		__field(u8, level)
 		__field(int, grplo)
 		__field(int, grphi)
@@ -128,16 +128,16 @@ TRACE_EVENT_RCU(rcu_future_grace_period,
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
-		__entry->gp_seq_req = gp_seq_req;
+		__entry->gp_seq = (long)gp_seq;
+		__entry->gp_seq_req = (long)gp_seq_req;
 		__entry->level = level;
 		__entry->grplo = grplo;
 		__entry->grphi = grphi;
 		__entry->gpevent = gpevent;
 	),
 
-	TP_printk("%s %lu %lu %u %d %d %s",
-		  __entry->rcuname, __entry->gp_seq, __entry->gp_seq_req, __entry->level,
+	TP_printk("%s %ld %ld %u %d %d %s",
+		  __entry->rcuname, (long)__entry->gp_seq, (long)__entry->gp_seq_req, __entry->level,
 		  __entry->grplo, __entry->grphi, __entry->gpevent)
 );
 
@@ -157,7 +157,7 @@ TRACE_EVENT_RCU(rcu_grace_period_init,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(u8, level)
 		__field(int, grplo)
 		__field(int, grphi)
@@ -166,14 +166,14 @@ TRACE_EVENT_RCU(rcu_grace_period_init,
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->level = level;
 		__entry->grplo = grplo;
 		__entry->grphi = grphi;
 		__entry->qsmask = qsmask;
 	),
 
-	TP_printk("%s %lu %u %d %d %lx",
+	TP_printk("%s %ld %u %d %d %lx",
 		  __entry->rcuname, __entry->gp_seq, __entry->level,
 		  __entry->grplo, __entry->grphi, __entry->qsmask)
 );
@@ -201,17 +201,17 @@ TRACE_EVENT_RCU(rcu_exp_grace_period,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gpseq)
+		__field(long, gpseq)
 		__field(const char *, gpevent)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gpseq = gpseq;
+		__entry->gpseq = (long)gpseq;
 		__entry->gpevent = gpevent;
 	),
 
-	TP_printk("%s %lu %s",
+	TP_printk("%s %ld %s",
 		  __entry->rcuname, __entry->gpseq, __entry->gpevent)
 );
 
@@ -320,17 +320,17 @@ TRACE_EVENT_RCU(rcu_preempt_task,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(int, pid)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->pid = pid;
 	),
 
-	TP_printk("%s %lu %d",
+	TP_printk("%s %ld %d",
 		  __entry->rcuname, __entry->gp_seq, __entry->pid)
 );
 
@@ -347,17 +347,17 @@ TRACE_EVENT_RCU(rcu_unlock_preempted_task,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(int, pid)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->pid = pid;
 	),
 
-	TP_printk("%s %lu %d", __entry->rcuname, __entry->gp_seq, __entry->pid)
+	TP_printk("%s %ld %d", __entry->rcuname, __entry->gp_seq, __entry->pid)
 );
 
 /*
@@ -378,7 +378,7 @@ TRACE_EVENT_RCU(rcu_quiescent_state_report,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(unsigned long, mask)
 		__field(unsigned long, qsmask)
 		__field(u8, level)
@@ -389,7 +389,7 @@ TRACE_EVENT_RCU(rcu_quiescent_state_report,
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->mask = mask;
 		__entry->qsmask = qsmask;
 		__entry->level = level;
@@ -398,7 +398,7 @@ TRACE_EVENT_RCU(rcu_quiescent_state_report,
 		__entry->gp_tasks = gp_tasks;
 	),
 
-	TP_printk("%s %lu %lx>%lx %u %d %d %u",
+	TP_printk("%s %ld %lx>%lx %u %d %d %u",
 		  __entry->rcuname, __entry->gp_seq,
 		  __entry->mask, __entry->qsmask, __entry->level,
 		  __entry->grplo, __entry->grphi, __entry->gp_tasks)
@@ -419,19 +419,19 @@ TRACE_EVENT_RCU(rcu_fqs,
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gp_seq)
+		__field(long, gp_seq)
 		__field(int, cpu)
 		__field(const char *, qsevent)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gp_seq = gp_seq;
+		__entry->gp_seq = (long)gp_seq;
 		__entry->cpu = cpu;
 		__entry->qsevent = qsevent;
 	),
 
-	TP_printk("%s %lu %d %s",
+	TP_printk("%s %ld %d %s",
 		  __entry->rcuname, __entry->gp_seq,
 		  __entry->cpu, __entry->qsevent)
 );
@@ -520,17 +520,19 @@ TRACE_EVENT_RCU(rcu_segcb,
 		TP_STRUCT__entry(
 			__field(const char *, ctx)
 			__array(int, cb_count, 4)
-			__array(unsigned long, gp_seq, 4)
+			__array(long, gp_seq, 4)
 		),
 
 		TP_fast_assign(
+			int i;
 			__entry->ctx = ctx;
 			memcpy(__entry->cb_count, cb_count, 4 * sizeof(int));
-			memcpy(__entry->gp_seq, gp_seq, 4 * sizeof(unsigned long));
+			for (i = 0; i < 4; i++)
+				__entry->gp_seq[i] = (long)(gp_seq[i]);
 		),
 
 		TP_printk("%s cb_count: (DONE=%d, WAIT=%d, NEXT_READY=%d, NEXT=%d) "
-			  "gp_seq: (DONE=%lu, WAIT=%lu, NEXT_READY=%lu, NEXT=%lu)", __entry->ctx,
+			  "gp_seq: (DONE=%ld, WAIT=%ld, NEXT_READY=%ld, NEXT=%ld)", __entry->ctx,
 			  __entry->cb_count[0], __entry->cb_count[1], __entry->cb_count[2], __entry->cb_count[3],
 			  __entry->gp_seq[0], __entry->gp_seq[1], __entry->gp_seq[2], __entry->gp_seq[3])
 
-- 
2.27.0.111.gc72c7da667-goog

