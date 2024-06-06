Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8494A196C97
	for <rcu@vger.kernel.org>; Thu,  6 Jun 2024 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695036; cv=none; b=EcHzfX3h0kdJiiek0vwIRN8fZ/OZ6m98kpAhI7GULJbCcZCWgRp1jq3A9aQlYd4rmtAfQJ+o2sTD0lmolNT0kNGl094hkIYUhLlp5as6J/bVEeTvqCTEbspcGf3HiZy2g+Bg5tMh5K/I1ovm/sk7E9dMjESAnpe/S1AdibewYK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695036; c=relaxed/simple;
	bh=EYlgpxPA80geN9LevgcDmS0gk8V4/XcgnBIobbz9TH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVy7WZ9Vr2VcPGrspMx3r9K3jAVzeoaJZ0MYkMm/QGmgFQwtjIdJ6kID9GWlwkGNigUghs4D5zRfv5Mka1OuPPOhiLoXHG1X8ybae8/2PbyZeONbxZv3dGkzLLwJ4/j4JM5pRe1EZgofDn6/KfEpNvMnrWKIZztDbqtKONaXQvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZhF2r/X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZhF2r/X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717695033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GOXhki6j2BQvamjk/NXsbVjbyb5r0aobhW6sKmuuMxA=;
	b=SZhF2r/XYh/q0tJKTiNhUCRbJcgF5O2t9AmxhwUfu8h9c0VEbm3JXWnQp5Fb41YyjaZSpq
	RIGV41Pf9Ixow6UeHsDoT8vQKgW8k5h/hZtGPFXDC2hb2mMtbqCGwpXYxSiZNWyCDK8qiB
	ql8okOLPWmsob1pXIRCg938MXVEn7JQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-bGoqTFl5OM-mZzo2n1jvJw-1; Thu, 06 Jun 2024 13:30:26 -0400
X-MC-Unique: bGoqTFl5OM-mZzo2n1jvJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79DFC8007A1;
	Thu,  6 Jun 2024 17:30:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by smtp.corp.redhat.com (Postfix) with SMTP id 825BA20232CB;
	Thu,  6 Jun 2024 17:30:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  6 Jun 2024 19:28:56 +0200 (CEST)
Date: Thu, 6 Jun 2024 19:28:49 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Wei Fu <fuweid89@gmail.com>
Cc: Sudhanva.Huruli@microsoft.com, akpm@linux-foundation.org,
	apais@linux.microsoft.com, axboe@kernel.dk, boqun.feng@gmail.com,
	brauner@kernel.org, ebiederm@xmission.com, frederic@kernel.org,
	j.granados@samsung.com, jiangshanlai@gmail.com,
	joel@joelfernandes.org, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	michael.christie@oracle.com, mjguzik@gmail.com,
	neeraj.upadhyay@kernel.org, paulmck@kernel.org,
	qiang.zhang1211@gmail.com, rachelmenge@linux.microsoft.com,
	rcu@vger.kernel.org, rostedt@goodmis.org, weifu@microsoft.com
Subject: Re: [RCU] zombie task hung in synchronize_rcu_expedited
Message-ID: <20240606172848.GC22450@redhat.com>
References: <20240606111051.GA22450@redhat.com>
 <20240606154553.53514-1-fuweid89@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606154553.53514-1-fuweid89@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hi Wei, thanks for more info.

On 06/06, Wei Fu wrote:
>
> > Well, due to unfortunate design zap_pid_ns_processes() can hang "forever"
> > if this namespace has a (zombie) task injected from the parent ns, this
> > task should be reaped by its parent.
>
> That zombie task was cloned by pid-1 process in that pid namespace. In my last
> reproduced log, the process tree in that pid namespace looks like

OK,

> ```
> # unshare(CLONE_NEWPID | CLONE_NEWNS)
>
> npm start (pid 2522045)
>     |__npm run zombie (pid 2522605)
>        |__ sh -c "whle true; do echo zombie; sleep 1; done" (pid 2522869)
> ```

only 3 processes? nothing is running? Is the last process 2522869 a
zombie too?

Could you show your .config? In particular, CONFIG_PREEMPT...

> The `npm start (pid 2522045)` was stuck in kernel_wait4. And its child,

so this is the init task in this namespace,

> `npm run zombie (pid 2522605)`, has two threads. One of them was in D status.
...
> $ sudo cat /proc/2522605/task/*/stack
> [<0>] synchronize_rcu_expedited+0x177/0x1f0
> [<0>] namespace_unlock+0xd6/0x1b0
> [<0>] put_mnt_ns+0x73/0xa0
> [<0>] free_nsproxy+0x1c/0x1b0
> [<0>] switch_task_namespaces+0x5d/0x70
> [<0>] exit_task_namespaces+0x10/0x20
> [<0>] do_exit+0x2ce/0x500
> [<0>] io_sq_thread+0x48e/0x5a0
> [<0>] ret_from_fork+0x3c/0x60
> [<0>] ret_from_fork_asm+0x1b/0x30

so I guess this is the trace of its sub-thread 2522645.

What about the process 2522605? Has it exited too?

> > But zap_pid_ns_processes() shouldn't cause the soft-lockup, it should
> > sleep in kernel_wait4().
>
> I run `cat /proc/2522045/status` and found that the status was kept switching
> between running and sleeping.

OK, this shouldn't happen in this case. So it really looks like it spins
in a busy-wait loop because TIF_NOTIFY_SIGNAL is not cleared. It can be
reported as sleeping because do_wait() sets/clears TASK_INTERRUPTIBLE,
although the window is small...

Oleg.

