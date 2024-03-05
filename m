Received: from mail.ams.netpunt.systems (mail.ams.netpunt.systems [178.62.236.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566047BAFE
	for <rcu@vger.kernel.org>; Tue,  5 Mar 2024 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.236.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709618260; cv=none; b=e05lfyMXLrhuEFkNIGn6Fr94jtWMELZE0nwHQuiqSc6Cs8Jh3KsigDpnpy/1oTzXKnl3yPsYU8esqbc+dZMK5m+fdip4QWSRwVAfYdk01z2yjw7eJRW+pkrnLkSk9OqY2Grsm6MzRTXcTAz5yKw5i7HkPkfQZXI7Z0lmNL9NlgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709618260; c=relaxed/simple;
	bh=kGjN01eBdxKgKM3QkoePQ2SjbyaBUiiB9x4r+77lQ+s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZDmv9riLYO5gXowARuHYxNnj/+aDRWJ6WctYdK8QpBSzFKFPkTg6itlpsahKeNyVwlIEGOmwlIMpN1eRq0C4z4k6fI9W/32WdYog8u0F9Qx64pOS9sHWA8rp6kO5Dw5yv8L1mshixduHnaaAyUJDL1EYSQRo2q/FLFYIBhWPppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxboone.com; spf=pass smtp.mailfrom=maxboone.com; dkim=fail (2048-bit key) header.d=maxboone.com header.i=@maxboone.com header.b=RQOcbuMh reason="signature verification failed"; arc=none smtp.client-ip=178.62.236.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxboone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxboone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=maxboone.com header.i=@maxboone.com header.b="RQOcbuMh"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3977AC4AB;
	Tue,  5 Mar 2024 06:57:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxboone.com;
	s=dkim; t=1709618254;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rFyyG+TBTr1y/ApHec4EvDcXF3z4g0zGpiHb+l+61XE=;
	b=RQOcbuMh4akOcXUQ3AgyeOR9gMWE1cB/8h8Gm/66om5cehdlOPFCQ2PgfD4KDGhkA+JOmK
	xUq4KworUU0gaH4+CU6ah0XZf3Ry/uyu1BkzpBqw/4/JHE3QrEXwt7MWSiSgYf1+0mqwPJ
	f2rV4Z2iMV38yvItlSVO4i2NYPvAZiS557dyOozE9kzY/k6lOn+0yitVxEj39Z4WLkTcHr
	JQ8JioXRzOhlYI0YFQkOvgqNekVnB1DXcQPm0Ioh2Mb/747tcEdkhce8Ra/ErefqwPxGDK
	KqIXx55JJ7HNGIRyZWBBp68mC8GshaMGiwpAliMjbG9IWdwpJDpzT3lHlv33eQ==
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Mar 2024 05:57:33 +0000
Message-Id: <CZLL3BA2G8O8.1M5NNUFKOJDY6@maxboone.com>
Cc: <rcu@vger.kernel.org>
Subject: Re: Advice sought on RCU stalls on ARM64 WSL2
From: "Max Boone" <contact@maxboone.com>
To: "Joel Fernandes" <joel@joelfernandes.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
References: <1a5d96d6-2057-44d9-a4b0-8771c46032fb@paulmck-laptop>
 <3718bb-65e38400-d-5cd53080@68830111>
 <99a0fb2c-c936-405f-85bf-847c61531bd5@paulmck-laptop>
 <ZeX327aMIrthOXbs@Boquns-Mac-mini.home>
 <CZLATSBV6XDH.2WUG4D8VJHEQ5@maxboone.com>
 <807b26d4-b55f-4b5e-932e-1252e1ff2446@joelfernandes.org>
In-Reply-To: <807b26d4-b55f-4b5e-932e-1252e1ff2446@joelfernandes.org>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Mar 5, 2024 at 12:32 AM UTC, Joel Fernandes wrote:
> FWIW, I use a Windows machine that has WSL2 (kernel version
> 5.15.133.1-microsoft-standard-WSL2) and I have never experienced any kind=
 of
> hang. Though, this is a desktop and not a laptop or battery powered devic=
e.

Is that also an ARM64 machine, because I have never seen this happen on
a x86_64 machine, there it runs like a charm. Out of curiousity, if you are=
=20
running an ARM64 Desktop. If I may as, which one, as the Volterra Developme=
nt=20
Kit is not available in the Netherlands.

> >=20
> > It also happens when I build the kernel myself from a more recent
> > release:
> > - https://github.com/maxboone/SQ2-Linux-Kernel-Builds
> >=20
> > Microsoft should have a Development Kit (Volterra) with identical hardw=
are=20
> > to mine (and other Surface Pro X, Surface Pro 9 users) that run into th=
e=20
> > same issue with WSL2.
>
> Right, so at least that's a data point, that its Surface-specific (?). Ha=
ve you
> tried to disable power management and see if it occurs? Like disable susp=
end,
> disable cpuidle, etc.

It also happens on non-Surface (but indeed mobile) devices, such as
Lenovo ThinkPads. However, the common denominator might be the Qualcomm
8cx chip (that Microsoft uses as SQ{1,2,3} -> 8cx Gen{1,2,3} with a=20
beefier GPU).

Changes to power management settings in Windows don't seem to have
effect other than stalls taking longer to occur when the device never
sleeps. But the stalls also happen (often) when it doesn't sleep.

Power management in WSL2 seems to be all but available:

```
root@ProX2024:~# uname -r
6.7.7-WSL2-STABLE+
root@ProX2024:~# echo freeze > /sys/power/state
-bash: echo: write error: Function not implemented
root@ProX2024:~# ls /sys/devices/system/cpu/
cpu0  cpu2  cpu4  cpu6  cpufreq   kernel_max  offline  possible  present  v=
ulnerabilities
cpu1  cpu3  cpu5  cpu7  isolated  modalias    online   power     uevent
```

However available in Hyper-V:

```
root@ubuntu0:~# uname -r
6.5.0-21-generic
root@ubuntu0:~# echo freeze > /sys/power/state
root@ubuntu0:~# ls /sys/devices/system/cpu
cpu0  cpu2  cpufreq  hotplug   kernel_max  offline  possible  present  ueve=
nt
cpu1  cpu3  cpuidle  isolated  modalias    online   power     smt      vuln=
erabilities
```

> Have you tried to reproduce the issue with CONFIG_RSEQ=3Dn and see if it =
happens?

Will build a new kernel today with that flag, and report back.

> Also this github thread looks awfully similar to the github thread you po=
inted
> and has the same clear_rseq signature leading to the RCU stall. Over ther=
e also
> it is a hang, but they say the CPU usage is at 100%:
> https://github.com/microsoft/WSL/issues/8529

Indeed, when the RCU stalls occur, the CPU of the core that is stalling
ramps up to 100%. I had thought that was an effect of the stall, but
will check if the 100% usage is caused by the process that is stalling.

Cheers,
Max.
