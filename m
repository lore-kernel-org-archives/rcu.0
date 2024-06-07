Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E978DDC9;
	Fri,  7 Jun 2024 03:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717729357; cv=none; b=e9eXDns3g2FJsx+zQ/PbNbpeT7I6WKSArNVvW3KW1XYPNaM1D2X+c8ZiG09BxAjCz6GdlImeAYylZiZKPZFj22Htc8ErbZGaKAqmHLIiDcFAVeWLpzb6Kh/cGqAB3dQb2MubMVwdfe9H7vS9vEepoR5ttxoM4ynrw7AS51gHZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717729357; c=relaxed/simple;
	bh=L1aAF7dAtjWnPMFqXiNyLMDHxg94N0lBQFrlvDFtYzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYKfX/Lz6J+sAyyYtHcJEFeAEinqHIHO9HYziEzg4Xoeme1E9AT8Cej5KBdKqtPV5OFhypogjUNEOqi2wfvgN2/yIFk3EiJzKxtV21HhujzPd9jt6OskliHYYJI6hA4S9ybOPVPyLkgcsd3E36s+wC2NFbu6t8l+XatC04lXsRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ic+Jp31N; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ic+Jp31N"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-704140292c2so39745b3a.1;
        Thu, 06 Jun 2024 20:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717729356; x=1718334156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejDXcxSpP9icVx/1EuiWyrQGyl9TpRx/2egbprYsM3E=;
        b=ic+Jp31N9C5VrFFm+RXin4t1+adZH1+5WIQBcy+AUqRNAcHrDGPeM21WNdU5N9xm2P
         oHtQLEthwOrRL21s45jEJK19D3CfkMZJhmEhu6ijQwN2NwUHMfEE6v50SRfzGYBlk2aw
         4v7TS87mRs2MWO1tp79QZyXmmp4IyB+op81r0H/nurtvvzN/O9yO26w1kGghxUrbhqNy
         YZtumFVvrCKhX+GIjR4TAHbADoIOatp2O2gKKxcsPPZ6Jel6H2B3+7LtUUoJyIsBQCJ2
         uer1VXyC67b+ELbP6GFz+W4XVxRfJTrl0XktVeWs2+J9fsEJj9cFGd+XJ0MLWqvzpISK
         BlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717729356; x=1718334156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejDXcxSpP9icVx/1EuiWyrQGyl9TpRx/2egbprYsM3E=;
        b=L2phxaLso1GtXZX8ZZAE2a1jgO3nFTCuqbRp/XooRofO75M8fHz6rlLIvKddPndrwb
         XGRoFfkqT1m1pE1ITCx1zoARIY4QnKZVo9jLZlLxg7UyOBJSxNh1Pg/CWx6teHCU6Wvl
         jMxN1aIJ7zCb5ueIU5fD+qHRqsalwkMUPLPyBuzb+lzgL7fL4OSsffQiY6obH+7piqO4
         qqzGtTD5bdNmjUvTnRRmGmkKzLzozXV1B5zzuTaKkJcA+n56zRJzZMVlz4+xW5txf0Po
         PIU3XRqM0l+dQpf+OM+issgdIAm2+f5+PJS1madVb9DBe56BmwKLMfX1ZJcfU1O3ZFVS
         rnOw==
X-Forwarded-Encrypted: i=1; AJvYcCVn4WZZmtiMJozBdauVpM9olnTWOnU7yOQ1BSEsLPCSqlk45rSxpZVewbDoDsphbbZWYVZqgIbo3AUIiALxtnhJV/MxEkwZfd6FAsJFXaXHOKCYc+5ijFsXPWLMQKpkHJz/
X-Gm-Message-State: AOJu0YxpNkOOL74T3ipH+E5cfKMLSUeC3ulc/7OyQj1zOhOB6v6C5brK
	Fzm6mbTpak8HefIHvT2uGLpAEI5JqcxnDJXli8uJ2atGlemsRSc9
X-Google-Smtp-Source: AGHT+IEhKraLWJQ16qpMEO3KRgHYMvSBWq5cqen0fVttn2vamXfceNIRqH+V2oFSHMdiJoCtgZr/fA==
X-Received: by 2002:a05:6a20:3c8a:b0:1ad:7e4d:2ea2 with SMTP id adf61e73a8af0-1b2f969ee1bmr1666829637.4.1717729355532;
        Thu, 06 Jun 2024 20:02:35 -0700 (PDT)
Received: from localhost.localdomain ([91.199.84.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c4a574bsm2429371a91.56.2024.06.06.20.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 20:02:35 -0700 (PDT)
From: Wei Fu <fuweid89@gmail.com>
To: oleg@redhat.com
Cc: Sudhanva.Huruli@microsoft.com,
	akpm@linux-foundation.org,
	apais@linux.microsoft.com,
	axboe@kernel.dk,
	boqun.feng@gmail.com,
	brauner@kernel.org,
	ebiederm@xmission.com,
	frederic@kernel.org,
	fuweid89@gmail.com,
	j.granados@samsung.com,
	jiangshanlai@gmail.com,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	michael.christie@oracle.com,
	mjguzik@gmail.com,
	neeraj.upadhyay@kernel.org,
	paulmck@kernel.org,
	qiang.zhang1211@gmail.com,
	rachelmenge@linux.microsoft.com,
	rcu@vger.kernel.org,
	rostedt@goodmis.org,
	weifu@microsoft.com
Subject: Re: [RCU] zombie task hung in synchronize_rcu_expedited
Date: Fri,  7 Jun 2024 11:02:19 +0800
Message-ID: <20240607030219.2990306-1-fuweid89@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606172848.GC22450@redhat.com>
References: <20240606172848.GC22450@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> 
> > ```
> > # unshare(CLONE_NEWPID | CLONE_NEWNS)
> >
> > npm start (pid 2522045)
> >     |__npm run zombie (pid 2522605)
> >        |__ sh -c "whle true; do echo zombie; sleep 1; done" (pid 2522869)
> > ```
> 
> only 3 processes? nothing is running? Is the last process 2522869 a
> zombie too?

Yes. The pid-2522045 sent SIGKILL to all the processes in that pid namespace,
when it exited. The last process 2522869 was zombie as well. Sometimes, 
`npm start` could exit before `npm run zombie` forks `sh`. You might see there
are only two processes in that pid namespace.


> 
> Could you show your .config? In particular, CONFIG_PREEMPT...

I'm using [6.5.0-1021-azure][1] kernel and preempt is disabled.
Highlight part of .config.

```
$ cat /boot/config-6.5.0-1021-azure | grep _RCU
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
CONFIG_RCU_CPU_STALL_CPUTIME=y
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set

$ cat /boot/config-6.5.0-1021-azure | grep _PREEMPT
CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_DYNAMIC is not set
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set

$ cat /boot/config-6.5.0-1021-azure | grep HZ
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_NO_HZ=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_MACHZ_WDT=m
```

> 
> > The `npm start (pid 2522045)` was stuck in kernel_wait4. And its child,
> 
> so this is the init task in this namespace,

Yes~

> 
> > `npm run zombie (pid 2522605)`, has two threads. One of them was in D status.
> ...
> > $ sudo cat /proc/2522605/task/*/stack
> > [<0>] synchronize_rcu_expedited+0x177/0x1f0
> > [<0>] namespace_unlock+0xd6/0x1b0
> > [<0>] put_mnt_ns+0x73/0xa0
> > [<0>] free_nsproxy+0x1c/0x1b0
> > [<0>] switch_task_namespaces+0x5d/0x70
> > [<0>] exit_task_namespaces+0x10/0x20
> > [<0>] do_exit+0x2ce/0x500
> > [<0>] io_sq_thread+0x48e/0x5a0
> > [<0>] ret_from_fork+0x3c/0x60
> > [<0>] ret_from_fork_asm+0x1b/0x30
> 
> so I guess this is the trace of its sub-thread 2522645.

Sorry for unclear message.
Yes~

> 
> What about the process 2522605? Has it exited too?

The process-2522605 has two threads. The main thread-2522605 was in zombie
status. Yes. That main thread has exited as well. Only thread-2522645 was
stuck in synchronize_rcu_expedited.

> 
> > > But zap_pid_ns_processes() shouldn't cause the soft-lockup, it should
> > > sleep in kernel_wait4().
> >
> > I run `cat /proc/2522045/status` and found that the status was kept switching
> > between running and sleeping.
> 
> OK, this shouldn't happen in this case. So it really looks like it spins
> in a busy-wait loop because TIF_NOTIFY_SIGNAL is not cleared. It can be
> reported as sleeping because do_wait() sets/clears TASK_INTERRUPTIBLE,
> although the window is small...
> 

I can reproduce this issue in v5.15, v6.1, v6.5, v6.8, v6.9 and v6.10-rc2.
All the kernels disable CONFIG_PREEMPT and PREEMPT_RCU. And it's very easy to
reproduce this in v5.15.x with 8 vcores in few minutes. For the other versions
of kernel, it could take 30 minutes or few hours.

Rachel provides [golang-repro][2] which is similar to docker repro. It can be
built as static binary which is friendly to reproduce.

Hope this information can help.

Thanks,
Wei

[1]: https://gist.github.com/fuweid/ae8bad349fee3e00a4f1ce82397831ac
[2]: https://github.com/rlmenge/rcu-soft-lock-issue-repro?tab=readme-ov-file#golang-repro
