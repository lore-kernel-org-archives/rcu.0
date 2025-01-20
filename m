Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83470154433;
	Mon, 20 Jan 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737379174; cv=none; b=PIZHKYKBK3D3s9dMsYEkcVRtLR5CANwfcxOaH+h0Ov2LBRY94VZtSIv6hbwjDFD0MGZbGlrAe/j+rw4n5IHRchpPx1IwUo+FFqhzekMAF7uhYJHSaLgr0VgmB9oePp1EtvU7DlpGxB2J61XQzORbCilrrcs9drK7TqY9Bq8QpDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737379174; c=relaxed/simple;
	bh=dyRY69dS8F1j1dPF8Y9Bfw1aFflH3rXjMbUtS7fVXew=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OIJ4RLdbxYKG+5Flsi0Wg55JA7pexqpTLrNxoNaP/3mq69LK/XtD2mq53lFdm0rn0emib2u24sd9pIOmctbgvpdAMPYwQgZnPh2Dp6ClyfYL/agWdsOHlZuSxxhcv6VG1JawQ58KxeGFYrzLe5paYYwS4ejllzViw1x8LvQkWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id AFC5692009C; Mon, 20 Jan 2025 14:19:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id A1BC892009B;
	Mon, 20 Jan 2025 13:19:23 +0000 (GMT)
Date: Mon, 20 Jan 2025 13:19:23 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Magnus Lindholm <linmag7@gmail.com>
cc: "Paul E. McKenney" <paulmck@kernel.org>, Michael Cree <mcree@orcon.net.nz>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
In-Reply-To: <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk>
References: <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com> <ef49a479-2000-42ee-9b10-9f3b6a68ec35@paulmck-laptop> <CA+=Fv5REK+xbA49zD3aYBgG2J1Xw1FWP02qjyyOTrwbzMRXu3w@mail.gmail.com> <be4fe590-b41c-4033-91c1-94f10c4f3d40@paulmck-laptop>
 <CA+=Fv5Tk-vbAK72ZOK-bPwvnx9w_1ATH=S9t-LW8gBEgQPYa3A@mail.gmail.com> <b3cd5af3-4b8f-43bd-b3f3-c9f4644c95d4@paulmck-laptop> <alpine.DEB.2.21.2412192347450.20821@angie.orcam.me.uk> <CA+=Fv5TJhDrrxG82=MNPFEFFwKD4NDYyB1u32ZvnGv6Ma0h_Nw@mail.gmail.com>
 <alpine.DEB.2.21.2412271452100.20821@angie.orcam.me.uk> <CA+=Fv5SW-N+5KzsnVdHvy406-p+g7giUbt626xwDduy6xjaPkw@mail.gmail.com> <CA+=Fv5TtOQkDMPnuPrPGcB0VGhUHUDqe5=Z+ovd5x5rBJ-Hsjw@mail.gmail.com> <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk>
 <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com> <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com> <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 Jan 2025, Magnus Lindholm wrote:

> 8-byte aligned. A quick-fix/workaround for this might be to avoid
> using the __attribute__((__aligned__(x))) directive on
> variables/structs declared on the stack in the kernel code (at least
> for alpha), but to really get to the bottom of this, the kernel needs
> to be fixed so that the kernel stack is in fact always 16-byte aligned
> on alpha. This means that this bug is not really related to rcu or smp
> but rather a mismatch between gcc and linux-alpha regarding psABI
> compliance.

 Correct.  Unless someone beats me to it, I'll work on a fix, but I'm busy
with other stuff right now, so it may take a few weeks.

  Maciej
