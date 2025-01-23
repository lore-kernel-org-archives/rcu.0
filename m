Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADFA1BD027;
	Thu, 23 Jan 2025 23:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737676629; cv=none; b=qaGxDI/d2De/N8Vt71pYphZi22z+rs6ie5KLoFl3KbHOT0u+V0vcsCo0za5/Qh4BNCgz1He476Emi+JzgBAfFrfV+Hv2wec61GloT7hELm8AXheuPZwONsetBs8ko5cKPG7/CRPelb3nlTHfxCv1wHUA2HakZbq6JXdh8BLhYng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737676629; c=relaxed/simple;
	bh=2PcI10Qz6G/W+oWbqtu+HzQgWAuPxMAOZ2YmJMvJZY0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aY/fttxz/dzJQ+U3isMKFl6mqp0rItuFz7WXh0xzsmZzS0I0M6azfetvM/27tJb+3Z7vyVIaBkLLOjrunOGEElMQRawyuy5UG6IJp5CtB76pW6QIuZHGe59nXAzksnOSPmLcy97ZbYAeAM9KTSDID9zIlixNK+T6/kVmGS1Yk1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id DDB9892009C; Fri, 24 Jan 2025 00:57:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id D780F92009B;
	Thu, 23 Jan 2025 23:57:03 +0000 (GMT)
Date: Thu, 23 Jan 2025 23:57:03 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Ivan Kokshaysky <ink@unseen.parts>
cc: Magnus Lindholm <linmag7@gmail.com>, 
    "Paul E. McKenney" <paulmck@kernel.org>, Michael Cree <mcree@orcon.net.nz>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
In-Reply-To: <Z5KMHoA7GlHJyUU_@minute>
Message-ID: <alpine.DEB.2.21.2501232306270.27203@angie.orcam.me.uk>
References: <CA+=Fv5TJhDrrxG82=MNPFEFFwKD4NDYyB1u32ZvnGv6Ma0h_Nw@mail.gmail.com> <alpine.DEB.2.21.2412271452100.20821@angie.orcam.me.uk> <CA+=Fv5SW-N+5KzsnVdHvy406-p+g7giUbt626xwDduy6xjaPkw@mail.gmail.com> <CA+=Fv5TtOQkDMPnuPrPGcB0VGhUHUDqe5=Z+ovd5x5rBJ-Hsjw@mail.gmail.com>
 <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk> <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com> <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com> <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com>
 <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk> <Z4-jgMJgbVriLaCr@minute> <Z5KMHoA7GlHJyUU_@minute>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 23 Jan 2025, Ivan Kokshaysky wrote:

> > Indeed, SP_OFF in entry.S is the main suspect at the moment.
> 
> In fact, it's the odd number of longs (29) in struct pt_regs that makes
> the stack misaligned by 8 bytes. The patch below works for me - no more
> oopses in rcu-torture test.
> 
> Unless I'm missing something, this change shouldn't have any ill effects.

 Umm, this is a part of UAPI, and the change in alignment changes the ABI 
(think padding where `struct pt_regs' has been embedded into another 
structure), so AFAICT it is a no-no.

 But the only place I could quickly find this should matter for is this:

	/* ... and find our stack ... */
	lda	$30,0x4000 - SIZEOF_PT_REGS($8)

which should be straightforward to fix:

	lda	$30,0x4000 - ((SIZEOF_PT_REGS + 15) & ~15)($8)

or suchlike.  Have I missed anything?

  Maciej
