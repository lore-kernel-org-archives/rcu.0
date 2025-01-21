Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9051E4113;
	Tue, 21 Jan 2025 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737466785; cv=none; b=fjuWHBsmcsYDUUtJQWn5PTOcxT3OB8TsshkjzWDz47zM4hXqxwmWZmAS9n1ljJILEI1pUKmh8v95lRyFMrGFHssTq1+X7WiT+K6ilBfudVxa/j4Ym/rSLN548N3N6CKGqGu45StxSUHA24FkemH+gM+1JbWbmxW3dZ7nix0E6TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737466785; c=relaxed/simple;
	bh=P/rdejKtkGF7phqCOM1uX7H/szH93gaF6eitNY7+Nl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdHbUkMshGf9ZvCykK+4NkUef/ZFxtuh4IE6dOL+m/cLWKb2QNMOnAFhAAL5G9NiGah2UpkWjpB2DTzOhWZuHBZTNNcQWQy66WlfKA4NrdLzHrYZZnYpX8Vxy7hl09QangKYtL6pOGoTZzQjZ0TXAXwJjzLlNQBMyQtZpJyINEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=PL7Pk3OK; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="PL7Pk3OK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yazK1+ptatThFrK4cT6AJGjYa0I7KYWYmu0jGBS9ews=; b=PL7Pk3OK72VyUslTKuVwbvRL4v
	1FB7WXS8NCFgOADlGDdPvSCF1M7960sX6m2/HkUHQS70KS54dKYQVj3DrdfCX+PCB4uBB8BCtHifO
	aBcydd4sGwDjtX78CC+7FFv9Bir5aruxG2wdn5fHE2GPWKy5K138bOoqIEzJ9BV+9mp4jqOB1od/a
	f4dnxqF1dNUrrv8ug5Ir2P0QFDYfv1lHB0AgUcH30i6zC9h6CR2Srs9q2caG3g2u2nYuIlC8/atNQ
	OqaquNQie/M6UFjNIkdbC6hmphhYcH+VCp1T68sfuzBJoqWxZTjAddwx+yskdGdkdsee5+SY8B2yF
	gjQCtiaA==;
Received: from minute.unseen.parts ([139.162.151.61]:53062 helo=minute)
	by minute.unseen.parts with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1taETK-00027I-1u;
	Tue, 21 Jan 2025 14:39:14 +0100
Date: Tue, 21 Jan 2025 14:39:12 +0100
From: Ivan Kokshaysky <ink@unseen.parts>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Magnus Lindholm <linmag7@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Michael Cree <mcree@orcon.net.nz>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <Z4-jgMJgbVriLaCr@minute>
References: <alpine.DEB.2.21.2412192347450.20821@angie.orcam.me.uk>
 <CA+=Fv5TJhDrrxG82=MNPFEFFwKD4NDYyB1u32ZvnGv6Ma0h_Nw@mail.gmail.com>
 <alpine.DEB.2.21.2412271452100.20821@angie.orcam.me.uk>
 <CA+=Fv5SW-N+5KzsnVdHvy406-p+g7giUbt626xwDduy6xjaPkw@mail.gmail.com>
 <CA+=Fv5TtOQkDMPnuPrPGcB0VGhUHUDqe5=Z+ovd5x5rBJ-Hsjw@mail.gmail.com>
 <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk>
 <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com>
 <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com>
 <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com>
 <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk>

On Mon, Jan 20, 2025 at 01:19:23PM +0000, Maciej W. Rozycki wrote:
> On Mon, 20 Jan 2025, Magnus Lindholm wrote:
> 
> > 8-byte aligned. A quick-fix/workaround for this might be to avoid
> > using the __attribute__((__aligned__(x))) directive on
> > variables/structs declared on the stack in the kernel code (at least
> > for alpha), but to really get to the bottom of this, the kernel needs
> > to be fixed so that the kernel stack is in fact always 16-byte aligned
> > on alpha. This means that this bug is not really related to rcu or smp
> > but rather a mismatch between gcc and linux-alpha regarding psABI
> > compliance.
> 
>  Correct.  Unless someone beats me to it, I'll work on a fix, but I'm busy
> with other stuff right now, so it may take a few weeks.

I'll look into that (I owe you for helping me with the binutils patch :)

Indeed, SP_OFF in entry.S is the main suspect at the moment.

Ivan.
