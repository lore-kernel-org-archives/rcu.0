Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D024262BE
	for <rcu@vger.kernel.org>; Mon, 27 May 2024 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838035; cv=none; b=IaUK7LtdpZh2UK3Thgg/riy7yk33oitlmB1dJ1n2oDvTfoMlnzNw7f71kS/eTJF4YhC8A6mwcll6AS8uWU3S1eagz/eR/cmAp8bMvSyavV8JlXDzQgIgTca7DrZc9vDxhjHu45Bw5RHhlB6N19bPLLzJjVAUf4TGgZJb/B36BfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838035; c=relaxed/simple;
	bh=iqoUo3SFAipQefWtj+yxERKHY3j2LgzgKzwnM6yP52M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=It3A8QAf/1y3p4eTaRUjLYE8F/F38ThTL+Chrb4id++BIzncV/xqRn4ikOmJ+cua+f03KKms/G+f6jiK6IXHgFFtpHP5Jc+rnvZZ+6weDnSRMFyA4tgRvXToih3lZ3ywdxqbE6N9OQxoozZ5QQ4/S1vyp5Tkz+YNpUXdiQ0YL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdEotALy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdEotALy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBD9C32781;
	Mon, 27 May 2024 19:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716838035;
	bh=iqoUo3SFAipQefWtj+yxERKHY3j2LgzgKzwnM6yP52M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=sdEotALy4cf/H0ss6II35tMEcp+SH/dklUm6QnKjo69jt8881o22JehAlVHHd/ajV
	 38nZdPUefd4TLRJej7A5BiZ5cmtQsxfJK2cutrjGk+jP7frgtEVpW+EVDk7YKsP7N3
	 5PCQ/k2n5fgrklZTuJXKB3OhAwQRFwSuAFqxZ1lxPTv1bi7n0/XqY9AVmQ1WiPLgP0
	 tVI/Jr6owxrE7Fau5Z8A33ejEBwtnpG0EB2qB7Do9Po0SG9pu0ikMcstvIFc+TXTbg
	 V+u/EhbKWHAT1GLCDIaGNpvptABUNBOIpk2kN0IIgeV7Wbgw34efN3zrlKPbop2xus
	 EWm68LIPgw2BQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C8C5CCE0991; Mon, 27 May 2024 12:27:14 -0700 (PDT)
Date: Mon, 27 May 2024 12:27:14 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	RCU <rcu@vger.kernel.org>, cocci@inria.fr
Subject: Re: [cocci] patch idea: convert trivial call_rcu users to kfree_rcu
Message-ID: <a1f15e67-25f5-4a0b-a9d0-ebbc0555fb12@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <68b85796-c674-4691-936a-2051849f4692@suse.cz>
 <6b7e3ed9-d974-cb3b-6839-a6b7cf5f5a36@inria.fr>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b7e3ed9-d974-cb3b-6839-a6b7cf5f5a36@inria.fr>

On Mon, May 27, 2024 at 10:13:40AM +0200, Julia Lawall wrote:
> 
> 
> On Mon, 27 May 2024, Vlastimil Babka wrote:
> 
> > Hi,
> >
> > one bit from LSF/MM discussions is that there might be call_rcu users with a
> > callback that only does a kmem_cache_free() to a specific cache. Since SLOB
> > was removed, it's always ok to use kfree() and thus also kfree_rcu() on
> > allocations from kmem_cache_alloc() in addition to kmalloc(). Thus, such
> > call_rcu() users might be simplified to kfree_rcu(). I found some cases
> > semi-manually, but I'd expect coccinelle could help here so if anyone wants
> > to take this task, feel free to.
> 
> Thanks for the suggestion!  I will try to look into it.

Thank you both!

							Thanx, Paul
