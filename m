Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFDD232367;
	Mon, 13 Jan 2025 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736755490; cv=none; b=km2dNKKmZWoTRAacRMje2Te4DBkKcL9VxaturIPJxx8LbXNkanm6k3UDfTSZIXM7aJFY0uzl0G8WdYPK/AiaaQ2KKID10c9Bcu6rRE7tyh1SsV8XOB8ApR3OOLTmXpiGOGs5N+2YjDVac2YNaR6DF8nRQc6O564PdwAGQ3oqkis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736755490; c=relaxed/simple;
	bh=6UlK3UZgeWqJfHQ7Bog0WwJPt09KBV48JptnaJ8rbgE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pFPwOhVnO1FHrj2jeXZXBHlKlPGVdCWuqKS/+y5GD55fCVgW5KZ8FO4lm188+Y8im6a0+XONQKqzz8PhNFssW2YoMcsWXRv//W/5f59u1mAPXBlJuVZ6F2BSrUQPP+EATDJlKxOKejEIY2lFjLCnehPnK88FgtzLKTilnMVBNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id D43FC92009C; Mon, 13 Jan 2025 09:04:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id CCF9192009B;
	Mon, 13 Jan 2025 08:04:45 +0000 (GMT)
Date: Mon, 13 Jan 2025 08:04:45 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Magnus Lindholm <linmag7@gmail.com>
cc: "Paul E. McKenney" <paulmck@kernel.org>, Michael Cree <mcree@orcon.net.nz>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
In-Reply-To: <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2501130759230.18889@angie.orcam.me.uk>
References: <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com> <CA+=Fv5RaqHL6MJjvhF-mn3CVY10e=2QqFBSVO6YXLUJ7WV9zGQ@mail.gmail.com> <CA+=Fv5RP=NoWo4VeTX7hx103=jP2d-NC-jFo+ePXLBRubCxc_w@mail.gmail.com> <ef49a479-2000-42ee-9b10-9f3b6a68ec35@paulmck-laptop>
 <CA+=Fv5REK+xbA49zD3aYBgG2J1Xw1FWP02qjyyOTrwbzMRXu3w@mail.gmail.com> <be4fe590-b41c-4033-91c1-94f10c4f3d40@paulmck-laptop> <CA+=Fv5Tk-vbAK72ZOK-bPwvnx9w_1ATH=S9t-LW8gBEgQPYa3A@mail.gmail.com> <b3cd5af3-4b8f-43bd-b3f3-c9f4644c95d4@paulmck-laptop>
 <alpine.DEB.2.21.2412192347450.20821@angie.orcam.me.uk> <CA+=Fv5TJhDrrxG82=MNPFEFFwKD4NDYyB1u32ZvnGv6Ma0h_Nw@mail.gmail.com> <alpine.DEB.2.21.2412271452100.20821@angie.orcam.me.uk> <CA+=Fv5SW-N+5KzsnVdHvy406-p+g7giUbt626xwDduy6xjaPkw@mail.gmail.com>
 <CA+=Fv5TtOQkDMPnuPrPGcB0VGhUHUDqe5=Z+ovd5x5rBJ-Hsjw@mail.gmail.com> <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk> <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 13 Jan 2025, Magnus Lindholm wrote:

> >  Can you please retrieve the value of SP in `smp_call_function_single'?
> > Just something such as:
> >
> >         printk("SP: %016lx\n", __builtin_frame_address(0));
> 
> I will check!

 Always welcome, but please also see my other follow-up.

> Also wondering if this may be relevant?
> 
>  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=16660

 The fix may have uncovered the stack pointer alignment breakage with the 
Alpha/Linux port.

  Maciej
