Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981933CFC
	for <rcu@vger.kernel.org>; Tue, 28 Jan 2025 00:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022989; cv=none; b=OrXc4BnKL27Nv9Lg/xqvN2DoGVbTB63d9fqQrvQ1ZE7YmMhvWgisJNfPNtfNusH5VubQgUH4MytIV7EPAS5dWEM/skq+yofma8VK3IX0UExPkYICENsygfJpVTHw5d08hsw8earBkGLp5yLLoV8b1xbZqD4wiHjMOhpZdvNfUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022989; c=relaxed/simple;
	bh=zir9ny3M0w39ZQPXr1mg/uo4hJVejzdr3GxEcWZVuuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gV+RbN3bpWF8RL+Iri9VtOVyZGKPZJAeSGFj8RIk100I/4sBVD6cz1LgNOE3IJmVFaWHXmnvWLb+7ERwhs5j4HRSew0MSR2ly4rQlEOqUWLCQMLAWj1Ehmdexvjr5UmL86yczva1354ACo4tO7Ywgh4j06c2QLija1YKhlFoiQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=brEbKrvi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="brEbKrvi"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3862d6d5765so2986739f8f.3
        for <rcu@vger.kernel.org>; Mon, 27 Jan 2025 16:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1738022986; x=1738627786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kiAfsHrZMOeVF4otJEqsBOT22FrsCMudjq48BuyC+U=;
        b=brEbKrvilrH4pmY3ZxDHg2gR6mwg8XGyJFC6sBXs+K6wLiIBU7VoBSFAjM0M528lhB
         o3vDhkK23hUIWCSV8ogVwnIYm7nNhJk+nDeEey5k3mLZXZNBMZt2JyqmEvmbtkICDvki
         8020PcYgKcijUgMSHN7FI5hqJrl/G+2T1IPMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738022986; x=1738627786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kiAfsHrZMOeVF4otJEqsBOT22FrsCMudjq48BuyC+U=;
        b=vSK05GgeqIkEy6X8xdDwmc99FhSdO35qmsNlgWiWzvtPG0zOitJHACal8gOWB8UstU
         lp4Fw+u/HreLl4bzfqvee/6SJWAaAQJOeDKX/gTVTdJ3ZLmnQ5KsnA+J+PwhIVuX9eV3
         MiaAV2XfNony1E4tLfsjtbafPMlyyWqmpwYJi857w5khvWv4XwK81rU4vihf0n6J7V/Z
         J128FSw5U3jRYLsrEvwDh9u1Mg0vW5iXniowWnwh4xH8eUOzFeZ1l+l2Bhpj9QOHROcW
         09WoZUInA8LKkP9vWJfI6JdaX/LAvtoX5H63yIdsX0tcorV3eAS+LZscIlPQkQODSNDh
         44Ug==
X-Gm-Message-State: AOJu0YzmWJkD48z172kK2SzU3CKR7GiyYMlQkP7RUZOOtho9/ZVyVcyQ
	PqQLhpG7J0z/bbBXavXHywGgdG1F7oa5cwog9g+TaYyyNE0gr3zW5jTcPQAdmgGuU6pj3QigBZ6
	sS529rRvgAxLZJuG/wuZDVsP2580BprcxrBphTw==
X-Gm-Gg: ASbGnctx0XUb6z8tr86oS7//y+lNsXVtD79yIteErY6hJowPeMOKW7Ny2ikeJDEeTIb
	4FNS6LnUpKfozvJLr7WgTNAmRJ3I5ZoCbHIia1/JiEwGJMGGQ5nI9OT6dle5ZVvk=
X-Google-Smtp-Source: AGHT+IEnAOAjVVY/edC0i7ShUxGOgMUnJ2Uq6bJSDhxdC7CDe1XhiXw8C4h2fF4K9yZrJHHN/AQe1K/uiEDTVvb+A3k=
X-Received: by 2002:a5d:64c2:0:b0:38b:da6a:8a02 with SMTP id
 ffacd0b85a97d-38bf59effcdmr39934814f8f.47.1738022985799; Mon, 27 Jan 2025
 16:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128000737.1264218-1-joel@joelfernandes.org>
In-Reply-To: <20250128000737.1264218-1-joel@joelfernandes.org>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Mon, 27 Jan 2025 19:09:34 -0500
X-Gm-Features: AWEUYZlLkkClGqoVofp0kAlzdwAGcAa4d-IDgkq7D7hqJSGCSoo3JZbg5juo2IE
Message-ID: <CAEXW_YTQpAKLRp4Nv-zM7NJ7JAnuPKSaLicwzL6w9eqMXQFQYQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: Merge rcu_seq_done_exact() logic into rcu_seq_done()
To: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Cc: rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 7:07=E2=80=AFPM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> The rcu_seq_done() API has a large "false-negative" windows of size
> ULONG_MAX/2, where after wrap around, it is possible that it will think
> that a GP has not completed if a wrap around happens and the delta is
> large.
>
> rcu_seq_done_exact() is more accurate avoiding this wrap around issue,
> by making the window of false-negativity by only 3 GPs. Use this logic
> for rcu_seq_done() which is a nice negative code delta and could
> potentially avoid issues in the future where rcu_seq_done() was
> reporting false-negatives for too long.
>
> rcutorture runs of all scenarios for 15 minutes passed. Code inspection
> was done of all users to convince the change would work.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I am leaving a 60 minute overnight run of all scenarios on my personal
server for further testing.

thanks,

 - Joel




> ---
>  kernel/rcu/rcu.h  | 13 ++-----------
>  kernel/rcu/tree.c |  6 +++---
>  2 files changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index eed2951a4962..c2ca196907cb 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -146,19 +146,10 @@ static inline bool rcu_seq_started(unsigned long *s=
p, unsigned long s)
>
>  /*
>   * Given a snapshot from rcu_seq_snap(), determine whether or not a
> - * full update-side operation has occurred.
> + * full update-side operation has occurred while also handling
> + * wraparounds that exceed the (ULONG_MAX / 2) safety-factor/guard-band.
>   */
>  static inline bool rcu_seq_done(unsigned long *sp, unsigned long s)
> -{
> -       return ULONG_CMP_GE(READ_ONCE(*sp), s);
> -}
> -
> -/*
> - * Given a snapshot from rcu_seq_snap(), determine whether or not a
> - * full update-side operation has occurred, but do not allow the
> - * (ULONG_MAX / 2) safety-factor/guard-band.
> - */
> -static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s=
)
>  {
>         unsigned long cur_s =3D READ_ONCE(*sp);
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b77ccc55557b..835600cec9ba 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4300,7 +4300,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu_full);
>  bool poll_state_synchronize_rcu(unsigned long oldstate)
>  {
>         if (oldstate =3D=3D RCU_GET_STATE_COMPLETED ||
> -           rcu_seq_done_exact(&rcu_state.gp_seq_polled, oldstate)) {
> +           rcu_seq_done(&rcu_state.gp_seq_polled, oldstate)) {
>                 smp_mb(); /* Ensure GP ends before subsequent accesses. *=
/
>                 return true;
>         }
> @@ -4347,9 +4347,9 @@ bool poll_state_synchronize_rcu_full(struct rcu_gp_=
oldstate *rgosp)
>
>         smp_mb(); // Order against root rcu_node structure grace-period c=
leanup.
>         if (rgosp->rgos_norm =3D=3D RCU_GET_STATE_COMPLETED ||
> -           rcu_seq_done_exact(&rnp->gp_seq, rgosp->rgos_norm) ||
> +           rcu_seq_done(&rnp->gp_seq, rgosp->rgos_norm) ||
>             rgosp->rgos_exp =3D=3D RCU_GET_STATE_COMPLETED ||
> -           rcu_seq_done_exact(&rcu_state.expedited_sequence, rgosp->rgos=
_exp)) {
> +           rcu_seq_done(&rcu_state.expedited_sequence, rgosp->rgos_exp))=
 {
>                 smp_mb(); /* Ensure GP ends before subsequent accesses. *=
/
>                 return true;
>         }
> --
> 2.34.1
>
