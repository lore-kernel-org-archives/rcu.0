Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAD81547C9;
	Tue, 20 Aug 2024 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724181620; cv=none; b=Tf0oJCpDd3hNyH7kQiediTrWRIebwERDKU0r+yXECmdOPsXU8BliJ5RmSdYq6/RSKk/fN081+juvngCwsqVb7kwpO1natTUTHpIzpQvPagiSv9JfwWPCLfZ6s2bWjz3VHnjsfBXX3Wv+pzMif+A6jkPMFCRsD6qw9QyrGH69dpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724181620; c=relaxed/simple;
	bh=z6sMV+fIP8pdgd8VF/zTMKbzES2yhLkyiceYKRyOY9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgyTCymcIdNZLqy/OUyF3SlcXkX6SExQ1mYf2T0b2so824dvsQVmDmQWoA/W2x1BQ+HvajVB6FE6djEC3O3j602r75BJN/8cxGP8IPUQ7unru7zwEnWyJAAk6aMzrGkwy2yRAqVEs87A0xRgNAxF3cHun4pEEggvHAOjVR+rSnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uY6+Ib+d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uY6+Ib+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B59DC4AF0B;
	Tue, 20 Aug 2024 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724181619;
	bh=z6sMV+fIP8pdgd8VF/zTMKbzES2yhLkyiceYKRyOY9M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=uY6+Ib+d2hKmFPtoIc6/G55lK8gW0onvPVgR2lOuae+1nvwcl7Us9Dmg7h2TRldBe
	 oCaH4juzLDAUtu8Z4iMVE2DtoahPN4+FIVpRsj+EJ8ohJjI6TxbwxSElqo7kdAX/WL
	 fy74F6Hav/+D1sDq8uQloFzaNXxQVW8M3/kOXUjZXlz2IbXYgRFU0fvqEjh7AXr+GT
	 0ta6X0Ug5wCr3fiW/yf2gs2+0CUMZEtrU+lfMWON6j43FspmwGSo62wmTZNU49fVE/
	 gMFn3HuffVU7/hu95X2UxGXU679k866JE1FWlgmBKqUAyuoVxOvyshVH+Bc7U9ys2X
	 +FiHfy5BUdcmA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D6B60CE0DE1; Tue, 20 Aug 2024 12:20:18 -0700 (PDT)
Date: Tue, 20 Aug 2024 12:20:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] rcu: Remove unused declaration
 rcu_segcblist_offload()
Message-ID: <6bf549e6-204a-478e-ad9d-3b1b438befe4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240815085053.4157590-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815085053.4157590-1-yuehaibing@huawei.com>

On Thu, Aug 15, 2024 at 04:50:53PM +0800, Yue Haibing wrote:
> Commit 17351eb59abd ("rcu/nocb: Simplify (de-)offloading state machine")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Good eyes!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/rcu_segcblist.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> index 259904075636..fadc08ad4b7b 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -120,7 +120,6 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
>  void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v);
>  void rcu_segcblist_init(struct rcu_segcblist *rsclp);
>  void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
> -void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload);
>  bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp);
>  bool rcu_segcblist_pend_cbs(struct rcu_segcblist *rsclp);
>  struct rcu_head *rcu_segcblist_first_cb(struct rcu_segcblist *rsclp);
> -- 
> 2.34.1
> 
