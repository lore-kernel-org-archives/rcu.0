Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4027533086
	for <rcu@vger.kernel.org>; Sun,  1 Dec 2024 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733072660; cv=none; b=HX87vyddd3GE4RsE+rwV0BqLkTPQk7VbG4fLy47OzcuX1whu0iuMRbdgMTYZr8V2kRthkDbm0KWjHLl5QFK8WaGwZv3+7F8oPmNNFGJ6nJgHoHJKvhJeiXN4PU6tuufnTFgrlJIe6ic6P8lonlDw5Gv/vfUcqHhsj79bi9hQS5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733072660; c=relaxed/simple;
	bh=EKXrWxUNpGfFM6+1EUTiXNGhnESgaYA6dk/YKKTMhf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOHFiCivDB2+xTFFfAGHkKh1+WvU6RaxE7Kdu9RfUymDnl2kwjrFdrwC0dJL2R+g/PON50/svUtsod3IKOpkQ2ENHhXQi7XMKp47zFrZFTYHmAsf7hLgoX8Ktn0wgNkJZ9zD2/ux8orT612g+eA4vlNKEgXHWzCaH3o/0E8NUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP/g06Cm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP/g06Cm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6BDC4CECF;
	Sun,  1 Dec 2024 17:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733072658;
	bh=EKXrWxUNpGfFM6+1EUTiXNGhnESgaYA6dk/YKKTMhf4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XP/g06Cmq7f0/TfULyw3Jkzlz5mzFo2fhjyNIFWsU+yqQjyn/WUY/gpKC4fxLmi1t
	 uY3OVZwW0e/EDmY5f2i9xyZFCjPUvPCHhGK1x7Up248dT1XiTUaE0ANZd0Wf+eFVFI
	 U/pIAPLIyXGEQ5smqJS5ddvO9UhbuyLtTFRwuulmcbXbdA83UOodMHIWMP+5n86J2L
	 XNTGOFvfyy4/XRNOJ2l6zVNDCSDAFNezVsnjlIt80+CvggoGOF5ZotbkTUDDBz1n0F
	 Gbl5W4Sv49dxDG0gRCdWvEl/Bk3U9eX92Daer6ZqOKaEjdwXdWNpkYd6ut7GilMba5
	 nBcupHJtvw8hw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3B17BCE0DB6; Sun,  1 Dec 2024 09:04:18 -0800 (PST)
Date: Sun, 1 Dec 2024 09:04:18 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: rcu@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <8e365392-0e0d-4d78-bae7-69f27c8350f9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+=Fv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=Ei90G98ukRcRJA@mail.gmail.com>
 <f1561626-fde6-41c0-9d45-87a6a7b13816@paulmck-laptop>
 <CA+=Fv5TMZ1bckob2VZ1AaNwdU3R+5a8REKg4aZR8novx7+dj-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+=Fv5TMZ1bckob2VZ1AaNwdU3R+5a8REKg4aZR8novx7+dj-g@mail.gmail.com>

On Sun, Dec 01, 2024 at 11:09:10AM +0100, Magnus Lindholm wrote:
> On Sun, Dec 1, 2024 at 5:31 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > Does booting with the "rcupdate.rcu_normal=1" kernel boot parameter
> > also suppress the problem?
> 
> setting rcupdate.rcu_normal=1 also suppresses the problem. I guess this makes
> RCU code not do synchronize_rcu_normal() in stead of the full
> synchronize_rcu_expedited() which is where I get the kernel Oops.

Exactly, though the effect is that any call to synchronize_rcu_expedited()
instead results in a call to synchronize_rcu().

Which means that you can work around this problem without having to
carry patches and without having to slow down network configuration for
everyone else.  ;-)

> > That "pc =" down below is the program counter?  If so, I am at a loss
> > as to what RCU could do to make it be zero.
> 
> No sure why this happens, if the RCU code is passing around pointers to
> worker function and this somehow ends up being a null pointer on the Alpha?

Are frame pointers enabled on your setup?  If not, could you please
enable them and reproduce the problem?  Could you also please try
building and reproducing with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y?

							Thanx, Paul
