Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A0D27FB3A
	for <rcu@vger.kernel.org>; Wed, 24 Sep 2025 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700178; cv=none; b=NAO+8XlT3JyVzrj8yYouGd7PGuVvaZBPi0jWFhIBUmajDba8aRzyXr3WUE9Qck6MSa1nj/9FYxmKRFKy9GMD2vI+0C5xiJD2A6ren/YZaVo51/xKjxD6HWCiPhYZrYlV+FwIYeT+jMb2o1jE7pVTR/UZ5SpRHHn1XvbG6hPvzJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700178; c=relaxed/simple;
	bh=imem7Fulr1tmQS9v5BeQ71kbYVLrqAiE9Lu1LMtwkdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVJSczWuYKwdTS8YHc0Z+rlU0Ca7+cS72iVTQdS5K5j9QksDC+Py9u9hty7IKiQnesaMkl77KdwmcRg9vQ9ZMacZ7vZ+bgacGfrrQ2AzG3dHjazJH292C6rgRafAZ+7Z9f+rSmiL1tF9tpkkyiiNEKHum8+BkCpNjFpjB/3utno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYZEJ6jl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYZEJ6jl"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so4842055f8f.3
        for <rcu@vger.kernel.org>; Wed, 24 Sep 2025 00:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758700175; x=1759304975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siednjEVlO5fU6PowVaXN3eMjFaXMH60luleJBwBeaM=;
        b=YYZEJ6jlfKeHQKjEbf4Pev88qZkDI6JoJwp6A3pPO4v6/RnARs6oBF5o8psJyeeW1R
         4fTS+gnKZkd1ibou9dN24ipD/ni2fFVlfFr5csuOVoimHlj1CRXBAreTIJtjLDY/+PDt
         4DxzpdLu/6HfJEF28DJSEPBSL4TBJJIhZS0FwJbKJ7kLYK/FiXQ3BZph9GQ0b/Cy0YBm
         7ao5XXBIB+roHP0f4F8i30Ue9aDfvkj6NbaFkMR5XjpqIB7pSwU/f7Z8PobrIY8FmXLG
         jp9K3tyGz2VnkNFpEI/In/jMlqSz/AOuk5aGOG69oVOzskzsQfX3Sb57pkukMMycfAOo
         YcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758700175; x=1759304975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siednjEVlO5fU6PowVaXN3eMjFaXMH60luleJBwBeaM=;
        b=Cwzaun+JXkX3eJtVflqGsVEUrJGo83c5tcO6XLqTvgnryYah5qXb5NvSLS7tNUNl8+
         LobULtm0K17usLOylEExXGoy2noHkoSH73HZSZpl0ZZcFMn8nPG6nKg1PXI8vgwJwfDg
         7qTffFCstC1yNFovV6dxumPgubRXTJVEJi6EZpOlyivUv7V9biZyUKTXZViUlnqqtM7e
         sDNf/8DJDPt+1FMNZzQ7GQBWtJyYKdKyLoCzehA8/nNIR26D3DSDAYQcBmn5/CVvq/uG
         uHi6UQciERvmFsjBuu/9XrC9F1zH+cP5oEq6xUIwG0nroC2m2IObj38nXzfBmjvfqBrq
         CQow==
X-Gm-Message-State: AOJu0YxRqWqBV92zfFL8oSPwz18KbK8ZyKJM4U2WVxQDCNKGB2YV7FmQ
	+qe2rHAgPzO/wbMHkZo0VTX+1/Z82iruiVHHoRyJqKpewxJp/2x/dTPNc5paL/k7Kq/+wIgtQz6
	5uvu8XlCp+QISJoj2TaSr3+og+1L825Q=
X-Gm-Gg: ASbGncslx1j/+xKD6Net+nBcMQvqioxPeFNYroaUeXEaYhHq6aHfaEYKD5eXckbDowE
	tltWO5CHskYLkyWbkP4WS60oKofKNioW9SndE3gqfX8XkG3Wkj3qkGdK6Ljqvou9X+ixMsbFTzQ
	ZgNhEsNRZEEJL/A96jvuDSzxmoVSFFYkzvbHPKR9CYmR4c4zvizLa83r/8SxFK9ow1LejRGc9U6
	3bGoRTM
X-Google-Smtp-Source: AGHT+IGDhPqwBOVdwQrZXuNT95QuC8D3rxlVtM3E8zQRECWZuS/44rqk3DnDKboFwDkEoAIcf8IsbSFEuGVppLC5crc=
X-Received: by 2002:a05:6000:616:b0:3ee:13ab:cd35 with SMTP id
 ffacd0b85a97d-405c3e27153mr4511400f8f.1.1758700174654; Wed, 24 Sep 2025
 00:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
In-Reply-To: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Sep 2025 09:49:23 +0200
X-Gm-Features: AS18NWCV1-h9hv6pfLwDQN-c9dkTUhxsqVE1RICvIEgy9IFTVhrkgbLet2-Jj5s
Message-ID: <CAADnVQKNxGFOWN7-HmzObYobW2y33g-i3xsNSkKicx88hqe70w@mail.gmail.com>
Subject: Re: [PATCH 0/34] Implement RCU Tasks Trace in terms of SRCU-fast and optimize
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 4:21=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> Hello!
>
> This series re-implements RCU Tasks Trace in terms of SRCU-fast,
> reducing the size of the Linux-kernel RCU implementation by several
> hundred lines of code.  It also removes a conditional branch from the
> srcu_read_lock_fast() implementation in order to make SRCU-fast a
> bit more fastpath-friendly.  The patches are as follows:
>
> 1.      Re-implement RCU Tasks Trace in terms of SRCU-fast.
>
> 2.      Remove unused ->trc_ipi_to_cpu and ->trc_blkd_cpu from
>         task_struct.
>
> 3.      Remove ->trc_blkd_node from task_struct.
>
> 4.      Remove ->trc_holdout_list from task_struct.
>
> 5.      Remove rcu_tasks_trace_qs() and the functions that it calls.
>
> 6.      context_tracking: Remove
>         rcu_task_trace_heavyweight_{enter,exit}().
>
> 7.      Remove ->trc_reader_special from task_struct.
>
> 8.      Remove now-empty RCU Tasks Trace functions and calls to them.
>
> 9.      Remove unused rcu_tasks_trace_lazy_ms and trc_stall_chk_rdr
>         struct.
>
> 10.     Remove now-empty show_rcu_tasks_trace_gp_kthread() function.
>
> 11.     Remove now-empty rcu_tasks_trace_get_gp_data() function.
>
> 12.     Remove now-empty rcu_tasks_trace_torture_stats_print() function.
>
> 13.     Remove now-empty get_rcu_tasks_trace_gp_kthread() function.
>
> 14.     Move rcu_tasks_trace_srcu_struct out of #ifdef
>         CONFIG_TASKS_RCU_GENERIC.
>
> 15.     Add noinstr-fast rcu_read_{,un}lock_tasks_trace() APIs.
>
> 16.     Remove now-unused rcu_task_ipi_delay and TASKS_TRACE_RCU_READ_MB.
>
> 17.     Create a DEFINE_SRCU_FAST().
>
> 18.     Use smp_mb() only when necessary in RCU Tasks Trace readers.
>
> 19.     Update Requirements.rst for RCU Tasks Trace.
>
> 20.     Deprecate rcu_read_{,un}lock_trace().
>
> 21.     Mark diagnostic functions as notrace.
>
> 22.     Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast.
>
> 23.     Create an srcu_expedite_current() function.
>
> 24.     Test srcu_expedite_current().
>
> 25.     Create an rcu_tasks_trace_expedite_current() function.
>
> 26.     Test rcu_tasks_trace_expedite_current().
>
> 27.     Make DEFINE_SRCU_FAST() available to modules.
>
> 28.     Make SRCU-fast available to heap srcu_struct structures.
>
> 29.     Make grace-period determination use ssp->srcu_reader_flavor.
>
> 30.     Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast().
>
> 31.     Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast().
>
> 32.     Require special srcu_struct define/init for SRCU-fast readers.
>
> 33.     Make SRCU-fast readers enforce use of SRCU-fast definition/init.
>
> 34.     Update for SRCU-fast definitions and initialization.

Maybe it's just me, but the patch set is too fine grained.
These 34 patches could be squashed into a handful for better
review. All these steps: add smp_mb(), make it conditional,
make it more conditional, remove one field,
remove another field is a distraction from actual logic at the end.
