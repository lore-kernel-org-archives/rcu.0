Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92C854FB5;
	Wed, 12 Jun 2024 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180861; cv=none; b=p1QtSxPesO3FdvZnbhg4L8PoSJjhpFvSvPMv5rxMLDcjPYlFEF9qw7fUdL77arl4R9UmI61/xOX1XBDAl8fBqLz+fEsHka0DlGhsSkw+pFSHC53H8jXL2LiqAafKSq+KwbTFXclWWLNao8ew92TofF8OPZkSGyEykKtRXxjmYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180861; c=relaxed/simple;
	bh=PwU2Gl1KBzn204l0FuhpWCGgDnHFdB5ybjTdvk7XpCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpVOAG4LF0CB2V/OvRf+JYnv424OlJm1iuLKbjwhXlt9SPvhLb85DBF3fJLkQD8nh91mWOImsmiyKdUzbMdnqbKM86kfeGtIKgwx4UQVH3yNOTciKu4dS+KAlS8b8UojJN626tDrDexpZkfHBsD43/Ut6AgOaS54W4tQaxUYuwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiBudH/Z; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiBudH/Z"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57c778b5742so4399155a12.2;
        Wed, 12 Jun 2024 01:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718180858; x=1718785658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwBHLuJXZXJ/sxu7Sz5T+qFIUs6Se3+i9MmuUqp0tm4=;
        b=XiBudH/Z4FFV7aASOGwTHp+P4Pe76+yjNHhhqFgk2T2e5ibOBKwCfF9yTcTyFGEGbk
         sPhKasnlIdU3GC6foda/vODvXRZKNO8ifBkOWqkqT2+C0T9XGZCGydrLfV5FYQwGTq+6
         2QkMwR3rcOP+QNef/tZp16FijDQx2wMPCRpEPzJP0D5WDCMlssRVnb3TUwGjK6C5rUsR
         FR0iayDBwcgJlEx3RcSskk5Vi/r7FGCkGOLMAFaQb+NO3InpbLwTPzGGKSMpztNJfudg
         MG2xP8coU1VfHpoBXv86mZfrkIK7zXtYzr+LQsCqxc6RO5+WsRtBfmsGozUfqlBbma6j
         EiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718180858; x=1718785658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwBHLuJXZXJ/sxu7Sz5T+qFIUs6Se3+i9MmuUqp0tm4=;
        b=offiPUCaGY5AZPPD6wGBOEJKZmyUWitphjVF8qr3pg4cBL8uSNC0RXhgIpz3p9oB6k
         cD6t/zJuuQAEsnnQHu73Iqk7jdFfs5Lq14zwAcWmKbMlk0z1nW5SGpMf6ZnkVArImy0u
         GHbrgfvsiyjeC3XrukBfpOg089lrTTVMPmSFeMMrpnkVVkvcFV6+ZmazFGL2FzmzTkYp
         qtpjXQVMeVYTk3bcUlDLuEovDyR+efHeJZOBt+EtBK/mj3z0yJTNdz02kJszTJkIpFWI
         2en6vfVp/VIrdDzqqK4qR7KCVH1K7gZsWNb/68TIq2i5fF2XeWZOHpR6XOGOctXD555G
         oLmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEWZKshJFicbuTNLc2xVE4ts479yjnOmV30Mtq21FpVhTCo8DJ0QaGoqCuQIZ4gwIN4jNgraOocb8vtnb3AIFGxcrjis1+UOPQPSng
X-Gm-Message-State: AOJu0Yw5QXjye2rEdG5bMDZqvadzD3EjDGU5ta+Fl6oT/kAy2z+GCl+M
	KRnqer2n12Ix/bdnega8Q9LxMc4o6juhvX9COV9ZxVUytLL8A+378qKjQixMWnG5TKGxPiyv8Iv
	sm3bX2msiF2awV6iHLPIdELw25vw=
X-Google-Smtp-Source: AGHT+IErh0x3Pm5np4qJe2wVyW/HJxAYB2W24/K+A8obzCtbP5fifWOzJ5EPqKu6agXA4fMAcnBVxBhGUcMmkkVMjUo=
X-Received: by 2002:a50:8d47:0:b0:57c:5fcf:b570 with SMTP id
 4fb4d7f45d1cf-57caaab44aamr619566a12.32.1718180857854; Wed, 12 Jun 2024
 01:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop> <20240604222652.2370998-2-paulmck@kernel.org>
In-Reply-To: <20240604222652.2370998-2-paulmck@kernel.org>
From: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date: Wed, 12 Jun 2024 13:57:20 +0530
Message-ID: <CAFwiDX9ynNpmU_Au=J7geJYjE8NLLM-p2x8QDyjmZ1qNBkLXZQ@mail.gmail.com>
Subject: Re: [PATCH rcu 2/6] rcu: Remove superfluous full memory barrier upon
 first EQS snapshot
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 3:58=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> From: Frederic Weisbecker <frederic@kernel.org>
>
> When the grace period kthread checks the extended quiescent state
> counter of a CPU, full ordering is necessary to ensure that either:
>
> * If the GP kthread observes the remote target in an extended quiescent
>   state, then that target must observe all accesses prior to the current
>   grace period, including the current grace period sequence number, once
>   it exits that extended quiescent state.
>
> or:
>
> * If the GP kthread observes the remote target NOT in an extended
>   quiescent state, then the target further entering in an extended
>   quiescent state must observe all accesses prior to the current
>   grace period, including the current grace period sequence number, once
>   it enters that extended quiescent state.
>
> This ordering is enforced through a full memory barrier placed right
> before taking the first EQS snapshot. However this is superfluous
> because the snapshot is taken while holding the target's rnp lock which
> provides the necessary ordering through its chain of
> smp_mb__after_unlock_lock().
>
> Remove the needless explicit barrier before the snapshot and put a
> comment about the implicit barrier newly relied upon here.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  .../Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst    | 6 +++---
>  kernel/rcu/tree.c                                          | 7 ++++++-
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ord=
ering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Orderi=
ng.rst
> index 5750f125361b0..728b1e690c646 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.r=
st
> +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.r=
st
> @@ -149,9 +149,9 @@ This case is handled by calls to the strongly ordered
>  ``atomic_add_return()`` read-modify-write atomic operation that
>  is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
>  time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
> -The grace-period kthread invokes ``rcu_dynticks_snap()`` and
> -``rcu_dynticks_in_eqs_since()`` (both of which invoke
> -an ``atomic_add_return()`` of zero) to detect idle CPUs.
> +The grace-period kthread invokes first ``ct_dynticks_cpu_acquire()``
> +(preceded by a full memory barrier) and ``rcu_dynticks_in_eqs_since()``
> +(both of which rely on acquire semantics) to detect idle CPUs.
>
>  +-----------------------------------------------------------------------=
+
>  | **Quick Quiz**:                                                       =
|
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index f07b8bff4621b..1a6ef9c5c949e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -769,7 +769,12 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, stru=
ct rcu_data *rdp)
>   */
>  static int dyntick_save_progress_counter(struct rcu_data *rdp)
>  {
> -       rdp->dynticks_snap =3D rcu_dynticks_snap(rdp->cpu);
> +       /*
> +        * Full ordering against accesses prior current GP and also again=
st
> +        * current GP sequence number is enforced by current rnp locking
> +        * with chained smp_mb__after_unlock_lock().
> +        */

It might be worth mentioning that this chained smp_mb__after_unlock_lock()
is provided by rnp leaf node locking in rcu_gp_init() and rcu_gp_fqs_loop()=
 ?


Thanks
Neeraj

> +       rdp->dynticks_snap =3D ct_dynticks_cpu_acquire(rdp->cpu);
>         if (rcu_dynticks_in_eqs(rdp->dynticks_snap)) {
>                 trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS(=
"dti"));
>                 rcu_gpnum_ovf(rdp->mynode, rdp);
> --
> 2.40.1
>
>
