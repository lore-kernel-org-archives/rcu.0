Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF00B3FB2F
	for <rcu@vger.kernel.org>; Tue, 19 Mar 2024 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881078; cv=none; b=HnWsofHJZxHjEpq2V+NhPHnknLQTZ1rHvqEikvZHQrwjXo/HWPepf1WhAkNQgexcyQ0aX9sax90vAwkFh2TEcIETwTF/kLc4ZODOild+qjzA67nTWogEOkZ00tAgBYpb64pfYvNFg44q6tuYau10OBuKCUfVgOYvkc6zghCmg8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881078; c=relaxed/simple;
	bh=oDe0geSLnuuk7SkmacOCsc3JgCu2wt8IttTF3ksVRbM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KTpqhvN+ol7CI428uWzkC4sQx/x6UzOrLq/RXUIEunHjHWsP8FAHCy5+lxaEmwOgozvqVPk3v/+FiRJmSll36wPysl5AAd36hCL6g/5jCNk9F+nOsYtRvJsclxfnZeDUFvloqQPfe9tkihjBj54kWaAksHqeUOGlEwsJjpj/hI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Kq7ykimC; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Kq7ykimC"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-476794adf30so883336137.1
        for <rcu@vger.kernel.org>; Tue, 19 Mar 2024 13:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710881075; x=1711485875; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CAhSTGhRiyAljzZj3105Ft8eQ+XhumjX9hGBP4lMS0I=;
        b=Kq7ykimCVSVgRZprjjbeAGcbmlICfOrK99qy29rYBetPxdIWMDxLf/rNZ07Vs2dFZ4
         5ua/HKgOtvLuHwMt6KElJ3jqLIK3fD3xwQNBbrfgYh543fhnrxCDL8cqzt3d+5a33Xpd
         xfDiuqACl8ZGyvqzW6GnnWlEUlkf6P+Zf08M6QqQ99z4HZHLaKY3PSxnOo8FY5cB+iy7
         tNt8E/mzBPtmipvnCtNp39E8uejOzKxB9WwVGlhYW/0dAOwviSlpylNPhshdkHPsrHKK
         n3O5lrZ278IH9iqwD9KtLTdKUXG52amhS/F3NQTGyhwc48XKRBdcfTciOQ1lm8zNkZRP
         3rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710881075; x=1711485875;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAhSTGhRiyAljzZj3105Ft8eQ+XhumjX9hGBP4lMS0I=;
        b=r0UfJtNLxeC8RsAq11NFhiIXXW0ZS03zYpKXV+N3hnOImAHjXYG9CZDauE5iy23d0M
         W2omji6x2ri8+dVti1H03QGqlmqChkrU61PItzIN0jmuSZJTeoqx2fa67bZ4ia3oFo5E
         J/z6azvNlvgymea9q5TvfTptYQyu7a05Dq5VkdvlosomT5aAFrrxFVgdliLM8sTLp3tT
         l8/GVhl2kh1U8oBCvcwp7ZGpff0vsOT+wi7Oq7x49UgJ0vwLsXAxSBdZa/LN2q/44H9c
         VFy9AbIi6xOqBYcI4/sX0hXLZPLIoMc7tWKWAqmqZaCDliJ+wLNfKt9QrWKRlf/faRl3
         cMKA==
X-Forwarded-Encrypted: i=1; AJvYcCWpf7VFe16kckVK0EXO2M18zjq2f75kp6bFVvos0Da/BvqzampFI4N0NYXIWRTrb/5ESzROmK5/6YxrUT/RuCCMeGMY
X-Gm-Message-State: AOJu0Yw8IIePsFPJQlgMefdyJupGeYIWr0Gup+5sNFjluXJxwP2jXS/6
	cQEy/vnel8fEPxeQPR5iV6mm3tDGCaF0tbXG4VAbwCRKz5IcurosMXDcOZUKDWs=
X-Google-Smtp-Source: AGHT+IFlFOB52SjxLdszQJJGneeQ+QorWaR6FhjitWP4enqBl+GDAaETy/cEnPLd6J2B8sy5tqEo8g==
X-Received: by 2002:a05:6102:3a48:b0:475:48c5:c4fc with SMTP id c8-20020a0561023a4800b0047548c5c4fcmr12142626vsu.24.1710881074319;
        Tue, 19 Mar 2024 13:44:34 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:1cd2::2df:49])
        by smtp.gmail.com with ESMTPSA id a9-20020a0ce349000000b006916003c53asm6621478qvm.27.2024.03.19.13.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 13:44:33 -0700 (PDT)
Date: Tue, 19 Mar 2024 13:44:30 -0700
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
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v5 net 0/3] Report RCU QS for busy network kthreads
Message-ID: <cover.1710877680.git.yan@cloudflare.com>
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
* if there are more work, call cond_resched() to allow scheduling
* continue to poll more packets when rx queue is not empty

We observed this being a problem in production, since it can block RCU
tasks from making progress under heavy load. Investigation indicates
that just calling cond_resched() is insufficient for RCU tasks to reach
quiescent states. This also has the side effect of frequently clearing
the TIF_NEED_RESCHED flag on voluntary preempt kernels. As a result,
schedule() will not be called in these circumstances, despite schedule()
in fact provides required quiescent states. This at least affects NAPI
threads, napi_busy_loop, and also cpumap kthread.

By reporting RCU QSes in these kthreads periodically before cond_resched, the
blocked RCU waiters can correctly progress. Instead of just reporting QS for
RCU tasks, these code share the same concern as noted in the commit
d28139c4e967 ("rcu: Apply RCU-bh QSes to RCU-sched and RCU-preempt when safe").
So report a consolidated QS for safety.

It is worth noting that, although this problem is reproducible in
napi_busy_loop, it only shows up when setting the polling interval to as high
as 2ms, which is far larger than recommended 50us-100us in the documentation.
So napi_busy_loop is left untouched.

Lastly, this does not affect RT kernels, which does not enter the scheduler
through cond_resched(). Without the mentioned side effect, schedule() will
be called time by time, and clear the RCU task holdouts.

V4: https://lore.kernel.org/bpf/cover.1710525524.git.yan@cloudflare.com/
V3: https://lore.kernel.org/lkml/20240314145459.7b3aedf1@kernel.org/t/
V2: https://lore.kernel.org/bpf/ZeFPz4D121TgvCje@debian.debian/
V1: https://lore.kernel.org/lkml/Zd4DXTyCf17lcTfq@debian.debian/#t

changes since v4:
 * polished comments and docs for the RCU helper as Paul McKenney suggested

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

 include/linux/rcupdate.h | 31 +++++++++++++++++++++++++++++++
 kernel/bpf/cpumap.c      |  3 +++
 net/core/dev.c           |  3 +++
 3 files changed, 37 insertions(+)

-- 
2.30.2


