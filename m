Received: from mail.ams.netpunt.systems (mail.ams.netpunt.systems [178.62.236.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423B11C6AB
	for <rcu@vger.kernel.org>; Mon,  4 Mar 2024 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.236.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589309; cv=none; b=U7dFSATMenUtDVlMLX68GU7O0M1+LUvUAGQYZxaUCtH/8cRNahhpjpb5e8qj8USt3vv3EDypOek7EY0AkNA4VrGS0qOXYnLA9u5RITAFzptECadQcYQFZ0zg1H7Km/JSXZ26gODNeCyx1/hkxOVmMTW7mPGAFxruQol9Q+8YkKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589309; c=relaxed/simple;
	bh=jJO+b+fYZoRg89CLzeyzUZhE+YTn0Hc/Fss0W1IJK1o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jH3iySboOAhFep2l37SpQcB3c8AjKIr0i2vshWqzLcX6G3y1IcEc65Z31f8JL0m2UrlNeUJhHh29YX4gPcefNnVw1rahRBueeLRwwau2dFxy05CGoGGy7me62Spz8b0Uf0coFf50qUAx96TXa4WHJoTsjEVkg8ftggJaqxYM1sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxboone.com; spf=pass smtp.mailfrom=maxboone.com; dkim=fail (2048-bit key) header.d=maxboone.com header.i=@maxboone.com header.b=cissPHZ/ reason="signature verification failed"; arc=none smtp.client-ip=178.62.236.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxboone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxboone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=maxboone.com header.i=@maxboone.com header.b="cissPHZ/"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55818AE860;
	Mon,  4 Mar 2024 22:54:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxboone.com;
	s=dkim; t=1709589296;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jJO+b+fYZoRg89CLzeyzUZhE+YTn0Hc/Fss0W1IJK1o=;
	b=cissPHZ/hbvesdrVtzSHpCd9Qwzf00HJwys1R5L4WLWyrdPf/QreWqTiOP9AQJjFQ1nFYI
	5Upil4L7T+9qVV14Ao5DXkHN4lp+LK7Tk0vV0wQv/EEErf1xBPvEeaUKI5toXcIiY78ApA
	UWGAcC8DRafF46JaU+i6h62Lefx+1vmLbgKCjBggxBBKOEaA+fMYCxRnFoS4JghGL6cz8A
	Qs/UL6g7wnJAOt4tuQHyHoVymV0is9n/wY2s3MbqTy6bxMevLShuWvYExYbMA+noSMhT1R
	RnP6U+ScZ+ZHDWElCKia1dvNuf59j936s/m1o3/T506Mr/X2PGMUrBb3vbQEOQ==
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Mar 2024 21:54:55 +0000
Message-Id: <CZLATSBV6XDH.2WUG4D8VJHEQ5@maxboone.com>
Cc: <rcu@vger.kernel.org>
Subject: Re: Advice sought on RCU stalls on ARM64 WSL2
From: "Max Boone" <contact@maxboone.com>
To: "Boqun Feng" <boqun.feng@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>
References: <1a5d96d6-2057-44d9-a4b0-8771c46032fb@paulmck-laptop>
 <3718bb-65e38400-d-5cd53080@68830111>
 <99a0fb2c-c936-405f-85bf-847c61531bd5@paulmck-laptop>
 <ZeX327aMIrthOXbs@Boquns-Mac-mini.home>
In-Reply-To: <ZeX327aMIrthOXbs@Boquns-Mac-mini.home>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Mar 4, 2024 at 4:33 PM UTC, Boqun Feng wrote:
> I haven't seen this issue before, looks to me the stall is caused by
> clear_rseq_cs(), which is basically a put_user(), and I don't have an
> immediate theory, could you share the kernel repo and configuration you
> used, so that I can see if I can reproduce this? (Note I don't have the
> exact device as you do nor an ARM64 Windows system with the exact
> Windows build you are using).
>
> Regards,
> Boqun

This happens on the default Windows System for Linux 2 setup, thus the
kernel built with the following sources:
- https://github.com/microsoft/WSL2-Linux-Kernel/tree/linux-msft-wsl-5.15.y

It also happens when I build the kernel myself from a more recent
release:
- https://github.com/maxboone/SQ2-Linux-Kernel-Builds

Microsoft should have a Development Kit (Volterra) with identical hardware=
=20
to mine (and other Surface Pro X, Surface Pro 9 users) that run into the=20
same issue with WSL2.

Moreover, the problem does not seem to occur on a regular Hyper-V VM=20
(with a different / standard kernel though) at all, so reproduction=20
might be difficult. The CPU that's shown by Hyper-V also differs from
the one visible in WSL2, maybe colleagues over at Redmond know what
CPU virtualization is used there?
- https://github.com/microsoft/WSL/issues/9454#issuecomment-1976411786

Thanks,
Max
