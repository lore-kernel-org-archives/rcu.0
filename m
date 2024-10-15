Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9541E1E9096;
	Tue, 15 Oct 2024 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007991; cv=none; b=FumMjhpmwP5iEDJVRenUXDi4wOJotXxZVN2ptm0jCHHYMeg/x945t40Hs42espRciWgiHauYpdO1AqijdN0G5RB/n2lbcdM1Xq1vRm32oVWZ6XHsAVoB9wBGMMTUNz3S6zyeS5wRjRsP3MdV7+L2WPXBIHupAn8YcrmQkJYyd7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007991; c=relaxed/simple;
	bh=5NaaBNOaRCCAQwYF+nDe/ZN5voDdMgWTNF8IQ2SoN1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3OQA/otC24u/8v5y5VVwvsBkRq3n2b9nX2ThObjwAw42Wj7wvDsVMYGTbMfeEY9JOyuWtowT+uiXyzRB7hgLbmcUjtCntpqbcWrLujqTkE5oZlSB3+FdlsFBItWNrAmP9TIz/CNdnP+15UflfVYuxx1RpNIhs3qvEl+vxzEN7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/gez9tf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/gez9tf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24647C4CEC6;
	Tue, 15 Oct 2024 15:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729007991;
	bh=5NaaBNOaRCCAQwYF+nDe/ZN5voDdMgWTNF8IQ2SoN1Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=f/gez9tfH2tYJDCsBuHroN3voe20/0GbkS2gE/ev2f8yKPnQRijsa+a7QbAvtC8Bg
	 h3ROPL7SYXjbg9ndbBGm3Q9Ls2RG6qM7e3ekeEOCpOo5bZmaa4R7Viog+Z1i6YycIm
	 VXb203CUkHUvQnbzOPU58soAj6492rQ5cyN7thw5J8ZvUaDg4WNArEhD7SUCeu7bbo
	 jBaJlQKHAhLIrXy2a7ourlm/+l2rlyi2SqpjEWPmJTYcDLLQiOe82f1/RQiHdnYH69
	 P1d9MQP8qVS3fLRQQAXUX8sYMDJZpr8mPjXwOomPvTXfKuMtnawzfn5fg4YygmKsTm
	 ZPnhgiyDe7Tow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AECA2CE0971; Tue, 15 Oct 2024 08:59:50 -0700 (PDT)
Date: Tue, 15 Oct 2024 08:59:50 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: frederic@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2 rcu 13/13] srcu: Improve srcu_read_lock_lite()
 kernel-doc comment
Message-ID: <3fa5f1c1-3635-408d-b0f2-e3aa63ecb76d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
 <20241011173931.2050422-13-paulmck@kernel.org>
 <CAEf4BzYOdvO_PY-QZySa1qtWqZ_+1zySrw+0Qo1cc9HL5=L4aA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYOdvO_PY-QZySa1qtWqZ_+1zySrw+0Qo1cc9HL5=L4aA@mail.gmail.com>

On Fri, Oct 11, 2024 at 10:57:13AM -0700, Andrii Nakryiko wrote:
> On Fri, Oct 11, 2024 at 10:39 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Where RCU is watching is where it is OK to invoke rcu_read_lock().
> >
> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  include/linux/srcu.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Applied, thank you!

							Thanx, Paul

> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index 4ba96e2cfa405..bab1dae3f69e6 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -270,7 +270,8 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
> >   * synchronize_rcu_expedited(), IPIs and all.
> >   *
> >   * Note that srcu_read_lock_lite() can be invoked only from those contexts
> > - * where RCU is watching.  Otherwise, lockdep will complain.
> > + * where RCU is watching, that is, from contexts where it would be legal
> > + * to invoke rcu_read_lock().  Otherwise, lockdep will complain.
> >   */
> >  static inline int srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp)
> >  {
> > --
> > 2.40.1
> >
