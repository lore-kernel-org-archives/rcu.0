Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7404C2F2;
	Thu, 23 Jan 2025 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657407; cv=none; b=luy8X2Tzmd2EBlCyCEO67cHp8CMfFwwhYC+EruozTkwWIWnyFynTQGt2wtM+VXPF8u3maW39zyDdgHjEnbm7ew8jEokt+NvS4KhfM+he74CsnZPu+Hwb/9qCxst2lN24GevDQospsdH6E9/jjRq2JdXjYiVScONJFiJmNnrZDHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657407; c=relaxed/simple;
	bh=1znrUAPCV5YyaeINzTxe/kxr0Oqa8tJbKbUanbWKDZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNOylnnRETd+KwX6TP+c6ZLbmWqPgMmhUIewZ/s/AdKju5XM9ZZZgnuVFZNbGvwAW2BRzXYi2P5IA7+z+bexuAJz8JggI+mQOVB+1VO2jAG02cCoiKcztdc361o4wHJsNKTNFDHgkQhNT8D4qiofFQRhpbYWMnqh2DYqn2ngJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=t+q/0eYI; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="t+q/0eYI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ba6G3GsKTzm+URrk7En9xuZ8K9p3rVyn90iUUZkXcAg=; b=t+q/0eYITzCeuCMEmJqkXyl6yu
	76VbUQIWfC5KX+F47b9zRRCIRJeKOUhuDs1kck6JtFFCpSr5mHyfcC5zbknp6ykX/iUhqBer5583N
	9Ez9KdjVGSCkVJXgAhageILi3tJFJgCQfp+rk2Q6awtpjuDUuGHuVdAxWFd0+i9qxo1X4p3yUiBkh
	jgcslc7lzQTXaktmHngOIYJgUuTjFJkOFBDTbieD1rjXJ72iaApyuoCHYPyqQr3s8lwWEPVoWdGq6
	vFJatN1Y5QsbabGfw3y+IWaka771t7ZUt4Wgw24R7fqYF+r/RIZCk82fp1CStsVgyFm7N9kc21gtY
	80sK+bRA==;
Received: from minute.unseen.parts ([139.162.151.61]:33572 helo=minute)
	by minute.unseen.parts with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1tb23t-0005RS-1n;
	Thu, 23 Jan 2025 19:36:17 +0100
Date: Thu, 23 Jan 2025 19:36:14 +0100
From: Ivan Kokshaysky <ink@unseen.parts>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Magnus Lindholm <linmag7@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Michael Cree <mcree@orcon.net.nz>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <Z5KMHoA7GlHJyUU_@minute>
References: <CA+=Fv5TJhDrrxG82=MNPFEFFwKD4NDYyB1u32ZvnGv6Ma0h_Nw@mail.gmail.com>
 <alpine.DEB.2.21.2412271452100.20821@angie.orcam.me.uk>
 <CA+=Fv5SW-N+5KzsnVdHvy406-p+g7giUbt626xwDduy6xjaPkw@mail.gmail.com>
 <CA+=Fv5TtOQkDMPnuPrPGcB0VGhUHUDqe5=Z+ovd5x5rBJ-Hsjw@mail.gmail.com>
 <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk>
 <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com>
 <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com>
 <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com>
 <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk>
 <Z4-jgMJgbVriLaCr@minute>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4-jgMJgbVriLaCr@minute>

On Tue, Jan 21, 2025 at 02:39:12PM +0100, Ivan Kokshaysky wrote:
> Indeed, SP_OFF in entry.S is the main suspect at the moment.

In fact, it's the odd number of longs (29) in struct pt_regs that makes
the stack misaligned by 8 bytes. The patch below works for me - no more
oopses in rcu-torture test.

Unless I'm missing something, this change shouldn't have any ill effects.

Ivan.

diff --git a/arch/alpha/include/uapi/asm/ptrace.h b/arch/alpha/include/uapi/asm/ptrace.h
index 5ca45934fcbb..d2e8e69a18f1 100644
--- a/arch/alpha/include/uapi/asm/ptrace.h
+++ b/arch/alpha/include/uapi/asm/ptrace.h
@@ -49,7 +49,7 @@ struct pt_regs {
 	unsigned long r16;
 	unsigned long r17;
 	unsigned long r18;
-};
+} __attribute__((aligned(16)));	/* GCC expects 16-byte stack alignment */
 
 /*
  * This is the extended stack used by signal handlers and the context
