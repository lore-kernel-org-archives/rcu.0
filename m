Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9EA433D2;
	Thu, 30 May 2024 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717092376; cv=none; b=My46Yxl+ehcWDbnuODfIU/xfua9j31jF2V/rZaVi9RamLBXZC2zy5gnNTwL1xq5nT86Inkuf5+vdq73CGDU+QjIQbp+evgntR8OVDD9yKfCEzdbxpkAKlE71XuXleAGTT3fFMLidM3+mL+Lle922evaBH1+9X/whFsJYOX+FcCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717092376; c=relaxed/simple;
	bh=ECROXY97FzRRFQfl/vTg9noe1+ys7k0kn2Q+dIUph7Y=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=H3kD1+pyqa25wJyfI6wU7ZqU3zjGGJcC29uv2BIcQdQroOLxNkiJSAi5al5waxoWRIaFTBI0rLKcZzHDTnqfyvlfyfcN8ildxUMd5b9IcUJhXuvQX7vTDAusv3kNwmQhvnKvkLS1pPbUh1EIgtdcEuWHrPQvGL3qz0bdQGwLCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LayYkV9W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F5yW3jNC; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LayYkV9W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F5yW3jNC"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id D5CAC1800079;
	Thu, 30 May 2024 14:06:12 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 30 May 2024 14:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1717092372; x=1717178772; bh=SkLD/QSa35
	SjDwEkaUt3lwI+SBmwPmQOygwVgmlQz2s=; b=LayYkV9WK4f6u5i7IHuefhADZR
	SRZx8GYAhJ2vN8neBBjcFYIqov388lwboVrHphim/Sw/W4elUyFixlKtLIXA6/hK
	vU26MgPk8udNrj5RkyKu3QlbMxUs/VDT4ELPRhVI+I2TzxWLsk21+ezWO+b2B03X
	JAT2X/BJQ+bkKcLJDD3GRQbRlPpKFiVIz47m/OegB5eDQxtbjIGdpMZnrFtqKhQB
	Gg10e7BAyGYoRTfls61EWjV+ooItFdbWlZphZZs0dwbpkFZHyq9b+4JznreCfSDX
	J2fl/147w3JZplclvkTAXJ+/FaohUwhFZ2YsYTtqHy2ByWSNfWGfyf0chYiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717092372; x=1717178772; bh=SkLD/QSa35SjDwEkaUt3lwI+SBmw
	PmQOygwVgmlQz2s=; b=F5yW3jNCWi4pf8bFfGOqpfo9+c/c7BOh0lfT5jd+dkvc
	4sfBpqMbeVGgKaMFKwBB/danWHi9fCWT9VT3QexmMoiPcTrQuGiW+3PM067YTORI
	2UzyyzW90pn2kHLVNIOQc1cArR8uj8cV3HK8MKpGPcDDhXdHhgTs+voOmJzBAkrs
	UmRXN4IKO7HhlA6FUjUQW2cfZPgUoT3070RJTjJtiE+3IJ9tMHJVWt8lM1ucvKbZ
	GAcoX7UO1glDoKWQczit6nDD/oXRwHzJPhOf94I2AyxUoRMXZFYzljwwYQsJckgm
	nLItEaTgt0Hh9I9MwR4NDt333OorSsOdw5ox1WIC8Q==
X-ME-Sender: <xms:FMBYZolMBkQ8--FIaWoIg4h6cE5bRL_i8Vvt9xkKn1bfVkpUoaadzA>
    <xme:FMBYZn3Is0PDuHMAU9Uv9B56vbV91_x56X9DARz34nJxt1-40kga_xEXxNEeneoSo
    z-VndqrUP7GVXs8llw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:FMBYZmoDSYqASoiDwPn7wqJPHrh-ybvXXxDq28TCC04Ayc_FszcfUw>
    <xmx:FMBYZkkcw9CdbF9WH9HwSJzMXG4xipkFmlY68RcbmFhhmDVvWvmxkw>
    <xmx:FMBYZm1lDMybhSKIMrStfnx9ONJx1jZkLSxQo7xdDNqTIXaXsjTz5Q>
    <xmx:FMBYZru5yYvLFagqIOqC_B4mHlLcZNB-w_R8vyqg9C6X1PQtjh8Xhg>
    <xmx:FMBYZsP7bYZrJdDZhdOZK9HZH_egqwQIt1lWUyxblVel5xBaPCG3pX-p>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E5E5DB6008D; Thu, 30 May 2024 14:06:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <38442e3d-1e43-4894-b126-b4258d331a32@app.fastmail.com>
In-Reply-To: <214a33ac-d4fa-4d48-ad3c-ad8b00ae1a5e@paulmck-laptop>
References: 
 <CA+G9fYuZ+pf6p8AXMZWtdFtX-gbG8HMaBKp=XbxcdzA_QeLkxQ@mail.gmail.com>
 <Zlhwe5owmbzI3jJK@shell.armlinux.org.uk>
 <7f61cc11-7afe-46ac-9f07-62e0b9ab429f@app.fastmail.com>
 <5426b25f-9c25-4938-99e8-5cdea75e4d3b@paulmck-laptop>
 <214a33ac-d4fa-4d48-ad3c-ad8b00ae1a5e@paulmck-laptop>
Date: Thu, 30 May 2024 20:05:50 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Russell King" <linux@armlinux.org.uk>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>, rcu <rcu@vger.kernel.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Joel Fernandes" <joel@joelfernandes.org>, eeraj.upadhyay@kernel.org,
 "John Ogness" <john.ogness@linutronix.de>, "Mark Brown" <broonie@kernel.org>
Subject: Re: arm-linux-gnueabihf-ld: kernel/rcu/update.o:update.c:(.text+0x1cc4): more
 undefined references to `__bad_cmpxchg' follow
Content-Type: text/plain

On Thu, May 30, 2024, at 19:24, Paul E. McKenney wrote:
> On Thu, May 30, 2024 at 09:37:21AM -0700, Paul E. McKenney wrote:
>> On Thu, May 30, 2024 at 03:27:58PM +0200, Arnd Bergmann wrote:

> And for an untested first attempt at a fix.
>
> What did I mess up this time?  ;-)
>

I think only the comment:

> 
>  	switch (size) {
> -#ifndef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
> +#ifdef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
> +	case 1:
> +		oldval = cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
> +		break;
> +#else

"min ARCH >= ARMv6K" now applies to the #else side, while the
#if side is the early ARMv6 (pre-v6K).

     Arnd
