Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE7825A64C;
	Sun, 26 Jan 2025 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900052; cv=none; b=kYNo4EYD3NbpKOJ7EYz77b8VDMxLKh8h+H1gOXBRSo6K7IjRgfRebS/kf76+pXCLMxPbkSYAJMwaQGxu3Yy59m0Upth8aawvjwAh1I1HxHo4HrBNXyRJW8cJjZKYQvLCnH8kiDar+06ivsF0dVQlm+U6xHOmB71x/ohM2I4tpeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900052; c=relaxed/simple;
	bh=jl5iwPrDVPIlm0Bf7MPaw6Ahqk/8YNdgvjWICISZUqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtOR5X5KobCJS34iJDFGbaNlZiuCL5NFfBBpS7lG6m2tCZV8l1svE9eyECPilNluKSTjF9u/KTbdQmt4Nzq/NMQoqX4jFgtaBc3ilAH+iAr24eEy+pMgZp6iJXYdb3i0PZlapGERBvloKbVZ1ABRrIrZgCGJt1yY6RzKaZnU/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=XSeeBzgX; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="XSeeBzgX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tUxaWyy7BwLBxJKdYAsYMsFfgwGGC2RsPkyNogf+gVI=; b=XSeeBzgXcPOVCSYoPuGNsuOuT3
	Ckmh0iXQCx926mXiAvRoD4WRK/kHHvk6wj6iiDY7MPf0z2hGiTxoZolvVZoteovYZchhawI8f7jHw
	IvfeX9YQMZzDeBfxT0BREbe56kxmrbLTWBASJjDvakaswx+Z0HYthfV0pxgLTqcjHXXLUGuHRedk8
	M38gcxuaIJcsE2rkt9SwcE5c9JM05XYwB7xfTz+4bZWtzK5MfuFyGHjQqyNO3m0K3GAohZk8IXhP+
	ET7k7UrdkHM5rjf6AccdpzRYp/6gGZIyYrZrQVrjQZl34TRCZRJoHpIEEotv0dEooHWNjKKUMfKeS
	wpp16ZsQ==;
Received: from minute.unseen.parts ([139.162.151.61]:52772 helo=minute)
	by minute.unseen.parts with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1tc3Be-0001ZX-2o;
	Sun, 26 Jan 2025 15:00:30 +0100
Date: Sun, 26 Jan 2025 15:00:29 +0100
From: Ivan Kokshaysky <ink@unseen.parts>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Magnus Lindholm <linmag7@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Michael Cree <mcree@orcon.net.nz>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <Z5Y__QtiySs8UeTK@minute>
References: <Z5NxuIFsMUvqWUtC@minute>
 <CA+=Fv5QmSkP4Ysp1zHNmUPftXYbSquTCsO_o3Rcgi2T5RcPj5A@mail.gmail.com>
 <Z5UAFAD6xCSpKJYw@minute>
 <alpine.DEB.2.21.2501251543460.27203@angie.orcam.me.uk>
 <Z5Uit9F7xF0ZlMk2@minute>
 <alpine.DEB.2.21.2501251806280.27203@angie.orcam.me.uk>
 <alpine.DEB.2.21.2501251839440.27203@angie.orcam.me.uk>
 <Z5U__sztq2P2UKWk@minute>
 <alpine.DEB.2.21.2501252129060.27203@angie.orcam.me.uk>
 <Z5Vtl8PzOY66bp9K@minute>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5Vtl8PzOY66bp9K@minute>

On Sun, Jan 26, 2025 at 12:02:47AM +0100, Ivan Kokshaysky wrote:
> >  Erm, that's a good starting point but offsets for the individual register 
> > slots need to be updated as well for `do_page_fault' and `do_entUnaUser' 
> > to get at the correct ones for those that are at negative indices from the 
> > `regs' pointer supplied, i.e. $9 at 8($sp), $10 at 16($sp), etc., and with 
> > 0($sp) now unoccupied.  Sorry to get it through unclear after all.
> 
> Ah, thanks a lot! Should've noticed that myself, but I've booted with the
> last patch and it didn't crash on me, so I thought the deed is done...
> 
> I'll fix that tomorrow.

Fixed in C, I guess it's easier to review.

Ivan.

diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index a9a38c80c4a7..035086e19d64 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -649,7 +649,7 @@ s_reg_to_mem (unsigned long s_reg)
 static int unauser_reg_offsets[32] = {
 	R(r0), R(r1), R(r2), R(r3), R(r4), R(r5), R(r6), R(r7), R(r8),
 	/* r9 ... r15 are stored in front of regs.  */
-	-56, -48, -40, -32, -24, -16, -8,
+	-64, -56, -48, -40, -32, -24, -16,
 	R(r16), R(r17), R(r18),
 	R(r19), R(r20), R(r21), R(r22), R(r23), R(r24), R(r25), R(r26),
 	R(r27), R(r28), R(gp),
diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 8c9850437e67..a9816bbc9f34 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -78,8 +78,8 @@ __load_new_mm_context(struct mm_struct *next_mm)
 
 /* Macro for exception fixup code to access integer registers.  */
 #define dpf_reg(r)							\
-	(((unsigned long *)regs)[(r) <= 8 ? (r) : (r) <= 15 ? (r)-16 :	\
-				 (r) <= 18 ? (r)+10 : (r)-10])
+	(((unsigned long *)regs)[(r) <= 8 ? (r) : (r) <= 15 ? (r)-17 :	\
+				 (r) <= 18 ? (r)+11 : (r)-10])
 
 asmlinkage void
 do_page_fault(unsigned long address, unsigned long mmcsr,
