Received: from mail.lony.xyz (unknown [172.105.251.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2661E98F6
	for <rcu@vger.kernel.org>; Wed, 15 Jan 2025 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.251.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938397; cv=none; b=Cjh0fXnujzz/5bMsHOztT6LTZ004lbe3p0w0iC59lSRIZ7cUXLylocLukmuscJoWI2vz25cumuk3pM2AImREdK4+SZiEP7KW9PK/7YocPmiOBIbcCnCZfUedLYtxK9lHNvXgHRWOJzKG1PR67i+RL4tU8N3NCaM1WkBKhTKVlWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938397; c=relaxed/simple;
	bh=kV8NCzAqZ+AjjvyfSzvWfCFZcmp6/sUjJ/Hc8aabX4w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To; b=Tzle+4p85Fp2/uqX/ddlCi6EMK1q1fP6MGfvSjG8ijkfstDtlh86qz21sluQHqunYh05ZacYAuylKzoRq6heGQW73i8jJ9JZA3RT1fyt8iT3vJrNsN2GRQ5RHsedtqDw3466jYZEB9871gtcLAbhVXN19uSEYmHR86f/+pOpHO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lony.xyz; spf=pass smtp.mailfrom=lony.xyz; dkim=fail (2048-bit key) header.d=lony.xyz header.i=@lony.xyz header.b=nxj4N+B1 reason="signature verification failed"; arc=none smtp.client-ip=172.105.251.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lony.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lony.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lony.xyz header.i=@lony.xyz header.b="nxj4N+B1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lony.xyz; s=mail;
	t=1736937998; bh=kV8NCzAqZ+AjjvyfSzvWfCFZcmp6/sUjJ/Hc8aabX4w=;
	h=Date:Subject:From:To:From;
	b=nxj4N+B13gExCxtnV0Aruzot3dcey9x+KSDY2J5xiodvqwsLtpTd1CeSuXYI5p/Fq
	 2N330D2c94+rmb9AJOCcIOhMqvc3vQ/tFEHINQwIbsqLJ7P+NxDRWGtZYE/Ry5xjnX
	 Mc6Y3cnQCyABqdtAmPCv4IyQS+schp6X//OP6vPOMT0G/4ySYFbPC/B9HEf8tuPlGF
	 YDZZkiFb4en58i7Dt6u6OSQ13WT8bjOr/fb6YG/lyWBlR6VJnJBmD2o9cBY+OMrawI
	 LYxJNujhROB4e5raJiir3pcM/zkgQUs+LBlBYX3lHWxT8j1Pajri2hwQiitsq6BLsz
	 7noU+xUBh2MSA==
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jan 2025 11:46:36 +0100
Message-Id: <D72L4RZIUEE0.1S1HF6ZNRTXN3@lony.xyz>
Subject: Supposed CPU stall in RCU reported by security firm
From: =?utf-8?q?Sergio_Migu=C3=A9ns_Iglesias?= <sergio@lony.xyz>
To: <rcu@vger.kernel.org>
X-Mailer: aerc 0.18.2

Hello,

I checked LinkedIn and the CEO of a Security firm posted this
(translated from Spanish):

> I have just discovered a #vulnerability in the #Linux #kernel that
> allows forcing a crash (exploitable locally, and in certain scenarios,
> remotely).
>
> The issue lies in the RCU subsystem, which is critical for the
> kernel's memory management. Unintentionally, I have found a way to
> generate a "lock" in this subsystem, causing the kernel's own memory
> management operations to fail (callbacks, memory allocation for process
> structures, etc.). Unable to recover, a kernel panic occurs (the
> equivalent of the Windows BSOD).
>
> I don't know how many kernel versions may be affected, as this
> subsystem has been part of Linux for over two decades and I imagine
> it has undergone many changes. However, the attack works on a version
> of the 6.X branch like clockwork.
>
> I believe this bug could be dangerous in shared hosting environments,
> VPS, etc.
>
> Let's see if I can find time to report it. Or not. If I see it can be
> militarized (for remote attacks), I will add it to our #0day arsenal
> for #pentest. Some clients sometimes simply want to see how a server
> crashes to test contingency plans, etc.
>
> If I cannot exploit it remotely, or it doesn't have much value, I will
> report it, as always. Unfortunately, our company cannot afford the
> luxury of reporting interesting vulnerabilities (that serve us in our
> day-to-day) for free. This is something that is sometimes not
> understood, but we are an offensive security company (genuine),
> we do not live off cloud smells.

He appends a screenshot which I have saved in the WayBack Machine here:
https://web.archive.org/web/20250115103832/https://www.linkedin.com/feed/up=
date/urn:li:activity:7284277163200057344/

While I know this may be a bluff, I prefer reporting it first, just in
case it is not.

Best regards,
Sergio M. Iglesias.
