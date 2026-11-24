Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795502861;
	b=vYvh1kMUrWCHtAWjstyBVVbwY7euW+a7UgsCtc/x5bbPlNGarxZONVzA2ce/wYgRiGO3
	 8ZubWL0qCYy9rVRZ2GtsY2ZwhBlw97r6XyhB3ppJArbaU9uHzLxVqs0Xsr/+YKsVSV9i0
	 GOcGSn346Hxnj4TU5rcM7K7pua6XlYGf586mEVSosf3+av5kzU1PBHJO8wJlhEjUDiLAz
	 rMk9oMhTddWhZWMEBOQKzMeCj9xYmAivxU/8Z+mxjLQb7f6Q5E5r8s7fvCjRTZ4zk04kr
	 PEALPj5IZ7DKB2rPQ3pwKd9VMeaqqjdcWsT/ZgfGU3RMTaJD0caibelK5DirfjOzzXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VnrZOZlg3BlUOIyh9s4cDgTJrHx2oMwWRpzxMW8e3a0=;
	b=FE02ZVI+H4SAIwr5IlRjIH+1QWJ9eJRnHHIY5woQ1SJEllxl96nCnM3lz9Ip2YP0L7wM
	 +ywo3pHcXKeyjxSZmSpgAbbZNmD6kFZJgP6/RMb9bSxuUqlOgQt6TKo/zwKw3YllHFL2V
	 0RHd5qL8u7QAbj1JMAH8NsQUowbxLUbte3tAMIoMjUnqWPUcTESnBPUrACE+ZEvaTx06c
	 7HUKsrYOBg2PudP+RNZ60o3jCybNOiXCpayPaz4bnzJd2Nek+qFvNWyVybv2xPlXk83+Q
	 0foh6UXmuFC0hfuMYa/EMp7EYmNyhE5Lbo3UKXgl8B3VRvKeMd+WG3WrbGL/egDgzfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l6KiE0vX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34989606A322
	for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 06:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34989606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l6KiE0vX
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b4dbdc9592so10149597b3.3
        for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 22:47:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795502860; cv=none;
        d=google.com; s=arc-20260327;
        b=kwcBe9S4kbpCQEDOD/irW06b4xyYi0Z4h5R5irpFs6N+5eBTYCTpVwkDSjmk+kWpJP
         FaHy7e3zJkQc8JhQCVphX2n7Slw4y8dSym9K43YmxJ+lNKaYanrCK9lXIdT3xUIWuEe1
         ULlnWRe3lce0He/RCVy4thstQElbtFIy847EGU2L2Th8rF2rnn7sFHwP/rHDVPzVaDUo
         S9MsF8+MwFq6EXzKn3pBYYixvnSqbpipQKfBM319QEF4LdZ6252DpFSWVxLp30/CUs3S
         npYuWMZreNXObnRYuCchKQi9gyAoou5aWNEajOLwiaVt7dSofM22PXi8a7cfFMq5udu2
         0ulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VnrZOZlg3BlUOIyh9s4cDgTJrHx2oMwWRpzxMW8e3a0=;
        fh=hB0HV16R5Hcca7fgOEvjQCh46lty8usPk0LGwnNUHeM=;
        b=WxWX/3PElOGjvZAK1sAMmU2lpSWt814nS4csfLZaDli5zx5qKd8UathpuBVr+faN34
         PSWvIBiXd+ru1WwqrFIkg/ouLgUqIn9EcrhpqlJA0wFKjeqlb42mgcQh5IXH8SKGtLeq
         ipxt0GOjq3+MgEE3JA8/wKnHIRfXGqsXLLJJhKOAD+/bdM0I+EPpmWEdRrlWM9xo3u/y
         7bcvNQozYPicLxNWcarIkkX+DBq8ZTGS7dTwGeAw6uTI3PVvyiqxt0XoiwXt5y4ecIOe
         lA6kh0aFP10YKhQ52bQe+A6+mR9ltAL1veNrGjCJLHzk+o4kByT4WmT7XOHtyc4SGrlj
         DmTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795502860; x=1796107660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VnrZOZlg3BlUOIyh9s4cDgTJrHx2oMwWRpzxMW8e3a0=;
        b=l6KiE0vX1DJWMgWjM8XEA6zfQmx+6toUGoWw49iNLZ2omHgB1EGKia+KQ9rLVa4EGn
         ICr+sMiZRF53bVRYYmsKeQGoVSR/QUMZ7Z78d3e2Fv464j90HRMgNMOSyWqOC9E7T03Z
         LJR7+upDUr92NJCWACupI+hSqkFt9bicdtGtHWTxpu4YwAoLqO0HlfdzPrCx6gFHWHLu
         xaiTtAkAoAvSuo2mfhCJTa1xc4Cov+uZI/fi6h7jfhpXNIVgyr08nlxdiiX/RA/K6Lnv
         H4OauwOSlcelISEbafEo5XADmEcNT9yKBAS5uQj4Sg7mjzgObOLPWacsXxHWD+hKX9fq
         zF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795502860; x=1796107660;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VnrZOZlg3BlUOIyh9s4cDgTJrHx2oMwWRpzxMW8e3a0=;
        b=eBDOrL0/bwDa5550OjQcpJwV0HA35HiDN+u3Fowp5JlM0OpjXTeQjUuICNQhdAB9xq
         mg9dTAVNj3KqoBo03nd6glVdnt140YPNXfbaoElg2lfV5YW8eoaky5ofWsS3QKf3I/L7
         vdrdPPnJHA2s0uvZ377j5XdEcb+e5h6nATTuk1+ZjSIABZAPutzqpUVDE1ME2UoRMkzQ
         YieMKgqTKwpk8hgqH8oWxJz33RL8QT/eCokLQwiYZN0364+gk8UfDsbiXQ4S+yiZanq2
         I9KdRgsTybrN2dwaWWLju12JRs9nDRTCJP0QEZ3bgseWVJ0bFePQsTjJk61UAwskj3RR
         DTIg==
X-Forwarded-Encrypted: i=1; AL+hErHbbyVOglxiLue9ogjU0o7ptrDnmE6pN2g0sDLc1g4nUuYEQQ4CmGWx6JO5Jf6nucwlOXo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XRjMdGL9o1zbUTwcRFu5pDGiQCfq2aG+JeG+OnJ5dDtr8mlz6
	x1RgS9oVjk6DGVDjDtmVKEOyw2tZ5A+D/N1I7sMfiVsIQVKu9CP9QGC6+ygH7S+FMyenKKpgcj2
	14STT/rx0QJfxfWO0mM0Rtf15A+yxfXs=
X-Gm-Gg: AZFdTZe2k1gOxLFY3cOR7aR+/kPOAnJBnYy22Rj9y2RP/YVnuMaOuNcPWhPBysCDSJf
	iy+2ZjZ1GEVYS4WPGafKUmPAUZpO1yDmm4xKxwACaWFWtVaaoPytEOsqgWo7s+PnUhfuWlmmQ6i
	WYib+5BsYJ4GAK3yObAlTyfNJUtWxw11vZ3b6aRlF8g/RVOshK3VYxO+tA7nu3Y54h3rXYFwOeG
	ApvU4yMGrJb+oAYvqJ/r+XNsiMlXQyEKKOG3AtELQbUHOqSXMe7JeLmlrrnENwBC1OoEhFx45q0
	v94Nq17QOQi7G8U547X64rtTnIJu5wIC+oW8mMhpwidf7s1Rhm8GsVmi1kb4TECE/0ud6V4i/b8
	uCH8FfyZbUxHxo5bqNPLz33JjNlnVTnYgWo5vPMG4HdPH2penIzzC7a5x9fa61c+mhfxB/lu3qd
	FXWWq1stM8jr87
X-Received: by 2002:a05:690c:f0a:b0:8b0:a8c1:b203 with SMTP id
 00721157ae682-8b5204a4d62mr49738217b3.29.1795502860010; Mon, 23 Nov 2026
 22:47:40 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-klp-series-v3-v1-0-427c95811d9b@vt.edu>
 <DM6PR05MB41373C039888AD13938D3838D1452@DM6PR05MB4137.namprd05.prod.outlook.com>
 <CALOAHbDu5NmVowk4SHzeUDxASaxKkbL_w1dModFWzdi8yK9tBw@mail.gmail.com> <DM6PR05MB41377901DA5182DDFAD6E3D4D1442@DM6PR05MB4137.namprd05.prod.outlook.com>
In-Reply-To: <DM6PR05MB41377901DA5182DDFAD6E3D4D1442@DM6PR05MB4137.namprd05.prod.outlook.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 24 Nov 2026 14:47:04 +0800
X-Gm-Features: Aa3M54o2kD5CAgD6Kh7BeaSGBGBREFHEzSySI0CnyEHkEYGRzmsY1gHwE2Ygmgc
Message-ID: <CALOAHbCDSAuvxHt2jd-f5rvTrxeZ4KZkKUfqxrE09PXk+Te36Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] livepatch: Do not lose exiting tasks during a transition
To: "Ravindran, Binoy" <binoy@vt.edu>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, 
	"live-patching@vger.kernel.org" <live-patching@vger.kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Shastri, Jaidev" <jaidevshastri@vt.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 12:57=E2=80=AFPM Ravindran, Binoy <binoy@vt.edu> wr=
ote:
>
>
> Hi Yafang,
>
> Thanks for the pointers to the earlier thread and to Josh's
> suggestion.
>
> > I did not take it for the same reason Sashiko raised in issue 2: the
> > RCU exit list narrows the race window but does not close it.
> > I could not see how klp_synchronize_transition(), as you describe
> > below, completely resolves it. Could you please explain that in
> > detail?
>
> The exit list alone does not close it, and v2 does not rely on it
> alone. The exit list covers the part of the exit path that can sleep.
> The part it misses cannot sleep or be preempted, and
> klp_synchronize_transition() waits it out. In detail:
>
> 1. Where the gap is. An exiting task is on an exit list from
>    exit_tasks_rcu_start() to exit_tasks_rcu_finish(). exit_notify()
>    runs inside that range, and the task is unhashed no earlier than
>    exit_notify(). So until exit_tasks_rcu_finish() the task is on the
>    task list, an exit list, or both. After exit_tasks_rcu_finish() it
>    may be on neither, if it has already been unhashed. That is the
>    gap in issue 2.
>
> 2. What the task can do in the gap. do_exit() calls preempt_disable()
>    before exit_rcu() and exit_tasks_rcu_finish(). After that the task
>    runs only lockdep_free_task() and do_task_dead(), whose __schedule()
>    is its last. From preempt_disable() on, the task stays on its CPU:
>    it cannot sleep, be preempted, or migrate. So once a task is in the
>    gap, the next context switch on its CPU is the task's final one.
>
> 3. What klp_synchronize_transition() guarantees. It calls
>    schedule_on_each_cpu() and returns only after a work item has run
>    on every online CPU, so every CPU has switched context since the
>    call began. Any task that was in the gap when the call began has
>    reached its final __schedule() and will never run again.
>
> 4. Where v2 calls it.
>
>    a. In klp_init_transition(), after patch_state has been set on
>       every task (the task list and the exit lists, walked under
>       tasklist_lock) and before func->transition is set. A task that
>       the walk did not visit had left the exit lists before or during
>       the walk, so it was in the gap when the sync began, and it is
>       dead before any function enters the transition. So when
>       func->transition is set, every task that can still run has a
>       valid patch_state.
>
>    b. In klp_try_complete_transition(), before it calls
>       klp_complete_transition(). A task in the gap can still be
>       running code reached through the old function, and the switch
>       check cannot see it. The sync makes it dead before
>       func->transition is cleared and before the old patch can be
>       freed. A task that leaves the exit lists after this sync was
>       already counted as switched, so it runs the new code.
>
> So there is no point at which a task that can still run patched code
> is invisible to the transition: before exit_tasks_rcu_finish() it is
> on a list the transition walks, and after it, the sync waits for it to
> die.

Thanks for the detailed explanation.
It makes sense to me.

>
> One limit: the exit lists exist only with CONFIG_TASKS_RCU. Without
> it, the helpers are empty and only the final non-preemptible stretch
> is covered.

Is it worth adding yet another separate list for the klp transition?
If not, I think we should at least make the CONFIG_TASKS_RCU dependency
explicit:

--- a/kernel/livepatch/Kconfig
+++ b/kernel/livepatch/Kconfig
@@ -12,6 +12,7 @@ config LIVEPATCH
        depends on KALLSYMS_ALL
        depends on HAVE_LIVEPATCH
        depends on !TRIM_UNUSED_KSYMS
+       select TASKS_RCU
        help
          Say Y here if you want to support kernel live patching.
          This option has no runtime impact until a kernel "patch"

--=20
Regards
Yafang
