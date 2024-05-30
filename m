Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E878F132120;
	Thu, 30 May 2024 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717072005; cv=none; b=twMxuLnvAxedO6OzIv7aUcI67107J8DGjE4/99AyOt8myhHcERJs9GR7Q6ejd340vNuP4pBojre17F2+7yg3cGrPfs5uHSebSfEdhmSxuz00MT6/Q1W2zk70AmOsmGUBMZOwQDOtSjZfE46aB7xOrJ8jylZdmwKO9UoHXs6Z3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717072005; c=relaxed/simple;
	bh=Ki0PXwDcgKCwKxNmPedJebPKiDnnFLgJd0CWDkQGwlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lxt5ViFLEO5UN6XD6AvWqQEAVnqd1WgodosqbmHOmgpGhGzFzNrUT5Gnrk8xFga5uyJx05XTdhnnUHiqfCdsnvuF6nc6xyWlqeRGD+teRsC7w0o0k2myDZVQon3ZCifkI7+otc3UXhmb2RBLqxaNOGIl3V/XqPKpSeDaWhbTaZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HAi0ODxC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HAi0ODxC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xesVBLyk2WRbDcXVWG0pEUYP3V61JmuSdVX8kyL/MGM=; b=HAi0ODxC1fc7rpfK3TIamNoDMg
	oEvRbbOfGupH4U/eg772GjYV89EKYxfiWHLPeEhV31kx4FNifX89nFjzAyNpSyh3PKxQd+IOp8YAa
	VZbU7PyIdszPWInRtS65Pi6XwXMz6VnEEkRmd/JHUy0+kb0S32WkJ3gTfUjwnnSqzRmfvNwmEAUY6
	zOwdabiUEvbVTJI1jt4jEpGHNjoVfZOT7tWis+uLc+HMQhKg+91OIwfhBM7f0rERt7ovM/a7hnTpg
	YAyKIgt3CUbQs2z4fX9PerPd6ysN7aXjTb/693olm/+sbG/bJN7/HP02c1DME89H+xEOZji+7I/WY
	AtpbyyDA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47132)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sCerb-0007MG-0r;
	Thu, 30 May 2024 13:26:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sCerc-00058h-BI; Thu, 30 May 2024 13:26:36 +0100
Date: Thu, 30 May 2024 13:26:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	rcu <rcu@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>, eeraj.upadhyay@kernel.org,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: arm-linux-gnueabihf-ld:
 kernel/rcu/update.o:update.c:(.text+0x1cc4): more undefined references to
 `__bad_cmpxchg' follow
Message-ID: <Zlhwe5owmbzI3jJK@shell.armlinux.org.uk>
References: <CA+G9fYuZ+pf6p8AXMZWtdFtX-gbG8HMaBKp=XbxcdzA_QeLkxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuZ+pf6p8AXMZWtdFtX-gbG8HMaBKp=XbxcdzA_QeLkxQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, May 30, 2024 at 05:50:52PM +0530, Naresh Kamboju wrote:
> The arm builds failed on Linux next with gcc-13 and clang-18.
> 
> Config: arm imx_v6_v7_defconfig - failed
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build log:
> -----
> arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
> `rcu_trc_cmpxchg_need_qs':
> update.c:(.text+0x348): undefined reference to `__bad_cmpxchg'
> arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
> `rcu_read_unlock_trace_special':
> update.c:(.text+0x41c): undefined reference to `__bad_cmpxchg'
> arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function
> `trc_read_check_handler':
> update.c:(.text+0x4b0): undefined reference to `__bad_cmpxchg'
> arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function `trc_inspect_reader':
> update.c:(.text+0x1518): undefined reference to `__bad_cmpxchg'
> arm-linux-gnueabihf-ld: update.c:(.text+0x1548): undefined reference
> to `__bad_cmpxchg'
> arm-linux-gnueabihf-ld: kernel/rcu/update.o:update.c:(.text+0x1cc4):
> more undefined references to `__bad_cmpxchg' follow
> make[3]: *** [/builds/linux/scripts/Makefile.vmlinux:34: vmlinux] Error 1

You get a reference to __bad_cmpxchg() when someone uses cmpxchg() on
a datatype that there are no CPU instructions to perform the atomic
compare-and-exchange.

As we support 8-bit, 16-bit and 32-bit, I would expect that we're now
seeing cmpxchg() being used on 64-bit values, which are unsupportable
on 32-bit Arm.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
