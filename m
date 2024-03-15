Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA85548FE
	for <rcu@vger.kernel.org>; Fri, 15 Mar 2024 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532516; cv=none; b=P8v8Bq35NlgAL5kUAiWMHZ1UK047X1t/h19cLS0y29e46o8obCinOCkrGBCtyUZCTD2+u1DvXhPzX4D1CMQDTo9hnoj6szYVTx3q21jOeFgQtDwT09YOa5GjfrsMW9qqSHoa2fhfylxAcaqgsLj3uEnz2DG8vu89mw6szId1fL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532516; c=relaxed/simple;
	bh=WZXQ3n6OAHQk56baal6CzZ+snXfrxRm2xjx8a0VoWYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeMbY1dx/O7eH9D+WSjpnr/JrhOIwuvv47CWAUoEOC7+EUB2GUkJalpI+HDhyJUE1jg+LS1kHHy+pAqliuxk9J0jV8xZnE4YT0mxaEC/8qdvs5k6zlaVG2ssi19lg8hL8P3W7bDuSSyX2QI13Itx122lt/lopLV5xZdOC9pE8jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=B8iM9QDV; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="B8iM9QDV"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso2489894276.3
        for <rcu@vger.kernel.org>; Fri, 15 Mar 2024 12:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710532512; x=1711137312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JuTpc8vOHdn72vm+nW+iFZ+lBgZnpQ42Xv3ej2YV4rQ=;
        b=B8iM9QDVZLZoUQZ8+NLabWS5GVaGI8Isyl0UZeZNi6c7bxWMDdD9oOzjKm+InlbPtd
         nLtyh/PmJjVYabW8/ArekKixTswp0SJY9jxQLAy4uANQmBoi4FNZ1kEf5v58iLn+lflE
         cvSy0WnZRUsVqeCOG8yHqRq/VircQ3NdY/VOZD652Ya6yioJSClcndMz7Dx9NliOLBoB
         Uxa3CffXk6RcH7qLIVVsFtAeZ80I8beZvtT1jSBwmrg8C3oATJ0UfNWGDuf0HloYEFBq
         7jlSpRAKasi40HOg/8QIJWkHFfbcSgJ3PWlIFSYEk+rSGMjFBxHTM8sjYzkGwID1e5oG
         xIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710532512; x=1711137312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuTpc8vOHdn72vm+nW+iFZ+lBgZnpQ42Xv3ej2YV4rQ=;
        b=d1HdotQfJWYndFm3n6pQOW9EjKYvAtNpDzVeSqTZJfYNCzQKQabIyyXRynHQ9tmD15
         3Sk9R4FJdV8a73JQXjhHAihsAbhJF3qY69deNNQBPSXZC0LruhdlhSgQB5F3DIcXzOKl
         tmifcyDFkEmSpEB+EJaZGe5Ib+hy5g0N7yxOF9/XOcu96V/WZWrUrJWqsqDMQFhg3Srm
         q1zvCtomfQtrmeO7Wf3NoKBm9/5GhronAEEypoWJSn/KjfGBZMRjCaQet/UqiBo6D5o5
         1tb59q8AkClLNLhAj8cdnk9sh7Ux2vMP+CISkv4tFPQoBDoxIVi7/Bl0Ub21aBfhlcfi
         rvZw==
X-Forwarded-Encrypted: i=1; AJvYcCUpCEmC15ZpUvGBcqnsAz3IjUCwlgkInMu9x0J75vnN6eGJU50oazrPrgw8JP2uKLYAUDMLDk9uUNx7apPbDCJVHlvd
X-Gm-Message-State: AOJu0YwI5ya3xwOQGSINvQSBfWcOoaaZw2fV8bqCIu7gT5CJK0yJeqwv
	kL5zj2BgTFJ+1slfOhkcRY5sx6gZWrPfLrklbIF8LWyvsKjhI0wlkp2jEOk+mfM=
X-Google-Smtp-Source: AGHT+IHyogcIr/Qsc9GsN9jZgtkStJ86LGPi25CEyZtC3+KaxMDzrcvpAOvf7tMwDDJPH7QLO3rHqA==
X-Received: by 2002:a25:ea43:0:b0:dc6:ff12:1a21 with SMTP id o3-20020a25ea43000000b00dc6ff121a21mr5517436ybe.31.1710532512300;
        Fri, 15 Mar 2024 12:55:12 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:1046::19f:c])
        by smtp.gmail.com with ESMTPSA id j6-20020ac86646000000b0042e2002ed12sm2251399qtp.57.2024.03.15.12.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 12:55:11 -0700 (PDT)
Date: Fri, 15 Mar 2024 12:55:09 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [PATCH v4 net 3/3] bpf: report RCU QS in cpumap kthread
Message-ID: <c8a337e11bb4843e2e1db4775f16518c18545950.1710525524.git.yan@cloudflare.com>
References: <cover.1710525524.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710525524.git.yan@cloudflare.com>

When there are heavy load, cpumap kernel threads can be busy polling
packets from redirect queues and block out RCU tasks from reaching
quiescent states. It is insufficient to just call cond_resched() in such
context. Periodically raise a consolidated RCU QS before cond_resched
fixes the problem.

Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_CPUMAP")
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 kernel/bpf/cpumap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index ef82ffc90cbe..8f1d390bcbde 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -262,6 +262,7 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 static int cpu_map_kthread_run(void *data)
 {
 	struct bpf_cpu_map_entry *rcpu = data;
+	unsigned long last_qs = jiffies;
 
 	complete(&rcpu->kthread_running);
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -287,10 +288,12 @@ static int cpu_map_kthread_run(void *data)
 			if (__ptr_ring_empty(rcpu->queue)) {
 				schedule();
 				sched = 1;
+				last_qs = jiffies;
 			} else {
 				__set_current_state(TASK_RUNNING);
 			}
 		} else {
+			rcu_softirq_qs_periodic(last_qs);
 			sched = cond_resched();
 		}
 
-- 
2.30.2


