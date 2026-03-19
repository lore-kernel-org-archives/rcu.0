Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A783E1D17
	for <rcu@vger.kernel.org>; Thu, 19 Mar 2026 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937684; cv=none; b=HcdxZKfjEAERey1BMp3SNzaqbc++OsznkoSscb5BOkLt02b84P6NGDRzVUxcdFo061ih/sGHr6Cbia4PiG3uXd8qXq46e03pQJxEo1PMK63rTSBTLWBjvREfFMTgRYUjfrGzO/Ed7wQeP+sbs6Cbx/go3ExEaXkFnBBOdE94boQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937684; c=relaxed/simple;
	bh=kyeeIbNr9oOvl2+NwrEyqTeykKt59HyxKD3wxTI3eRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QavsLlMgusvH1VWjuGM9hAAOletyqSJg25Zf+cA+gyu+F42+uZ7oPM0Udw7eFqc/BNHf5n7/olrDW0PTHOUAF0bowF6sxLAuhm0TxhSjx7ZvmC9kU2rsoKva50w6xp0aB/IcWLZJwSpVIK2ASZH96mvvVp3gi6zmeN/C29ROXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpeGWIWp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpeGWIWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C206EC2BCAF;
	Thu, 19 Mar 2026 16:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773937683;
	bh=kyeeIbNr9oOvl2+NwrEyqTeykKt59HyxKD3wxTI3eRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hpeGWIWpDpOSysFNVys1AmXYLld2ilN6sSIueioqSNgtuTJFNHV4uibkkTAwnWNSy
	 oa8GAZMEHs4vdUGa6VrzP90hAWIdP74XxSxK9Rz1e1W3PXsAlMHGxyX6pPsnRnOqLq
	 73Sq5LG0QbyuLE8ZNvEMwxqqu3bvwJORRcvIP3ktHRox7/7TLQEuT28kG906i2Nmyw
	 DzuxDMB/lx+Zic084pXBLgO45ViL4zmFm48zS7vZossnED88M61z8gZXCzhCFsHiHu
	 2ORIpers5OB1gp200MS1SuybR4LJgDI7+d8LRZATPKXt0cRbOLfLU8k24GQPyZYfF8
	 e0kPfGcESSZQg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4A9C0F40079;
	Thu, 19 Mar 2026 12:28:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 12:28:01 -0400
X-ME-Sender: <xms:ESS8aZiPms85m3JjydGMFpC3Vh7zdLnIyUHjPPhPOqHnz7Z6b7PYKw>
    <xme:ESS8aWPEYzSD-68nNt7g2BOYmWXPaPRqtZ-CvGEfd_LrsjSwpJ3wKOFrdF4dkjsgZ
    6XIElfV9F4tvldNyWrIEr7eGlZoIWBTgF-4uQ-u8lUaberfF_VD1g>
X-ME-Received: <xmr:ESS8aUpSql9Keir74v5EhwAVrjD_zjh-OuKVFiJTA1yaW1l8rc6p6OrDcmQJEq6mIABv5UkAF-2B_OATPpGdPENKrIN42H8Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnsehkvghrnhgvlhdr
    ohhrgheqnecuggftrfgrthhtvghrnhepkefghffhueehlefhkeetueffjeevteejfeffte
    ettdetgeefffdtudetuddugfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlih
    hthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrhhnvghl
    rdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepuddupdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhigidruggv
    pdhrtghpthhtohepjhhovghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphhtth
    hopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhi
    tgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhiihhtrhdutdesgh
    hmrghilhdrtghomhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgt
    phhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehrtg
    husehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvmhigohhrsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:ESS8aY4LJCw6HwyXe-5Qrlq544I7t2H7yIr1oZuhSCekzow36RZrJg>
    <xmx:ESS8aSjD8O_9qyUDGIv2P34zW6vpPt706O0ewLFHqZ4dW169zIRgag>
    <xmx:ESS8ae7anQhd_EzSeMq8LQiW9XXtA-68xW7U3DxI6ZWWCoPm-D2Krg>
    <xmx:ESS8aXEmG4XFguNF2VCtQR9OHp3hYV6KaBZA2_-qFTriHtXbw7m3hA>
    <xmx:ESS8aQJPdjwbM4y5_sTP3AuXjBwrYl0Pn7GbP6GMXM6iuBsGA3X0KuQ1>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 12:28:00 -0400 (EDT)
Date: Thu, 19 Mar 2026 09:27:59 -0700
From: Boqun Feng <boqun@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, paulmck@kernel.org,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <abwkD0mOdAbD9ENJ@tardis.local>
References: <abrJ9C637V6keRvd@tardis.local>
 <214fb140-041d-4fd1-8694-658547209b84@paulmck-laptop>
 <3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com>
 <absesPf-10awctq9@tardis.local>
 <absfZGD3en9TUA1U@tardis.local>
 <absj6rZbyLZY8PPz@tardis.local>
 <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
 <abs026TUV9oAg_Xy@tardis.local>
 <abtMhd_LVp3uL_pA@tardis.local>
 <20260319090315.Ec_eXAg4@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319090315.Ec_eXAg4@linutronix.de>

On Thu, Mar 19, 2026 at 10:03:15AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-03-18 18:08:21 [-0700], Boqun Feng wrote:
> > @@ -1979,6 +1986,17 @@ static void process_srcu(struct work_struct *work)
> >  	srcu_reschedule(ssp, curdelay);
> >  }
> >  
> > +static void srcu_irq_work(struct irq_work *work)
> > +{
> > +	struct srcu_struct *ssp;
> > +	struct srcu_usage *sup;
> > +
> > +	sup = container_of(work, struct srcu_usage, irq_work);
> > +	ssp = sup->srcu_ssp;
> > +
> > +	queue_delayed_work(rcu_gp_wq, &sup->work, !!srcu_get_delay(ssp));
> > +}
> > +
> 
> Please just use the queue_delayed_work() with a delay >0.
> 

That doesn't work since queue_delayed_work() with a positive delay will
still acquire timer base lock, and we can have BPF instrument with timer
base lock held i.e. calling call_srcu() with timer base lock.

irq_work on the other hand doesn't use any locking.

Regards,
Boqun

> Sebastian
