Received: from smtp-4.orcon.net.nz (smtp-4.orcon.net.nz [60.234.4.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0D11D31A8;
	Mon, 16 Dec 2024 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.234.4.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734390560; cv=none; b=B9n9BCbGXNcZ67DCqyuJJfacP1LtvxA0GjEC8IAPwnOM7O3RKGBuhvJZ5uMRz9EXzWLQr5+rwHvJkBsGLEOH2ghQh5LvBqB8if1cPVZ26yj+dwnGHEWRilGDke25URVvd2WURcm1YTEgSaolNAilpij4dOZjn+9MVffwIlhxS8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734390560; c=relaxed/simple;
	bh=eEvR6MzLfsFMX2eJJEaXHAlxTmcbq13dlB1QR8bfpEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roAoJIegfudmo+iknKilrDKM3uPAsnG+cioNWIgKGEOLiz6PQZ9r7ntcCMerAyIdudsSOSL5oNuLbdOfu/9hi6acSd4sVXGMder3wVH1xdaOf5LIQUBvthVG0tvoh7DRhhz55rBWl0bqab8d/dpDNy1YzXdb/a9bpss6kHY1Zas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orcon.net.nz; spf=pass smtp.mailfrom=orcon.net.nz; arc=none smtp.client-ip=60.234.4.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orcon.net.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orcon.net.nz
Received: from [121.99.247.178] (port=57973 helo=creeky)
	by smtp-4.orcon.net.nz with esmtpa (Exim 4.90_1)
	(envelope-from <mcree@orcon.net.nz>)
	id 1tNJIG-0005XQ-Gs; Tue, 17 Dec 2024 11:10:24 +1300
Date: Tue, 17 Dec 2024 11:10:18 +1300
From: Michael Cree <mcree@orcon.net.nz>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	paulmck@kernel.org, rcu@vger.kernel.org,
	linux-alpha@vger.kernel.org
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
Message-ID: <Z2ClSlwznfuk8Uwr@creeky>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
	Magnus Lindholm <linmag7@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	paulmck@kernel.org, rcu@vger.kernel.org,
	linux-alpha@vger.kernel.org
References: <CA+=Fv5QH1nUO1D1=Osqic6mNN6vLxiLqvNA4D9uAUgZA_w+7Tw@mail.gmail.com>
 <0b338882a82c3f505407cb313b89a2c7f891d982.camel@physik.fu-berlin.de>
 <CA+=Fv5RDcgm4YSX1AcpOgLvL=XXKyA=71ZasbJSc7+79Kh_Xpg@mail.gmail.com>
 <d9330edfca0fb34c69a68c56924fa0b074b26d29.camel@physik.fu-berlin.de>
 <CA+=Fv5T9nrQjGHOR+42tfgT723TJGgyVqBY7CwY4L-gYSoWTag@mail.gmail.com>
 <c661a771a86267c158d7f2eba1494fe94350fb06.camel@physik.fu-berlin.de>
 <CA+=Fv5Rxrwn0SEMgjufJcxSaB0_gOiKBjXuZnSKzgKakDHeCOw@mail.gmail.com>
 <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com>
 <Z1YpKFQGtMWF3yy3@creeky>
 <CA+=Fv5Q=f-6y=EhZhG2XfZB0O=m+yOiv+gmtmMABVQZieKdwbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+=Fv5Q=f-6y=EhZhG2XfZB0O=m+yOiv+gmtmMABVQZieKdwbQ@mail.gmail.com>
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --

On Mon, Dec 09, 2024 at 09:05:46AM +0100, Magnus Lindholm wrote:
> > Maybe, maybe not.  Building 6.11.11 with alpha-linux-gnu-gcc-9
> > (Debian 9.3.0-22) fixed the null pointer access in the scsi
> > subsystem, and finally I have a bootable system! (Tested on ES45.)
> > But I now get a null pointer access when network driver loaded:
> 
> Very interesting! Can you provide a full stack dump? interested to
> see if this is the same issue as on my system.

[   33.144514] e100 0001:02:04.0 enP1p2s4: NIC Link is Up 100 Mbps Full Duplex
[   36.878887] Unable to handle kernel paging request at virtual address 0000000000000000
[   36.879863] CPU 0 
[   36.879863] kworker/0:1(10): Oops -1
[   36.881817] pc = [<0000000000000000>]  ra = [<0000000000000001>]  ps = 0000    Not tainted
[   36.882793] pc is at 0x0
[   36.883770] ra is at 0x1
[   36.884746] v0 = 0000000000000007  t0 = 0000000000000001  t1 = fffffc000091cc80
[   36.884746] t2 = 0000000000000000  t3 = fffffc00040cca40  t4 = 0000000000000001
[   36.884746] t5 = 0000000000000001  t6 = 0000000000000000  t7 = fffffc0004124000
[   36.884746] s0 = fffffc000a037e00  s1 = fffffc000a037f28  s2 = fffffffffffffed8
[   36.884746] s3 = fffffc0004020b40  s4 = fffffc0001c8d688  s5 = fffffc0004020bc0
[   36.884746] s6 = fffffc0001c8d680
[   36.884746] a0 = fffffc0001c5b320  a1 = fffffc000ac14200  a2 = fffffc00040ccac0
[   36.884746] a3 = fffffc0003df36c0  a4 = fffffc000dfb3d38  a5 = ffffffffffffffff
[   36.884746] t8 = 0000000000000000  t9 = 0000000000000000  t10= 0000000000000001
[   36.884746] t11= 0000000000000001  pv = fffffc00018b7180  at = 0000000000000001
[   36.884746] gp = fffffc0001cb08c8  sp = 00000000ab1ca88d
[   36.884746] Disabling lock debugging due to kernel taint
[   36.896465] Trace:
[   36.896465] [<fffffc0001049c8c>] process_scheduled_works+0xdc/0x420
[   36.898418] [<fffffc000104a740>] worker_thread+0x0/0x3d0
[   36.899395] [<fffffc000104a8f0>] worker_thread+0x1b0/0x3d0
[   36.900371] [<fffffc000104a740>] worker_thread+0x0/0x3d0
[   36.901348] [<fffffc000105705c>] kthread+0x17c/0x1c0
[   36.902324] [<fffffc000104a740>] worker_thread+0x0/0x3d0
[   36.903301] [<fffffc0001011198>] ret_from_kernel_thread+0x18/0x20
[   36.904277] [<fffffc0001056ee0>] kthread+0x0/0x1c0
[   36.905254] [<fffffc0001011180>] ret_from_kernel_thread+0x0/0x20

[   36.907207] Code:
[   36.907207]  00000000 
[   36.908184]  00000000 
[   36.909160]  00063301 
[   36.910137]  00000e90 
[   36.911113]  00001111 
[   36.912090]  0000795c 

> Have you tried passing rcupdate.rcu_normal=1 as boot parameter
> to the kernel? That allowed me to bypass the network interface
> problem on my system.

Haven't as yet, but backtrace above does not go through rcu routines.
Maybe I am seeing a different issue.

Cheers,
Michael.
