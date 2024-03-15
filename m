Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEAF1F19A
	for <rcu@vger.kernel.org>; Fri, 15 Mar 2024 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532506; cv=none; b=ho0uaq+Xrj6Myt1G4dzdrkIjCtf/PafMfF8/bqXxeq17J3YZ+QWfDWWsMBns5rnVbpT/GkDaP0p7uk0lx3DpG+xWP5/7s10+DbxZbty4Rm3cOj8J83O1Zf9jw8wNliN924U3ilgUjqmmXE7fys4AyeLxuyoca+F46k/qt1M07GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532506; c=relaxed/simple;
	bh=CZwUyc/DMM0Uny3U5TTGXkC9yXTk8fyaov4ApURGlJU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DiFxOD7COUbZF50wqIBOi02QLnC3sGOyC/7PaKMRqJf2qVaFCsnuYA2Ha+10sygqEDNJEIsFazFRa7cHKZuP+xYP2GfQF1Khx+e7Juak1vC1AXo3dsKn84bLZNW7mWQM+vY2V0PrpcRSzgx3++p35SAB+CyYWAtortROicS4FHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZRc8at8i; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZRc8at8i"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7887649cc6cso272829485a.1
        for <rcu@vger.kernel.org>; Fri, 15 Mar 2024 12:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710532503; x=1711137303; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hFCxDEQwJlvWrjzvbkqgNENtA83xO4o1dn3KyfRTRKA=;
        b=ZRc8at8iONxvknmBCFFyHlu9gFSFLwBb453B9kYYGuRULPGhJLb37TucWku2c10dKs
         hYOcYEnMKNGmKutNCt3x2hGlVlLo+cF/Ub+77ZN61SK1EsVO8qySOu5uFv1RwrqMAmi6
         Di+lcr7tZdfpwR9qxa+bznu3bm4sRwLEJoVj1ARHfsZXbpHw9qDp8vopNJy7iAQeXn2t
         OZq5n9oNy05qJz5prXOz+5b4gxmrwnLatar7jkcJ8l3KsgwurtQ8vWhDT2B8AWbbCbdw
         sgS0M5tXyGkpxcTk4y2KUfEK2duQNKKaZpah0wD/nOFtU9acliHcH+SmbszcNxtbf/Gl
         AB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710532503; x=1711137303;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFCxDEQwJlvWrjzvbkqgNENtA83xO4o1dn3KyfRTRKA=;
        b=gF70IRife/tQtr9g9HSQvC+UTAV9reBfpx9MRs0YXheFdR5vjfjn90HBgfOi1LFgsW
         fGchB8k4MA0+e5DN5qKXahbw4/HgVnTlWxl1HW73l8tc2gRw1t6GeRGlRVI9+90CZ3b1
         Ry4ENI5njbpD/tk2fNZOsBuzzhVbroV/+7zCxzrog0BRFxM4b3lbKKrMy9d20XIvGJwk
         gWDXmeZhkGffiiFbVBbfuf/Jf13/LOAGX9lcoYyBgT2bMUWiDgiITWZcOEoEx+h1pYU0
         nY9bUAFjJeRzql7qT4g8PXqDOSTueIoKx1n2vAWrjwHWsBNx7P7MUYsE238NWMg/UJ5P
         R/jg==
X-Forwarded-Encrypted: i=1; AJvYcCU+QHW4fLn+gQYHp9s6UuGYpmDh6mvd+d65DS5Pb/eYmoVNmLtFywJdG50MuPCbxmvpHNG46o03GK9UJVtyTdHyhZpo
X-Gm-Message-State: AOJu0Ywuh12v0dAglzAOaSnjdAXf8HeeSBhLxa8ZdpT9MGK8pa8ct1WD
	QRds7Kd0amhwFb9xyShHnz9iYWo9eXUce7a1dz9F4ZrIkpQjspR3LwzJOhHJJGY=
X-Google-Smtp-Source: AGHT+IFjd6KHONFC5gxvbd85NmSgiMqQ0lkwBquMR6XDCX/5Tlz40CkSaVE6adtcrZ4M3JLDNtVK/g==
X-Received: by 2002:a05:620a:158f:b0:788:49fd:a3de with SMTP id d15-20020a05620a158f00b0078849fda3demr8820691qkk.16.1710532503509;
        Fri, 15 Mar 2024 12:55:03 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:1046::19f:c])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a136700b0078863e0f829sm1405472qkl.12.2024.03.15.12.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 12:55:03 -0700 (PDT)
Date: Fri, 15 Mar 2024 12:55:00 -0700
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
Subject: [PATCH v4 net 0/3] Report RCU QS for busy network kthreads
Message-ID: <cover.1710525524.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This changeset fixes a common problem for busy networking kthreads.
These threads, e.g. NAPI threads, typically will do:

* polling a batch of packets
* if there are more work, call cond_resched to allow scheduling
* continue to poll more packets when rx queue is not empty

We observed this being a problem in production, since it can block RCU
tasks from making progress under heavy load. Investigation indicates
that just calling cond_resched is insufficient for RCU tasks to reach
quiescent states. This at least affects NAPI threads, napi_busy_loop, and
also cpumap kthread for now.

By reporting RCU QSes in these kthreads periodically before
cond_resched, the blocked RCU waiters can correctly progress. Instead of
just reporting QS for RCU tasks, these code share the same concern as
noted in the commit d28139c4e967 ("rcu: Apply RCU-bh QSes to RCU-sched
and RCU-preempt when safe"). So report a consolidated QS for safety.

It is worth noting that, although this problem is reproducible in
napi_busy_loop, it only shows up when setting the polling interval to as
high as 2ms, which is far larger than recommended 50us-100us in the
documentation. So napi_busy_loop is left untouched.

V3: https://lore.kernel.org/lkml/20240314145459.7b3aedf1@kernel.org/t/
V2: https://lore.kernel.org/bpf/ZeFPz4D121TgvCje@debian.debian/
V1: https://lore.kernel.org/lkml/Zd4DXTyCf17lcTfq@debian.debian/#t

changes since v3:
 * fixed kernel-doc errors

changes since v2:
 * created a helper in rcu header to abstract the behavior
 * fixed cpumap kthread in addition

changes since v1:
 * disable preemption first as Paul McKenney suggested

Yan Zhai (3):
  rcu: add a helper to report consolidated flavor QS
  net: report RCU QS on threaded NAPI repolling
  bpf: report RCU QS in cpumap kthread

 include/linux/rcupdate.h | 24 ++++++++++++++++++++++++
 kernel/bpf/cpumap.c      |  3 +++
 net/core/dev.c           |  3 +++
 3 files changed, 30 insertions(+)

-- 
2.30.2


