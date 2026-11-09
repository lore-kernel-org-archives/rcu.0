Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249857;
	b=TgXNA6I4Z9jQB1J5hL7xDtbM4z/ObArXzpZ3FgMdTOYlcu3uClIxdWNUQuq25GGW+iOH
	 riHUzASKD7AQYieOlF/SJeAVp7S+S2g70ti4+uqOl9tBKy5ykZJb/pdY4d8cT6gOCGDUV
	 YqUg6Fwo6yiZHPPF2stleEJZR2gLu2bOF8uKAtuH1vq2HgqV7luh0Wb0zO+dRM05sfNx9
	 gTYy01lsQ3ZrpAULTM67XcmxH/MpyA+Cj+LAYqqdNiKYoAfiyKG1DQYzwd4CTnmFEFGwv
	 xmWGDFp21KZHS8Trylx6NcbNkDO7kRvEPAi9oqE/1+36siQvvGlCB5QodZ2J3kJYbrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249857;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=nQXypYppoi0DRmP6r7VK69Yjx+zAm4GuIfrhfhMyqDg=;
	b=DlNamKGV+npeQa4V1qD//srLzMY7VFyTO4FvEyjKkyptv3Fss4Q8Rf85NghDYQTjXvef
	 HA1puR2F6tFzX/Shv8KS/gRLw2dGKR0tO5zk4o3pmaVXxPsTOc/nPOKJDWDvmxcvp8uqm
	 x9GSk/B68oDOXN8z7hrSjqv0wS7RmNG8t5GCOkKhXHY3LXxOZmNXe1EhZa+8L7D7G2buq
	 1JAACjohx0QoaV99qCOOlssptAF/eaNEdLj60hCdTQwOvxCNPmbajFP6ettcz/zH42bA1
	 MKzwiJEM87n4h5oz02ByKbORsP0tBwljH39p+MackgsveJjysv/UBr3uCqv458Sr4JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0XFKKFe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB8E606A325;
	Mon,  9 Nov 2026 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0XFKKFe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101F31F0089F;
	Mon,  9 Nov 2026 18:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794249857;
	bh=nQXypYppoi0DRmP6r7VK69Yjx+zAm4GuIfrhfhMyqDg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=U0XFKKFeUe36mqjmeD4889LDgMRQG/sZy86/2O4Ca7Z/IIC2zntARbkrQxuW71OQr
	 yJZdhTuhrgAd1Ug/Gr+mDzlQV3sQM2SuBKLVI9KnHer1JZA47NvEy9DJHFWjKU/F/f
	 YzvlmF64/m83QgGV+XmSdVoO4r7nSfqZImCUkL4rthncDtNULsek1R29fhCMQUBJWT
	 sRPIeYNiZYRYqm8I/+6cADFCI7TQyOXec0VqDFnMlcx51/nq/hW1vJBzZ7axgP+Mvc
	 LZHDy97mI3R6M2cMgG5dOw5+gWeFlAX7r8tbRUB+RvJtgwulVBzEk3MoonMwfqCXEr
	 aauOecnhSayOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C442FCE0CC1; Mon,  9 Nov 2026 10:44:16 -0800 (PST)
Date: Mon, 9 Nov 2026 10:44:16 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcuscale: Constify struct rcu_scale_ops
Message-ID: <730e60cb-30fd-43a3-8152-543b4ba5878e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3f546f8e102ef271e7d5ac6d8b6a1f44d0fb20cb.1794085327.git.christophe.jaillet@wanadoo.fr>
 <20261108230623.GA3148953@joelbox>
 <2727df26-9f09-48c9-90b5-2d1416c3b2b1@wanadoo.fr>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2727df26-9f09-48c9-90b5-2d1416c3b2b1@wanadoo.fr>

On Mon, Nov 09, 2026 at 06:32:15PM +0100, Christophe JAILLET wrote:
> Le 09/11/2026 à 00:06, Joel Fernandes a écrit :
> > On Sat, Nov 07, 2026 at 10:02:25PM +0100, Christophe JAILLET wrote:
> > > 'struct rcu_scale_ops' is not modified in this driver.
> > > 
> > > Constifying these structures moves some data to a read-only section, so
> > > increases overall security, especially when the structure holds some
> > > function pointers.
> > > 
> > > On a x86_64, with allmodconfig:
> > > Before:
> > > ======
> > >     text	   data	    bss	    dec	    hex	filename
> > >    45585	  24946	   2816	  73347	  11e83	kernel/rcu/rcuscale.o
> > > 
> > > After:
> > > =====
> > >     text	   data	    bss	    dec	    hex	filename
> > >    46545	  23986	   2816	  73347	  11e83	kernel/rcu/rcuscale.o
> > > 
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > Compile tested only.
> > 
> > rcuscale is a test kernel module, is it worth adding boilerplate for
> > non-production code sighting security reasons?
> 
> Oups, now I better understand Bradley Morgan comments.
> 
> I didn't notice it was a test module.
> My patch makes no more sense, as it is not hardening runtime, so feel free
> to just drop it.
> 
> Sorry for the noise and not seeing it by myself.

Although the header comment does say "Read-Copy Update module-based
scalability-test facility", maybe there is something that should be
done to more clearly mark code that is not to be used in production.
And maybe to inform the LLM review bots of this.

But this is bigger than just RCU.

Thoughts?

							Thanx, Paul

> CJ
> 
> > 
> > Do you mind runtime testing it too if you still feel we should do it (and
> > provide reasons why)?
> > 
> > thanks,
> > 
> > Joel Fernandes
> > 
