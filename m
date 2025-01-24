Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C84157E82
	for <rcu@vger.kernel.org>; Fri, 24 Jan 2025 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737683403; cv=none; b=b0I9XUb2vNi8op0xehW2bXbW83R66qq2jtdfTg3HcfU9eUJs6OM1m7BzcL905DtF1Na9VKGhQHw+zGZsXIrzKP/iGWp8JoVnCSMvDgxSYUUxPBKEyyADB3B+sAZAIC5h99wKoiC0YbPSSwg+QcyZGayUOEL1DT4EnEtXcFqL+JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737683403; c=relaxed/simple;
	bh=i+wf1oj72TYUrIbcx1SHFByW5a41CIAp43iEu0qYtYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIiSRgPsmhvtCRg9ZmI30FBWkQH+KqcUnx5Gjg0S4o4IOyxWTCtyUBN7Rym2fdPJKZOtMcLcGTG3FjfqHCDralje/Oao8bhCM5X9Y/xuhaF/i6IxGRNvvk3JS5LCOYFfScD7Mz8om+c1oyiZHjxkB+JIv9BSvMRi6ij5MPV/Gm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=U38ylILg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="U38ylILg"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38a34e8410bso860740f8f.2
        for <rcu@vger.kernel.org>; Thu, 23 Jan 2025 17:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1737683399; x=1738288199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbDEHQjDxbvFGsR4a3UMc+knAMgT/0dDcH6SHEPIFiw=;
        b=U38ylILg0MBs3+zv9MalWPGfPz214mJnZAy9c/0rHMCg3HTqeoU77GZsjsDToqJGWp
         u1G4F7HrLHH6fcDNyqfi8NiGYxjbk79X51Su58PzRpgij/z8QbO1tn+W6KalIjDPMnBJ
         SzIMAUGMXYugkeAeW2mtQ6s67rAOguNOqLDeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737683399; x=1738288199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbDEHQjDxbvFGsR4a3UMc+knAMgT/0dDcH6SHEPIFiw=;
        b=gUYibwnWDJOJI4y6g6faS9LPKwyNcMGZlymRs6lYKvdov8Mh8I3umdQB6Yd/7WA/0w
         76VbkjFHVpeGjWcYsqUFdcUKA/TNZ7Dr/fdOyGnqkVT5sEzSP7B8nQp8eC6KMgx2r5eL
         Ei0ht4vfMNOTtselGx8LN6Pje2wS3yCm9TcADNt+NROpt1SdB335qtoiFxpycNHBa5jk
         ZSyTghkr6vKtXklkNv/K5m690Nzjq692ZLHk1HAZx0KFc+dlGMWJupYUUkobh+ikFO1X
         jONluPhQz7c3ZGfEO2eoem2kzj6yiwl6FHl31ajE89/5HYy8Y2yJjZIu7WmhIKvJd4bc
         /Cyg==
X-Gm-Message-State: AOJu0YzWldjb7wvzFHpsTa336uHgqg9A+XA7sXgTkZwBIbjeFz/wjkBv
	YFYxZ/ojPH0k5OjO4MBCn+21FHMt3K6veA+AOxe3eDD9F8MITKRznotoVCSgffP2HlMVxhYrHxI
	enVdWJRImcEj1/63rjxHMInQ8P2uPsHTORWkOK4n/Bsl+zo/Y
X-Gm-Gg: ASbGncu2g28IuxuSxWVBXFUTs/VWjlq7gfJ9mgaVIihuuHyTYr1y2OrqwMbkddUw7Dp
	NHfNMvOq62uY+3qmX6qhjUi8cmMSTEX6/IbsZH6jXw60HvOz3jvEQ335C7e90xAA=
X-Google-Smtp-Source: AGHT+IHnpP0P1Fl815j7V1u3kOD9djnVTMukISrufibOGngjzKj/u/kHi42ehREKgsDEOi2jsZNRJGcE51Y4CKjgcuU=
X-Received: by 2002:a5d:6d86:0:b0:385:e38f:8cc with SMTP id
 ffacd0b85a97d-38bf59e1e56mr33924316f8f.38.1737683399424; Thu, 23 Jan 2025
 17:49:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eb83ab84-05b3-43da-bc59-e2dbd932740c@paulmck-laptop>
In-Reply-To: <eb83ab84-05b3-43da-bc59-e2dbd932740c@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Thu, 23 Jan 2025 20:49:47 -0500
X-Gm-Features: AWEUYZm8kcwoKeN2b0sKKREuhDVXdJ47HBv-361P29Luf6aoIbVtiZTvaX16-Dw
Message-ID: <CAEXW_YSo1NTmx8FE3WNN7zL9so24o40HXhxubHJVvfxWBYtz0w@mail.gmail.com>
Subject: Re: [PATCH RFC rcu] Fix get_state_synchronize_rcu_full() GP-start detection
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 7:59=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> The get_state_synchronize_rcu_full() and poll_state_synchronize_rcu_full(=
)
> functions use the root rcu_node structure's ->gp_seq field to detect
> the beginnings and ends of grace periods, respectively.  This choice is
> necessary for the poll_state_synchronize_rcu_full() function because
> (give or take counter wrap), the following sequence is guaranteed not
> to trigger:
>
>         get_state_synchronize_rcu_full(&rgos);
>         synchronize_rcu();
>         WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&rgos));
>
> The RCU callbacks that awaken synchronize_rcu() instances are
> guaranteed not to be invoked before the root rcu_node structure's
> ->gp_seq field is updated to indicate the end of the grace period.
> However, these callbacks might start being invoked immediately
> thereafter, in particular, before rcu_state.gp_seq has been updated.
> Therefore, poll_state_synchronize_rcu_full() must refer to the
> root rcu_node structure's ->gp_seq field.  Because this field is
> updated under this structure's ->lock, any code following a call to
> poll_state_synchronize_rcu_full() will be fully ordered after the
> full grace-period computation, as is required by RCU's memory-ordering
> semantics.
>
> By symmetry, the get_state_synchronize_rcu_full() function should also
> use this same root rcu_node structure's ->gp_seq field.  But it turns out
> that symmetry is profoundly (though extremely infrequently) destructive
> in this case.  To see this, consider the following sequence of events:
>
> 1.      CPU 0 starts a new grace period, and updates rcu_state.gp_seq
>         accordingly.
>
> 2.      As its first step of grace-period initialization, CPU 0 examines
>         the current CPU hotplug state and decides that it need not wait
>         for CPU 1, which is currently offline.

This can also happen if CPU 1 is idle, and then becomes non-idle and
starts a reader which does step #3?

Reason I was asking is because it sounded from the code comment in
patch below that this issue could happen only via hotplug.

But I agree fully with the change that get.._full() should sample the
rcu_state counter and not the root node one since it more accurately
spans a full GP.

I will look through this patch again tomorrow though...
Thanks!

  - Joel



>
> 3.      CPU 1 comes online, and updates its state.  But this does not
>         affect the current grace period, but rather the one after that.
>         After all, CPU 1 was offline when the current grace period
>         started, so all pre-existing RCU readers on CPU 1 must have
>         completed or been preempted before it last went offline.
>         The current grace period therefore has nothing it needs to wait
>         for on CPU 1.
>
> 4.      CPU 1 switches to an rcutorture kthread which is running
>         rcutorture's rcu_torture_reader() function, which starts a new
>         RCU reader.
>
> 5.      CPU 2 is running rcutorture's rcu_torture_writer() function
>         and collects a new polled grace-period "cookie" using
>         get_state_synchronize_rcu_full().  Because the newly started
>         grace period has not completed initialization, the root rcu_node
>         structure's ->gp_seq field has not yet been updated to indicate
>         that this new grace period has already started.
>
>         This cookie is therefore set up for the end of the current grace
>         period (rather than the end of the following grace period).
>
> 6.      CPU 0 finishes grace-period initialization.
>
> 7.      If CPU 1=E2=80=99s rcutorture reader is preempted, it will be add=
ed to
>         the ->blkd_tasks list, but because CPU 1=E2=80=99s ->qsmask bit i=
s not
>         set in CPU 1's leaf rcu_node structure, the ->gp_tasks pointer
>         will not be updated.  Thus, this grace period will not wait on
>         it.  Which is only fair, given that the CPU did not come online
>         until after the grace period officially started.
>
> 8.      CPUs 0 and 2 then detect the new grace period and then report
>         a quiescent state to the RCU core.
>
> 9.      Because CPU 1 was offline at the start of the current grace
>         period, CPUs 0 and 2 are the only CPUs that this grace period
>         needs to wait on.  So the grace period ends and post-grace-period
>         cleanup starts.  In particular, the root rcu_node structure's
>         ->gp_seq field is updated to indicate that this grace period
>         has now ended.
>
> 10.     CPU 2 continues running rcu_torture_writer() and sees that,
>         from the viewpoint of the root rcu_node structure consulted by
>         the poll_state_synchronize_rcu_full() function, the grace period
>         has ended.  It therefore updates state accordingly.
>
> 11.     CPU 1 is still running the same RCU reader, which notices this
>         update and thus complains about the too-short grace period.
>
> The fix is for the get_state_synchronize_rcu_full() function to use
> rcu_state.gp_seq instead of the the root rcu_node structure's ->gp_seq
> field.  With this change in place, if step 5's cookie indicates that the
> grace period has not yet started, then any prior code executed by CPU 2
> must have happened before CPU 1 came online.  This will in turn prevent
> CPU 1's code in steps 3 and 11 from spanning CPU 2's grace-period wait,
> thus preventing CPU 1 from being subjected to a too-short grace period.
>
> This commit therefore makes this change.  Note that there is no change to
> the poll_state_synchronize_rcu_full() function, which as noted above,
> must continue to use the root rcu_node structure's ->gp_seq field.
> This is of course an asymmetry between these two functions, but is an
> asymmetry that is absolutely required for correct operation.  It is a
> common human tendency to greatly value symmetry, and sometimes symmetry
> is a wonderful thing.  Other times, symmetry results in poor performance.
> But in this case, symmetry is just plain wrong.
>
> Although this fixes 91a967fd6934 ("rcu: Add full-sized polling for
> get_completed*() and poll_state*()"), it is not clear that it is worth
> backporting this commit.  First, it took me many weeks to convince
> rcutorture to reproduce this more frequently than once per year.  Second,
> this cannot be reproduced at all without frequent CPU-hotplug operations,
> as in waiting all of 50 milliseconds from the end of the previous
> operation until starting the next one.  Third, extremely heavy use of
> get_state_synchronize_rcu_full() and/or poll_state_synchronize_rcu_full()
> is required to reproduce this, and as of v6.12, only kfree_rcu() uses it,
> and even then not particularly heavily.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 980f1fa719665..71620a8a2eb3d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4204,14 +4204,17 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
>   */
>  void get_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
>  {
> -       struct rcu_node *rnp =3D rcu_get_root();
> -
>         /*
>          * Any prior manipulation of RCU-protected data must happen
>          * before the loads from ->gp_seq and ->expedited_sequence.
>          */
>         smp_mb();  /* ^^^ */
> -       rgosp->rgos_norm =3D rcu_seq_snap(&rnp->gp_seq);
> +
> +       // Yes, rcu_state.gp_seq, not rnp_root->gp_seq, the latter's use
> +       // in poll_state_synchronize_rcu_full() notwithstanding.  Use of
> +       // the latter here would result in too-short grace periods due to
> +       // interactions with newly onlined CPUs.
> +       rgosp->rgos_norm =3D rcu_seq_snap(&rcu_state.gp_seq);
>         rgosp->rgos_exp =3D rcu_seq_snap(&rcu_state.expedited_sequence);
>  }
>  EXPORT_SYMBOL_GPL(get_state_synchronize_rcu_full);
>
