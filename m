Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FBB126F32;
	Wed,  8 May 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180111; cv=none; b=ZLIUkUEFTt5V2zXebOLGlPLoOi7THCRcFdW7i/lPUpqxbPWPo3hG+4narOXAcTxMogJoxYbfNgJ9beoDHeUuvR4N2PUTw3B0DWJ+5WTldode7XLl2+1aX0cNJ8Et49DhuuPS7oFakzJHJC7lZqVTGLvueQwd8n3kyXYKP7fLE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180111; c=relaxed/simple;
	bh=e/Vq3mzFZvYVxvGvhb41dxlfmvKiC5BzmYJi9fjCl98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfQl/9WGIzDSBhClFUlFuJcUm0Kgt93D1PwCjli8UUFDzsxrBOW3sz7F6hYuYivNNf0mBYyv877t3S6wnPyAVRsSd9mSkp2Zc7A8spuZ8h2sVW9XrO2i0aKjOdLoDawdTWw2c+mhAWy2nXnrYEccowywdO/HJ24cmjmKKIgTnBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmY2I9Kn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmY2I9Kn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3D0C2BD10;
	Wed,  8 May 2024 14:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715180111;
	bh=e/Vq3mzFZvYVxvGvhb41dxlfmvKiC5BzmYJi9fjCl98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmY2I9KnV7WC332LXcYFBhEMd2AxtzU5THcs/Fwd9I1rkoQhNc1e4O3KwS1VPMcwB
	 CL8+qcs+7C69y3bGCzRfz6D9d5nWELxwXPF35bQt9V+VIzx8WUeqpCvPlZwQ5pj0Uo
	 KRh3RZWXyqVgs9cvugI4ZCGwo8pGXbL0v912ZJltUswrpEMtZihuj207vU5zElMma7
	 AFJLBHaWpm/2nh5p2n0PMmNDg6nptIdq+IRiFn0w4CX33Arjl24DqCpL/Y+o4kpqcW
	 oC7jQn9U1LlTwOHUL24ta6ok0ZXdrS1HrWXw0vrGuVb0G4iZ7IZKrJxR9ofZ+YZ4kD
	 RShBXjXtex34Q==
Date: Wed, 8 May 2024 16:55:08 +0200
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
Subject: Re: [PATCH v2 26/27] rcu: Update stray documentation references to
 rcu_dynticks_eqs_{enter, exit}()
Message-ID: <ZjuSTC0sZvuqx57r@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-27-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-27-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:30AM +0200, Valentin Schneider a écrit :
> rcu_dynticks_eqs_{enter, exit}() have been replaced by their
> context-tracking counterparts since commit:
> 
>   171476775d32 ("context_tracking: Convert state to atomic_t")
> 
> Update the stray documentation references.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  .../RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst   | 4 ++--
>  Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg  | 4 ++--
>  Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg   | 4 ++--
>  Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg       | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> index 0533814a1f69a..50fc99aba777f 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> @@ -147,8 +147,8 @@ RCU read-side critical sections preceding and following the current
>  idle sojourn.
>  This case is handled by calls to the strongly ordered
>  ``atomic_add_return()`` read-modify-write atomic operation that
> -is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
> -time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
> +is invoked within ``ct_kernel_enter_state()`` at idle-entry

Looks like ct_kernel_exit_state().

> +time and within ``ct_kernel_exit_state()`` at idle-exit time.

And ct_kernel_enter_state()

>  The grace-period kthread invokes ``rcu_watching_snap()`` and
>  ``rcu_watching_changed_since()`` (both of which invoke
>  an ``atomic_add_return()`` of zero) to detect idle CPUs.
> diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
> index b57210ecd689e..c7d16b72f0973 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
> +++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
> @@ -607,7 +607,7 @@
>         font-weight="bold"
>         font-size="192"
>         id="text202-7-5-3-27-6"
> -       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_enter()</text>
> +       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_enter_state()</text>

ct_kernel_exit_state()

>      <text
>         xml:space="preserve"
>         x="3745.7725"
> @@ -638,7 +638,7 @@
>         font-weight="bold"
>         font-size="192"
>         id="text202-7-5-3-27-6-1"
> -       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_exit()</text>
> +       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_exit_state()</text>

ct_kernel_enter_state()

etc...

Thanks.

>      <text
>         xml:space="preserve"
>         x="3745.7725"
> diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
> index bd2b33e05447f..bcb71714b4197 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
> +++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
> @@ -977,7 +977,7 @@
>         font-weight="bold"
>         font-size="192"
>         id="text202-7-5-3-27-6"
> -       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_enter()</text>
> +       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_enter_state()</text>
>      <text
>         xml:space="preserve"
>         x="3745.7725"
> @@ -1008,7 +1008,7 @@
>         font-weight="bold"
>         font-size="192"
>         id="text202-7-5-3-27-6-1"
> -       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_exit()</text>
> +       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_exit_state()</text>
>      <text
>         xml:space="preserve"
>         x="3745.7725"
> diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
> index 8ece2b559bd35..e110b0ac74ffe 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
> +++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
> @@ -3107,7 +3107,7 @@
>           font-weight="bold"
>           font-size="192"
>           id="text202-7-5-3-27-6"
> -         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_enter()</text>
> +         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_enter_state()</text>
>        <text
>           xml:space="preserve"
>           x="3745.7725"
> @@ -3138,7 +3138,7 @@
>           font-weight="bold"
>           font-size="192"
>           id="text202-7-5-3-27-6-1"
> -         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_exit()</text>
> +         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_exit_state()</text>
>        <text
>           xml:space="preserve"
>           x="3745.7725"
> -- 
> 2.43.0
> 
