Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CE718D643;
	Sat, 25 Jan 2025 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737846186; cv=none; b=GsQw106f5wp3CGOHEpvBp1p07qVXz4Gvohx+XqkYIquZRxyPqxP5inf2GVgefdWZjr32IlxGdgBXMp92qBu8MRLbanYwxtu9MEV62a5Km/FHHsBb3eBzBYNXju37Q2CY8JaUV/MnlKixdCJs/HQG8Xl4zJIkDlC+cyngTrpqoek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737846186; c=relaxed/simple;
	bh=xf5xjMP7V7fGqpREa+1F1TtZZcFOSlX3aQz3cN1lMUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDh2j657KhNZgyyVp8E/mmI+uFZyvLWqKRXsaguV0R+6hNfZnXvKdNkmkz5wsOj3fXDB6KF0RO8DlPsqStC4Bw5vAmOZWRbw+rS/G+oXjU/SdZZwB+C/WSJBgEgC5WxTr/J2QbgZFz6xdjUsos1Ad+X+KPo9CXr4ex+LpSMN5WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=uU+1+UPM; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="uU+1+UPM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1N1SyN6F5/f4Q1W0d7dOz3SvWIn4KuUpO/PkcYdUeKo=; b=uU+1+UPMFdFVPbswtk8osXr7Gh
	e1t6FTmkyOT5JO0gZw/n41TfHP0ub7kpiNQmx2p4MQhGu4ql/36wvgmkQmn5AT47M95ZyspyDcOtf
	vBdMUddKR0SNhJYWC1697g27fr801sCvSK2f8eQxubtClpwt2tEIEAz0TNSXYvN439Nr1CtwZoZ6m
	bfphY2mXvmR0prJZpXdng3L9hx2B4h4Jj7zydCWD43SHRRgm5EMyNSnSPqe1drAD1pEcfHmRHj5It
	SCfYSj9TVsQ21ZV32PdfWJ/X/yeVFIvVNZBiFyKTWRFoLRL+wlF55ObD5L3A8Sc+AEM3T0H8LLxMk
	GiGsf5Kw==;
Received: from minute.unseen.parts ([139.162.151.61]:57424 helo=minute)
	by minute.unseen.parts with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1tbpAv-0000f7-0f;
	Sun, 26 Jan 2025 00:02:49 +0100
Date: Sun, 26 Jan 2025 00:02:47 +0100
From: Ivan Kokshaysky <ink@unseen.parts>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Magnus Lindholm <linmag7@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Michael Cree <mcree@orcon.net.nz>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <Z5Vtl8PzOY66bp9K@minute>
References: <alpine.DEB.2.21.2501232306270.27203@angie.orcam.me.uk>
 <Z5NxuIFsMUvqWUtC@minute>
 <CA+=Fv5QmSkP4Ysp1zHNmUPftXYbSquTCsO_o3Rcgi2T5RcPj5A@mail.gmail.com>
 <Z5UAFAD6xCSpKJYw@minute>
 <alpine.DEB.2.21.2501251543460.27203@angie.orcam.me.uk>
 <Z5Uit9F7xF0ZlMk2@minute>
 <alpine.DEB.2.21.2501251806280.27203@angie.orcam.me.uk>
 <alpine.DEB.2.21.2501251839440.27203@angie.orcam.me.uk>
 <Z5U__sztq2P2UKWk@minute>
 <alpine.DEB.2.21.2501252129060.27203@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2501252129060.27203@angie.orcam.me.uk>

On Sat, Jan 25, 2025 at 10:06:38PM +0000, Maciej W. Rozycki wrote:
> On Sat, 25 Jan 2025, Ivan Kokshaysky wrote:
> 
> > > >  Here just bumping up the frame size and adjusting offsets in assembly 
> > > > code accordingly so as to account for the empty longword at the bottom 
> > > > of the frame should do, just as I did across my change.
> > > 
> > >  ... or, depending on how you look at it, top of the frame and FAOD in any 
> > > case the longword closest to the stack pointer will be the empty one.
> > 
> > Right. So if we agree on my variant, this addition patch is needed.
> 
>  Erm, that's a good starting point but offsets for the individual register 
> slots need to be updated as well for `do_page_fault' and `do_entUnaUser' 
> to get at the correct ones for those that are at negative indices from the 
> `regs' pointer supplied, i.e. $9 at 8($sp), $10 at 16($sp), etc., and with 
> 0($sp) now unoccupied.  Sorry to get it through unclear after all.

Ah, thanks a lot! Should've noticed that myself, but I've booted with the
last patch and it didn't crash on me, so I thought the deed is done...

I'll fix that tomorrow.

Ivan.
