Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C7818BBAE;
	Thu,  2 Jan 2025 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844105; cv=none; b=SV9OnpFkLyDcOPxOLRK6Wuz3k7ZGQKHRpKjPwOilrtkbz4S9K/f6ugwylDqw5cwkLIrsnMYSaSatsadeI9UmUVFZDxQriEtzvRN+hytc016u1/8ZFeWycv60hY+ni4BDYAEtgsi7h+pQfUeTq8xl4IcZuzOxPqeHTDgEh4KJnBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844105; c=relaxed/simple;
	bh=83DocZnzzQNmLwcRm5BQ58v4a9z4jIiag/1PvvzaPEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maeAil7xq1OtmF99K5LrKroyo1PLEbc1rHIhv+FrCgYVGVJg/7QkrBaRurj6ztzG4NtKiZ6UMKTcQ3LCIaWIhQI0X9weYx82GqFSS0nd7Ek2Z0+Gahz+6X9QLtio0sf7zxrAaJatSZ0x/+388rtgTt9BqINYgLKC6/fpRFCs8Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+IfkERR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+IfkERR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEFCC4CED0;
	Thu,  2 Jan 2025 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735844104;
	bh=83DocZnzzQNmLwcRm5BQ58v4a9z4jIiag/1PvvzaPEw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=N+IfkERRI2s79rLkneNnhc4avdWkawy83WHf3EIlRzIE2BFXwU9QA+zOzINWft7Mo
	 QGstsabqN/7II/qLATvwz2OoEW3PMWMoGU/NJS2vbsqRK7LspM8qLm2sFa23bNwQlk
	 jooEgrJClxijZ3RgJJon9BZE0viFwiz083PWoHiQ/shuPGcMeQJGPUvGrnxNcRFP2z
	 TECFp7LuIN58hr5ixhQbruiYh/wReigshh2uPWQjAC2Uk8zVN87qWch3ncT7XYJWcN
	 yLw41xOyaI+Ta+j398MKpUEOtczHVAkzqgbEUUgqXfYZ8oc2R+uA/7igggr/FCp6Md
	 40RrgFvC6yPmQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1A93CCE09CC; Thu,  2 Jan 2025 10:55:04 -0800 (PST)
Date: Thu, 2 Jan 2025 10:55:04 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Z qiang <qiang.zhang1211@gmail.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, rcu@vger.kernel.org
Subject: Re: [paulmckrcu:dev.2024.12.24a] [srcu] 9216c28c6a:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <c8c4c6d6-ad52-4cd2-ba1f-c442da4432af@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202412311203.ca7bddba-lkp@intel.com>
 <CALm+0cWOxUm_hrNe4UP4Z-vyr4RCOw+dc=kCBTgsyjHFHiHDsg@mail.gmail.com>
 <949f6251-d411-45ef-9f85-d5d069b90b0e@paulmck-laptop>
 <Z3Ym/DDtGOPamGjZ@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3Ym/DDtGOPamGjZ@xsang-OptiPlex-9020>

On Thu, Jan 02, 2025 at 01:41:16PM +0800, Oliver Sang wrote:
> hi, Zqiang, hi, Paul,
> 
> On Tue, Dec 31, 2024 at 08:19:44AM -0800, Paul E. McKenney wrote:
> > On Tue, Dec 31, 2024 at 03:16:25PM +0800, Z qiang wrote:
> 
> [...]
> 
> > > >
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-lkp/202412311203.ca7bddba-lkp@intel.com
> > > >
> > > 
> > > Please try the following modifications:
> 
> yes, the following modifications fix the issues we found for 9216c28c6a. thanks!
> 
> Tested-by: kernel test robot <oliver.sang@intel.com>

Thank you, and I will apply this during my next rebase.

Zqiang, unless you tell me otherwise, I will add your Co-developed-by
and Signed-off-by.

Either way, Happy Square New Year!

							Thanx, Paul

> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index e85db7d5b364..7c7304dee645 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -1999,6 +1999,7 @@ static int srcu_module_coming(struct module *mod)
> > >         for (i = 0; i < mod->num_srcu_structs; i++) {
> > >                 ssp = *(sspp++);
> > >                 ssp->sda = alloc_percpu(struct srcu_data);
> > > +               ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
> > 
> > This does look quite promising, so thank you for digging into this!!!
> > 
> > Looking forward to seeing if it fixes the problem.  ;-)
> > 
> > 							Thanx, Paul
> > 
> > >                 if (WARN_ON_ONCE(!ssp->sda))
> > >                         return -ENOMEM;
> > >         }
> > > 
> > > 
> > > 
> > > Thanks
> > > Zqiang
