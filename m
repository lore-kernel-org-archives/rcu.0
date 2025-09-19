Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F270F263C90
	for <rcu@vger.kernel.org>; Fri, 19 Sep 2025 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293457; cv=none; b=Jta4J+sD/5Ri4IhJaaoyvgQWa49IfKcwHWXS9peVyAcDanuGe82PGTBjsRnzdyVLTtNRLGvwQgvqPKWb4UvOGfMsBTJGxg4Jrkr9hkfegkZW8EWB2IO3QJiCwstnb3UhL/VckV6GVKmWUQAeOheTVhqmEf9J+ldiEKUxPhpnTzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293457; c=relaxed/simple;
	bh=IYbkaDSJK/MsI08RUb+i/WJqEc72qtzOPNCB6tRbT5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bj5XJBzEyKc7JtpTo9c7ytxajO4Mkoym+bVLPdPoRs+O+vs55DPttf8BxK/Q1z3Ya+/D89rPBRhalbs1KM7heC9YzuQuVgEXo/oqEPUeMPzLc4UpMeO0Xc2VH8/ilwLkCDBXPDxfNBqo/6+Dq2vAlLnH+qlTWGGApvKNlJboRYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ahlfsqkz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ahlfsqkz"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46897c60e38so5060405e9.0
        for <rcu@vger.kernel.org>; Fri, 19 Sep 2025 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758293453; x=1758898253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a39diFNJWgxr3FQyapz8HaQx19r+VVUG7JQzrSi4iDw=;
        b=AhlfsqkzImZGqPXFSfs7cHxQdbxCe+dlWHDgZQXTiJtKjPstSgNVLp+FeZCUll7L/s
         cRywaJD2ovk8jRPojmcpNVcYotLPob7qjQlqVrgXFtPfFv8m6QmW2+aoUqkwLCOeXLRL
         E7lDSBmcoYVHf0n6uxZstM9YMoeyVrVp+JdvafkJqsTxCqjOilTOV3t3V+i8JYDRbNY9
         oNhnMo57ZScdo67GrIiOk5WiQwbk3+GTgdjhfFC/6qLOUsiY1/R/hVuP99Jr+x5I4ChA
         9L39jGzlncwYhPJAyJjMBzL2vgpmzYQ1kRueD/hwQnXROAhJExmhWHS2G01TRbDmv6FM
         LWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293453; x=1758898253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a39diFNJWgxr3FQyapz8HaQx19r+VVUG7JQzrSi4iDw=;
        b=pezNZF0XCJblXRRboLPQiimHeQrBEMw7//GKGt12dmhfPHmuV9OSJ7FmtknNbMHNSW
         jYFdxXVjNQfsWOQG1/gDriEFUChwnq6Pq5ZSPgjsOC+94IN307fSUcm+38C2xFXl6Kli
         bVRTFlo3A7nZZ7VmKhPuqXYz3OxgyH2u9Pwt+hXwZbGocCGTFtQw+zC2HY9K5Daa5pcl
         eVzV2jWUhWG3y04HEO6MJNX898GKe13KATgXv1+MOG07HnWWdE+Krk9dxWYPLkEqhW2Y
         Jlv+9ntf0l7MM1GlnMnk2FA+N1fnS3LQ5nLsy/YMC9quYKxsuip+fTYlRE2Q/dS9i94H
         95LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUPPD1k9Gl9LK66MnRy7OpMY/wwl3X/qU/NU+0zaNYSNq1CWDqOMlPoIjuxZ2AtAGvQlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8LD7RGgOusaqPaV1Lr+D+USDT5uiunLw/Q2LX+uPeO0V/LJx+
	LgExXe8fhrKsYTi3VnG98yOL6azFbo9A07O+9Q8vJEmH6/IEwXy2bLUNVrs/gmCndHg=
X-Gm-Gg: ASbGncs6XmzNekKk+kp5cpGWQN6a4co+C+SQAk4d68MI09I52v4jFmKkDRu//uq86F9
	fHBqAeAVVFqK3QePGfOPwqu7QUy6nwbsfbkICAYlBIAm6854oGA68sRDlIQItzFKOjEC0lEgl02
	Bfy3A9UoHjOR3biED4AeIp5PK6HHt/Zhv1Ebsnt7kXVv8mUs6O3ndD1aQU4GaTCOfMcs3ALtZ3X
	GtTdbaB5c1Z5FcdKfwcTo1ZIsRIyWyiY+uDJeKkT7XULhyrHQSFWMA0Dey0WxVwiyTbS/SaObbM
	dZQiEGEWM6X3MZqcf/nbu5kCCVfow0fjvpkHWoCWKL2rYT5s0d5Nlr7twCPbzsCFr9tarNL7vwq
	EzSyu7iKf3/XynsaFDdWrVuJ8C42BGop/7CiS1JEEccOdWg==
X-Google-Smtp-Source: AGHT+IErceu7QLWloEQH2lrNBaTxdD2XPLeNYqSyKYD6Djjy3eEcDH4Pl0dN11iIdw/d6podUBIkrg==
X-Received: by 2002:a05:600c:4f46:b0:468:7f92:5a80 with SMTP id 5b1f17b1804b1-4687f925e16mr26453175e9.27.1758293453266;
        Fri, 19 Sep 2025 07:50:53 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325c3c29sm86220025e9.3.2025.09.19.07.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:50:53 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v2 1/3] rcu: replace use of system_wq with system_percpu_wq
Date: Fri, 19 Sep 2025 16:50:37 +0200
Message-ID: <20250919145040.290214-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919145040.290214-1-marco.crivellari@suse.com>
References: <20250919145040.290214-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users. Make
it clear by adding a system_percpu_wq.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/rcu/tasks.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f92443561d36..2dc044fd126e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -553,13 +553,13 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 		rtpcp_next = rtp->rtpcp_array[index];
 		if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
 			cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
-			queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
+			queue_work_on(cpuwq, system_percpu_wq, &rtpcp_next->rtp_work);
 			index++;
 			if (index < num_possible_cpus()) {
 				rtpcp_next = rtp->rtpcp_array[index];
 				if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
 					cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
-					queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
+					queue_work_on(cpuwq, system_percpu_wq, &rtpcp_next->rtp_work);
 				}
 			}
 		}
-- 
2.51.0

