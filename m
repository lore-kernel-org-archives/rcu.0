Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2896F07E;
	Wed,  8 May 2024 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174472; cv=none; b=JEml5AMpXZrgjxjUaeVSVheTtSr9VK6il0A+v3jb0EEa5dlpCEAf2sNsV8rlTHmptaATTwRqeD+GcYxAHkWUs019bSt1MCbfTXl3XKP/lo9uSoNVcMGhIwdWNFN+vZPMf9DmlO8gxFeeUqtkPrOMfYq2wsPG+jOBVRVlZWuXsxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174472; c=relaxed/simple;
	bh=3lpzmZ1CcF+40VeU5eyrSjKDwEL08Geu8Md3lZ8zsv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mn/ws/ZrK2u8lwRwLXvD+pmMzQdPaG0DrPeCstlGO4lrFS/nt5uTY6ogyJoz7k6vamm+jo0zIZHxyAoHgU0GOIfcPOUW8oMz31YKY3KJIWVQIMz3ityDufGqewZWgE5QVSMh/tEhN7OUj/jvZchPjF/HqXeS57SFTo/dJ6R2Zvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISRSIXfr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISRSIXfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FCFC113CC;
	Wed,  8 May 2024 13:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715174472;
	bh=3lpzmZ1CcF+40VeU5eyrSjKDwEL08Geu8Md3lZ8zsv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISRSIXfr2CwhmfRHGt7q/WgKF7xmXanDYpsIDtXOlZ+mwDPGDST3zysNt6VRigy3g
	 VfXiXVb903n4D3gUe5Bvlg/eIse7LbwlgUCrKG2KhhbmQIUuE7PvBvwXRk10VMtTfh
	 oIhyI8vc2ke5ixmmXG8VNXUFoGj4mSfvEyXjSYKqe/lCl05R+MpN8IKXQDv6Q0YgiY
	 xkPz9r9JzJpoInqzxPuIrKSPuO/hCLs8dQ8UcQ5ZtaC6p6LpjkW44GXtj72ofWir34
	 yxI1y8vj/EhOHbHRwF+E5mXkjtqMwTEZ+eQb0KHYEqXhDLZwGPR1Mk6NOZT6mR5w5O
	 pId8VRj2IbXxQ==
Date: Wed, 8 May 2024 15:21:09 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 22/27] rcu: Rename dyntick_save_progress_counter()
 into eqs_save_progress_counter()
Message-ID: <Zjt8RSn6D4SzZJHC@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-23-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-23-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:26AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
> meaning.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  .../RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg        | 2 +-
>  .../RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg         | 2 +-
>  Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg   | 2 +-
>  .../RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg        | 2 +-
>  kernel/rcu/tree.c                                         | 8 ++++----
>  5 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
> index 423df00c4df9d..961b2595241fe 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
> +++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
> @@ -528,7 +528,7 @@
>         font-style="normal"
>         y="-8652.5312"
>         x="2466.7822"
> -       xml:space="preserve">dyntick_save_progress_counter()</text>
> +       xml:space="preserve">eqs_save_progress_counter()</text>
>      <text
>         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"
>         id="text202-7-2-7-2-0"
> diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
> index d82a77d03d8cc..9a8e7d1686ce1 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
> +++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
> @@ -844,7 +844,7 @@
>       font-style="normal"
>       y="1547.8876"
>       x="4417.6396"
> -     xml:space="preserve">dyntick_save_progress_counter()</text>
> +     xml:space="preserve">eqs_save_progress_counter()</text>
>    <g
>       style="fill:none;stroke-width:0.025in"
>       transform="translate(6501.9719,-10685.904)"
> diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
> index 53e0dc2a2c793..40e6686962de1 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
> +++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
> @@ -2974,7 +2974,7 @@
>         font-style="normal"
>         y="38114.047"
>         x="-334.33856"
> -       xml:space="preserve">dyntick_save_progress_counter()</text>
> +       xml:space="preserve">eqs_save_progress_counter()</text>
>      <g
>         style="fill:none;stroke-width:0.025in"
>         transform="translate(1749.9916,25880.249)"
> diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
> index 4fa7506082bfe..14313aeb8affd 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
> +++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
> @@ -516,7 +516,7 @@
>         font-style="normal"
>         y="-8652.5312"
>         x="2466.7822"
> -       xml:space="preserve">dyntick_save_progress_counter()</text>
> +       xml:space="preserve">eqs_save_progress_counter()</text>
>      <text
>         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"
>         id="text202-7-2-7-2-0"
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 73b95240a1a6c..2037daf0298d0 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -764,11 +764,11 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
>  }
>  
>  /*
> - * Snapshot the specified CPU's dynticks counter so that we can later
> + * Snapshot the specified CPU's RCU_WATCHING counter so that we can later
>   * credit them with an implicit quiescent state.  Return 1 if this CPU
>   * is in dynticks idle mode, which is an extended quiescent state.
>   */
> -static int dyntick_save_progress_counter(struct rcu_data *rdp)
> +static int eqs_save_progress_counter(struct rcu_data *rdp)

rcu_watching_snap_save() ?

>  {
>  	rdp->watching_snap = rcu_watching_snap(rdp->cpu);
>  	if (rcu_watching_in_eqs(rdp->watching_snap)) {
> @@ -782,7 +782,7 @@ static int dyntick_save_progress_counter(struct rcu_data *rdp)
>  /*
>   * Returns positive if the specified CPU has passed through a quiescent state
>   * by virtue of being in or having passed through an dynticks idle state since
> - * the last call to dyntick_save_progress_counter() for this same CPU, or by
> + * the last call to eqs_save_progress_counter() for this same CPU, or by
>   * virtue of having been offline.
>   *
>   * Returns negative if the specified CPU needs a force resched.
> @@ -1981,7 +1981,7 @@ static void rcu_gp_fqs(bool first_time)
>  
>  	if (first_time) {
>  		/* Collect dyntick-idle snapshots. */
> -		force_qs_rnp(dyntick_save_progress_counter);
> +		force_qs_rnp(eqs_save_progress_counter);
>  	} else {
>  		/* Handle dyntick-idle and offline CPUs. */
>  		force_qs_rnp(rcu_implicit_dynticks_qs);

And then I'm tempted to propose rcu_watching_snap_recheck() instead of
rcu_implicit_dynticks_qs().

Thanks.

> -- 
> 2.43.0
> 
