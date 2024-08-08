Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B0081745;
	Thu,  8 Aug 2024 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723140169; cv=none; b=EwiIwnR57f/ufpUdAANRG79GcoMZyW4AqOr8XravEkwx9Hb/SzOWtS/mqXvz3t3LRxVuROYkrnQDiTTgHoE/z2Ar/V5Ud7l4cqxOdRQma/sKpu7M93MKjQSbbyZE1smvkq6S9LW93bOrl/VPhKUMfJ9F10WeSwH/IMNyWo7gmT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723140169; c=relaxed/simple;
	bh=7YdN0oj7fQwrSTsXIU36WQOIKQ7pRxhyimICcVHzHMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxS2ymcreqTJTT2uNozXksZHIlyOiJLi9oHfNjYhhdmqcejNgQ5+MLhXUoy90K7zYm7WrbJ+XnzXSruUztvQlEhHeDN0zPQKNCxsWg8WCkXdvoF6lyGJxKa1HU+ye+UKgcBD21DQwE6lh6fvoihSNXE0S+7iuusUW+/X4sXVf7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlbnyHCz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlbnyHCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F6CC32782;
	Thu,  8 Aug 2024 18:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723140169;
	bh=7YdN0oj7fQwrSTsXIU36WQOIKQ7pRxhyimICcVHzHMI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NlbnyHCzse9Yz4Y6qPy0UC+BhAzlPwVj8/cL9tfHHPluf7Vyo7zfo0YGnLhaj/Rsr
	 dY8SSbvqmp04dj5b/Hp+jfqaIcaHIhTMjE+3M8+uQDLCq4dHr6uwO+dDnO5xvZumiv
	 xZne0cd/nc9ixiA7Zfc0HLM+85khr1hNduLAkeh1xJmh58loFCWeJF/6BNz6SMU5dv
	 3KndT+1XonQrQmb1rbeqbS8GpginvupzSmrfmfBccSKn5hnQr6QBe44sI/IFchFBvL
	 2NNIf9glTzbhS/dOWB8ZiBb5mCgVu6Jwyu4cuDmvQEjklaiI3uEGKoPlgZ33Qfjkiv
	 CK+L5STlJFxzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 10EC6CE09DB; Thu,  8 Aug 2024 11:02:49 -0700 (PDT)
Date: Thu, 8 Aug 2024 11:02:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] rcu: Annotate struct kvfree_rcu_bulk_data with
 __counted_by()
Message-ID: <2f134298-d41d-4022-a2d5-e89e0c87b00c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240807095459.1400-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807095459.1400-2-thorsten.blum@toblux.com>

On Wed, Aug 07, 2024 at 11:55:00AM +0200, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> records to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Increment nr_records before adding a new pointer to the records array.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e641cc681901..76d8d75dd8b3 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3227,7 +3227,7 @@ struct kvfree_rcu_bulk_data {
>  	struct list_head list;
>  	struct rcu_gp_oldstate gp_snap;
>  	unsigned long nr_records;
> -	void *records[];
> +	void *records[] __counted_by(nr_records);
>  };
>  
>  /*
> @@ -3767,7 +3767,8 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>  	}
>  
>  	// Finally insert and update the GP for this page.
> -	bnode->records[bnode->nr_records++] = ptr;
> +	bnode->nr_records++;
> +	bnode->records[bnode->nr_records - 1] = ptr;
>  	get_state_synchronize_rcu_full(&bnode->gp_snap);
>  	atomic_inc(&(*krcp)->bulk_count[idx]);
>  
> -- 
> 2.45.2
> 
