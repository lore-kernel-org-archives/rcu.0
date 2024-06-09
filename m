Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C7663C7
	for <rcu@vger.kernel.org>; Sun,  9 Jun 2024 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717952131; cv=none; b=euTTsGLtuFCMCVziKTtDYrL8UCUhVDmNo6W8QTI2ZVFtKTzLj7wJdL9HuDx2F1FKH/3kpYNNpUlOMKAnKZsbyHz6T7EtTRTh22UH51Wcmuu/tOeiAYGjoUm5BIU6qQO7J4O3N86Rs5/v9/+EH9oaEHduzn2DUfTeLmeaJENRCHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717952131; c=relaxed/simple;
	bh=1JxYCFy7h3QmaFfBmdQFL150Lm8YkexbB4ZxRzgMBU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvJSA+H/nqsFQAHNhJNAt8acPUee9/+9sBAHrxqFWw3qp18ohjA9p/XHXc8whtomHu+lyLvULHVhLb/1q4ad61q55rqdbf6z1L7f1YKqtgmae9k0RnJZeLKAEZS/dY9T0PEzlpJ7VZJZpkM/2WRLiTEtAwA6flUl0SS1HFwakH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txnPzaY2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txnPzaY2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9088DC2BD10;
	Sun,  9 Jun 2024 16:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717952130;
	bh=1JxYCFy7h3QmaFfBmdQFL150Lm8YkexbB4ZxRzgMBU8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=txnPzaY2fCmnX6AVnbAIO9DVMXHZqeDk2+HzDuJHrrfbjfUJQ24YhB+2RFX90uSBL
	 ojLJ2i+7+4que1Mv02qeTXlPm1qIJA9GY92KIxVq/r/alhahkN+KgXOCtAYbcvt9MN
	 slLh6/h0hAzEnrb2YmQGooVfxBfdPGt+udwjDhtNtqeeAljzB9Clm/lDJ4LgtLVpg9
	 ntYBzEwgjJn5FdOVbuZFmaHTmICxhhGURpuTRJE6BJJigj9J8wsLL1dAAZO9sQwkIF
	 V4R+dLhVofoSnOF7IokOYTcKmuanL/H45ukOMj/cZB4qpeBIKhko4GiH8YpSce22TM
	 yibuRkBtnQdEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 33DE5CE22D7; Sun,  9 Jun 2024 09:55:30 -0700 (PDT)
Date: Sun, 9 Jun 2024 09:55:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: srcu_cleanup warning
Message-ID: <d21f257a-4056-43d9-80f5-f07f1285c7fa@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <y5hi7x5w3yi4i5sh2b5hgk7xu2mghkthabc7adrqteg3muc5y4@pbnkp7yyxcrp>
 <e7d313d4-04a7-4f24-bec6-8ade82e3be3b@paulmck-laptop>
 <lfqpkn4ailnaa3da45cnk33yorufv63accbrtnzf7chqa56lyc@jg6ldk4wexzz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lfqpkn4ailnaa3da45cnk33yorufv63accbrtnzf7chqa56lyc@jg6ldk4wexzz>

On Sun, Jun 09, 2024 at 11:37:45AM -0400, Kent Overstreet wrote:
> On Sat, Jun 08, 2024 at 08:25:53PM -0700, Paul E. McKenney wrote:
> > Could you please try something like this just before the call to
> > cleanup_srcu_struct()?
> > 
> > 	WARN_ON_ONCE(poll_state_synchronize_srcu(&c->btree_trans_barrier, ck->btree_trans_barrier_seq);
> 
> Which seq was this supposed to be? All keys have been freed by this
> point...

Or, alternatively, where in the code is this supposed to be?

If there is no convenient point in the code to grab the most recent
return value from start_poll_synchronize_srcu(), another thing to do
is to invoke either synchronize_srcu() or synchronize_srcu_expedited()
just before the call to cleanup_srcu_struct().

Another approach is to use get_state_synchronize_srcu() instead of
start_poll_synchronize_srcu(), and have a self-reposting SRCU callback
to keep the grace periods going.  Then you would set a flag that
stopped it from self-posting, then do srcu_barrier().  With careful
memory ordering.

There are quite a few techniques to shut down the self-reposting SRCU
callback when there is nothing for it to do and to restart it if need be.

But just doing a synchronize_srcu() or synchronize_srcu_expedited() is
a lot simpler and probably does the job.

							Thanx, Paul
