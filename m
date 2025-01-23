Received: from smtp-3.orcon.net.nz (smtp-3.orcon.net.nz [60.234.4.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F4717C;
	Fri, 24 Jan 2025 00:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.234.4.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737677451; cv=none; b=PLgbhl2hcKCiPsgY90BHH2shnF6Li/0qCAAJXaZ3ENFfoIH4ed292KQh3rf6XPYWLhECmqnlpEpQDAVRs35KMd5KfvUOQ8t6Lbh88VymFEWG6tX3IVXJJsWodwjX9vs8oXMCcOopGt5r9a3kwrPSfwOFE8aT3TFny9YGZB3XOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737677451; c=relaxed/simple;
	bh=zAXKuySCb4Lk9JRrVg91NzYalHoKgPhTkHdPY4qIjK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4sm324v8i6CKfrbk2fJuFCV6kg0lQ2jziV7bKl4Du2q/bg+HdVU75R7k+1mQpvlWRVYYr/gmgPMGeMg8GPDNRnLGxOeZo01ZmEFnmwTUIuF7s7WoVP0k36wZ7grbq4bcTf1Wbmxr+VpwaQqJ20n6eeUnP2qeRBAVajgLcm9tSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orcon.net.nz; spf=pass smtp.mailfrom=orcon.net.nz; arc=none smtp.client-ip=60.234.4.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orcon.net.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orcon.net.nz
Received: from [121.99.247.178] (port=39309 helo=creeky)
	by smtp-3.orcon.net.nz with esmtpa (Exim 4.90_1)
	(envelope-from <mcree@orcon.net.nz>)
	id 1tb6yY-0000V3-LZ; Fri, 24 Jan 2025 12:51:06 +1300
Date: Fri, 24 Jan 2025 12:51:02 +1300
From: Michael Cree <mcree@orcon.net.nz>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Ivan Kokshaysky <ink@unseen.parts>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <Z5LV5rfM_XO4gx0U@creeky>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
	Magnus Lindholm <linmag7@gmail.com>,
	Ivan Kokshaysky <ink@unseen.parts>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	rcu@vger.kernel.org, linux-alpha@vger.kernel.org
References: <CA+=Fv5SW-N+5KzsnVdHvy406-p+g7giUbt626xwDduy6xjaPkw@mail.gmail.com>
 <CA+=Fv5TtOQkDMPnuPrPGcB0VGhUHUDqe5=Z+ovd5x5rBJ-Hsjw@mail.gmail.com>
 <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk>
 <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com>
 <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com>
 <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com>
 <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk>
 <Z4-jgMJgbVriLaCr@minute>
 <Z5KMHoA7GlHJyUU_@minute>
 <CA+=Fv5QkJi19DRhUu23hmOcps8Wj2_a90TLfBrXN47ceJ2we+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+=Fv5QkJi19DRhUu23hmOcps8Wj2_a90TLfBrXN47ceJ2we+w@mail.gmail.com>
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --

On Fri, Jan 24, 2025 at 12:00:41AM +0100, Magnus Lindholm wrote:
> >
> > In fact, it's the odd number of longs (29) in struct pt_regs that makes
> > the stack misaligned by 8 bytes. The patch below works for me - no more
> > oopses in rcu-torture test.
> >
> > Unless I'm missing something, this change shouldn't have any ill effects.
> >
> > Ivan.
> 
> 
> Very nice! This seems to do the trick! I've been chasing this bug for
> quite some time now and with this patch it seems to work! applied to
> my systems and no problems so far. I was looking at a mail-thread
> working with 16-bit stack alignment on x86_64 and there the solution
> seems a lot more complex than a one-liner.

Also installed kernel with the patch on an ES45 system and it has
booted without any OOPses and is running nicely!

Cheers
Michael.
