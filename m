Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6B4CA4E;
	Sat, 25 Jan 2025 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737834516; cv=none; b=Vht4r92XjXGMdurPDrUTztWTfNq7SNd3LWLDwXCLKw2V/WYJ9cE6eTuhXfYH5p7KaCksMq4YYS/JhYKPlJDHejd+0X//ukENENOkndSyBsxz3NpGEYzEylnxVmUgdHfAU5rxdlN4iqrEUUCx8Ur5ArZK76+iwUeACdd9bdNM+ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737834516; c=relaxed/simple;
	bh=l68+gSUWjJIHFBBAvFu85G/zG9ghVK+dT0CsXpPOPAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL36D4PvK+r7jOdCYEbfBRMuKVkh6VfyLt4gpwjLvsREJy3VImSwh8o+6lce/lwhQdLQHjba6Rv6699Cnn4HIkYNCB4Jne9G9AQCFwg0TWq/7gX5GZB7DKeCO1RGYT5SGhZC0Gog4Xb41OhW6lpFcRDz98mhuKiEzCtuBus3iKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=C9T9W6nz; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="C9T9W6nz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3Zu/5NjCkSv8RrZtd5TzSI4LhFuIiXfnNGAQIcuw1Tk=; b=C9T9W6nzMplCxBes9gpK0RLQ9u
	ujnfb0Rs2h/HSP/9BpF6io4EhVjTGGdE4uOgHaDyV2o1Qz3Dtn6GUa4Em7puLKcZXS/kTVdp9fs6t
	UX8DwLGrqsi69zwrsKIijf1ZHEyN9X5mDnDHVTrdWvkCbIhk4pjhGxN5xbjMBPz3xY3rxZ2cQTVq6
	mHt8OeTOqH+0lZlsoMnQZKm6xaQtfL64qL9XGxSQlfN4ASwlPzOGpWu847eeJxktOtuO6J8TEb9dW
	KveHu8J9/7RCaeFFn2fzLv6ofQsdb4ZcWx0S+NvX0HqAad4NVzbHEcZtZQSI/rJInLUSj5z3GJ47b
	mC7Efg9g==;
Received: from minute.unseen.parts ([139.162.151.61]:44256 helo=minute)
	by minute.unseen.parts with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1tbm8f-0000N0-0r;
	Sat, 25 Jan 2025 20:48:17 +0100
Date: Sat, 25 Jan 2025 20:48:14 +0100
From: Ivan Kokshaysky <ink@unseen.parts>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Magnus Lindholm <linmag7@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Michael Cree <mcree@orcon.net.nz>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	rcu@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <Z5U__sztq2P2UKWk@minute>
References: <Z4-jgMJgbVriLaCr@minute>
 <Z5KMHoA7GlHJyUU_@minute>
 <alpine.DEB.2.21.2501232306270.27203@angie.orcam.me.uk>
 <Z5NxuIFsMUvqWUtC@minute>
 <CA+=Fv5QmSkP4Ysp1zHNmUPftXYbSquTCsO_o3Rcgi2T5RcPj5A@mail.gmail.com>
 <Z5UAFAD6xCSpKJYw@minute>
 <alpine.DEB.2.21.2501251543460.27203@angie.orcam.me.uk>
 <Z5Uit9F7xF0ZlMk2@minute>
 <alpine.DEB.2.21.2501251806280.27203@angie.orcam.me.uk>
 <alpine.DEB.2.21.2501251839440.27203@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2501251839440.27203@angie.orcam.me.uk>

On Sat, Jan 25, 2025 at 06:59:32PM +0000, Maciej W. Rozycki wrote:
> On Sat, 25 Jan 2025, Maciej W. Rozycki wrote:
> 
> > > Interesting. Perhaps these frames are aligned by PAL-code as well,
> > > the reference manual wasn't clear about that.
> > 
> >  I think it just boils down to the amount of exception nesting.
> 
>  Ah, actually most of these faults were entered from the user mode and the 
> kernel stack starts at a page boundary, so once the stack frame has been 
> allocated by PALcode and SAVE_ALL combined the stack pointer ends up 
> misaligned.  For faults entered from the kernel mode the opposite might be 
> the case.

Indeed, sounds plausible.

> So unless we want to play (and we don't) with FP and the saving 
> and restoration of SP, we just want to keep SP aligned at all times.

> > > I knew about entUna, I thought it's safe as it only deals with 64-bit data
> > > and not going to be changed in future, but missed entMM...
> > > 
> > > I agree, better fix both.
> > 
> >  Well, we may get away with it in many cases, which is obviously why 
> > this bug has survived so long, but in principle it is not safe to enter 
> > C code with the stack misaligned, so yes, we need to fix all the code 
> > paths, also because a nested exception will cause hell to break loose.  
> > 
> >  Here just bumping up the frame size and adjusting offsets in assembly 
> > code accordingly so as to account for the empty longword at the bottom 
> > of the frame should do, just as I did across my change.
> 
>  ... or, depending on how you look at it, top of the frame and FAOD in any 
> case the longword closest to the stack pointer will be the empty one.

Right. So if we agree on my variant, this addition patch is needed.

[No problems with gdb, as expected.]

Ivan.

diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index 6fb38365539d..f4d41b4538c2 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -194,8 +194,8 @@ CFI_END_OSF_FRAME entArith
 CFI_START_OSF_FRAME entMM
 	SAVE_ALL
 /* save $9 - $15 so the inline exception code can manipulate them.  */
-	subq	$sp, 56, $sp
-	.cfi_adjust_cfa_offset	56
+	subq	$sp, 64, $sp
+	.cfi_adjust_cfa_offset	64
 	stq	$9, 0($sp)
 	stq	$10, 8($sp)
 	stq	$11, 16($sp)
@@ -210,7 +210,7 @@ CFI_START_OSF_FRAME entMM
 	.cfi_rel_offset	$13, 32
 	.cfi_rel_offset	$14, 40
 	.cfi_rel_offset	$15, 48
-	addq	$sp, 56, $19
+	addq	$sp, 64, $19
 /* handle the fault */
 	lda	$8, 0x3fff
 	bic	$sp, $8, $8
@@ -223,7 +223,7 @@ CFI_START_OSF_FRAME entMM
 	ldq	$13, 32($sp)
 	ldq	$14, 40($sp)
 	ldq	$15, 48($sp)
-	addq	$sp, 56, $sp
+	addq	$sp, 64, $sp
 	.cfi_restore	$9
 	.cfi_restore	$10
 	.cfi_restore	$11
@@ -231,7 +231,7 @@ CFI_START_OSF_FRAME entMM
 	.cfi_restore	$13
 	.cfi_restore	$14
 	.cfi_restore	$15
-	.cfi_adjust_cfa_offset	-56
+	.cfi_adjust_cfa_offset	-64
 /* finish up the syscall as normal.  */
 	br	ret_from_sys_call
 CFI_END_OSF_FRAME entMM
@@ -378,8 +378,8 @@ entUnaUser:
 	.cfi_restore	$0
 	.cfi_adjust_cfa_offset	-256
 	SAVE_ALL		/* setup normal kernel stack */
-	lda	$sp, -56($sp)
-	.cfi_adjust_cfa_offset	56
+	lda	$sp, -64($sp)
+	.cfi_adjust_cfa_offset	64
 	stq	$9, 0($sp)
 	stq	$10, 8($sp)
 	stq	$11, 16($sp)
@@ -395,7 +395,7 @@ entUnaUser:
 	.cfi_rel_offset	$14, 40
 	.cfi_rel_offset	$15, 48
 	lda	$8, 0x3fff
-	addq	$sp, 56, $19
+	addq	$sp, 64, $19
 	bic	$sp, $8, $8
 	jsr	$26, do_entUnaUser
 	ldq	$9, 0($sp)
@@ -405,7 +405,7 @@ entUnaUser:
 	ldq	$13, 32($sp)
 	ldq	$14, 40($sp)
 	ldq	$15, 48($sp)
-	lda	$sp, 56($sp)
+	lda	$sp, 64($sp)
 	.cfi_restore	$9
 	.cfi_restore	$10
 	.cfi_restore	$11
@@ -413,7 +413,7 @@ entUnaUser:
 	.cfi_restore	$13
 	.cfi_restore	$14
 	.cfi_restore	$15
-	.cfi_adjust_cfa_offset	-56
+	.cfi_adjust_cfa_offset	-64
 	br	ret_from_sys_call
 CFI_END_OSF_FRAME entUna
 
